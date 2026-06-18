#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node
// ============================================================================
//  英特尔杯大学生电子设计竞赛嵌入式系统专题邀请赛 —— 作品设计报告 (Final Report)
//  Typst 模板（严格按照官方《中文报告模板》排版要求转写）
// ----------------------------------------------------------------------------
//  排版要求一览（与官方模板批注逐条对应）：
//   · 报告题目（页眉右侧）         小五号黑体
//   · 中文题目                     三号黑体居中，上下各空一行
//   · "摘要" 二字                  四号黑体居中
//   · 摘要正文                     五号宋体，首行缩进二字，单倍行距
//   · 中文关键词标签               小四号黑体；关键词五号宋体，逗号分开，末尾无标点
//   · 英文题目                     三号 Times New Roman 居中加黑，一律大写，上下各空一行
//   · "ABSTRACT"                   四号 Times New Roman 居中加黑
//   · 英文摘要正文                 五号 Times New Roman，首行缩进两格，单倍行距
//   · "Key words" 标签             小四 Times New Roman 加黑（Key words 间加空格）
//   · 目录标题 "目 录"             三号黑体居中，上下各空一行；条目五号宋体单倍行距
//   · 一级标题（第X章）            三号黑体居中，上下各空一行
//   · 二级标题（X.Y）              四号黑体，序数空两格，单倍行距
//   · 三、四级标题（X.Y.Z）        小四宋体，空两格书写序数
//   · 正文                         中文五号宋体 / 英文五号 Times New Roman，首行缩进二字，单倍行距
//   · 分项序号                     (1)、(2)、(3) …
//   · 参考文献标注                 中括号 + 上标形式
//   · 公式                         另起一行，圆括号编号(章-序)，转行在等号/运算符处，等号对齐
//   · 表格                         三线表；表题在表上方居中，五号宋体加黑，"表X-Y 标题"无尾点
//   · 插图                         图序图题在图下方居中，五号宋体加黑，"图X-Y 标题"
//   · 页脚                         第 X 页  共 N 页（正文从第 1 页起编号）
//
//  编译： typst compile report_template.typ
//  预览： typst watch   report_template.typ
//  字体： Windows 自带 SimSun / SimHei / KaiTi / Times New Roman（已配 macOS 回退）
// ============================================================================


// ─────────────────────────── ① 可填写信息 ────────────────────────────────
// 把下面的内容替换为你自己的报告信息即可。
// 【封面信息：题目/姓名/导师/学校 待最后填写——当前为工作占位】
#let 竞赛年份 = "2026"
#let 报告题目 = "LabGuardian：基于边缘AI的智能助教系统"
#let 英文题目 = "LABGUARDIAN: AN INTELLIGENT TEACHING ASSISTANT SYSTEM BASED ON EDGE AI"
#let 学生姓名 = ""
#let 指导教师 = ""
#let 参赛学校 = ""

#let 中文摘要 = [
  高校电子实验中，学生常出现“原理图正确但实物接错”的接线错误。这类错误难以从外观直接发现，排查依赖教师逐项检查，而电子实验课师生比偏高，教师难以及时照顾全部学生。本文研究面向电子实验教学的自动接线诊断与解释方法，目标是在不依赖云端、可在边缘设备本地运行的前提下，给出可审计、可解释的诊断结果。所提系统 LabGuardian 不让大模型直接判定电路对错，而是把感知与判断分开。系统以面包板俯视照片为输入，先用自建引脚级数据集训练的关键点模型检测引脚，再将引脚对齐到孔位并结合面包板导通规则，重构出引脚级电气网表；随后由确定性图比对算法判断对错，输出带证据引用的结构化错误码；最后由端侧小模型只依据检索到的证据生成解释，并由校验器拦截缺乏依据的陈述。教学解释模型由双教师生成接地答案蒸馏、再经 INT4 量化得到，可在边缘设备上本地运行。其中，引脚级电气网表重构、判断与解释的分工设计，以及面向边缘部署的小模型蒸馏，是本文的主要工作。系统在 Intel DK-2500 上以 8 GB 内存预算完成视觉识别与端侧解释，延迟、吞吐与功耗可满足课堂实时使用。
]
#let 中文关键词 = ("面包板接线诊断", "神经—符号", "可审计解释", "知识蒸馏", "边缘部署")

#let 英文摘要 = [
  In undergraduate electronics laboratories, students often build circuits that are schematically correct but physically miswired. Such errors are hard to spot from appearance and must be checked item by item, while the high student-to-teacher ratio makes timely help difficult. This paper studies automatic diagnosis and explanation of breadboard wiring for laboratory teaching, aiming to produce auditable and explainable feedback that runs locally on an edge device without cloud access. The proposed system, LabGuardian, does not let a large model judge circuit correctness directly; instead it separates perception from judgement. It takes a top-view breadboard photo, detects pin keypoints with a model trained on a self-built pin-level dataset, aligns each pin to its hole and reconstructs a pin-level electrical netlist using breadboard connectivity rules; a deterministic graph-matching engine then decides correctness and emits structured error codes with evidence references; finally an on-device small model generates an explanation using only the retrieved evidence, and a verifier rejects unsupported statements. The teaching-explanation model is distilled from grounded answers produced by two teacher models and quantized to INT4 so that it runs locally on the edge device. The main work consists of keypoint-based pin-level netlist reconstruction, the division of labour between deterministic judgement and constrained explanation, and distillation of the small model for edge deployment. On the Intel DK-2500, the system performs visual recognition and on-device explanation within an 8 GB memory budget, with latency, throughput and power suitable for real-time classroom use.
]
#let 英文关键词 = (
  "breadboard wiring diagnosis",
  "neuro-symbolic",
  "auditable explanation",
  "knowledge distillation",
  "edge intelligence",
)


// ─────────────────────────── ② 字体与字号 ────────────────────────────────
#let 正文字体 = ("Times New Roman", "SimSun", "Songti SC", "Source Han Serif SC")   // 宋体 / 英文 Times
#let 标题字体 = ("Times New Roman", "SimHei", "Heiti SC", "Noto Sans SC")           // 黑体
#let 楷体字体 = ("KaiTi", "STKaiti", "Kaiti SC")                                    // 楷体
#let 华文楷体 = ("STKaiti", "华文楷体", "Kaiti SC")                                  // 华文楷体（封面“作品设计报告”）
#let 楷体GB = ("KaiTi_GB2312", "楷体_GB2312", "KaiTi", "STKaiti", "Kaiti SC")      // 楷体_GB2312（封面题目/信息栏；Windows 无此字体时回退 KaiTi）
#let 英文字体 = ("Times New Roman", "STSong")

#let 小五 = 9pt
#let 五号 = 10.5pt
#let 小四 = 12pt
#let 四号 = 14pt
#let 三号 = 16pt
#let 二号 = 22pt
#let 小二 = 18pt
#let 小初 = 36pt
#let 一行 = 16pt    // “空一行” 的近似高度（约一行正文）


// ─────────────────────────── ③ 页面：页眉 / 页脚 ─────────────────────────
// 页眉：左侧 ESDC 徽标 + 右侧报告题目（小五黑体）+ 下方分隔线，全篇可见。
#let 页眉 = {
  set text(font: 标题字体, size: 小五)
  set par(leading: 0pt, spacing: 0pt)
  // 分隔线作为 block 的底边框，始终紧贴徽标/题目底部（避免内容与线之间出现空隙）
  // 左：完整 ESDC 徽标（含下方文字）；右：报告题目，与徽标底部对齐
  block(width: 100%, stroke: (bottom: 0.7pt), inset: (bottom: 3pt))[
    #grid(
      columns: (auto, 1fr),
      align: (left + bottom, right + bottom),
      image("assets/esdc_logo.jpg", height: 1.2cm), text(font: 标题字体, size: 小五)[#报告题目],
    )
  ]
}

// 页脚：第 X 页 共 N 页（仅正文启用；正文从第 1 页起算）
#let 页脚 = context {
  set align(center)
  set text(font: 正文字体, size: 五号)
  [第 #counter(page).display() 页　共 #counter(page).final().first() 页]
}

#set page(
  paper: "a4",
  margin: (top: 3.1cm, bottom: 2.4cm, left: 2.6cm, right: 2.6cm),
  header: 页眉,
  header-ascent: 9pt, // 分隔线落在约 2.78cm 处、logo 顶在约 1.5cm 处，与原模板一致
  footer: none, // 前置部分（封面～目录）不显示页码，正文处再开启
)


// ─────────────────────────── ④ 正文与段落 ────────────────────────────────
#set text(font: 正文字体, size: 五号, lang: "zh", region: "cn")
// 首行缩进二字（all:true 使每段含标题后首段均缩进）；单倍行距
#set par(first-line-indent: (amount: 2em, all: true), leading: 1em, spacing: 1em, justify: true)
#set underline(offset: 3pt)


// ─────────────────────────── ⑤ 标题编号与样式 ────────────────────────────
// 一级用中文“第X章”，其余用 X.Y / X.Y.Z 数字编号
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    "第" + ("〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十").at(n.first()) + "章"
  } else {
    numbering("1.1.1.1", ..n)
  }
})

// 一级标题：三号黑体居中，上下各空一行；每章另起一页并复位图/表/公式计数器
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  set align(center)
  set par(first-line-indent: (amount: 0em, all: false))
  v(一行)
  text(font: 标题字体, size: 三号, weight: "bold")[
    #if it.numbering != none { counter(heading).display() + "  " }
    #it.body
  ]
  v(一行)
}

// 二级标题：四号黑体，序数空两格（缩进两字），单倍行距
#show heading.where(level: 2): it => {
  set par(first-line-indent: (amount: 0em, all: false))
  v(0.6em)
  text(font: 标题字体, size: 四号, weight: "bold")[
    #h(2em)#counter(heading).display()#h(0.5em)#it.body
  ]
  v(0.3em)
}

// 三级 / 四级标题：小四宋体，空两格书写序数
#show heading.where(level: 3): it => {
  set par(first-line-indent: (amount: 0em, all: false))
  v(0.4em)
  text(font: 正文字体, size: 小四, weight: "bold")[
    #h(2em)#counter(heading).display()#h(0.5em)#it.body
  ]
  v(0.2em)
}
#show heading.where(level: 4): it => {
  set par(first-line-indent: (amount: 0em, all: false))
  v(0.3em)
  text(font: 正文字体, size: 小四, weight: "bold")[
    #h(2em)#counter(heading).display()#h(0.5em)#it.body
  ]
  v(0.2em)
}


// ─────────────────────────── ⑥ 图 / 表 / 公式编号 ────────────────────────
// 编号按章重置：图X-Y / 表X-Y / (X-Y)
#set figure(numbering: num => context [#counter(heading).get().first()\-#num])
#set math.equation(numbering: num => context [(#counter(heading).get().first()\-#num)])
#show figure.where(kind: image): set figure(supplement: [图])
#show figure.where(kind: table): set figure(supplement: [表])
#show figure.where(kind: table): set figure.caption(position: top)   // 表题在上方
#show figure.where(kind: image): set figure.caption(position: bottom) // 图题在下方

// 图/表标题：五号宋体加黑，"表2-1 标题"（序号与“表/图”之间不加点，标题前空一格，末尾无标点）
#show figure.caption: it => context {
  set text(font: 正文字体, size: 五号, weight: "bold")
  set par(first-line-indent: (amount: 0em, all: false), leading: 0.7em)
  align(center)[#it.supplement#it.counter.display(it.numbering)#h(0.5em)#it.body]
}
// 公式占位居中、编号右对齐由 Typst 自动处理
#set math.equation(supplement: none)


// ─────────────────────────── ⑦ 实用宏 ───────────────────────────────────
// 参考文献上标标注：正文中写 #cite(<spice>) 得到上标 [1]

// 三线表：顶线 1pt + 表头底线 0.5pt + 底线 1pt，无竖线
#let 三线表(columns: (), align-cells: auto, header: (), rows: ()) = {
  let n = rows.len()
  set text(size: 小五)
  table(
    columns: columns,
    align: align-cells,
    inset: (x: 5pt, y: 4pt),
    stroke: (x, y) => {
      if y == 0 { (top: 1pt, bottom: 0.5pt) } else if y == n { (bottom: 1pt) } else { none }
    },
    table.header(..header.map(c => [*#c*])),
    ..rows.flatten().map(c => [#c]),
  )
}

// 中文关键词行
#let 关键词行(..kw) = {
  set par(first-line-indent: (amount: 0em, all: false), leading: 1em)
  text(font: 标题字体, size: 小四, weight: "bold")[关键词：]
  text(font: 正文字体, size: 五号)[#kw.pos().join("，")]
}
// 英文关键词行
#let key-words-line(..kw) = {
  set par(first-line-indent: (amount: 0em, all: false), leading: 1em)
  text(font: 英文字体, size: 小四, weight: "bold")[Key words: ]
  text(font: 英文字体, size: 五号)[#kw.pos().join(", ")]
}


// ── 架构图 / 流程图绘制辅助（纯黑白：黑描边+白底，层次以实线/虚线区分）──
#let fig-ink = black
#let fig-aux = black
#let fig-plain = "plain"
#let fig-emph = "emph"
#let fig-warm = "warm"
#let box-stroke(style) = if style == "warm" {
  (paint: fig-ink, thickness: 0.7pt, dash: "dashed")
} else { 0.7pt + fig-ink }

#let arch-layer(name, modules, fill: fig-plain) = block(
  width: 100%,
  fill: white,
  stroke: box-stroke(fill),
  radius: 3pt,
  inset: (x: 9pt, y: 8pt),
  grid(
    columns: (7.5em, 1fr),
    column-gutter: 11pt,
    align: (center + horizon, left + horizon),
    text(weight: "bold", size: 10pt, fill: fig-ink, name),
    {
      set par(leading: 0.62em, justify: false, first-line-indent: 0pt)
      text(size: 8.4pt, fill: fig-ink, modules)
    },
  ),
)
#let flow-node(body, fill: fig-plain) = block(
  width: 100%,
  fill: white,
  stroke: box-stroke(fill),
  radius: 3pt,
  inset: (x: 10pt, y: 8pt),
  align(center + horizon, {
    set par(leading: 0.62em, justify: false, first-line-indent: 0pt)
    text(size: 9pt, body)
  }),
)
#let v-both = align(center, text(fill: fig-aux, size: 12pt, sym.arrow.t.b))
#let v-down = align(center, text(fill: fig-aux, size: 12pt, sym.arrow.b))
#let h-right = align(center + horizon, text(fill: fig-aux, size: 12pt, sym.arrow.r))
#let h-both = align(center + horizon, text(fill: fig-aux, size: 12pt, sym.arrow.l.r))
#let tag-box(body, fill: fig-plain) = block(
  fill: white,
  stroke: box-stroke(fill),
  radius: 3pt,
  inset: (x: 6pt, y: 8pt),
  align(center + horizon, text(size: 9pt, body)),
)


// ════════════════════════════ 封面 (Cover) ═══════════════════════════════
#{
  set align(center)
  set par(first-line-indent: (amount: 0em, all: false), leading: 1em)

  v(0.6cm)
  text(font: 正文字体, size: 四号)[#竞赛年份 年英特尔杯大学生电子设计竞赛嵌入式系统专题邀请赛]
  v(0.2em)
  text(font: 英文字体, size: 四号)[#竞赛年份 Intel Cup Undergraduate Electronic Design Contest]
  v(0.1em)
  text(font: 英文字体, size: 四号)[#"- Embedded System Design Invitational Contest"]

  v(1.0cm)
  text(font: 华文楷体, size: 32pt)[作品设计报告] // 华文楷体 32pt
  v(0.1em)
  text(font: 英文字体, size: 32pt)[Final Report]

  v(0.8cm)
  image("assets/esdc_logo.jpg", width: 38%)

  v(1.4cm)
  // 报告题目：______（标签 楷体_GB2312 二号 22pt）
  grid(
    columns: (auto, 1fr),
    align: (left + bottom, left + bottom),
    column-gutter: 0.3em,
    text(font: 楷体GB, size: 二号)[报告题目：],
    box(width: 100%, stroke: (bottom: 1pt), inset: (bottom: 4pt))[
      #align(center)[#text(font: 楷体GB, size: 三号)[#报告题目]]
    ],
  )

  v(1.5cm)
  // 学生姓名 / 指导教师 / 参赛学校（楷体_GB2312 三号 16pt）
  let 信息行(标签, 值) = grid(
    columns: (auto, 7.6cm),
    align: (left + bottom, center + bottom),
    column-gutter: 0.3em,
    text(font: 楷体GB, size: 三号)[#标签：],
    box(width: 100%, stroke: (bottom: 1pt), inset: (bottom: 3pt))[
      #text(font: 楷体GB, size: 三号)[#值]
    ],
  )
  block(width: 12.5cm)[
    #set align(center)
    #信息行("学生姓名", 学生姓名)
    #v(0.8cm)
    #信息行("指导教师", 指导教师)
    #v(0.8cm)
    #信息行("参赛学校", 参赛学校)
  ]
}


// ═════════════════════════ 参赛作品原创性声明 ════════════════════════════
#pagebreak()
#{
  set align(center)
  set par(first-line-indent: (amount: 0em, all: false), leading: 1em)
  v(0.4cm)
  text(font: 标题字体, size: 四号, weight: "bold")[#竞赛年份 年英特尔杯大学生电子设计竞赛嵌入式系统专题邀请赛]
  v(0.6em)
  text(font: 标题字体, size: 小二, weight: "bold")[参赛作品原创性声明]
}
#v(1.0cm)
#block(width: 100%)[
  #set par(first-line-indent: (amount: 2em, all: true), leading: 1.6em, justify: true)
  #set text(font: 正文字体, size: 四号)
  本人郑重声明：所呈交的参赛作品报告，是本人和队友独立进行研究工作所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果，不侵犯任何第三方的知识产权或其他权利。本人完全意识到本声明的法律结果由本人承担。
]
#v(2.5cm)
#block(width: 100%)[
  #set par(first-line-indent: (amount: 0em, all: false), leading: 2em)
  #set text(font: 正文字体, size: 四号)
  #h(1fr) 参赛队员签名：#h(3cm)
  #v(0.8cm)
  #h(1fr) 日　期：　　　年　　月　　日#h(1.2cm)
]


// ════════════════════════════ 中文摘要 ═══════════════════════════════════
#pagebreak()
// 中文题目：三号黑体居中，上下各空一行
#align(center)[
  #v(一行)
  #text(font: 标题字体, size: 三号, weight: "bold")[#报告题目]
  #v(一行)
  // “摘要”二字：四号黑体居中
  #text(font: 标题字体, size: 四号, weight: "bold")[摘　要]
]
#v(一行)   // 空一行
// 摘要正文：五号宋体，首行缩进二字，单倍行距
#block(width: 100%)[
  #set par(first-line-indent: (amount: 2em, all: true), leading: 1em, justify: true)
  #set text(font: 正文字体, size: 五号)
  #中文摘要
]
#v(一行)   // 空一行
#关键词行(..中文关键词)


// ════════════════════════════ 英文摘要 ABSTRACT ══════════════════════════
#pagebreak()
#align(center)[
  #v(一行)
  // 英文题目：三号 Times New Roman 居中加黑，一律大写
  #text(font: 英文字体, size: 三号, weight: "bold")[#upper(英文题目)]
  #v(一行)
  // ABSTRACT：四号 Times New Roman 居中加黑
  #text(font: 英文字体, size: 四号, weight: "bold")[ABSTRACT]
]
#v(一行)
#block(width: 100%)[
  #set par(first-line-indent: (amount: 2em, all: true), leading: 1em, justify: true)
  #set text(font: 英文字体, size: 五号)
  #英文摘要
]
#v(一行)
#key-words-line(..英文关键词)


// ════════════════════════════ 目  录 ═════════════════════════════════════
#pagebreak()
#align(center)[
  #v(一行)
  #text(font: 标题字体, size: 三号, weight: "bold")[目　录]
  #v(一行)
]
#{
  set text(font: 正文字体, size: 五号)
  set par(leading: 1em, first-line-indent: (amount: 0em, all: false))
  show outline.entry: it => {
    set text(font: 正文字体, size: 五号)
    it
  }
  outline(title: none, depth: 3, indent: 1.5em)
}


// ════════════════════════════ 正文 (Body) ════════════════════════════════
// 正文从第 1 页起编号，启用页脚
#pagebreak()
#set page(footer: 页脚)
#counter(page).update(1)


= 绪论

== 教学背景与核心痛点

高校电子类基础实验是学生由理论走向工程实践的关键环节.学生需依据电路原理图，在面包板上插接电阻、电容、二极管、发光二极管、晶体管和运算放大器等元件，并借助电源、示波器和函数信号发生器等工具来对电路进行实验。这一过程要求学生完成从理论操作到实物操作的完整过程—，即由电路原理到元件功能、由二维原理图到面包板孔位、由实验现象到故障原因，任何操作过程的失败都可能使实验停滞。

电子实验课普遍师生比例不匹配，教师难以同时照顾到所有学生。学生向教师提出问题后，教师还需逐项排查元件是否插对、引脚是否接反、孔位是否正确、电源是否误接等基础问题。此类排查高度依赖经验、重复性强，却不能省略。一旦出现极性反接与电源短路可能损坏芯片，存在损坏仪器的风险。

上述场景对智能诊断提出了四个超出常规视觉识别的核心难点。其一，真实图像遮挡严重，导线交叠、元件遮挡引脚与拍摄角度差异都会干扰识别，而常规目标检测只给元件级边界框、无法判定引脚插入哪一孔位，因而诊断必须深入引脚级与孔位级。其二，面包板导通关系不直观，主区按列导通、中缝隔离左右半区、电源轨可能分段，须将物理孔位映射为导通节点，才能判定相邻孔位并非同网、或两引脚短接于同一网络。其三，教学需要可解释、可在界面高亮的证据链而非黑盒结论（具体错误码与证据字段见第四章）。其四，系统须适应边缘环境，实验室网络未必稳定、数据不宜全部上云，故以边缘设备为主要运行平台、降低依赖。

== 现有技术路线及其局限

围绕“判断学生电路是否正确”这一目标，现有技术路线大致可分为三类，各自存在难以回避的局限。

第一类是通用电路仿真软件。以 SPICE 为代表，它面向理想原理图、验证设计层面的正确性，却无法感知面包板上的真实接线，难以发现“原理图正确但实物接错”这一最常见的问题#cite(<spice>)。

第二类是纯规则或模板比较。它借助图同构与引脚角色规则给出确定、可解释的结论#cite(<subgemini>)，但在遇到多余元件、角色标注偏弱、输入输出网络重映射等边界情形时需不断打补丁，易判定过宽或诊断粒度不足。

第三类是端到端大模型直接看图判错。近年多模态大模型展现出强大的视觉理解能力#cite(<llava>)，亦有研究进一步将其用于电路网表故障定位与端到端电路分析辅导#cite(<llm4eda>)#cite(<spiced>)#cite(<e2ecircuit>)；但这类方案多由模型自身承担对错判定、且普遍依赖云端算力，其输出难以审计、易生幻觉，不宜作为正误判定的唯一依据，难以满足教学对安全与可解释的严苛要求。

因此，本文采取折中且工程可落地的路线，由确定性算法构建可验证的结构化事实链承担事实判断，再由智能体在受约束的证据范围内生成解释，从而在可解释性与安全性之间取得平衡。这一“神经—符号”的设计取向贯穿全文，也是本系统区别于上述三类方案的根本所在。

== 项目定位、目的与必要性

LabGuardian 是面向电子实验教学的边缘智能助教系统。与在虚拟环境验证原理的通用仿真不同，它以学生实际搭建的面包板照片为输入，将元件、引脚、孔位与电气连接重建为可验证、可审计的结构化事实，再与参考电路逻辑比较，输出错误位置、成因、风险等级与修改建议，把高度依赖经验的实验巡检形式化为可复现、可解释的诊断流程。

系统主线可形式化为“元件 → 引脚 → 物理孔位 → 导通节点 → 电气网络 → 结构化网表”的逐级事实链，把“某引脚在图像中接近某处”的模糊观察，逐层上升为“某引脚归属某一电气网络”的确定结论。该链路的可靠性，决定了系统能否将像素层面的连接观测转化为确定性的网络归属判断。

== 需求分析与本文工作

面向上述教学场景，系统需同时服务三类用户。学生希望快速知道电路哪里错、为什么错、如何改；教师与助教希望掌握多个实验台状态、定位共性错误以减少重复巡检；系统维护者则关注各模块数据约定稳定、便于后续扩展。

在功能上，系统以“图像接入 → 组件与引脚检测 → 孔位映射 → 拓扑重构 → 参考比较 → 诊断解释”为主线，识别教学常见元件、将引脚吸附至物理孔位并映射为电气节点、合并导线网络输出结构化网表、与逻辑参考电路比较生成差异报告，最终转化为学生可理解的自然语言建议。同时提供人工修正与结果可视化，并在服务端记录运行元数据与硬件遥测。

在非功能上，系统强调准确性、可解释性、低延迟、弱网可用、隐私保护与可扩展性。每个错误都应有证据引用与可视化目标，交互需及时，推理尽量本地运行，新增板型、元件、参考电路与故障案例时无需重写核心链路。

围绕上述需求，本项目的主要工作如下。（1）提出面向真实拍摄照片的引脚级电气网表重构方法，以关键点检测与孔位吸附替代元件级目标检测，将识别粒度下沉至引脚与孔位；（2）以确定性图比对承担对错判断、智能体仅在受约束证据内生成解释，并由确定性校验器拦截无依据陈述，构成“神经—符号”的可审计诊断链；（3）面向边缘部署，采用双教师蒸馏与 INT4 量化得到端侧教学解释模型，并在 Intel DK-2500 上以 NPU、iGPU、CPU 异构分工实现本地推理；（4）通过三组消融与端侧实测，分别考察检索约束、模型蒸馏与量化的作用。

== 诊断三链路设计

本项目并非简单叠加“视觉模型 + 大语言模型”，而是把诊断拆成三条逐级递进的链路，即视觉识别、网络搭建与情景解释。如#ref(<fig:three-chains>)所示，前两链以确定性算法产出可审计的结构化事实，第三链才由受约束的小模型把事实改写为教学语言。这样既用上大模型的语言能力，又不把对错判定交给不可审计的模型。

#figure(
  [#set text(size: 9pt)
    #diagram(
      spacing: (3.6mm, 6.5mm),
      node-stroke: 0.7pt + black,
      node-corner-radius: 3pt,
      node-inset: 6.5pt,
      node-shape: fletcher.shapes.rect,

      // ── 行名(左侧小字) ──
      node((0, 0), text(weight: "bold")[全图\ 视觉识别], stroke: none, inset: 2pt),
      node((0, 2), text(weight: "bold")[参考\ 电路逻辑比对], stroke: none, inset: 2pt),
      node((0, 4), text(weight: "bold")[受约束行\ 情景解释], stroke: none, inset: 2pt),

      // ── 第1行: 感知事实链 ──
      node((1.1, 0), [面包板\ 俯视照片], name: <a1>),
      node((3.0, 0), [关键点检测（NPU）\ 孔位吸附 · 板型规则], fill: luma(236), name: <a2>),
      node((5.2, 0), [引脚级\ 结构化网表], name: <a3>),
      edge(<a1>, <a2>, "-|>", stroke: 0.6pt + black),
      edge(<a2>, <a3>, "-|>", stroke: 0.6pt + black),

      // ── 第2行: 符号判定链 ──
      node((1.6, 2), [VF2 确定性图比对 · 模板匹配], stroke: 1.3pt + black, name: <b1>),
      node((3.7, 2), [结构化\ 错误码], name: <b2>),
      edge(<b1>, <b2>, "-|>", stroke: 0.6pt + black),

      // ── 第3行: 情景解释链 ──
      node((1.1, 4), [受约束 LLM\ 生成草稿], fill: luma(236), name: <c1>),
      node((2.95, 4), [不可绕过的\ 确定性校验器], stroke: 1.3pt + black, name: <c2>),
      node((4.7, 4), text(fill: white)[可靠性\ 教学解释], fill: luma(62), name: <c3>),
      edge(<c1>, <c2>, "-|>", stroke: 0.6pt + black),
      edge(<c2>, <c3>, "-|>", stroke: 0.6pt + black),

      // ── 链间纵向传递(竖直向下箭头) ──
      edge(
        <a3.south>,
        (5.2, 2),
        "-|>",
        stroke: 0.6pt + black,
        label: text(8pt, fill: luma(90))[引脚级网表],
        label-side: right,
        label-sep: 3pt,
      ),
      // VF2 向下,对齐校验器(c2)正上方,标「结构化错误码」于分隔线处
      edge((2.95, 2), (2.95, 4), "-|>", stroke: 0.6pt + black),
      node((3.35, 3), text(8pt, fill: luma(90))[结构化错误码], stroke: none, inset: 1pt),

      // ── 分界(横向虚线)及上下小字 ──
      edge((0.4, 3), (5.6, 3), stroke: (paint: luma(100), dash: "dashed")),
      node((5.6, 2.78), text(8pt, fill: luma(60))[事实生产（可核验 · 可审计）], stroke: none, inset: 1pt),
      node((5.6, 3.22), text(8pt, fill: luma(60))[话术生成（受约束）], stroke: none, inset: 1pt),

      // ── 校验失败回环(向下弯曲虚线,行下方) ──
      edge(<c2.south>, <c1.south>, "-|>", bend: 42deg, stroke: (paint: luma(100), dash: "dashed")),
      node((2.0, 4.85), text(8pt, fill: luma(90))[校验失败 → 打回重写], stroke: none, inset: 1pt),
    )
  ],
  caption: [神经—符号的三链路：感知、符号两链“生产”可审计的结构化事实，安全敏感的对错判定只发生在符号判定链（VF2 确定性图比对）；以“事实生产 / 话术生成”为解释边界，第三链才由受约束小模型把事实改写为教学语言，并经不可绕过的校验器拦截无依据陈述（校验失败即打回重写）],
) <fig:three-chains>

= 系统总体设计

== 总体架构

总体架构要回答的核心问题是，如何既用上大模型的语言能力，又不让它参与安全敏感的对错判定。LabGuardian 的答案是以分层把“事实生产”与“话术生成”在结构上隔开。系统采用交互端与服务端分离，交互端负责图片上传、参数与参考电路选择、结果可视化、人工修正与智能体对话；服务端承接协议入口、视觉与拓扑流水线、领域规则验证、知识检索、智能体编排与遥测推流。整体可概括为“交互层—API 服务层—流水线事实层—领域规则层—Agent 与知识解释层—基础支撑层”六个层次，各层次的职责如#ref(<fig:arch>)所示。由此“事实生产”与“话术生成”相互分开，下游的自然语言解释只能以上游可核验的结构化事实为依据。

#figure(
  [#set text(size: 9pt)
    #context {
      let BARW = 13.2cm
      let layers = (
        ("交互层", "图片上传 · 结果可视化 · 人工修正 · 智能体对话", false),
        ("API 服务层", "协议入口 · 编排下发 · 审计 · 异步任务管理", false),
        ("流水线事实层", "组件/引脚检测 · 孔位映射 · 拓扑重构（只输出结构化事实）", true),
        ("领域规则层", "板型规则 · 电路分析 · 验证 · 风险评估 · 参考电路 DSL", false),
        ("Agent 与知识解释层", "上下文编排 · 工具调用 · 检索约束 · 校验器（唯一接触大模型）", true),
        ("基础支撑层", "异步任务 · 缓存 · 容器化 · 单元/约定测试", false),
      )
      let layerbar(name, mods, emph) = box(
        width: BARW,
        stroke: (if emph { 1.3pt } else { 0.7pt }) + black,
        radius: 3pt,
        inset: 0pt,
      )[#grid(
        columns: (3.45cm, 0.7pt, 1fr),
        rows: 1.0cm,
        align: (center + horizon, center + horizon, left + horizon),
        inset: (x: 7pt, y: 0pt),
        text(weight: "bold")[#name], rect(width: 0.7pt, height: 100%, fill: luma(120), stroke: none), text[#mods],
      )]
      let bars = stack(spacing: 6pt, ..layers.map(((n, m, e)) => layerbar(n, m, e)))
      let H = measure(bars).height
      let varrow(up) = box(width: 8pt, height: H)[
        #place(center + horizon, line(start: (0pt, 0pt), end: (0pt, 100%), stroke: 0.9pt + black))
        #if up { place(top + center, polygon(fill: black, (0pt, 7pt), (8pt, 7pt), (4pt, 0pt))) } else {
          place(bottom + center, polygon(fill: black, (0pt, 0pt), (8pt, 0pt), (4pt, 7pt)))
        }
      ]
      grid(
        columns: (auto, auto, auto, auto, auto),
        column-gutter: 5pt,
        align: horizon,
        rotate(-90deg, reflow: true, text(style: "italic")[上层发起调用]),
        varrow(false),
        bars,
        varrow(true),
        rotate(90deg, reflow: true, text(style: "italic")[逐层向上提供可核验事实]),
      )
    }
  ],
  caption: [系统六层总体架构],
) <fig:arch>

== 主业务流程

一次完整诊断从交互端上传图片开始。用户选定参考电路与阈值参数后，图片提交至同步诊断接口，编排器依次执行从组件检测到语义分析的各环节，服务层把结果封装为统一诊断结果并同步到课堂状态。交互端展示事实链与诊断报告后，自动向智能体请求基于运行证据的诊断解释与下一步建议。整体流程如#ref(<fig:pipeline>)所示。

若视觉映射不准确，交互端可进入网表模式人工修正孔位、端口、网络角色或器件标注后调用重算接口；服务端不重跑视觉检测，仅从修正后的元件重新执行拓扑重构、参考验证与语义分析，以人机协同避免视觉阶段偶发错误导致系统整体不可用。

#figure(
  [#set text(size: 9.5pt)

    #let main = ("上传图片", "组件检测", "孔位映射", "拓扑重构", "参考验证", "语义分析", "诊断解释")
    #let emphs = ("组件检测", "拓扑重构")
    #let dash = (paint: rgb("#666"), dash: "dashed")

    #diagram(
      spacing: (3mm, 13mm),
      node-inset: 7pt,
      node-corner-radius: 3pt,
      ..main.enumerate().map(((i, s)) => node((i, 0), s, stroke: (if s in emphs { 1.3pt } else { 0.7pt }) + black)),
      ..range(6).map(i => edge((i, 0), (i + 1, 0), "-|>", stroke: 0.7pt)),
      // 人机协同修正回路
      node((2.7, 1.05), [人工修正], stroke: dash, corner-radius: 3pt),
      node((4.3, 1.05), [重算接口], stroke: dash, corner-radius: 3pt),
      node((1.35, 1.05), text(8pt, fill: rgb("#555"))[视觉结果不准时], stroke: none),
      edge((2.7, 1.05), (4.3, 1.05), "-|>", stroke: dash),
      edge(
        (4.3, 1.05),
        (3, 0),
        "-|>",
        bend: 32deg,
        stroke: dash,
        label: text(7.5pt, fill: rgb("#555"))[不重跑视觉，从修正元件起重算],
        label-pos: 0.55,
        label-side: right,
      ),
    )
  ],
  caption: [主业务流程：上排为自动诊断主链（上传图片 → 组件检测 → 孔位映射 → 拓扑重构 → 参考验证 → 语义分析 → 诊断解释）；下方为人机协同修正回路——视觉结果不准时，人工修正后从拓扑重构起重算，不重跑视觉检测],
) <fig:pipeline>

== 技术选型与设计原则

在技术选型上，服务端以 Python 与 FastAPI 构建异步接口，视觉识别采用 YOLO 系列模型经 OpenVINO 适配英特尔异构硬件。电气比对基于图论库实现确定性图同构与子图匹配，知识检索使用本地多通道知识库。后端解释模型由开源中文基座（Qwen2.5-1.5B，详见第五章）蒸馏量化得到，交互端以画布叠加方式呈现识别与诊断结果。

在此之上，系统设计遵循四项原则。视觉模型只产生候选事实，最终结论须经板型规则、拓扑分析与验证模块约束；各阶段输出与网表、诊断报告、上下文包均以统一结构化格式为协作边界，避免任何一方私自猜测；允许把 AI 输出修正为可信事实后再重算；保留模型路径、推理参数、版本号与阶段耗时，连同遥测用于分析追溯。


== 本地运行与容器化部署

英特尔竞赛平台在本项目中并非演示载体，而是系统设计的约束来源。DK-2500 的 NPU、iGPU 与 CPU 恰好对应视觉关键点推理、自回归解释生成与图算法/编排三类负载，避免单一计算单元被争抢，并使项目能以真实板端功耗与延迟数据证明“可在课堂边缘部署”，而非仅在开发机上完成算法验证。

服务端以 FastAPI 配合 Redis/Celery 组织异步接口；边缘部署采用统一模型根目录、模型以只读方式挂载，并将模型版本、推理尺寸与板型定义写入运行元数据以保证可复现。

竞赛平台并非仅作运行服务端的小主机，而是把异构计算能力纳入系统架构。OpenVINO#cite(<openvino>)适配端侧推理、Level-Zero 与 NPU 驱动栈负责设备调度、遥测通道实时回传利用率与功耗。平台资源与系统负载的对应关系如表#ref(<tab:intel-platform-use>)所示。

#figure(
  三线表(
    columns: (1fr, 1.9fr, 2.25fr),
    align-cells: (left, left, left),
    header: ([平台资源], [系统负载], [使用理由与实测依据]),
    rows: (
      ([NPU], [YOLOv8s-pose INT8 引脚关键点检测], [张量计算规则、可常驻；13.37 ms、74.7 img/s，增量功耗约 4.12 W]),
      ([iGPU], [OpenVINO GenAI INT4 文本生成与解释], [自回归生成并行度高；约 23 tok/s，CPU 对照功耗约为其 4.7 倍]),
      ([CPU], [图同构、子图同构、检索、服务编排、遥测], [不规则控制流与图算法更适合通用核心，释放加速器给模型推理]),
      (
        [内存],
        [视觉模型、INT4 学生模型、知识库与服务进程共存],
        [学生模型约 0.88 GB，解释峰值约 1.36 GB，可落入 8 GB 预算],
      ),
      ([遥测], [5 Hz WebSocket 推送硬件状态与流水线阶段], [把平台利用率变成可视化证据，便于课堂演示与竞赛验收]),
    ),
  ),
  caption: [Intel DK-2500 平台资源与 LabGuardian 负载映射],
) <tab:intel-platform-use>

== NPU、iGPU 与 CPU 的异构分工

DK-2500 搭载 Intel Core Ultra 5 225U，板端经 OpenVINO 配合 Level-Zero 与 NPU 驱动栈完成异构推理。各阶段对算力的需求差异显著。视觉检测是规则的稠密张量运算，适合专用加速器；拓扑与图论计算是不规则数据流，更适合通用核心。据此，NPU 常驻视觉关键点检测（约 75 img/s，几乎不占用其他单元），iGPU 承担自回归的解释生成与热力图，CPU 处理图同构、检索、编排与遥测等不规则逻辑。

= 视觉感知与网表重构

本系统将“看图诊断电路”分解为组件检测、引脚检测、孔位映射、拓扑重构和参考比较几个明确的步骤。这几个步骤分别负责一段流程，而智能体仅负责解释，使每一步可独立测试、可视化与修正，降低端到端模型难以审计、易于幻觉的风险。

== 自建引脚级面包板数据集

视觉链路的可靠性首先取决于训练数据，而本场景需要的既非原理图符号数据、亦非印制电路板（PCB）器件数据，而是真实面包板照片上精确到引脚与孔位的细粒度标注。经调研，已有电路类数据集多停留在原理图识别、PCB 缺陷检测或干净网表层面#cite(<amsnet>)，鲜有在“教学面包板 + 引脚级关键点 + 孔位映射 + 真实干扰”四个维度同时满足本任务者。为此本项目自行采集并标注了一套专用数据集，构成本系统视觉感知的基础，也是既有公开资源所缺少的。

数据集采集自真实实验台照片，覆盖六类教学拓扑，并刻意纳入多角度、不同光照与导线遮挡等真实变体，样本本身即贴近课堂实拍的情景、无需合成增强。标注采用“组件级边界框 + 引脚级关键点”双层结构（关键点张量 3×3，每实例至多 3 引脚，记录横纵坐标与可见性），把识别精度从元件级下沉到引脚级。这正是常规检测数据集所不具备、却为电气诊断所必需的粒度。数据按训练 / 验证 / 测试留出划分以支持独立评测，主要规格如#ref(<tab:dataset>)所示。

#figure(
  三线表(
    columns: (1.1fr, 3fr),
    align-cells: (left, left),
    header: ([数据集维度], [内容]),
    rows: (
      ([元件类别], [电阻、陶瓷电容、电解电容、二极管、发光二极管、跳线、三脚晶体管（共 7 类）]),
      ([标注粒度], [组件边界框 + 引脚级关键点（关键点张量 3×3，每实例至多 3 引脚，含可见性）]),
      ([覆盖拓扑], [一阶 RC、共射放大、差分对、UA741 反相、UA741 积分、UA741 加法（共 6 类）]),
      ([数据划分], [真实实验台自采自标，按训练 / 验证 / 测试留出划分]),
      ([训练配置], [YOLOv8s-pose 骨干，输入 960，batch 8，训练 100 轮；INT8 由 144 张校准图训练后量化]),
    ),
  ),
  caption: [自建引脚级面包板数据集主要规格],
) <tab:dataset>

视觉模型经由易到难的渐进路线训练得到，先在单元件照片上验证基础元件的可识别性；再将标注升级为 pose 形式，把任务由“识别元件是什么”推进到“识别引脚在哪里”；继而扩展电位器与双列直插芯片等复杂器件（多脚器件结合封装规则生成引脚候选）；最终过渡到真实实验板上多元件共存与遮挡的综合场景，使数据标注与模型能力同步演进。

最终的 pose 训练运行采用 Ultralytics YOLOv8s-pose#cite(<yolo>)，输入尺寸 960、batch size 为 8、训练 100 轮，启用默认优化器与常规颜色/平移/缩放增强，末 10 轮关闭 mosaic。训练日志显示，模型在第 100 轮的验证集上，组件检测框（B）指标为 precision=0.991、recall=0.989、mAP50=0.991、mAP50-95=0.786，引脚关键点（P）指标为 precision=0.955、recall=0.954、mAP50=0.947、mAP50-95=0.829。上述验证集指标说明模型能较稳定地同时完成组件定位与引脚关键点回归，为孔位映射与拓扑重构提供可用的视觉前提；测试集未参与任何训练与模型选择，留作端到端系统级评测的独立样本。

== 流水线编排

流水线编排器是服务端事实链的核心，以线程安全的单例复用检测器以免重复加载模型，为每次请求单独创建保存网格状态的面包板校准器；接收图片、参考电路与阈值参数，依次执行组件检测到语义分析各环节，返回各阶段结果、总耗时与运行元数据。

== 组件检测

组件检测以面包板俯视图为输入，建立全局唯一的元件主实例与编号，作为引脚检测、孔位映射与比对的共同锚点，使下游各阶段对“同一元件”不再产生分歧。输出采用统一结构化格式（编号、类别、封装、置信度与边界框），过滤面包板本体等背景类别；对集成芯片经封装识别推断双列直插 8/14 脚，为后续引脚生成提供依据。

== 全图引脚检测

电气诊断要求识别粒度下沉到引脚级，而常规目标检测无法回答“某引脚究竟插在哪个孔”。直觉方案是先裁剪单个元件框、再在框内回归引脚，但实践发现裁剪会把引脚切到框外并丢失周边上下文，导致系统性漏检。因此系统改为整图关键点检测，在俯视图上以 YOLO-Pose 一次性回归全部引脚关键点，再依类别与边界框的几何约束把引脚归属到对应元件，既避免裁剪误差，又保留完整引脚证据。

模型不可用时，该阶段输出格式兼容的占位结果，保证下游不因模型缺失而结构崩溃。每个引脚记录关键点坐标、可见性与综合置信度，为孔位映射提供完整证据。

在真实面包板上，整图关键点检测的输出经组件归属与孔位映射汇聚为引脚级结构化事实，一例电路实验情景的实际识别效果如#ref(<fig:e2e>)所示。

#figure(
  image("pictures/cadx/e2e_triptych.pdf", width: 100%),
  caption: [视觉事实链实际演示示例（真实模型输出，板上实拍）：(a) 俯视照片输入；(b) 组件检测与类别框；(c) 引脚级关键点汇聚为结构化网表（元件—引脚关联图，IC 引脚按 DIP 封装几何派生）——“像素 → 神经感知 → 符号化结构事实”端到端贯通],
) <fig:e2e>

== 框—点关联与正确的引脚归属

组件检测与引脚检测分属两个模型，前者在整图上给出元件本体的类别与边界框，后者在整图上给出引脚关键点实例。要重构引脚级网表，必须先确定每个引脚实例归属于哪一个元件本体，且不被相邻元件错误认领，否则下游的孔位映射与网表比对都会偏离真实电路。本系统不依赖单一信号，而是对每个引脚实例与每个候选元件框计算一个多信号匹配分数，再以贪心方式做一对一指派。

匹配分数综合以下证据，引脚实例外接框与元件框的交并比、两者中心的邻近度、关键点落入元件框内的比例、引脚跨度与元件尺度的一致性以及检测置信度，并要求引脚类型与元件类别相容（如运算放大器引脚只归属运放本体）。系统按分数从高到低贪心指派，已被占用的引脚实例不再参与后续匹配，从而避免同一引脚被多个元件重复认领。集成电路引脚不依赖关键点检测，而是在识别封装后按双列直插几何规则推导，以应对密集引脚下关键点易混淆的问题。

当某引脚实例对所有候选元件的最高分仍低于阈值时，系统不强行归属，而是将其标记为低置信、在前端暴露候选孔位交由学生确认。这一“多信号打分、贪心一对一指派、低置信拒绝兜底”的关联策略，使引脚到元件的归属在遮挡与密集排布下保持稳定，是后续确定性网表重构可靠的前提。

== 孔位映射与导通节点解析

把“引脚在图像中接近某处”的模糊观测，上升为“引脚归属某一导通节点”的确定结论，是整条事实链中最易产生歧义的一步，同一关键点可能落在相邻孔位之间，单凭最近邻吸附极易误判。孔位映射因此并不简单选取最近孔，而是先用俯视图标定面包板网格（校准失败则回退合成网格并显式标记），再为每个引脚整合关键点坐标、可见性、来源与投影构造观测记录以生成候选孔位，最后依据板型规则把孔位解析为对应的导通节点。

这一步的歧义并非工程实现不足，而是密集小目标检测的固有难点。面包板上的引脚是典型的密集小目标，数十至上百个孔位以毫米级间距规则排布，单个引脚在俯视图中仅占十余像素，相邻孔位外观近乎一致，且常被导线与元件本体部分遮挡。密集小目标的关键点定位是计算机视觉中的难点，即便换用更强的检测与关键点模型，在“引脚究竟落在相邻哪一孔”上也难以做到 100% 正确，孔位级的残余误差不可完全消除。因此系统并不以追求一个不可达的完美视觉为目标，而是正视这一残差、将其显式暴露并交由低成本的人在回路消解。

孔位映射保留而非隐藏不确定性，每个映射后的引脚带有候选孔位、候选节点、是否歧义及原因、综合置信度、吸附距离等信息，使下游能区分高置信映射与需人工复核的低置信映射，与其在低置信处强行给出可能错误的结论，不如显式标注歧义、交由学生一键修正（见#ref(<fig:ambiguity>)）。

#figure(
  image("pictures/cadx/ambiguity.pdf", width: 100%),
  caption: [低置信引脚的歧义可视化：不强行吸附，以虚线环标出候选孔位、交由学生在前端界面修正，把“网匹配歧义”显式化为人机协同介入点],
) <fig:ambiguity>

板型规则承担视觉与电气逻辑的桥梁，依孔位行列归属把物理孔位规范化为稳定导通节点，并支持据节点反查整条导通带的全部孔位、供交互端整带高亮。

在通用孔位投票之外，系统还按器件类型施加几何约束（两脚器件的引脚配对、电位器三孔共线、轴向器件不跨中缝），并由元件外形推断三极管的发射极—基极—集电极极性。这些器件级先验把“像素邻近”修正为“符合物理形态的孔位与极性”，为后续电气比对提供更可靠的引脚级事实。



== 异构性能实测与能效

为量化 NPU、iGPU 与 CPU 的异构分工，项目以 turbostat 按 0.25 秒间隔采样 RAPL 能量计，并在板端以输入分辨率 960 单进程串行采集 60 至 1153 次推理统计，测得 YOLOv8s-pose 关键点检测在 CPU、iGPU、NPU 三种单元上的延迟、吞吐与功耗。其功耗时序如#ref(<fig:power-ts>)所示，NPU 推理期间 CPU 核心与 iGPU 功率曲线全程贴近空闲基线（约 4.4 W），说明 NPU 几乎不占用其他单元资源，为“NPU 负责视觉、iGPU 负责诊断、CPU 负责控制”的三路异构分工提供了硬件层面的可行性。

#figure(
  image("pictures/cadx/power_timeseries.pdf", width: 88%),
  caption: [YOLOv8s-pose INT8 在 DK-2500 上的 RAPL 功耗时序：三段分别对应 CPU/iGPU/NPU 各持续 15 秒的工作态；NPU 工作时 CPU 与 iGPU 全程贴近空闲基线，是三单元异构分工、互不争用的硬件前提],
) <fig:power-ts>

各配置详细指标如#ref(<tab:hetero>)所示，NPU INT8 在延迟、吞吐与 P99 三项上均居各配置之首（13.37 ms、74.7 img/s、P99 仅 15.61 ms），满足课堂实时视频流需求；INT8 经 144 张校准图训练后量化得到，模型由 22 MB 压至 11 MB，NPU 吞吐由 FP16 的 60.4 升至 INT8 的 74.7 img/s。

#figure(
  三线表(
    columns: (1fr, 0.9fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align-cells: (center, center, center, center, center, center, center),
    header: ([设备], [精度], [负载(s)], [均值(ms)], [P95(ms)], [P99(ms)], [img/s]),
    rows: (
      ([CPU], [FP16], [0.14], [92.44], [96.74], [98.92], [10.8]),
      ([CPU], [INT8], [0.24], [29.02], [30.13], [30.65], [34.5]),
      ([iGPU], [FP16], [0.43], [26.87], [27.32], [28.18], [37.2]),
      ([iGPU], [INT8], [2.85], [18.26], [19.29], [20.11], [54.7]),
      ([NPU], [FP16], [1.01], [16.55], [16.64], [17.67], [60.4]),
      ([NPU], [INT8], [1.20], [13.37], [13.75], [15.61], [74.7]),
    ),
  ),
  caption: [YOLOv8s-pose 在 DK-2500 上六种设备—精度配置的延迟与吞吐实测（输入分辨率 960）],
) <tab:hetero>

能效上，NPU INT8 增量功耗仅 4.12 W、单次推理能耗 114.2 mJ、性能功耗比 18.1 ips/W，较 CPU INT8 节能约 7.1 倍。实测印证异构分工，视觉常驻负载交给 NPU，既释放 CPU 与 iGPU，又在功耗预算内满足实时性。系统另提供 5 Hz 硬件遥测与降级能力。

= 电气重构与符号诊断引擎

本章是“神经—符号”中的符号侧，它不依赖任何神经网络，对错判断由图论算法以确定、可复现、可审计的方式给出，因而不会在安全敏感的对错问题上产生幻觉。

== 拓扑重构与结构化网表

视觉阶段给出“哪个引脚落在哪个孔”，电气诊断需要“哪些引脚同属一个导通网络”，拓扑重构完成这一跨越。读取孔位映射后的元件与引脚构造电路分析器，以图结构表示元件—网络关系，用并查集把导线连接的等电位孔位合并为统一网络。这里有一个易被忽视的陷阱，若沿用上游旧的节点编号，一旦人工修正了某个孔位，旧编号残留便会致错。因此系统坚持以物理孔位为唯一可信来源、据孔位重新解析导通节点。在最终的元件—网络二分图中，导线不作为元件参与拓扑、仅用于合并网络，若某非导线元件的多个引脚落入同一网络，则标记为同网络以供短路风险判断。

该部分流程的核心产物是结构化网表。一个保留元件、引脚、网络、节点索引与板型拓扑的结构化对象，被交互端、验证模块与智能体共同消费，亦可导出拓扑级 SPICE 网表。它同时服务于电气比较与可视化定位，选中某网络即可高亮其全部相关孔位（结构化网表及其拓扑级 SPICE 导出的实例见#ref(<fig:netlist>)）。

#figure(
  image("pictures/cadx/netlist_info.pdf", width: 100%),
  caption: [结构化网表可视化（board_1，真实管线输出；电源与地依实际接线人工校正）：(a) 面包板视图——同色引脚同属一个电气节点，电源/地网络加深描边；(b) 拓扑级电路图——网络为节点、元件为边，导线隐式合并入网络（IC 双电源 VCC/VEE 与地 GND 清晰可辨）；(c) 由该网表导出的拓扑级 SPICE 片段（GND 映射为节点 0，元件取值留作占位）],
) <fig:netlist>

== 参考电路的领域特定语言

参考电路的正确性直接决定诊断可信度。系统不手写网表 JSON，而以一套嵌入式 Python 领域特定语言（DSL）声明逻辑参考电路，把“作者意图”与“机器可比对结构”分离，Circuit 承载网络、元件、对称组与等价选项，Net 携带语义角色（signal / input / output / power / ground）与角色标签，Pin 可显式标注不连接（no-connect），并以等价规则（忽略孔位与元件编号、忽略无极性引脚顺序、允许多余导线）表达比对意图，最终编译为统一逻辑参考 JSON。新增参考电路只需书写数十行接近原理图的 DSL，既降低出错概率，又与比对器保持稳定数据约定。

== 确定性图比对算法

此处面临一对看似矛盾的要求，学生在面包板上的摆放千差万别，不能因孔位不同就判错；但只要电气逻辑接错，又必须准确指出。逐孔位的硬规则只能满足其一，无法实现两全。本系统的解决方案是把比对提升到逻辑层，在元件—网络二分图上、只对照逻辑参考电路，使“摆放不同但逻辑等价”判为正确、“逻辑网络接错”判为错误。算法分级进行，首先尝试完整图同构匹配（采用 VF2 子图同构算法#cite(<vf2>)，基于 networkx 图论库#cite(<networkx>)实现），节点按元件类型与网络角色匹配、边按引脚角色匹配。在同构之前，系统先做一次模糊组件对齐与规范名（canonical-name）角色传播，把参考电路的语义（如 INV、VOUT）传播到学生电路的匿名网络上，使下游消费者看到富语义；此步只更新网表语义而不重建结构图，以免干扰结构匹配的判定。

当完整同构失败时，算法逐级降级。先判断学生电路是否为参考电路的子图或包含关系，仍不成立时，才以图编辑距离或近似相似度给出错接报告。匹配规则采用“严格/宽松”分级，电源与地、以及功能引脚严格匹配；电阻、电容、导线等无极性两脚器件忽略引脚顺序；并允许合理的额外导线。相比逐孔位规则，该分级显著降低了因摆放差异导致的误报；相比纯文本规则，又对关键电气语义保持刚性约束。这正是把对错判断交给符号系统、而非交给易幻觉大模型的根本理由。

算法核心不是单次布尔判断，而是一条可解释的级联判定链（见#ref(<fig:compare-cascade>)）。先尽量证明电路正确，再逐级识别失败类型并转写为稳定错误码，每个结论都能回溯到具体匹配阶段，交互端据此高亮，智能体只能引用这些结构化事实而不能臆测故障。

#figure(
  [#set text(size: 8pt)
    #diagram(
      spacing: (1.4mm, 13mm),
      node-stroke: 0.7pt + black,
      node-corner-radius: 3pt,
      node-inset: 4pt,
      node-shape: rect,

      // 主链 (y=1)
      node((0, 1), [当前电路图 \ ∥ 参考逻辑电路], name: <nin>),
      node((2, 1), [完整图 \ 同构?], stroke: 1.3pt + black, name: <d1>),
      node((4, 1), [角色推断 \ 传播语义角色], fill: luma(236), name: <p1>),
      node((6, 1), [子图 / \ 包含?], stroke: 1.3pt + black, name: <d2>),
      node((8, 1), [图编辑距离 \ / 近似相似度], fill: luma(236), name: <p2>),
      node((10, 1), text(fill: white)[结构化 \ 错误码], fill: luma(62), stroke: 1.3pt + black, name: <err>),

      // 终止框 (y=0)
      node((2, 0), [判定逻辑等价 → 正确], name: <t1>),
      node((6, 0), [区分“多余连接 / 未完成电路”], name: <t2>),

      // 主链实线
      edge(<nin>, <d1>, "-|>", stroke: 0.6pt + black),
      edge(
        <d1>,
        <p1>,
        "-|>",
        stroke: 0.6pt + black,
        label: text(8pt, fill: luma(90))[否],
        label-pos: 0.5,
        label-side: left,
      ),
      edge(<p1>, <d2>, "-|>", stroke: 0.6pt + black),
      edge(
        <d2>,
        <p2>,
        "-|>",
        stroke: 0.6pt + black,
        label: text(8pt, fill: luma(90))[否],
        label-pos: 0.5,
        label-side: left,
      ),
      edge(<p2>, <err>, "-|>", stroke: 0.6pt + black),

      // 向上「是」分支
      edge(<d1>, <t1>, "-|>", stroke: 0.6pt + black, label: text(8pt, fill: luma(90))[是], label-side: right),
      edge(<d2>, <t2>, "-|>", stroke: 0.6pt + black, label: text(8pt, fill: luma(90))[是], label-side: right),
    )
  ],
  caption: [确定性图比对的级联判定链：先尝试完整图同构以证明逻辑等价，否则逐级降级——经角色推断后判断子图 / 包含关系以区分“多余连接 / 未完成电路”，仍不成立则以图编辑距离给出错接报告；每个结论可回溯到具体判定阶段，并统一转写为稳定错误码（见#ref(<tab:errcode>)）],
) <fig:compare-cascade>

== 拓扑模板与三层语义匹配

纯图比对需要一份确定的参考电路，但同一教学拓扑常有多种正确的实现方式，以单一参考硬比较极易误报。为此系统引入拓扑模板，把每类规范拓扑表达为“偏规范”，以三层语义刻画结构（如#ref(<tab:tier>)所示），required 缺失则不匹配，ptional 可缺不扣分，forbidden出现即降级或否决；另以变体与重数容纳多种合法实现，并声明参数化不变量。

#figure(
  三线表(
    columns: (1fr, 1.1fr, 2.4fr),
    align-cells: (left, center, left),
    header: ([语义层], [匹配影响], [示例]),
    rows: (
      ([required（必需）], [缺失则不匹配], [共射的三极管、集电极电阻、输入/输出耦合电容]),
      ([optional（可选）], [可缺，不扣分], [共射发射极旁路电容 C#sub[E]、偏置补偿电阻 R#sub[p]]),
      ([forbidden（禁止）], [出现则降级/否决], [反相放大器中出现反馈电容（实为积分器）]),
    ),
  ),
  caption: [拓扑模板的三层语义结构],
) <tab:tier>

匹配以子图同构搜索模板在学生电路图中的嵌入，按必需边占比计分、forbidden 命中扣分。模板层与图比对并行、对管线只读，把绪论所述“纯规则需不断打补丁”的边界情形系统化容纳进来。

== 诊断报告与错误码

参考比较与模板匹配的结论汇聚为结构化诊断报告，每条诊断项含错误码、错误族、严重程度、建议动作、证据引用及涉及的元件、引脚与孔位等字段。错误码采用稳定的确定性词表（如#ref(<tab:errcode>)所示），它也是后文检索约束中“验证器↔知识库”桥接的关键，故障案例正是依据错误码被精确召回。

#figure(
  三线表(
    columns: (2.0fr, 0.8fr, 2.3fr),
    align-cells: (left, center, left),
    header: ([错误码], [错误族], [含义与典型成因]),
    rows: (
      ([COMPONENT_MISSING], [缺件], [参考电路所需元件在当前电路中缺失]),
      ([WRONG_CONNECTION], [接线], [引脚连接到了与参考不一致的电气网络]),
      ([SHORT_CIRCUIT], [短路], [本应分离的关键网络（电源/地、输入/输出）被合并]),
      ([OPEN_CIRCUIT], [开路], [本应共网的引脚被分到不同网络，连接断开]),
      ([OUTPUT_NODE_MISMATCH], [节点], [输出节点角色与参考不符（输入/电源/地同理）]),
      ([CRITICAL_EXTRA_CONNECTION], [多接], [关键网络上存在参考未要求的额外接线]),
      ([INCOMPLETE_CIRCUIT], [未完成], [当前电路仅匹配参考电路的一部分]),
    ),
  ),
  caption: [诊断报告常见错误码（确定性图比对输出的稳定词表，节选）],
) <tab:errcode>

诊断报告还包含面向交互端的高亮协议，把每条诊断项的证据引用转换为可直接绘制的高亮目标，智能体生成解释时复用同一份协议，使自然语言说明与界面定位指向同一份事实。


== 功能与单元测试覆盖

确定性主张的工程基础是各模块在统一约定下行为可复现、可回归。后端以 pytest 组织约 900 余个单元与约定用例，整体通过率约 99%（个别失败为预先存在的环境依赖），分布如#ref(<tab:test>)所示。

#figure(
  三线表(
    columns: (2.8fr, 1fr, 1fr),
    align-cells: (left, center, center),
    header: ([模块], [用例数], [关键断言]),
    rows: (
      ([智能体（意图/上下文/校验器/路由）], [60+], [意图路由、ReAct 流程、verifier 规则]),
      ([检索与知识库（RAG/KB/Agent）], [55+], [器件手册检索、场景检索、智能体提交]),
      ([确定性图比对（拓扑/比较）], [40+], [图同构、子图匹配、错误码生成]),
      ([视觉管线（检测/吸附/网表）], [50+], [校准、孔位吸附、结构化网表]),
      ([其他（知识库/评估/工具）], [200+], [数据约定与回归]),
      ([合计], [约 900+], [整体通过率约 99%]),
    ),
  ),
  caption: [后端单元与约定测试覆盖分布],
) <tab:test>

= 智能解释与人机协同

得到结构化网表与诊断报告后，系统进行事实链最后一环，智能体在受控事实约束下生成解释，知识检索安全补充背景，交互端呈现证据并定位错误，人工修正与重算形成闭环。

== 诊断智能体与推送式上下文管理

最直接的做法是把完整网表与知识库塞进大模型上下文任其推理，但边缘小模型上下文与内存紧张，且一旦看到全部原始事实，便有“重新判断对错”的空间而引入幻觉。系统因此采用推送式上下文管理（Push-based Context Management, PCM），按错误类型、风险等级、场景与用户问题，从课堂状态编译出仅含被推送事实、被允许工具与证据引用的最小上下文包并估算 token 控制规模。智能体只能看到被推送内容，不会越过验证模块猜测孔位或网络；这种主动压缩对内存受限的边缘部署尤为关键。

诊断智能体统一编排诊断、概念讲解、操作指导与混合问答四类教学意图，共用同一张状态图，仅按意图切换工具白名单、校验规则与回答模板（如#ref(<fig:intent>)所示）；工具选择进一步取决于错误族（如短路类调用网表追踪与板型查询），智能体据此动态选工具#cite(<react>)，而非把所有知识与历史塞入上下文。意图判定以确定性关键词分类为主，端侧小模型做四类意图分类的准确率与延迟均不及零延迟关键词路由，故路由交给关键词分类、小模型只负责生成（实测消融见本章三组消融实验一节）。

#figure(
  [#set text(size: 9.5pt)
    #diagram(
      spacing: (10mm, 7mm),
      node-stroke: 0.7pt + black,
      node-corner-radius: 3pt,
      node-inset: 7pt,

      // left fan-in (x=0, y=0..3)
      node((0, 0), [诊断]),
      node((0, 1), [概念讲解]),
      node((0, 2), [操作指导]),
      node((0, 3), [混合问答]),

      // center emphasized node
      node(
        (3, 1.5),
        [统一 \ 状态图],
        stroke: 1.3pt + black,
        corner-radius: 5pt,
        shape: fletcher.shapes.rect,
        inset: 12pt,
        width: 28mm,
      ),

      // right fan-out (x=6, light gray fill)
      node((6, 0.5), [工具白名单], fill: luma(236)),
      node((6, 1.5), [校验规则], fill: luma(236)),
      node((6, 2.5), [回答模板], fill: luma(236)),

      // fan-in edges
      edge((0, 0), (3, 1.5), "-|>", stroke: 0.6pt + black),
      edge((0, 1), (3, 1.5), "-|>", stroke: 0.6pt + black),
      edge((0, 2), (3, 1.5), "-|>", stroke: 0.6pt + black),
      edge((0, 3), (3, 1.5), "-|>", stroke: 0.6pt + black),

      // fan-out edges
      edge(
        (3, 1.5),
        (6, 0.5),
        "-|>",
        stroke: 0.6pt + black,
        label: text(8pt, fill: luma(90))[按意图切换],
        label-side: left,
        label-pos: 0.32,
      ),
      edge((3, 1.5), (6, 1.5), "-|>", stroke: 0.6pt + black),
      edge((3, 1.5), (6, 2.5), "-|>", stroke: 0.6pt + black),
    )
  ],
  caption: [一图四意图：四类意图共用同一状态图，仅按意图切换工具白名单、校验规则与回答模板],
) <fig:intent>

状态图以 LangGraph 为编排外壳，管理节点（错误分类、上下文构建、规划、观察、反思、回答验证、修复、定稿）的流转，并为最小化边缘部署提供行为等价的确定性顺序回退路径。其核心是职责分离，视觉、拓扑、比较与验证模块用于确定电路事实，大模型仅用于将问题改写为自然语言而不介入判定；反思环节的确定性校验器构成模型无法绕过的强制约束，回答缺少必需错误码、证据引用或危险场景断电提示时，无论文本如何均判失败并触发修复。即便解释模型仅十亿级参数，一旦偏离既定事实即被结构化拦截，无需依赖提示工程。这正是端侧小模型在正确性敏感场景可靠应用的前提。

== 知识检索约束与安全降级

为避免“训练一套知识、部署另一套”的不一致，系统对智能体的检索增强生成（RAG）#cite(<rag>)施加可审计约束，合法知识源仅有教学场景库、故障案例库、器件手册库与电路知识库四个通道，另加工位状态、流水线快照与参考电路等结构化事实通道（如#ref(<tab:retrieval-contract>)所示）。早期基于通用向量库的文档检索仅保留给后台调试，禁止进入主链路或蒸馏管线，以避免分布漂移、云端依赖与内容污染。

#figure(
  三线表(
    columns: (1.25fr, 2.05fr, 2.55fr),
    align-cells: (left, left, left),
    header: ([通道], [内容], [约束作用]),
    rows: (
      ([教学场景库], [六类 demo 场景的目标、步骤、测量点与安全提示], [回答先对应当前拓扑，避免跨实验串场]),
      ([故障案例库], [按场景、错误标签、错误码组织的典型故障与修复步骤], [只有命中当前错误码才返回，防止凭空举例]),
      (
        [器件手册库],
        [UA741、LM324、NE555、BJT 等结构化 datasheet 与本地嵌入],
        [场景白名单过滤无关芯片，端侧无外网依赖],
      ),
      ([电路知识库], [放大器、积分器、比较器等原理知识], [只补充教学解释，不改写诊断事实]),
      (
        [结构化事实],
        [工位状态、pipeline 快照、reference circuit、error codes],
        [作为最高优先级证据，所有解释必须引用它],
      ),
    ),
  ),
  caption: [Agent/RAG 检索约束的合法通道与约束作用],
) <tab:retrieval-contract>

上述约定让蒸馏训练与板端部署保持一致，蒸馏数据生成与板端部署使用同一套代码、知识与场景白名单，并由起飞前自检脚本校验两端等价。它把“可用知识的边界”做成可审计的工程约束，场景白名单按拓扑过滤器件手册，使反相放大器的问题不会召回无关的定时器芯片；故障案例仅在错误码命中时返回，召回键正是第四章图比对输出的错误码词表。检索缺失时系统 fail-closed，蒸馏样本拒绝生成、部署端回退确定性模板，宁可少答也不让错误默认值污染结论。这一取向与近年电子设计自动化语言模型“以确定性结构约束生成”的方向一致#cite(<llm4eda>)。

== 交互端设计与结果呈现

交互界面以 React、Vite 与 TypeScript 构建，职责是把服务端的结构化事实清晰呈现给师生。主区提供两种视图，网表视图支持孔位、端口、网络角色与引脚极性的人工修正，图像视图在原图上渲染识别框与高亮目标；点选某条诊断即据其证据引用定位到元件、引脚与孔位，使自然语言解释与界面定位指向同一份事实。

== 人工修正闭环

人工修正时，系统结合用户对端口、网络角色、引脚极性等的修改生成补丁，调用重算接口重新执行拓扑重构与比较，不重跑视觉检测，以极小代价纠正视觉阶段偶发偏差。视觉模型难免漏检、误检或吸附偏差，LabGuardian 保留视觉阶段的大部分事实、只对有争议的引脚或端口做局部修改再重新判断，把 AI 定位为助教而非裁判。显式保留不确定性、低成本纠正回路，正是面对必然带有干扰的真实照片输入时仍能可靠服务教学的工程基础。

作为本章诊断闭环的整体印证，#ref(<fig:diag-demo>)给出一例反相放大器双故障的端到端诊断，系统在真实故障板上同时定位“输入电阻错接至偏置脚”与“运放负电源缺失”两处接线错误，由确定性比对输出稳定错误码、再由端侧学生模型生成有依据的讲解，使自然语言解释与界面高亮指向同一份结构化事实。这正是从真实照片输入到确定性诊断、再到受约束解释这一闭环在真实故障样本上的完整呈现。

#figure(
  image("pictures/cadx/diag_demo.pdf", width: 100%),
  caption: [反相放大器双故障端到端诊断示例（板上实拍 + 真实管线输出）：(a) 故障板的组件/引脚检测与错误定位——①输入电阻错接至偏置/调零脚 pin1（应接反相输入 pin2），②运放 pin4（V−）未接负电源 VEE；(b) 确定性比对输出的结构化错误码（`WRONG_CONNECTION`、`OPEN_CIRCUIT`）与端侧学生模型生成的有依据的讲解，自然语言解释与错误定位指向同一份事实],
) <fig:diag-demo>



== 端侧教学解释小模型的蒸馏与初步评测

本章前述的诊断智能体在没有可用大模型时会退回确定性模板；算力允许时，则由大模型把结构化诊断结果改写成更容易理解的讲解。为把这一环节放到边缘端本地运行、减少对云端的依赖，本项目采用双教师蒸馏#cite(<kd>)训练了一款面向教学问答的小模型，并完成 OpenVINO INT4 导出与初步评测。

蒸馏数据不是让教师模型自由发挥生成的，而是严格建立在系统已经固定好的结构化证据上。项目选用本地部署的 Qwen3-32B#cite(<qwen3>)和云端的 DeepSeek-V3#cite(<deepseekv3>)作为双教师，让它们在同一份固定证据上分别作答，把回答内容和可核查的事实对应起来，尽量减少幻觉。候选问题围绕典型电路、常见故障和学生常问的问题自动扩展，再结合人工与规则过滤掉不贴近课堂场景的样本；教师回答也不会直接拿来训练，只保留有明确依据、没有被降级为“证据不足”、长度合适且表达基本一致的样本。最终从 4990 条候选教师输出中保留 3466 条高质量样本，并构建为 3450 条正式 SFT 数据（候选留存率约 69.1%）。学生模型以 Qwen2.5-1.5B-Instruct#cite(<qwen25>)为基座，经 LoRA#cite(<lora>)微调并合并权重后，再进行 INT4 量化#cite(<awq>)并导出为 OpenVINO 部署模型，合并后约 3.1 GB、INT4 约 0.88 GB，拷贝到板端即可运行，全程无需外网。

#figure(
  [#set text(size: 8.5pt)
    #diagram(
      spacing: (5.5mm, 6.5mm),
      node-stroke: 0.7pt + black,
      node-corner-radius: 3pt,
      node-inset: 6pt,
      node-shape: fletcher.shapes.rect,

      node((2, -0.3), text(7.5pt, fill: luma(90))[双教师 · 仅依据证据作答], stroke: none, inset: 1pt),
      node((5.9, -0.62), text(7.5pt, fill: luma(90))[端侧学生模型], stroke: none, inset: 1pt),

      node(
        (0, 1.5),
        align(
          center,
        )[固定结构化证据\ #text(7.5pt, fill: luma(85))[场景 · 错误码\ 故障案例 · 工具结果\ 风险等级]\ #text(weight: "bold")[检索约束]],
        stroke: 1.3pt + black,
        fill: luma(240),
        name: <ev>,
      ),

      node((2, 0.75), align(center)[*Qwen3-32B*\ #text(7.5pt, fill: luma(85))[本地部署]], name: <qw>),
      node((2, 2.25), align(center)[*DeepSeek-V3*\ #text(7.5pt, fill: luma(85))[云端]], name: <ds>),

      node((3.9, 0.45), [候选池 4990], name: <pool>),
      node(
        (3.9, 1.45),
        text(7.5pt)[筛样],
        shape: fletcher.shapes.trapezium.with(angle: -22deg),
        fill: luma(240),
        name: <filt>,
      ),
      node((3.9, 2.4), align(center)[*SFT 3450*], stroke: 1.3pt + black, fill: luma(240), name: <sft>),

      node((5.9, 0.2), align(center)[*Qwen2.5-1.5B*\ #text(7.5pt, fill: luma(85))[LoRA 监督微调]], name: <stu>),
      node((5.9, 1.1), [合并权重 → 3.1 GB], name: <merge>),
      node((5.9, 2.0), [*INT4 量化 → 0.88 GB*], stroke: 1.3pt + black, fill: luma(240), name: <int4>),
      node((5.9, 2.9), [OpenVINO · DK-2500], name: <ov>),

      edge(<ev>, <qw>, "-|>", stroke: 0.6pt + black),
      edge(<ev>, <ds>, "-|>", stroke: 0.6pt + black),
      edge(<qw>, <pool>, "-|>", stroke: 0.6pt + black),
      edge(<ds>, <pool>, "-|>", stroke: 0.6pt + black),
      edge(<pool>, <filt>, "-|>", stroke: 0.6pt + black),
      edge(<filt>, <sft>, "-|>", stroke: 0.6pt + black),
      edge(<sft>, <stu>, "-|>", stroke: 0.6pt + black),
      edge(<stu>, <merge>, "-|>", stroke: 0.6pt + black),
      edge(<merge>, <int4>, "-|>", stroke: 0.6pt + black),
      edge(<int4>, <ov>, "-|>", stroke: 0.6pt + black),

      edge(
        <ev>,
        (0, 3.9),
        (5.9, 3.9),
        <ov>,
        "--|>",
        stroke: luma(110),
        label: text(7.5pt, fill: luma(90))[训练即部署 · 同一检索约束],
        label-pos: 0.5,
        label-side: center,
      ),

      node((3.9, 3.05), text(7pt, fill: luma(100))[引用合规 · 长度 · 未降级　留存 69.1%], stroke: none, inset: 1pt),
    )],
  caption: [基于固定证据的双教师检索增强蒸馏流程：本地 Qwen3-32B 与云端 DeepSeek-V3 在同一份固定结构化证据上作答，候选池经筛样（引用合规、长度达标、未降级为“证据不足”）得到 3450 条 SFT 数据，用以微调 Qwen2.5-1.5B 学生模型并经 INT4 量化部署；训练数据生成与板端部署共用同一检索约束],
) <fig:distill-record>

如果用简单流程来概括，这部分蒸馏主要分五步。先整理课堂里常见的问题；再运行正式诊断链路，把这道题对应的场景、错误码、故障案例、工具结果和风险等级固定下来；然后让 Qwen3-32B 与 DeepSeek-V3 只根据这份固定证据作答，危险场景要先提醒断电；接着把没有依据、过短或者已被降级为“证据不足”的回答筛掉；最后把“问题 + 固定证据 + 合格教师答案”整理成 SFT 数据，用来微调 1.5B 学生模型，并在合并权重后导出 INT4 OpenVINO 模型。以“UA741 反相放大输出钉在 +13 V”为例，这份固定证据里会保留 `FLOATING_PIN`、`floating_connection` 和“负电源未连接”等关键信息，因此教师回答也必须围绕这些事实展开。

双教师同时生成时呈现出明显互补，DeepSeek 更稳定，Qwen 在一些边界问题和少见问法上能补上答案，因此并行候选池比只用单一稳定教师多带来 14.7 个百分点的高质量样本覆盖率。筛样后得到的训练数据主要覆盖缺件、悬空和错接这三类课堂里最常见的问题，并保留了场景证据、工具白名单和风险等级等信息。换句话说，这里蒸馏的不是一个脱离实验环境的通用聊天模型，而是一个更贴近课堂排障场景的小模型。

和常见那种强调“把大模型能力搬给小模型”的思路不同，本项目更关注让小模型在课堂场景里答得稳、答得准、答得安全。教师答案必须基于固定证据，尽量减少幻觉；训练时和板端部署时用的是同一套检索规则和场景白名单，避免训练一套、部署另一套；学生模型后面还有确定性校验器兜底，只要回答越过结构化事实边界，就会被拦下来。因此，这里更像是在训练一个“会看证据说话”的端侧教学解释模型。

项目把导出的 INT4 学生模型部署到 DK-2500 后，在板端 iGPU 上做了实机测试。模型冷启动约 3.7 秒，首 token 延迟约 64 毫秒，解码吞吐约 23 token/s，生成一段约 128 token 的教学解释大约需要 5.5 秒；常驻内存增量约 0.35 GB、峰值约 1.36 GB，在 8 GB 板载内存下仍能和视觉、检索模块一起运行。功耗方面，空载整封装功率约 4.4 W，推理时升至约 10.2 W，单次生成约 128 token 回答的能耗约 56 焦耳。

作为对照，同一模型如果改在板端 CPU 上运行，虽然吞吐接近，但整封装平均功率会升到约 43 W，约为 iGPU 的 4.7 倍。这说明把解释生成放到 iGPU 上更省电，而 CPU 更适合留给拓扑分析、检索和服务控制等任务；同时，把模型蒸馏到 1.5B 也是它能落进边缘端内存和功耗预算的重要前提。



== 本地检索精度评估

检索命中正确性与跨芯片隔离是“解释严格落在正确证据上”的前提。对六类示范拓扑共设计约 32 条检索测试问题，结果如#ref(<tab:rag>)所示，器件手册、教学场景与语义路由均 top-1 全命中且严格跨芯片隔离；故障案例召回按错误标签匹配时存在个别边界漏识别，已在后文错误码桥接修复中改善。

#figure(
  三线表(
    columns: (2.4fr, 1fr, 1.2fr, 1.6fr),
    align-cells: (left, center, center, left),
    header: ([评估项], [查询数], [top-1 命中率], [备注]),
    rows: (
      ([器件手册检索], [12], [100%], [跨芯片隔离，问 UA741 不命中 LM324]),
      ([教学场景检索], [10], [100%], [按错误码与关键词]),
      ([语义路由（datasheet 路由）], [8], [100%], [自动触发 + 向量匹配]),
      ([故障案例召回（按错误标签）], [12], [92%], [1 个边界样例漏识别]),
    ),
  ),
  caption: [本地四通道检索精度评估],
) <tab:rag>

== 三组消融实验，分别看检索约束、意图和蒸馏量化的作用

本节安排了三组消融实验。每组只改一个条件，其余保持不变，用来分别看检索约束、意图路由和蒸馏量化到底带来了什么提升。

=== 检索约束消融，同一模型看是否走约束路径

这组实验用的是同一款 INT4 学生模型，只比较它是否走完整约束路径。我们在六个示范场景里各注入一个典型故障，让同一道学生问题分别走“基座模型直答”和“完整约束路径”，结果见#ref(<tab:bare-contract>)。不走完整检索约束时，模型六个场景都说不清涉事故障器件；走了完整检索约束后，六个场景都能对准场景、引用错误码和涉事器件，危险场景还会先提醒断电，并且都能通过校验。这说明这里的提升主要来自检索约束，而不是单纯靠模型自己发挥。

#figure(
  三线表(
    columns: (1.2fr, 1.4fr, 1.4fr),
    align-cells: (left, center, center),
    header: ([评估维度], [基座模型直答], [完整约束路径]),
    rows: (
      ([命中涉事故障器件], [0 / 6], [6 / 6]),
      ([引用当前错误码], [0 / 6], [6 / 6]),
      ([引用涉事元件], [0 / 6], [6 / 6]),
      ([危险场景安全前置], [—], [6 / 6]),
      ([场景对应正确], [—], [6 / 6]),
      ([确定性校验通过], [—], [6 / 6]),
    ),
  ),
  caption: [基座模型 vs 检索约束，六示范场景诊断对应真实故障的能力对照（同一 INT4 学生模型）],
) <tab:bare-contract>

项目还专门检查了“验证器到知识库”这一段的错误码是否对得上。问题出在两边早期用的不是同一套词表，图比对产出的真实错误码和故障案例库里的标注经常对不上，所以真实故障明明出现了，案例却召不回来。我们用六个示范故障做实测，修复前只有 1/6 能把目标案例排在第一位；把词表统一后提升到 6/6，并在板端完成了 3/3 的端到端验证。这说明这条链路里，词表对齐和算法本身一样重要。

=== 意图路由消融

这组实验比较的是“让小模型自己判断意图”还是“先用关键词规则做路由”。实测发现，端侧小模型直接做四类意图分类时，在规范问法和口语问法混在一起的题目上，准确率还不如关键词路由，而且每次还会多带来约 1.5 到 2.5 秒延迟。基于这个结果，系统把意图判断交给零延迟的确定性关键词路由，小模型只负责生成回答。

=== 蒸馏与量化消融，教学解释质量评测

这部分主要看蒸馏和量化会不会影响教学解释质量。为减少主观判断，我们引入了自动评分。具体做法是让 DeepSeek-V3 作为独立评委，在 `temperature=0` 的设置下，对每道回答从正确性、教学性、简洁性、格式结构和依据安全性五个维度分别打 1 到 5 分。这种方式更细，也更容易复现。作为对照，我们还用了确定性校验规则再打一次分，比如是否先提醒安全、有没有提到关键故障点、步骤是否完整。两套自动评分的整体趋势是一致的，只是 LLM-Judge 能看得更细。

=== 量化前后对比，FP vs INT4

在同一题集、同一约束和同一评委下，我们对比了本地 `FP` merged 模型和部署版 `INT4` 模型，结果见#ref(<fig:p05-judge-quality>)。从综合得分看，`INT4` 是 3.37/5，`FP` 是 3.33/5；从正确性看，`INT4` 是 3.90/5，`FP` 是 3.87/5；从通过率看，`INT4` 是 90.0%，`FP` 是 83.3%。按题目意图细分，`INT4` 在实验指导和诊断排查上略好，`FP` 只在混合问答上稍高一点。整体来看，量化后没有出现明显质量下降，部署版 `INT4` 反而略占优。

#figure(
  image("board_data/p0_5_fp_vs_int4_judge.png", width: 94%),
  caption: [FP vs INT4 的 LLM-Judge 对比：左为综合得分、正确性与通过率对比，右为按教学意图细分。`INT4` 综合略优、通过率高出 6.7 个百分点，量化未造成质量退化],
) <fig:p05-judge-quality>

=== 四模型横向对比

项目进一步用同一套 30 题，对基座模型、蒸馏 `FP`、蒸馏 `INT4` 和教师上限做了横向对比，结果见#ref(<fig:p0-four-judge>)。综合得分的排序很清楚，教师 3.93，`INT4` 3.37，`FP` 3.33，基座 3.23。这个结果说明，蒸馏后的学生模型整体上优于基座模型，量化也没有把效果拉低。再看细项，当前最弱的一项还是教学启发性，这和回答长度偏短有关；但在依据安全性上，蒸馏模型相比基座有稳定提升。

从目前的自动评分结果看，后续最值得继续优化的是诊断排查类题目，以及教学启发性这一项。

#figure(
  image("board_data/p0_four_model_judge.png", width: 94%),
  caption: [四模型 LLM-Judge 评分：上图为综合得分与正确性（1-5分量表，分组柱形），下图为各模型 ≥3 分通过率。综合得分呈清晰单调排序（教师 > INT4 > FP > 基座），蒸馏与量化未造成质量退化],
) <fig:p0-four-judge>

再看一个反相放大器相关的具体例子。面对“我把运放的两个输入接反了，会有什么现象？”这道训练分布内题目，蒸馏后的 `INT4` 学生模型能更快抓住“输出会饱和到电源轨附近”这个最关键的实验现象，回答也更集中在故障机理和直接表现上；未蒸馏基座模型虽然也会说“电路无法正常工作”，但后面的表述更偏一般说明，范围更宽，对课堂里真正需要关注的症状抓得没那么准。这个例子本身不能单独代表总体结论，但可以作为上面统计结果的一个直观补充，也就是说，蒸馏带来的提升不主要是让回答更长，而是让回答更贴近实验助教场景里的关键现象和排查语境。

= 结论与展望


表#ref(<tab:key-results>)先汇总关键量化结果，主要证据不集中于单一模型精度，而是覆盖数据资产、确定性算法、检索约束、模型压缩、异构部署与工程测试六个维度，对应“把真实感知、符号判断、智能解释与边缘部署放在同一套可验证闭环中”的设计取向。

#figure(
  三线表(
    columns: (1.25fr, 2.4fr, 2.1fr),
    align-cells: (left, left, left),
    header: ([维度], [指标], [结果]),
    rows: (
      ([数据资产], [自建引脚级视觉数据集], [自采真实面包板照片，引脚级关键点 + 孔位映射标注]),
      ([视觉部署], [DK-2500 NPU INT8 延迟/吞吐], [13.37 ms，74.7 img/s，P99 15.61 ms]),
      ([视觉能效], [NPU INT8 增量功耗/单次能耗], [约 4.12 W，114.2 mJ，18.1 ips/W]),
      ([解释模型], [INT4 学生模型体积/吞吐], [约 0.88 GB，约 23 tok/s，峰值约 1.36 GB]),
      ([检索约束], [基座模型 vs 约束路径], [故障定位 0/6 → 6/6，校验通过 6/6]),
      ([知识桥接], [故障案例召回修复], [真实错误码召回 1/6 → 6/6]),
      ([工程质量], [单元与约定测试], [约 900+ 用例，整体通过率约 99%]),
    ),
  ),
  caption: [LabGuardian 关键量化结果汇总],
) <tab:key-results>


本文提出并实现了 LabGuardian，一个面向电子实验教学、运行于英特尔边缘平台的神经—符号电路诊断系统。系统以真实拍摄的面包板照片为起点，经关键点检测与孔位吸附重构引脚级电气网表，由确定性图比对承担可审计的对错判断，再由受约束的智能体在校验器约束下生成有依据的解释。教学解释模型经双教师蒸馏与 INT4 量化部署于 DK-2500，以 NPU、iGPU、CPU 异构分工实现本地推理。板端实测表明，系统可在 8 GB 内存预算内完成视觉识别与端侧解释，延迟、吞吐与功耗满足课堂实时使用；检索约束使同一小模型从无法指认故障转为正确指出故障，而教学解释的事实正确性由确定性校验器保证。

与既有工作相比，本系统主要有三点不同。其一，面向必然带有干扰的真实照片输入，而非理想的干净网表；其二，以神经—符号的思路把对错判断交给可审计的符号系统、把语言表达交给受约束的小模型；其三，让蒸馏训练与板端部署使用同一套检索约束，再配合校验器，把防幻觉做成工程上可审计的约束而非提示技巧。这样一个十亿级小模型也能在对正确性要求较高的教学场景中、于边缘设备上稳定运行。

== 局限

系统在确定性链路、检索约束与边缘部署上的能力已获实测支撑，但仍有不足。评测题量仅 30 题、教师列仅作质量上限参考；蒸馏学生在没有兜底路径时的语言质量受参数规模所限；端到端从真实照片到正确诊断的成功率仍需在更大真板集上统计。



== 展望

后续工作将集中于四个方向，把当前 30 题四模型矩阵扩展为更大规模、多人复核的 gold 评测集，并进一步补做板端 `FP16` 与 `INT4` 的真机对比；针对 `diagnostic` 类题目继续增强蒸馏数据与回答约束，降低排查顺序与关键检查点的漏答率；在更大规模真板集上统计“照片→诊断”的端到端成功率；并持续扩充教学场景、故障案例与器件手册知识库，使系统覆盖更多课程实验。






// ════════════════════════════ 参考文献 ═══════════════════════════════════
// 不编章号，三号黑体居中；条目按出现次序用中括号数字连续编号，顶格、五号宋体、单倍行距
#heading(level: 1, numbering: none)[参考文献]
#{
  set text(font: 正文字体, size: 五号)
  set par(leading: 1em, first-line-indent: (amount: 0em, all: false))
  bibliography("refs.bib", title: none, style: "gb-7714-2015-numeric")
}


#heading(level: 1, numbering: none)[附录]

#block[
  #set par(first-line-indent: (amount: 2em, all: true), leading: 1em)
  *附录 A　源代码与程序清单.* 本作品的完整源代码、知识库与板端部署脚本随作品实物一并提交。后端服务（视觉流水线、确定性图比对、检索约束与智能体编排）、交互前端、知识库（教学场景、故障案例、器件手册、电路知识）、模型蒸馏与评测脚本，以及 DK-2500 板端性能与能耗采集脚本均在其中；关键模块的单元与约定测试见后端测试目录。

  *附录 B　扩展应用系统电路图.* 六类示范教学拓扑（一阶 RC、共射放大、差分对、UA741 反相/积分/加法）的逻辑参考电路定义与对应故障案例随知识库提交，可作为系统扩展到更多课程实验的样例。

  *附录 C　应用资料与参考文献目录.* 见上节参考文献；器件手册原始资料（UA741、LM324、NE555、S8050 等）随器件手册知识库提交。
]


#heading(level: 1, numbering: none)[谢辞]

在本报告完成之际，谨向在项目研究与报告撰写过程中给予悉心指导的指导教师，以及给予帮助与支持的队友、同学与提供竞赛平台与技术支持的英特尔公司表示衷心的感谢。
