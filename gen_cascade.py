# -*- coding: utf-8 -*-
"""确定性图比对级联判定链 —— 顶会风横版科研流程图(灰度 + 单深色落点)。
   主路(降级路径)横向一条线;"是"分支上挑到终止结论;最终落到深色错误码节点。
   输出: pictures/cadx/compare_cascade.pdf  (矢量,Windows 端直接嵌入,无需 typst 包)"""
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

plt.rcParams.update({
    "font.sans-serif": ["Songti SC"], "font.serif": ["Songti SC"],
    "axes.unicode_minus": False,
})
INK = "#222222"; DARK = "#3a3a3a"; PROC = "#ededed"; GRAY = "#888888"

fig, ax = plt.subplots(figsize=(11.0, 2.7), dpi=200)
ax.set_xlim(0, 11.3); ax.set_ylim(0.2, 3.0); ax.axis("off")

# 主路 y=0.95;终止结论 y=2.45
Y0, Y1 = 0.95, 2.45
def node(x, y, w, h, text, *, kind):
    if kind == "decision":
        fc, ec, lw, tc, fw = "white", DARK, 1.5, INK, "bold"
    elif kind == "process":
        fc, ec, lw, tc, fw = PROC, GRAY, 1.0, INK, "normal"
    elif kind == "term":
        fc, ec, lw, tc, fw = "white", GRAY, 1.0, INK, "normal"
    elif kind == "final":
        fc, ec, lw, tc, fw = DARK, DARK, 1.5, "white", "bold"
    else:  # input
        fc, ec, lw, tc, fw = "white", INK, 1.2, INK, "normal"
    box = FancyBboxPatch((x - w/2, y - h/2), w, h,
                         boxstyle="round,pad=0.02,rounding_size=0.14",
                         fc=fc, ec=ec, lw=lw, zorder=3)
    ax.add_patch(box)
    ax.text(x, y, text, ha="center", va="center", color=tc, fontsize=10.5,
            fontweight=fw, zorder=4, linespacing=1.25)
    return (x, y, w, h)

def arrow(p, q, *, label="", dx=0.0, lstyle="normal"):
    # 从节点 p 边缘指向节点 q 边缘(按方向留间隙)
    (x0, y0, w0, h0), (x1, y1, w1, h1) = p, q
    if abs(y1 - y0) < 0.1:          # 水平
        sx, sy = x0 + w0/2, y0
        tx, ty = x1 - w1/2, y1
    else:                            # 垂直(上挑)
        sx, sy = x0, y0 + h0/2
        tx, ty = x1, y1 - h1/2
    ax.annotate("", xy=(tx, ty), xytext=(sx, sy),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.15,
                                shrinkA=2, shrinkB=2), zorder=2)
    if label:
        mx, my = (sx + tx)/2 + dx, (sy + ty)/2
        ax.text(mx, my, label, ha="center", va="center", fontsize=9,
                style="italic", color=INK,
                bbox=dict(boxstyle="square,pad=0.08", fc="white", ec="none"), zorder=5)

# ---- 主路节点(降级路径,横向一条线) ----
nin = node(0.95, Y0, 1.55, 0.80, "当前电路图\n∥ 参考逻辑电路", kind="input")
d1  = node(2.95, Y0, 1.35, 0.80, "完整图\n同构？",             kind="decision")
p1  = node(4.95, Y0, 1.50, 0.80, "角色推断\n传播语义角色",     kind="process")
d2  = node(6.85, Y0, 1.30, 0.80, "子图 /\n包含？",             kind="decision")
p2  = node(8.70, Y0, 1.45, 0.80, "图编辑距离\n/ 近似相似度",    kind="process")
err = node(10.55, Y0, 1.40, 0.80, "结构化\n错误码", kind="final")

# ---- 终止结论(上挑) ----
t1 = node(2.95, Y1, 1.70, 0.62, "判定逻辑等价 → 正确", kind="term")
t2 = node(6.85, Y1, 2.05, 0.62, "区分“多余连接 / 未完成电路”", kind="term")

# ---- 箭头 ----
arrow(nin, d1)
arrow(d1, p1, label="否")
arrow(d1, t1, label="是")
arrow(p1, d2)
arrow(d2, p2, label="否")
arrow(d2, t2, label="是")
arrow(p2, err)

fig.tight_layout(pad=0.3)
fig.savefig("pictures/cadx/compare_cascade.pdf", bbox_inches="tight")
plt.close(fig)
print("ok pictures/cadx/compare_cascade.pdf")
