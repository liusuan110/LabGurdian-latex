# -*- coding: utf-8 -*-
"""神经—符号解耦三链路 —— 顶会风科研图(灰度 + 单深色落点 + 解耦分隔 + 校验器打回回环)。
   感知事实链 / 符号判定链 / 接地解释链 三行,中部虚线为"事实生产 ╱ 话术生成"解耦边界。
   输出: pictures/cadx/three_chains.pdf  (矢量,字体子集已嵌,Windows 端直接嵌入)"""
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch

plt.rcParams.update({
    "font.sans-serif": ["Songti SC"], "font.serif": ["Songti SC"],
    "axes.unicode_minus": False,
})
INK = "#222222"; DARK = "#3a3a3a"; PROC = "#ededed"; GRAY = "#888888"

fig, ax = plt.subplots(figsize=(10.8, 5.0), dpi=200)
ax.set_xlim(0, 11.0); ax.set_ylim(-0.35, 5.0); ax.axis("off")

def node(x, y, w, h, text, *, kind, fs=10.5):
    sty = {
        "input":   ("white", INK,  1.2, INK,    "normal"),
        "data":    ("white", GRAY, 1.0, INK,    "normal"),
        "process": (PROC,    GRAY, 1.0, INK,    "normal"),
        "emph":    ("white", DARK, 1.9, INK,    "bold"),
        "gate":    ("white", DARK, 2.2, INK,    "bold"),
        "final":   (DARK,    DARK, 1.5, "white","bold"),
    }[kind]
    fc, ec, lw, tc, fw = sty
    ax.add_patch(FancyBboxPatch((x - w/2, y - h/2), w, h,
                 boxstyle="round,pad=0.02,rounding_size=0.13",
                 fc=fc, ec=ec, lw=lw, zorder=3))
    ax.text(x, y, text, ha="center", va="center", color=tc, fontsize=fs,
            fontweight=fw, zorder=4, linespacing=1.25)
    return (x, y, w, h)

def harrow(p, q):
    (x0, y0, w0, _), (x1, y1, w1, _) = p, q
    ax.annotate("", xy=(x1 - w1/2, y1), xytext=(x0 + w0/2, y0),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.15,
                                shrinkA=2, shrinkB=2), zorder=2)

def vlabelarrow(x, ytop, ybot, label):
    ax.annotate("", xy=(x, ybot), xytext=(x, ytop),
                arrowprops=dict(arrowstyle="-|>", color=INK, lw=1.15,
                                shrinkA=1, shrinkB=1), zorder=2)
    ax.text(x + 0.2, (ytop + ybot)/2, label, ha="left", va="center",
            fontsize=8.6, style="italic", color=INK, zorder=4,
            bbox=dict(boxstyle="square,pad=0.08", fc="white", ec="none"))

def chain_label(y, text):
    ax.text(0.5, y, text, ha="center", va="center", fontsize=9.5,
            fontweight="bold", color=INK, linespacing=1.2)

YA, YB, YC = 4.25, 2.75, 1.15
H = 0.74

# ── 感知事实链 ──
chain_label(YA, "感知\n事实链")
a1 = node(2.45, YA, 1.65, H, "面包板\n俯视照片", kind="input")
a2 = node(5.15, YA, 2.75, H, "关键点检测（NPU）\n孔位吸附 · 板型规则", kind="process")
a3 = node(7.95, YA, 1.75, H, "引脚级\n结构化网表", kind="data")
harrow(a1, a2); harrow(a2, a3)

# ── 符号判定链 ──
chain_label(YB, "符号\n判定链")
b1 = node(3.55, YB, 3.05, H, "VF2 确定性图比对 · 模板匹配", kind="emph")
b2 = node(6.75, YB, 1.7, H, "结构化\n错误码", kind="data")
harrow(b1, b2)

# ── 链间数据传递(右侧短箭头,各自标注所传数据) ──
vlabelarrow(8.95, YA - H/2, YB + H/2, "引脚级网表")
vlabelarrow(5.0, YB - H/2, YC + H/2, "结构化错误码")

# ── 解耦边界(虚线) ──
ax.plot([1.3, 10.5], [1.95, 1.95], ls=(0, (6, 4)), lw=1.0, color=GRAY, zorder=1)
ax.text(10.45, 2.18, "事实生产（可证伪 · 可审计）", ha="right", va="center",
        fontsize=8.4, color=DARK, zorder=4)
ax.text(10.45, 1.72, "话术生成（受约束）", ha="right", va="center",
        fontsize=8.4, color=DARK, zorder=4)

# ── 接地解释链 ──
chain_label(YC, "接地\n解释链")
c1 = node(3.05, YC, 2.45, H, "受约束 LLM\n生成草稿", kind="process")
c2 = node(6.05, YC, 2.15, H, "不可绕过的\n确定性校验器", kind="gate")
c3 = node(8.95, YC, 1.85, H, "接地\n教学解释", kind="final")
harrow(c1, c2); harrow(c2, c3)
# 校验器打回回环(向下弧形虚线,置于行下方避免拥挤)
ax.add_patch(FancyArrowPatch((c2[0], YC - H/2), (c1[0], YC - H/2),
             connectionstyle="arc3,rad=-0.5", arrowstyle="-|>",
             color=INK, lw=1.0, ls="dashed", shrinkA=3, shrinkB=3, zorder=2))
ax.text((c1[0] + c2[0]) / 2, YC - H/2 - 0.52, "校验失败 → 打回重写",
        ha="center", va="center", fontsize=8.2, style="italic", color=INK, zorder=5)

fig.tight_layout(pad=0.3)
fig.savefig("pictures/cadx/three_chains.pdf", bbox_inches="tight")
plt.close(fig)
print("ok pictures/cadx/three_chains.pdf")
