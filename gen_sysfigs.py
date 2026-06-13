# -*- coding: utf-8 -*-
"""系统类示意图(架构/主流程/意图路由)统一为顶会风灰度矢量图。
   输出: pictures/cadx/{arch,pipeline,intent}.pdf  (字体子集已嵌,Windows 端直接嵌入)"""
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch

plt.rcParams.update({
    "font.sans-serif": ["Songti SC"], "font.serif": ["Songti SC"],
    "axes.unicode_minus": False,
})
INK = "#222222"; DARK = "#3a3a3a"; PROC = "#ededed"; GRAY = "#888888"; WARM = "#666666"

def box(ax, x, y, w, h, text, *, kind="data", fs=10.5, dash=False):
    sty = {
        "data":    ("white", GRAY, 1.0, INK,    "normal"),
        "process": (PROC,    GRAY, 1.0, INK,    "normal"),
        "emph":    ("white", DARK, 1.9, INK,    "bold"),
        "final":   (DARK,    DARK, 1.5, "white","bold"),
        "warm":    ("white", WARM, 1.0, WARM,   "normal"),
    }[kind]
    fc, ec, lw, tc, fw = sty
    ax.add_patch(FancyBboxPatch((x - w/2, y - h/2), w, h,
                 boxstyle="round,pad=0.02,rounding_size=0.12",
                 fc=fc, ec=ec, lw=lw, ls="--" if dash else "-", zorder=3))
    ax.text(x, y, text, ha="center", va="center", color=tc, fontsize=fs,
            fontweight=fw, zorder=4, linespacing=1.2)
    return (x, y, w, h)

def arr(ax, p, q, *, dash=False, color=INK, rad=None):
    (x0, y0, w0, h0), (x1, y1, w1, h1) = p, q
    if abs(y1 - y0) < 0.05:      sx, sy, tx, ty = x0+w0/2, y0, x1-w1/2, y1
    elif abs(x1 - x0) < 0.05:
        if y1 > y0: sx, sy, tx, ty = x0, y0+h0/2, x1, y1-h1/2
        else:       sx, sy, tx, ty = x0, y0-h0/2, x1, y1+h1/2
    else:                        sx, sy, tx, ty = x0+w0/2, y0, x1-w1/2, y1
    cs = dict(connectionstyle=f"arc3,rad={rad}") if rad is not None else {}
    ax.add_patch(FancyArrowPatch((sx, sy), (tx, ty), arrowstyle="-|>",
                 color=color, lw=1.15, ls="--" if dash else "-",
                 shrinkA=2, shrinkB=2, mutation_scale=12, zorder=2, **cs))


# ───────────────────────── ① 六层架构(纵向分层栈) ─────────────────────────
def fig_arch():
    layers = [
        ("交互层",            "图片上传 · 结果可视化 · 人工修正 · 智能体对话", "data"),
        ("API 服务层",        "协议入口 · 编排下发 · 审计 · 异步任务管理",      "data"),
        ("流水线事实层",      "组件/引脚检测 · 孔位映射 · 拓扑重构（只输出结构化事实）", "emph"),
        ("领域规则层",        "板型规则 · 电路分析 · 验证 · 风险评估 · 参考电路 DSL", "data"),
        ("Agent 与知识解释层","上下文编排 · 工具调用 · 检索契约 · 校验器（唯一接触大模型）", "emph"),
        ("基础支撑层",        "异步任务 · 缓存 · 容器化 · 单元/契约测试",        "data"),
    ]
    fig, ax = plt.subplots(figsize=(10.2, 5.0), dpi=200)
    ax.set_xlim(0, 11.0); ax.set_ylim(0, 5.6); ax.axis("off")
    x0, x1 = 1.55, 9.6; bh = 0.74; gap = 0.92
    ytop = 5.0
    ys = [ytop - i*gap for i in range(6)]
    for (name, mods, kind), y in zip(layers, ys):
        fc, ec, lw = (("white", DARK, 1.9) if kind == "emph" else ("white", GRAY, 1.0))
        ax.add_patch(FancyBboxPatch((x0, y - bh/2), x1 - x0, bh,
                     boxstyle="round,pad=0.02,rounding_size=0.10",
                     fc=fc, ec=ec, lw=lw, zorder=3))
        ax.plot([x0 + 2.55, x0 + 2.55], [y - bh/2 + 0.08, y + bh/2 - 0.08],
                color=GRAY, lw=0.8, zorder=4)
        ax.text(x0 + 1.28, y, name, ha="center", va="center", fontsize=10.2,
                fontweight="bold", color=INK, zorder=4)
        ax.text(x0 + 2.75, y, mods, ha="left", va="center", fontsize=8.8,
                color=INK, zorder=4)
    # 两侧方向箭头
    ax.add_patch(FancyArrowPatch((0.95, ys[0] + bh/2), (0.95, ys[-1] - bh/2),
                 arrowstyle="-|>", color=INK, lw=1.2, mutation_scale=12, zorder=2))
    ax.text(0.62, (ys[0]+ys[-1])/2, "上层发起调用", rotation=90, ha="center",
            va="center", fontsize=8.6, style="italic", color=INK)
    ax.add_patch(FancyArrowPatch((10.2, ys[-1] - bh/2), (10.2, ys[0] + bh/2),
                 arrowstyle="-|>", color=INK, lw=1.2, mutation_scale=12, zorder=2))
    ax.text(10.55, (ys[0]+ys[-1])/2, "逐层向上提供可证伪事实", rotation=90, ha="center",
            va="center", fontsize=8.6, style="italic", color=INK)
    fig.tight_layout(pad=0.3)
    fig.savefig("pictures/cadx/arch.pdf", bbox_inches="tight"); plt.close(fig)
    print("ok arch.pdf")


# ───────────────────────── ② 主业务流程(横向链 + 修正回路) ─────────────────────────
def fig_pipeline():
    fig, ax = plt.subplots(figsize=(11.2, 3.0), dpi=200)
    ax.set_xlim(0, 11.6); ax.set_ylim(-0.1, 3.0); ax.axis("off")
    stages = ["上传图片", "组件检测", "孔位映射", "拓扑重构", "参考验证", "语义分析", "诊断解释"]
    YM = 2.15; xs = [0.85 + i*1.62 for i in range(7)]
    nodes = []
    for s, x in zip(stages, xs):
        kind = "emph" if s in ("组件检测", "拓扑重构") else "data"
        nodes.append(box(ax, x, YM, 1.46, 0.66, s, kind=kind, fs=9.8))
    for i in range(6):
        arr(ax, nodes[i], nodes[i+1])
    # 人机协同修正回路(下方虚线)
    YC = 0.55
    h1 = box(ax, xs[3] - 0.2, YC, 1.5, 0.62, "人工修正", kind="warm", fs=9.6, dash=True)
    h2 = box(ax, xs[4] + 0.45, YC, 1.5, 0.62, "重算接口", kind="warm", fs=9.6, dash=True)
    arr(ax, h1, h2, dash=True, color=WARM)
    # 重算接口 → 回到拓扑重构(向上)
    arr(ax, (h2[0], YC, 0, 0.62), (nodes[3][0]+0.15, YM, 0, 0.66), dash=True, color=WARM, rad=0.3)
    ax.text(xs[2]-0.1, YC, "视觉结果不准时", ha="right", va="center", fontsize=8.4,
            style="italic", color=WARM)
    ax.text((h2[0]+nodes[3][0])/2+0.2, 1.45, "不重跑视觉,从修正元件起重算", ha="center",
            va="center", fontsize=8.0, style="italic", color=WARM)
    fig.tight_layout(pad=0.3)
    fig.savefig("pictures/cadx/pipeline.pdf", bbox_inches="tight"); plt.close(fig)
    print("ok pipeline.pdf")


# ───────────────────────── ③ 一图四意图(汇聚 → 共用状态图 → 切换) ─────────────────────────
def fig_intent():
    fig, ax = plt.subplots(figsize=(9.6, 3.6), dpi=200)
    ax.set_xlim(0, 10.0); ax.set_ylim(0, 3.8); ax.axis("off")
    intents = ["诊断", "概念讲解", "操作指导", "混合问答"]
    yi = [3.25, 2.4, 1.55, 0.7]
    ileft = [box(ax, 1.35, y, 1.6, 0.6, s, kind="data", fs=10) for s, y in zip(intents, yi)]
    graph = box(ax, 4.85, 1.98, 1.95, 1.0, "统一\n状态图", kind="emph", fs=11)
    for n in ileft:
        arr(ax, n, graph)
    outs = ["工具白名单", "校验规则", "回答模板"]
    yo = [2.85, 1.98, 1.11]
    oright = [box(ax, 8.35, y, 1.75, 0.6, s, kind="process", fs=10) for s, y in zip(outs, yo)]
    for n in oright:
        arr(ax, graph, n)
    ax.text(6.6, 2.55, "按意图切换", ha="center", va="center", fontsize=8.6,
            style="italic", color=INK,
            bbox=dict(boxstyle="square,pad=0.1", fc="white", ec="none"))
    fig.tight_layout(pad=0.3)
    fig.savefig("pictures/cadx/intent.pdf", bbox_inches="tight"); plt.close(fig)
    print("ok intent.pdf")


fig_arch(); fig_pipeline(); fig_intent(); print("DONE")
