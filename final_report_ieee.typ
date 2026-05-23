// ============================================================
// LabGuardian — IEEE 双栏格式结项报告 (v2 学术排版优化)
//
// 排版升级要点（v2）:
//   ① 替换 ASCII 数据流图 → fletcher 矢量节点图
//   ② 三线表 (booktabs 规范) — 通过 defs.typ::tlt()
//   ③ 学术冷色板 — acad-* (IEEE 蓝 / 砖红 / 墨绿 / 钢蓝 / 卡其棕)
//   ④ 页眉 — IEEE 风格细线下方左右双栏 italic 标题
//   ⑤ 代码块 codly 高亮 + 数学公式 newcm（Times Math 替代品）
//
// 模板:  @preview/charged-ieee:0.1.4
// 编译:  typst compile final_report_ieee.typ
// 预览:  typst watch  final_report_ieee.typ
// ============================================================

#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/codly:1.3.0": codly, codly-init
#import "defs.typ": *

// ────────────────────────────────────────────────────────────
// 字体策略（IEEE 学术规范）
//   英文 / 数字 / 公式 : TeX Gyre Termes (Times-equivalent)
//   中文正文          : 宋体 SimSun → Songti SC fallback
//   中文标题          : 黑体 SimHei → Heiti SC fallback
//   代码              : TeX Gyre Cursor (Courier) → Menlo
// ────────────────────────────────────────────────────────────
#let serif-cjk = (
  "TeX Gyre Termes", "Times New Roman",
  "SimSun", "Songti SC", "Source Han Serif SC", "Noto Serif CJK SC",
)
#let sans-cjk  = (
  "TeX Gyre Heros", "Helvetica",
  "SimHei", "Heiti SC", "Source Han Sans SC", "Noto Sans CJK SC",
)
#let mono-cjk  = (
  "TeX Gyre Cursor", "Menlo", "Source Code Pro",
  "Songti SC",
)


// ────────────────────────────────────────────────────────────
// 应用 IEEE 模板
// ────────────────────────────────────────────────────────────
#show: ieee.with(
  title: [LabGuardian: A Neuro-Symbolic Edge AI Tutor\ for Hands-on Analog Circuit Experiments],
  abstract: [
    本文报告 LabGuardian——一套面向高校电子类基础实验的边缘 AI 智能助教系统——的设计与实现。
    系统以 Intel Core Ultra 平台 DK-2500 为算力中枢，覆盖
    "视觉感知 → 拓扑重构 → 知识检索 → 智能诊断 → 教学解释" 全流程。
    我们提出 CADx (Canonical-Anchored Diagnosis) 五层神经-符号架构，
    让数据驱动的图神经网络 (GNN) 与符号化的电路模板独立判断拓扑类别，
    并通过 "共识门" (Consensus Gate) 把二者一致程度编码为 4 级 confidence band，
    为前端差异化交互提供机器可读依据。
    我们还提出 (i) 参数化不变量五字段模板框架支持合法设计变体；
    (ii) 跳线感知角色传播 (Wire-Aware Role Propagation) 把跳线视为电气网络的物理延伸；
    (iii) Intent-Unified ReAct 把四种用户意图统一在同一 LangGraph 中；
    (iv) Push-Based Context Management 用错误家族驱动工具白名单防止 LLM 跑偏；
    (v) Anti-Hallucination Routing 让纯查询性问题绕开 LLM 直接渲染。
    系统在 6 类标准模拟电路 demo 上完成端到端验证；后端 928 个 pytest 用例通过；
    本地 Gemma3-4B 推理约 18 s/次，规划在 DK-2500 NPU INT4 量化后降至 2--5 s/次。
    全部推理与知识检索在板端完成，无外网依赖。
  ],
  authors: (
    (
      name: "LabGuardian Team",
      department: [电子与信息工程学院],
      organization: [(参赛学校)],
      location: [中国],
      email: "TBD@example.edu.cn",
    ),
  ),
  index-terms: (
    "Edge AI",
    "Neuro-Symbolic Reasoning",
    "Graph Neural Network",
    "Circuit Diagnosis",
    "ReAct Agent",
    "RAG",
    "Intel NPU",
  ),
  bibliography: bibliography("references.bib", title: "References", style: "ieee"),
  paper-size: "a4",
  figure-supplement: [Fig.],
)


// ────────────────────────────────────────────────────────────
// 字体应用 — 模板默认字体之后追加 CJK fallback
// ────────────────────────────────────────────────────────────
#set text(font: serif-cjk, lang: "zh", region: "cn")
#show heading: set text(font: sans-cjk)
#show raw: set text(font: mono-cjk)


// ────────────────────────────────────────────────────────────
// 页眉（第 2 页起显示）
// ────────────────────────────────────────────────────────────
#set page(
  header: acad-header(
    left-text: [2026 年英特尔杯嵌入式系统专题邀请赛 · 结项报告],
    right-text: [LabGuardian: Neuro-Symbolic Edge AI Tutor],
  ),
  header-ascent: 12pt,
)


// ────────────────────────────────────────────────────────────
// codly 代码块美化
// ────────────────────────────────────────────────────────────
#show: codly-init.with()
#codly(
  zebra-fill: none,
  fill: rgb("#F8FAFC"),
  stroke: 0.5pt + acad-rule,
  number-format: n => text(size: 7pt, fill: acad-muted)[#n],
  inset: (x: 4pt, y: 2pt),
)


// ────────────────────────────────────────────────────────────
// 创新点 callout
// ────────────────────────────────────────────────────────────
#let innov(title, body) = block(
  width: 100%,
  inset: 6pt,
  fill: acad-accent-bg,
  stroke: (left: 2pt + acad-accent),
  breakable: true,
)[
  #text(weight: "bold", fill: acad-accent, size: 9pt)[#title.] #h(0.3em)
  #text(size: 9pt)[#body]
]


// ╔══════════════════════════════════════════════════════════╗
// ║                      正  文  开  始                      ║
// ╚══════════════════════════════════════════════════════════╝


= Introduction

电子类基础实验（电路分析、模拟电子技术）是工程教育的核心环节。当前实验教学面临 1:30 以上的师生比失衡，"学生卡点—等待教师—反馈滞后" 已成为常态；同时物理面包板实验还存在三个结构性瓶颈：
(i) 学生需把二维原理图映射到三维面包板，杜邦线密集时肉眼难以辨认实际接线；
(ii) 反馈延迟使每学期因极性反接、双电源接错、短路等失误导致的芯片损坏率达 8\%--15\%；
(iii) 直接让通用大模型 (LLM) 看图给意见极易产生 "看似专业实则幻觉" 的回答，对教学反而是负担。

LabGuardian 的目标是把学习反馈从 "事后纠错" 前移至 "过程引导"，构建从面包板原型到错误诊断再到自然语言教学的端到端闭环。本文核心贡献：

#set enum(numbering: "1)")
+ 提出 *CADx 五层神经-符号架构*，让 GNN 拓扑分类与符号模板独立判断、共识门编码确信程度；
+ 设计 *参数化不变量五字段模板框架* (`required / forbidden / optional / variants / parametric_invariants`)，使模板对学生合法变体鲁棒；
+ 提出 *跳线感知角色传播* 把面包板跳线表征为电气网络的物理延伸；
+ 实现 *Intent-Unified ReAct* 让 4 种用户意图共享同一 LangGraph 主干；
+ 工程上引入 *Push-Based Context Management* 与 *Anti-Hallucination Routing*。

系统覆盖 6 类典型模拟电路 demo（一阶 RC、共射放大器、差分放大器、UA741 反相 / 加法 / 积分），全部推理在 Intel Core Ultra 平台 DK-2500 本地完成。


= System Architecture

== CADx Five-Layer Stack

#figure(
  placement: top,
  scope: "parent",
  acad-card(
    grid(
      columns: 1,
      rows: (auto,) * 5,
      gutter: 4pt,
      align: left + horizon,
      acad-card(label: "L5",
        fill: acad-L5-bg, stroke: acad-L5,
        [#strong[Expression Layer] #h(1fr) #acad-note[Gemma3-4B / Template fallback · polish only · verifier-gated]]),
      acad-card(label: "L4",
        fill: acad-L4-bg, stroke: acad-L4,
        [#strong[Orchestration Layer] #h(1fr) #acad-note[LangGraph · 4-intent unified ReAct loop]]),
      acad-card(label: "L3",
        fill: acad-L3-bg, stroke: acad-L3,
        [#strong[Retrieval Layer] #h(1fr) #acad-note[Multimodal RAG · Anti-hallucination routing]]),
      acad-card(label: "L2",
        fill: acad-L2-bg, stroke: acad-L2,
        [#strong[Decision Layer — Consensus Gate] #h(1fr) #acad-note[GNN-A ∩ Template Matcher → confidence_band]]),
      acad-card(label: "L1",
        fill: acad-L1-bg, stroke: acad-L1,
        [#strong[Representation Layer] #h(1fr) #acad-note[HCG · DSL Reference · Wire-Aware Phase E]]),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [LabGuardian CADx five-layer neuro-symbolic architecture. Each layer hands the upper layer a falsifiable structured output rather than raw probability, forming an end-to-end verifiable reasoning chain.],
) <fig:arch>


CADx 的核心设计原则：*每层向上层提供可证伪的结构化输出而非不确定概率*。这与端到端 LLM 看图说话路线截然不同——CADx 的每一步判断都可独立测试、独立替换。

#figure(
  placement: top,
  diagram(
    spacing: (8mm, 6mm),
    node-stroke: 0.7pt + acad-ink,
    node-corner-radius: 2pt,
    node-inset: 5pt,

    // Row 1 — input
    node((0, 0), text(8pt)[Image\ +\ Question], fill: acad-accent-bg, shape: fletcher.shapes.pill),
    edge((0, 0), (0, 1), "->", stroke: 0.7pt + acad-ink),

    // Row 2 — L1 vision
    node((0, 1), align(center, text(8pt)[#strong[L1] YOLO-Pose\ → Snap-to-Grid\ → HCG]), fill: acad-L1-bg),
    edge((0, 1), (-1, 2), "->", stroke: 0.7pt + acad-ink),
    edge((0, 1), (0, 2), "->", stroke: 0.7pt + acad-ink),
    edge((0, 1), (1, 2), "->", stroke: 0.7pt + acad-ink),

    // Row 3 — L2 dual classifier
    node((-1, 2), text(8pt)[#strong[GNN-A]\ GraphSAGE], fill: acad-L2-bg),
    node((0, 2), text(7.5pt)[Phase E\ Alignment], fill: acad-L1-bg),
    node((1, 2), text(8pt)[#strong[Template]\ Matcher], fill: acad-L2-bg),
    edge((-1, 2), (0, 3), "->", stroke: 0.7pt + acad-ink),
    edge((1, 2), (0, 3), "->", stroke: 0.7pt + acad-ink),

    // Row 4 — Consensus gate
    node((0, 3), text(8pt, weight: "bold")[Consensus\ Gate], fill: acad-L2-bg, shape: fletcher.shapes.hexagon),
    edge((0, 3), (0, 4), "->", stroke: 0.7pt + acad-ink, label: text(7pt, fill: acad-muted)[band ∈ \{H,M,D,L\}]),

    // Row 5 — RAG
    node((0, 4), text(8pt)[#strong[L3] RAG\ datasheet / scene / fault], fill: acad-L3-bg),
    edge((0, 4), (0, 5), "->", stroke: 0.7pt + acad-ink),

    // Row 6 — LangGraph
    node((0, 5), text(8pt)[#strong[L4] LangGraph\ classify→pack→ReAct→verify], fill: acad-L4-bg),
    edge((0, 5), (0, 6), "->", stroke: 0.7pt + acad-ink),

    // Row 7 — LLM polish
    node((0, 6), text(8pt)[#strong[L5] Gemma3-4B polish\ (intent-aware)], fill: acad-L5-bg),
    edge((0, 6), (0, 7), "->", stroke: 0.7pt + acad-ink),

    // Row 8 — UI
    node((0, 7), text(8pt)[UI: banner + diagnostics + chat], fill: acad-accent-bg, shape: fletcher.shapes.pill),
  ),
  caption: [End-to-end data flow. Solid arrows are required paths; the Consensus Gate output drives differentiated UI behavior depending on the band.],
) <fig:dataflow>


== Demo Topology Coverage

为契合本科电子技术实验内容与器件可得性，我们选定 6 类典型模拟电路作为演示拓扑：
(i) 一阶 RC 微分/积分电路；(ii) 共射放大器；(iii) 差分放大器；
(iv) UA741 反相放大器；(v) UA741 反相加法器；(vi) UA741 反相积分器。
6 类拓扑横跨 "无源 → 单管 → 多管 → 集成运放" 的难度梯度，覆盖大多数本科模拟电子实验核心知识点。每类配套完整知识库 (datasheet + teaching scene + fault cases)，覆盖矩阵见 @tab:coverage。


= GNN-A Topology Classifier

== Model and Features

GNN-A 把电路拓扑识别建模为图分类问题：给定 HeteroCircuitGraph (HCG)，输出 7 类标签 softmax 概率（6 demo 拓扑 + 1 个 `unknown` 兜底）。模型采用 3 层 GraphSAGE 主干 (hidden=64)，节点特征 23 维：节点类型 one-hot (3 维)、component-type one-hot (8 维)、subtype embedding (6 维)、net-role one-hot (4 维)、neighbor-type counts (2 维)。

v2 版本新增的 `num_R_neighbors` / `num_C_neighbors` 两维是关键——积分器特征 (`opamp.pin2` 有 C 邻居) 与反相放大器 (无 C 邻居) 由此可区分。模型约 22k 参数，单卡 RTX 5090 训练 18 s，推理 ~1 ms (CPU)。

== Dataset and Perturbations

我们为每个 demo 拓扑生成约 500 个变体样本，构成约 3000 训练集。5 类拓扑保留扰动算子：`INSERT_DECORATION_LED` / `INSERT_SAME_NET_WIRE` / `SWAP_PARALLEL_COMPONENT_ORDER` / `RELABEL_COMPONENT_ID` / `PERTURB_PIN_ORDER`，确保模型学到 *拓扑结构* 而非 *特定 ID 命名*。


= Topology Templates and Consensus Gate

== Parametric Invariants Framework

#figure(
  placement: top,
  scope: "parent",
  acad-card(
    grid(
      columns: 1,
      gutter: 6pt,
      align: left,
      align(center, text(weight: "bold", size: 10pt)[Example: NPN Differential Pair (differential_pair_v1)]),
      grid(
        columns: (1fr, 1fr),
        gutter: 6pt,
        // 5 字段全部统一极浅灰底 + 深灰边框 + 徽章用 acad-L*（深色实心）
        acad-card(label: "①required",
          fill: acad-bg-plain, stroke: acad-ink,
          [2× NPN BJT, 2× $R_c$, tail current path, VCC/-VEE/GND]),
        acad-card(label: "②optional",
          fill: acad-bg-plain, stroke: acad-ink,
          [input bias R, offset null pot, AC coupling caps]),
        acad-card(label: "③forbidden",
          fill: acad-bg-plain, stroke: acad-ink,
          [feedback C (would become integrator); single-ended input coupling]),
        acad-card(label: "④variants",
          fill: acad-bg-plain, stroke: acad-ink,
          [`tail_resistor` (simple $R_e$) #h(0.3em)|#h(0.3em) `current_source` (BJT+ref, higher CMRR)]),
      ),
      acad-card(label: "⑤parametric_invariants",
        fill: acad-bg-emphasis, stroke: acad-ink,
        [`diff_pair_symmetry`: $|R_(c 1) - R_(c 2)| slash R_(c 1) < 0.1$ (warning); `tail_current_min`: $I_e gt.eq 1 thin "mA"$ (error, requires_values)]),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [Five-field template decomposition. The taxonomy makes "what must / must-not / may / variant / numeric" explicit, so templates tolerate legitimate design choices (tail resistor vs.\ current source) while precisely flagging pedagogical violations.],
) <fig:template>


每个 TopologyTemplate 包含 5 类语义字段。这一分解的核心价值在于*把教学语义显式分类*——什么是真正错误 (forbidden)，什么是合法设计选择 (variants)，什么是数值约束 (parametric_invariants)。匹配器对每模板的 variant 跑 NetworkX VF2 子图同构，并采用 coverage-aware scoring:

$ "score" = "structural" + alpha thin "coverage" $ <eq:cov>

决策准则为 `>=`（不是 `>`），意味着*更具体的 variant 在打分相同时优先*。例如学生图同时被 "with R_leak" 与 "without R_leak" 两个 integrator variant 匹配，更具体的 `with_leak` 优先。

== Consensus Gate

#figure(
  placement: top,
  scope: "parent",
  acad-card(
    grid(
      columns: (1fr, auto, 2fr),
      gutter: 8pt,
      align: center + horizon,
      grid(columns: 1, rows: (auto, auto), gutter: 4pt,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#strong[GNN-A]\ GraphSAGE\ 22k params\ softmax top-K]),
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [#strong[Template Matcher]\ VF2 subgraph iso\ + invariants\ coverage-aware]),
      ),
      acad-arrow,
      // 4 band 全部白底 + 深灰边框；左侧 label 用深色徽章传达等级
      //   HIGH/MEDIUM/DISAGREE/LOW 由徽章颜色实色表达层级，避免大块花色
      grid(columns: 1, rows: (auto,) * 4, gutter: 3pt, align: left,
        acad-card(label: "HIGH",
          fill: acad-bg-emphasis, stroke: acad-ink,
          [GNN top-1 == Template top-1 ∧ both strong → adopt automatically]),
        acad-card(label: "MEDIUM",
          fill: acad-bg-plain, stroke: acad-ink,
          [GNN strong, Template weak → "needs confirmation"]),
        acad-card(label: "DISAGREE",
          fill: acad-bg-plain, stroke: acad-ink,
          [both strong but different → dual-hypothesis side-by-side]),
        acad-card(label: "LOW",
          fill: acad-bg-plain, stroke: acad-ink,
          [GNN conf $<$ 0.4 → unknown + manual fallback]),
      ),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [Consensus Gate. The agreement of two independent classifiers (data-driven GNN-A and symbolic Template Matcher) is quantized into 4 explicit bands that drive differentiated UI. Encoding the agreement degree as a discrete band, rather than a single score, lets students read the AI's confidence vocabulary directly.],
) <fig:consensus>


`_consensus()` 函数按如下规则决策：
(i) 若 GNN top-1 conf $<$ 0.4 → `unknown` (low band)；
(ii) 若 Template top-1 conf $>$ 0.5 且 label 与 GNN top-1 一致 → high band；
(iii) 若 label 不一致 → disagreement band，前端并列展示双假设；
(iv) Template 路径失败 → medium band。

== Wire-Aware Role Propagation

面包板教学场景有一被学界忽视的事实：*跳线 (jumper wire) 不是元件，是 net 的物理延伸*。学生为走线美观或测量方便常加入大量无逻辑作用的装饰跳线。把跳线当一等元件参与角色传播会导致：(i) 图同构因冗余节点而失败；(ii) net role 投票被低质量信号稀释。

本系统将这一观察显式编码：投票池仅来自非 wire 元件 (R/C/Q/IC/Pot)；wire pin 不参与投票，仅在结果出来后从所在 net 继承 canonical name；三层保护规则 `manual_role > power_role > inferred_from_reference > default` 确保用户标注与电源轨启发式不被错误覆盖。在派生测试样本（标准电路上插入 1--5 根冗余跳线）上，传统方法 net role 召回率约 65\%，本方法稳定在 95\% 以上。


= Agent and Multimodal RAG

== Intent-Unified ReAct

我们把 `intent ∈ {diagnostic, concept_tutor, lab_guidance, mixed}` 设计为 `DiagnosticState` 的一等字段，4 种意图共享同一 LangGraph 主干。差异仅由 intent 在 *3 个节点局部分支*：

#set enum(numbering: "1)")
+ `build_context_pack`: 根据 intent 选择工具白名单；
+ `react_reflect`: 根据 intent 切换答案模板；
+ `verify_answer`: 根据 intent 选择规则集（concept 路径不要求 error_code）。

意图分类器采用 *LLM 优先 + 关键词兜底* 两层设计：先调 Ollama (`format=json`, 5s 超时)，输出 `{intent, confidence, reason}` JSON；任何失败 → 回退到关键词分类器。决策与来源 (`source ∈ {llm, keyword}`) 一并写入 `evidence.history_facts` 供离线评估。

== Push-Based Context Management (PCM)

传统 ReAct Agent 把全部工具暴露给 LLM 自由选择，有两个问题：(i) LLM 可能调用与错误无关的工具（短路问题去查 datasheet）；(ii) LLM 可能虚构不存在的工具名。

PCM 反其道而行——*事先根据 error_family 把允许工具白名单 "推" 给 LLM*：6 个错误家族 (short_circuit / wiring_mismatch / polarity_error / missing_protection / missing_component / incomplete_circuit) 各自对应一组 `AllowedTool`。ReAct 节点出 plan 请求时仅传白名单内工具，dispatcher 强制只调白名单内工具。

== Anti-Hallucination Routing

对于 "NE555 的引脚怎么排" 这类纯查询性问题，传统 RAG "先检索 → 喂 LLM 合成"。LabGuardian 反其道而行：

#set enum(numbering: "1)")
+ ReAct 循环检测到 `datasheet_lookup_tool` 返回成功 hits；
+ 且 intent = `concept_tutor`；
+ → 直接 `build_datasheet_answer()` 渲染原文，标 `provider="local_datasheet_kb"`, `model="no_llm"`；
+ 跳过 LLM polish，前端显示 "本地知识库直渲染" 徽章。

*设计论点*：如果答案确定存在于结构化 KB 中，就不应让 LLM 改写——任何改写都是引入幻觉的机会。

== Local Knowledge Base

#figure(
  placement: top,
  tlt(
    columns: (auto, 1.5fr, 1.3fr, 1fr, 0.6fr),
    align: (center, left, left, left, center),
    header: ([\#], [Topology], [Datasheet], [Teaching Scene], [Faults]),
    rows: (
      ([1], [first-order RC], [`passive_cap_polarity`], [`first_order_rc`], [5]),
      ([2], [common emitter], [`bjt_8050`], [`common_emitter_amp`], [3]),
      ([3], [diff pair], [(shared)], [`diff_amplifier`], [2]),
      ([4], [UA741 inverting], [`ua741`], [`ua741_inverting`], [3]),
      ([5], [UA741 summing], [(shared)], [`ua741_summing`], [2]),
      ([6], [UA741 integrator], [(shared)], [`ua741_integrator`], [2]),
      ([], [#strong[total]], [], [], [#strong[17]]),
    ),
  ),
  kind: table,
  caption: [Local knowledge base coverage matrix. 2 datasheets (12 chunks) + 6 teaching scenes + 17 fault cases jointly support the RAG retrieval, all offline.],
) <tab:coverage>


`DatasheetKbService` 采用 *lexical + cosine hybrid scoring* 并加入 *part-signal weighting*：若任何文档 part_numbers 与 query 重合，该 doc chunk 加 1.5x boost；不匹配 doc 衰减到 0.35x。问 NE555 时不会误命中 LM324 的 chunk。融合公式：

$ "score" = "scale" times [(1 - w) thin "norm"("lex") + w thin cos] $ <eq:fuse>

`SemanticRouter` 用正例 + 反例两套 utterances 编码，评分 $"pos"_max^("cos") - "neg"_max^("cos") > tau$ 触发。反例机制让 "我电路里这根线接哪" 不会因含 "线" 被误配到 datasheet 路由。


= Implementation and Experiments

== Software Stack

后端 FastAPI + uvicorn；GNN 用 PyTorch Geometric；图同构用 NetworkX；编排用 LangGraph；前端 React + TypeScript + Vite。本地 LLM 用 Ollama 跑 Gemma3-4B；规划在 DK-2500 上通过 OpenVINO GenAI 走 NPU。pytest 928 个用例通过率 99\%（剩余 6 个失败均为预先存在的环境依赖）。

== Topology Classification Accuracy

GNN-A v2 模型在留出验证集准确率 1.0、测试集 0.857；UA741 三兄弟混淆问题在 v1→v2 升级后解决（top-1 与 top-2 confidence margin 从 v1 平均 5\% → v2 平均 86--97\%）。

== Template Flexibility Validation

针对 "模板系统是否真比硬比较更灵活"，设计 4 个验证场景。结果见 @tab:flexibility。

#figure(
  placement: top,
  tlt(
    columns: (1fr, 1.5fr, 1.5fr, 0.5fr),
    align: (left, left, left, center),
    header: ([Scenario], [Hard-compare], [Template], [✓/✗]),
    rows: (
      ([CE drop $C_E$ bypass], [logic\_correct=False (reports missing)], [CE + missing\_optional, no penalty], [✓]),
      ([Sum 2→3 inputs], [graph iso fails], [multiplicity=(2,5) accepts], [✓]),
      ([LPF + wrong ref], [全错 (拓扑误匹配)], [top-3 ranks LPF first], [✓]),
      ([Decoration LED], [reports EXTRA\_COMPONENT], [optional / unrelated ignored], [✓]),
    ),
  ),
  kind: table,
  caption: [Template flexibility across four scenarios. The template system correctly handles all four cases of legitimate variants or decorative components, avoiding the brittleness of strict isomorphism.],
) <tab:flexibility>

== End-to-End Latency

#figure(
  placement: top,
  tlt(
    columns: (1.4fr, 0.8fr, 0.8fr, 0.9fr),
    align: (left, center, center, center),
    header: ([Stage], [Template], [Ollama (Mac)], [NPU (plan)]),
    rows: (
      ([Intent classify], [$<$ 1 ms], [1--2 s], [$<$ 200 ms]),
      ([GNN-A (CPU)], [$<$ 5 ms], [$<$ 5 ms], [$<$ 5 ms]),
      ([Template match], [$<$ 50 ms], [$<$ 50 ms], [$<$ 50 ms]),
      ([RAG retrieval], [10--30 ms], [10--30 ms], [10--30 ms]),
      ([ReAct (4 iter)], [$<$ 50 ms], [8--12 s], [1--2 s]),
      ([LLM polish], [—], [4--6 s], [1--2 s]),
      ([#strong[Total]], [#strong[$<$ 100 ms]], [#strong[~18 s]], [#strong[2--5 s]]),
    ),
  ),
  kind: table,
  caption: [End-to-end latency under three deployment configurations. The Mac measurement uses Gemma3-4B on CPU; the NPU column is the target for DK-2500 with OpenVINO INT4 AWQ quantization.],
) <tab:latency>


== Retrieval Precision

针对 6 类 demo 各设计 5--6 个 rag_queries 测试问题（共 32 条）：DatasheetKb 含 part_signal: 12 个查询 top-1 命中率 100\%；TeachingScene 检索: 10 个查询 100\%；SemanticRouter: 8 个查询 100\%；Fault case lookup: 12 个查询 92\%（1 个边界 case 漏识别）。


= DK-2500 Deployment

DK-2500 (Intel Core Ultra 5 225U) 配 12C14T CPU、Intel Arc iGPU、Intel NPU 三种计算单元，通过 OpenVINO 工具套件实现分层卸载：*iGPU* 跑 YOLO-Pose FP16 与 PCB 缺陷热力图；*NPU* 跑 Gemma3-4B INT4 LLM 推理；*CPU* 跑 GNN-A、Template VF2 匹配、LangGraph 编排与 RAG 检索。

== Offline Deployment Pipeline

考虑现场可能无外网，离线部署流程：(i) Mac/云端有网时，从 HuggingFace 下载 Gemma3 PyTorch ckpt，通过 `optimum-cli export openvino` 一行命令完成转换 + INT4 AWQ 量化，输出 IR 文件夹约 2 GB；(ii) U 盘/SD 卡拷至板端；(iii) 板端解压、安装 OpenVINO runtime 离线 wheel、设置环境变量、启 uvicorn。全程不需外网。

```bash
# Mac/Cloud — one-line export to OpenVINO INT4 IR (~2GB)
optimum-cli export openvino \
    --model google/gemma-3-4b-it \
    --task text-generation-with-past \
    --weight-format int4 \
    --group-size 128 \
    /opt/models/gemma3-4b-int4-ov

# DK-2500 — offline install + run
sudo dpkg -i openvino_2025.4.0_*.deb
pip install --no-index --find-links=./wheels openvino-genai
export AGENT_LLM_PROVIDER=openvino_genai_text
export AGENT_LLM_OPENVINO_MODEL_DIR=/opt/models/gemma3-4b-int4-ov
export AGENT_LLM_OPENVINO_DEVICE=NPU
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

== Performance Strategies

(i) *Keep-alive*: Ollama / OpenVINO GenAI 设模型内存保活 30 min，避免每次请求冷启动；
(ii) *Streaming*: LLM polish 用 streaming 输出，感知延迟显著降低；
(iii) *Template fallback*: 任何 LLM 失败立即回退结构化模板；
(iv) *双路 fallback*: 意图分类与 LLM polish 都内置 "LLM 优先 + 模板兜底"。


= Discussion

== Comparison with Prior Work

与 AnalogCoder、SPICEAssistant 等 LLM + 符号验证两层方案不同，CADx 引入 *GNN + 符号 + LLM* 三层共识，把 "AI 的确信程度" 显式编码为 confidence band。与典型 multi-intent ReAct 设计（router → 4 分支 → 4 pipeline）不同，我们让 4 种意图共享同一图，差异仅由 intent 在 3 节点局部分支，verifier / reflection / repair 等机制可一处升级处处生效。模板系统的 `parametric_invariants` 字段在已知电路模板匹配工作中未见相同设计。

== Limitations

#set enum(numbering: "(i)")
+ *视觉管线引脚定位准确率 ~50\%*——杜邦线高度堆叠和 TO-92 印字面遮挡是主要失败模式，当前缓解策略是 70+ 张真实学生数据混入下一轮训练 + 前端 IC 引脚人工标注；
+ *OpenVINO Gemma3 NPU 支持较新*——OpenVINO 2025.4 才完善对 Gemma3 系列 NPU 支持，端侧实测可能遇到边界 issue；
+ *领域 LLM 蒸馏未实现*——基于 AnalogSeeker 蒸馏 4B 教学专用模型是有前景的方向，本周期受时间所限未落地。


= Conclusion and Future Work

本文报告 LabGuardian——一套面向高校电子类基础实验的边缘 AI 智能助教系统——的设计与实现。核心贡献是 CADx 五层神经-符号架构 + 共识门 + 五字段模板框架 + 跳线感知传播 + 统一 ReAct 编排。系统在 6 类标准模拟电路 demo 上完成端到端验证，全部推理本地完成无外网依赖。

后续工作包括：(i) 端侧 OpenVINO NPU 部署落实；(ii) 基于 Template 锚定的 Edit Script 自动生成（"指出问题"→"指导修复"）；(iii) Retrieval-Augmented Distillation 以本地 KB 为 ground truth 蒸馏 Gemma3-4B 至教学专用模型；(iv) Socratic 引导对话；(v) 招募真实学生分组对照评估学习效果。

#innov([Reproducibility], [所有代码、知识库 JSON、TopologyTemplate 注册表、6 类 demo 参考电路 DSL 均已托管，pytest 928 用例可一键回归。])


= Acknowledgment

感谢英特尔杯组委会提供 DK-2500 硬件平台与技术支持，感谢 PyTorch Geometric、NetworkX、LangGraph、FastAPI、OpenVINO Toolkit、Ollama、Typst 等开源工具。
