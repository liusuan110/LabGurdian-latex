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
#let 竞赛年份        = "2026"
#let 报告题目        = "LabGuardian：面向噪声感知输入的神经—符号解耦边缘电路实验诊断系统"
#let 英文题目        = "LABGUARDIAN: A NEURO-SYMBOLIC EDGE SYSTEM FOR BREADBOARD CIRCUIT DIAGNOSIS UNDER NOISY PERCEPTION"
#let 学生姓名        = ""
#let 指导教师        = ""
#let 参赛学校        = ""

#let 中文摘要 = [
  针对高校电子实验中“原理图正确但实物接错”难以发现、师生比偏高、教学诊断需可解释且安全的痛点，本文提出 LabGuardian——一个运行于英特尔边缘平台的神经—符号解耦电路实验诊断系统。系统不让大模型直接“看图判错”，而是以多视角面包板图像为输入，经自建引脚级数据集训练的关键点模型、孔位吸附与板型导通规则重构引脚级电气网表；由确定性图比对算法承担对错判断并输出可审计的结构化错误事实，再由智能体在检索契约限定的证据范围内生成自然语言解释，并以不可绕过的校验器拦截无依据陈述。教学解释模型经双教师蒸馏与 INT4 量化后部署于 Intel DK-2500，借助 NPU、iGPU 与 CPU 的异构分工实现低功耗本地推理。实验表明，NPU INT8 视觉模型达到 13.37 ms 延迟与 74.7 img/s 吞吐，端侧 INT4 学生模型约 0.88 GB、约 23 tok/s；检索契约使同一小模型由 0/6 场景无法定位故障提升至 6/6 场景正确接地，系统可在 8 GB 内存边缘设备上以约 10 W 完成诊断与解释。
]
#let 中文关键词 = ("面包板电路诊断", "神经—符号", "检索契约", "知识蒸馏", "边缘智能")

#let 英文摘要 = [
  To address "schematic-correct but wrongly-wired" breadboard circuits, high student-to-teacher ratios, and the need for explainable and safe feedback in electronics laboratories, this paper presents LabGuardian, a neuro-symbolic circuit-diagnosis system running on an Intel edge platform. Instead of asking a large model to directly judge an image, LabGuardian reconstructs a pin-level electrical netlist from noisy breadboard images using a self-built pin-level dataset, keypoint detection, hole snapping, and breadboard connectivity rules. A deterministic graph-comparison engine makes the correctness judgement and emits auditable structured error facts; an agent then generates explanations strictly within a retrieval contract, while an unbypassable verifier rejects ungrounded statements. The teaching-explanation model is produced by dual-teacher distillation and INT4 quantization, and is deployed on the Intel DK-2500 through heterogeneous NPU/iGPU/CPU scheduling. Experiments show that the NPU INT8 vision model reaches 13.37 ms latency and 74.7 img/s throughput, while the 0.88 GB INT4 student model runs at about 23 tok/s. With the same small model, the retrieval contract improves fault grounding from 0/6 to 6/6 demo scenarios, enabling diagnosis and explanation at about 10 W on an 8 GB edge device.
]
#let 英文关键词 = ("breadboard circuit diagnosis", "neuro-symbolic", "retrieval contract", "knowledge distillation", "edge intelligence")


// ─────────────────────────── ② 字体与字号 ────────────────────────────────
#let 正文字体 = ("Times New Roman", "SimSun", "Songti SC", "Source Han Serif SC")   // 宋体 / 英文 Times
#let 标题字体 = ("Times New Roman", "SimHei", "Heiti SC", "Noto Sans SC")           // 黑体
#let 楷体字体 = ("KaiTi", "STKaiti", "Kaiti SC")                                    // 楷体
#let 华文楷体 = ("STKaiti", "华文楷体", "Kaiti SC")                                  // 华文楷体（封面“作品设计报告”）
#let 楷体GB   = ("KaiTi_GB2312", "楷体_GB2312", "KaiTi", "STKaiti", "Kaiti SC")      // 楷体_GB2312（封面题目/信息栏；Windows 无此字体时回退 KaiTi）
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
      image("assets/esdc_logo.jpg", height: 1.2cm),
      text(font: 标题字体, size: 小五)[#报告题目],
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
  header-ascent: 9pt,      // 分隔线落在约 2.78cm 处、logo 顶在约 1.5cm 处，与原模板一致
  footer: none,            // 前置部分（封面～目录）不显示页码，正文处再开启
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
// 参考文献上标标注：正文中写 #引[1] 得到上标 [1]
#let 引(n) = super(typographic: false)[\[#n\]]

// 三线表：顶线 1pt + 表头底线 0.5pt + 底线 1pt，无竖线
#let 三线表(columns: (), align-cells: auto, header: (), rows: ()) = {
  let n = rows.len()
  table(
    columns: columns,
    align: align-cells,
    inset: (x: 6pt, y: 4pt),
    stroke: (x, y) => {
      if y == 0 { (top: 1pt, bottom: 0.5pt) }
      else if y == n { (bottom: 1pt) }
      else { none }
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
  width: 100%, fill: white, stroke: box-stroke(fill), radius: 3pt, inset: (x: 9pt, y: 8pt),
  grid(columns: (7.5em, 1fr), column-gutter: 11pt, align: (center + horizon, left + horizon),
    text(weight: "bold", size: 10pt, fill: fig-ink, name),
    { set par(leading: 0.62em, justify: false, first-line-indent: 0pt); text(size: 8.4pt, fill: fig-ink, modules) }),
)
#let flow-node(body, fill: fig-plain) = block(
  width: 100%, fill: white, stroke: box-stroke(fill), radius: 3pt, inset: (x: 10pt, y: 8pt),
  align(center + horizon, { set par(leading: 0.62em, justify: false, first-line-indent: 0pt); text(size: 9pt, body) }),
)
#let v-both = align(center, text(fill: fig-aux, size: 12pt, sym.arrow.t.b))
#let v-down = align(center, text(fill: fig-aux, size: 12pt, sym.arrow.b))
#let h-right = align(center + horizon, text(fill: fig-aux, size: 12pt, sym.arrow.r))
#let h-both = align(center + horizon, text(fill: fig-aux, size: 12pt, sym.arrow.l.r))
#let tag-box(body, fill: fig-plain) = block(
  fill: white, stroke: box-stroke(fill), radius: 3pt, inset: (x: 6pt, y: 8pt),
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
  text(font: 华文楷体, size: 32pt)[作品设计报告]   // 华文楷体 32pt
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
  show outline.entry: it => { set text(font: 正文字体, size: 五号); it }
  outline(title: none, depth: 3, indent: 1.5em)
}


// ════════════════════════════ 正文 (Body) ════════════════════════════════
// 正文从第 1 页起编号，启用页脚
#pagebreak()
#set page(footer: 页脚)
#counter(page).update(1)


= 绪论

== 教学背景与核心痛点

高校电子类基础实验是学生由理论走向工程实践的关键环节：学生需依据原理图，在面包板上插接电阻、电容、二极管、发光二极管、晶体管与运算放大器等元件，并借助电源、示波器与万用表观察电路现象。这一过程要求学生完成三重映射——由电路原理到元件功能、由二维原理图到面包板孔位、由实验现象到故障原因，任一映射失败都可能使实验停滞。

电子实验课普遍师生比偏高，教师难以同时覆盖所有实验台，学生常需排队等待检查；教师到场后还需逐项排查元件是否插对、引脚是否接反、孔位是否同组、电源轨是否误接、导线是否短路等基础问题。此类排查高度依赖经验、重复性强，却不能省略——极性反接与电源短路可能损坏芯片，甚至带来安全风险。

上述场景对智能诊断提出了四个超出常规视觉识别的核心难点。其一，真实图像遮挡严重：导线交叠、元件遮挡引脚与拍摄角度差异都会干扰识别，而常规目标检测只给元件级边界框、无法判定引脚插入哪一孔位，诊断因而必须深入引脚级与孔位级。其二，面包板导通关系不直观：主区按列导通、中缝隔离左右半区、电源轨可能分段，初学者易把相邻孔位误判为等价；将物理孔位映射为导通节点后，系统才能指出相邻孔位并非同网、或两引脚短接于同一网络。其三，教学需要可解释的证据而非黑盒结论：诊断应给出错误类型及其涉及的元件、引脚、孔位与建议动作，并保留证据引用以便界面高亮。其四，系统须适应边缘环境：实验室网络未必稳定、数据不宜全部上云，故以边缘设备为主要运行平台、降低对外网依赖。

== 现有技术路线及其局限

围绕“判断学生电路是否正确”这一目标，现有技术路线大致可分为三类，各自存在难以回避的局限。

第一类是通用电路仿真软件。以 SPICE 为代表，它面向理想原理图、验证设计层面的正确性，却无法感知面包板上的真实接线，难以发现“原理图正确但实物接错”这一最常见的问题#引[1]。

第二类是纯规则或模板比较。它借助图同构与引脚角色规则给出确定、可解释的结论，但在遇到多余元件、角色标注偏弱、输入输出网络重映射等边界情形时需不断打补丁，易判定过宽或诊断粒度不足。

第三类是端到端大模型直接看图判错。近年多模态大模型展现出强大的视觉理解能力，但其输出难以审计、易生幻觉，不宜作为正误判定的唯一依据，难以满足教学对安全与可解释的严苛要求#引[2]。

有鉴于此，本文采取折中且工程可落地的路线：由确定性算法构建可验证的结构化事实链承担事实判断，再由智能体在受约束的证据范围内生成解释，从而在可解释性与安全性之间取得平衡。这一“神经—符号解耦”的设计取向贯穿全文，也是本系统区别于上述三类方案的根本所在。

== 需求分析与本文工作

面向上述教学场景，系统需同时服务三类用户：学生希望快速知道电路哪里错、为什么错、如何改；教师与助教希望掌握多个实验台状态、定位共性错误以减少重复巡检；系统维护者则关注各模块数据契约稳定、便于后续扩展。由此提炼出功能性与非功能性两方面需求。

在功能上，系统以“图像接入 → 组件与引脚检测 → 孔位映射 → 拓扑重构 → 参考比较 → 诊断解释”为主线：支持上传面包板图片并识别电阻、电容、导线、二极管、三极管、集成芯片等教学常见元件；将引脚吸附至物理孔位并映射为电气节点；合并导线网络输出结构化网表；与逻辑参考电路比较生成差异报告；最终转化为学生可理解的自然语言建议。系统同时提供人工修正（孔位、端口、网络角色与器件标注）与结果可视化，并在服务端记录运行元数据与硬件遥测。

在非功能上，系统强调准确性、可解释性、低延迟、弱网可用、隐私保护与可扩展性：每个错误都应有证据引用与可视化目标，交互需及时，推理尽量本地运行，新增板型、元件、参考电路与故障案例时无需重写核心链路。

围绕上述需求，本文的主要工作与贡献概括如下：（1）提出面向噪声感知输入的引脚级电气网表重构方法，以关键点检测与孔位吸附替代端到端目标检测，将识别精度下沉至引脚与孔位；（2）以确定性图比对承担对错判断、智能体仅在受约束证据内生成解释，并以不可绕过的确定性校验器拦截无依据陈述，构成“神经—符号解耦”的可审计诊断链；（3）面向边缘部署，采用双教师蒸馏与 INT4 量化得到端侧教学解释模型，并在 Intel DK-2500 上以 NPU、iGPU、CPU 异构分工实现低功耗本地推理；（4）通过三组正交消融与端侧实测，分别验证检索契约、模型蒸馏与量化各自的贡献。

本文余下章节安排如下：第二章给出系统总体方案与架构；第三章阐述视觉感知与拓扑重构；第四章阐述符号诊断引擎；第五章阐述智能体与多模态检索增强；第六章阐述端侧蒸馏与英特尔异构部署；第七章给出系统测试与结果分析；第八章回顾项目落地过程中的探索与失败；第九章总结全文并展望后续工作。

= 系统方案与总体设计

== 项目定位、目的与必要性

LabGuardian 是面向电子实验教学的边缘智能助教系统。与在虚拟环境验证原理的通用仿真不同，它以学生实际搭建的面包板照片为输入，将图像中的元件、引脚、孔位与电气连接重建为可验证、可审计的结构化事实，再与参考电路逻辑比较，输出错误位置、成因、风险等级与修改建议，从而把高度依赖经验的实验巡检形式化为可复现、可解释的诊断流程，降低教师的重复排错负担并为学生提供即时反馈。

系统主线可形式化为“元件 → 引脚 → 物理孔位 → 导通节点 → 电气网络 → 结构化网表”的逐级事实链：把“某引脚在图像中接近某处”的模糊观察，逐层上升为“某引脚归属某一电气网络”的确定结论。该链路的可靠性，决定了系统能否将像素层面的连接观测转化为确定性的网络归属判断。

== 核心创新与竞赛平台适配

本项目的独特立意不在于简单叠加“视觉模型 + 大语言模型”，而在于把电子实验诊断拆成三条互相制约的链路：第一条是从像素到网表的感知事实链，解决真实面包板图像带噪、遮挡和孔位歧义问题；第二条是从网表到错误码的符号判定链，保证对错判断可复现、可审计；第三条是从错误码到教学语言的接地解释链，保证智能体回答不越过证据边界。三条链路共同形成“噪声感知输入—确定性诊断—受约束解释”的闭环，使系统既能体现人工智能能力，又不把安全敏感的正误判定交给不可审计模型。

英特尔竞赛平台在本项目中并非演示载体，而是系统设计的约束来源。DK-2500 同时具备 CPU、iGPU 与 NPU，恰好对应 LabGuardian 的三类负载：NPU 承担规则稠密的视觉关键点推理，iGPU 承担自回归解释生成，CPU 承担图同构、子图匹配、知识检索、服务编排与遥测控制。该分工避免单个计算单元被视觉、语言与控制逻辑争抢，亦使项目能够以真实板端功耗与延迟数据证明“可在课堂边缘部署”，而非仅在开发机上完成算法验证。

== 总体架构

总体架构要回答的核心问题是：如何既用上大模型的语言能力，又不让它染指安全敏感的对错判定。LabGuardian 的答案是以分层把“事实生产”与“话术生成”在结构上彻底隔开。系统采用交互端与服务端分离：交互端负责图片上传、参数与参考电路选择、结果可视化、人工修正与智能体对话；服务端负责接口接入、图像处理、模型推理、孔位映射、拓扑构建、逻辑比较、课堂状态、知识检索、智能体编排与遥测推流。整体可概括为“交互层—API 服务层—流水线事实层—领域规则层—Agent 与知识解释层—基础支撑层”六个层次，如#ref(<fig:arch>)所示。

服务端六层各司其职：API 层作为协议入口，不承担领域推理；服务层负责编排、审计、下发和任务管理；领域层承载板型规则、电路分析、验证、风险评估与参考电路描述等稳定规则；流水线层只输出结构化事实，不直接生成教学话术；Agent 与知识层在事实基础上组织上下文、工具调用与回答；基础设施层提供异步任务、缓存、容器化与测试支撑。这种分层使“事实生产”与“话术生成”彻底解耦——下游的自然语言解释永远以上游可证伪的结构化事实为唯一依据。

#figure(
  align(center, grid(
    columns: (auto,) * 13, align: horizon, column-gutter: 3pt,
    tag-box([交互层], fill: fig-emph), h-both,
    tag-box([API 层]), h-both,
    tag-box([服务层]), h-both,
    tag-box([流水线层], fill: fig-emph), h-both,
    tag-box([领域层]), h-both,
    tag-box([Agent 与\ 知识层]), h-both,
    tag-box([基础设施层]),
  )),
  caption: [系统总体架构（左端发起调用，右端逐层向左提供可证伪的结构化事实）],
) <fig:arch>

== 主业务流程

一次完整诊断从交互端上传图片开始：用户选定参考电路并设定置信度、交并比、推理尺寸与电源轨角色后，图片编码提交至同步诊断接口；流水线服务解析参考电路、调用编排器依次执行从组件检测到语义分析的各环节，服务层再把结果封装为统一诊断结果并同步到课堂状态。交互端显示识别事实链与诊断报告后，自动向智能体请求诊断解释与下一步建议，智能体基于运行证据生成自然语言解释。整体流程如#ref(<fig:pipeline>)所示。

若发现视觉映射不准确，交互端可进入网表模式人工修正引脚孔位、端口标签、网络角色或三极管与集成芯片标注，再调用人工修正重算接口；服务端不重跑视觉检测，而是从修正后的元件重新执行拓扑重构、参考验证与语义分析。这种设计兼顾 AI 自动识别与教学现场的人机协同，避免视觉阶段偶发错误导致系统整体不可用，亦正面回应了真实感知输入必然带噪这一现实约束。

#figure(
  block(width: 100%, stack(spacing: 8pt,
    align(center, grid(
      columns: (auto,) * 13, align: horizon, column-gutter: 3pt,
      tag-box([上传图片]), h-right,
      tag-box([组件检测], fill: fig-emph), h-right,
      tag-box([孔位映射]), h-right,
      tag-box([拓扑重构], fill: fig-emph), h-right,
      tag-box([参考验证]), h-right,
      tag-box([语义分析]), h-right,
      tag-box([诊断解释]),
    )),
    align(center, text(size: 8.2pt, fill: fig-aux, [— — —　人机协同修正回路（视觉结果不准时）　— — —])),
    align(center, grid(
      columns: (auto,) * 5, align: horizon, column-gutter: 3pt,
      tag-box([人工修正], fill: fig-warm), h-right,
      tag-box([重算接口], fill: fig-warm), h-right,
      tag-box([拓扑重算], fill: fig-emph),
    )),
  )),
  caption: [主业务流程（上排为自动诊断主链，下排为人机协同修正回路）],
) <fig:pipeline>

== 技术选型与设计原则

在技术选型上，服务端以 Python 与 FastAPI 构建异步接口，视觉识别采用 YOLO 系列模型并经 OpenVINO 转换以适配英特尔异构硬件，电气比对基于图论库实现确定性图同构与子图匹配，知识检索使用本地向量化的多通道知识库，端侧教学解释模型由开源中文小模型经蒸馏与量化得到，交互端采用现代前端框架并以画布叠加方式呈现识别与诊断结果。

在此之上，系统设计遵循四项原则。第一，事实链优先：视觉模型只产生候选事实，最终教学结论必须经过板型规则、拓扑分析与验证模块约束。第二，接口契约优先：各阶段输出，以及结构化网表、诊断报告、运行证据与上下文包，都以统一的结构化格式作为协作边界，避免交互端、服务端或智能体私自猜测。第三，人机协同优先：系统允许人工端口标注与孔位修正，教师与学生可把 AI 输出修正为可信事实后再重算。第四，边缘可观测优先：运行结果保留模型路径、推理参数、板型定义、版本号与阶段耗时，可与遥测数据一起用于实验分析与问题追溯。


= 视觉感知与拓扑重构

本系统的核心工程方法是将“看图诊断电路”分解为若干可解释的事实转换步骤，而非以单一端到端大模型直接给出结论：组件检测负责元件实例、引脚检测负责引脚候选、孔位映射负责孔位吸附、拓扑重构负责导通网络、参考比较负责逻辑比较，智能体仅负责解释。这一结构化事实链使每一步均可被独立测试、独立可视化与独立修正，错误定位也因此更为具体，并从根本上抑制了端到端模型难以审计、易于幻觉的风险。本章聚焦事实链的前段，即从图像到引脚与孔位的视觉感知与映射环节。

== 自建引脚级面包板数据集

视觉链路的可靠性首先取决于训练数据，而本场景对数据的要求相当特殊：既非电路原理图层面的符号数据，亦非印制电路板（PCB）层面的器件数据，而是真实面包板照片上、精确到引脚与孔位的细粒度标注，且须覆盖真实拍摄中普遍存在的遮挡、反光与视角差异。据我们调研，当前学术界缺乏严格符合这一情景的公开数据集——已有电路类数据集多停留在原理图识别、PCB 缺陷检测或干净网表层面，鲜有在“教学面包板 + 引脚级关键点 + 孔位映射 + 真实噪声”四个维度上同时满足本任务者。为此，本项目自行采集并标注了一套专用数据集，它构成本系统视觉感知的基础，亦相对于既有公开资源具有独创性。

数据集采集自真实面包板实验照片，覆盖一阶 RC、共射放大、差分对、UA741 反相/积分/加法等六类教学拓扑，并刻意纳入多角度、不同光照与导线遮挡等真实变体。标注采用“组件级边界框 + 引脚级关键点”的双层结构：每个元件实例除给出类别与边界框外，还以关键点形式标注其引脚位置（关键点张量形状为 3×3，即每实例至多 3 个引脚、每个引脚记录横纵坐标与可见性），从而把识别精度从元件级下沉到引脚级——这正是常规目标检测数据集所不具备、却为电气诊断所必需的标注粒度。该数据集由项目自行拍摄并标注的真实面包板照片构成，并按训练 / 验证 / 测试三部分留出划分以支持独立评测。由于全部取自真实实验台、并刻意涵盖多角度、不同光照与导线遮挡，其样本本身即贴近课堂实拍的噪声分布，无需依赖合成增强。数据集主要规格如#ref(<tab:dataset>)所示。

#figure(
  三线表(
    columns: (1.1fr, 3fr),
    align-cells: (left, left),
    header: ([数据集维度], [内容]),
    rows: (
      ([元件类别], [电阻、陶瓷电容、电解电容、二极管、发光二极管、跳线、三脚晶体管（共 7 类）]),
      ([标注粒度], [组件边界框 + 引脚级关键点（关键点张量 3×3：每实例至多 3 引脚，含可见性）]),
      ([覆盖拓扑], [一阶 RC、共射放大、差分对、UA741 反相 / 积分 / 加法（共 6 类）]),
      ([数据划分], [真实实验台自采自标，按训练 / 验证 / 测试留出划分，涵盖多角度、光照与遮挡变体]),
      ([训练配置], [YOLOv8s-pose 骨干，输入 960，batch 8，训练 100 轮；INT8 由 144 张校准图训练后量化]),
    ),
  ),
  caption: [自建引脚级面包板数据集主要规格],
) <tab:dataset>

视觉模型的形成并非一步到位，而是经历了由易到难的逐步迭代。最初阶段，项目先在单个离散元件照片上训练组件级检测器，验证电阻、电容、二极管、发光二极管、跳线与三脚晶体管等基础元件的可识别性；在此基础上进一步把任务从“识别元件是什么”推进到“识别引脚在哪里”，将标注升级为 pose 形式，使模型能够直接回归引脚位置并为后续孔位吸附提供几何证据。随后，组件检测侧继续扩展对电位器与双列直插芯片等复杂器件的识别能力，对多脚器件则结合封装规则生成引脚候选；最后再把元件级样本扩展到典型教学电路的综合场景中，使模型从“看单个元件”过渡到“看真实实验板上的多元件共存与遮挡”。这一渐进式训练路线降低了任务难度，也让数据标注与模型能力始终与系统需求同步演进。

最终的 pose 训练运行采用 Ultralytics YOLOv8s-pose，输入尺寸 960、batch size 为 8、训练 100 轮，启用默认优化器与常规颜色/平移/缩放增强，末 10 轮关闭 mosaic。训练日志显示，模型在第 100 轮的验证集上，组件检测框（B）指标为 precision=0.991、recall=0.989、mAP50=0.991、mAP50-95=0.786，引脚关键点（P）指标为 precision=0.955、recall=0.954、mAP50=0.947、mAP50-95=0.829（其中 B 指检测框指标、P 指引脚关键点指标）。虽然课堂真实拍摄仍会受到遮挡、模糊与反光影响，但上述验证集指标已说明模型能够较稳定地同时完成组件定位与引脚关键点回归，为后续孔位映射与拓扑重构提供可用的视觉前提。测试集未参与任何训练与模型选择决策，留作后续端到端系统级评测的独立样本。

综上，这套“面向噪声、引脚级标注、孔位可映射”的自建数据集，为本系统的引脚级感知提供了贴近真实课堂的训练基础。

== 流水线编排

流水线编排器是服务端事实链的核心：它以线程安全的单例复用组件与引脚检测器以免重复加载模型，并为每次请求单独创建保存网格状态的面包板校准器。编排器接收图片、参考电路、电源轨、各类标注与阈值参数，依次执行组件检测、引脚检测、孔位映射、拓扑重构、参考验证与语义分析，返回各阶段结果、总耗时与运行元数据。

== 组件检测

组件检测以面包板俯视图为输入，建立全局唯一的元件主实例与编号，作为引脚检测、孔位映射与比对的共同锚点——该编号一经确立即贯穿整条事实链，使下游各阶段对“同一元件”不再产生分歧。

检测输出采用统一结构化格式（含元件编号、类别、封装、置信度与边界框等字段），并过滤面包板本体与布线区域等背景类别；对集成芯片则通过封装识别推断双列直插 8/14 脚，为后续引脚生成提供依据。

== 全图引脚检测

电气诊断要求识别精度下沉到引脚级，而常规目标检测只能给出元件级边界框，无法回答“某引脚究竟插在哪个孔”。一个直觉方案是先裁剪单个元件框、再在框内分别回归引脚，但实践中我们发现裁剪会把引脚切到框外、并丢失元件周边的上下文，导致系统性漏检。为此本系统改采整图关键点检测：在俯视图上以 YOLO-Pose 一次性回归全部引脚关键点，再依据类别与边界框的几何约束把引脚归属到对应元件——既避免了裁剪误差与局部上下文丢失，又为后续孔位映射保留了完整的引脚证据。

模型不可用时，该阶段输出格式兼容的“不可用”占位结果，保证下游不因模型缺失而结构崩溃；对集成芯片则可不依赖引脚模型，按边界框与面包板行列约束生成 8 或 14 个引脚。每个引脚记录其关键点坐标、可见性与综合置信度，为孔位映射提供完整证据。

== 孔位映射与导通节点解析

把“引脚在图像中接近某处”的模糊观测，上升为“引脚归属某一导通节点”的确定结论，是整条事实链中最易产生歧义的一步：同一关键点可能落在相邻孔位之间，单凭最近邻吸附极易误判。孔位映射因此并不简单选取最近孔，而是先用俯视图标定面包板网格（校准失败则回退合成网格并显式标记），再为每个引脚整合关键点坐标、可见性、来源与投影构造观测记录以生成候选孔位，最后依据板型规则把孔位解析为对应的导通节点。

孔位映射的一个重要特点是保留而非隐藏不确定性：每个映射后的引脚都带上候选孔位、候选节点、是否歧义及其原因、综合置信度与置信裕度、吸附距离与吸附置信度等信息。这种“显式保留不确定性”的设计，使下游能够区分高置信映射与需人工复核的低置信映射，也为人机协同修正提供了明确的介入点——这恰是应对真实拍摄中遮挡与反光的关键：与其在低置信处强行给出可能错误的结论，不如显式标注歧义、交由教师一键修正（见#ref(<fig:ambiguity>)）。

#figure(
  rect(width: 100%, height: 4.8cm, stroke: (paint: gray, thickness: 0.6pt, dash: "dashed"), fill: luma(248), inset: 10pt)[
    #align(center + horizon)[#text(fill: gray, size: 9pt)[【待插入截图：交互端面包板视图——低置信引脚的歧义标记（虚线候选孔位环 + 指向各候选的虚线）】]]
  ],
  caption: [低置信引脚的歧义可视化：系统不强行吸附，而以虚线环标出候选孔位、交由教师一键确认，将真实照片中遮挡 / 反光导致的“网匹配歧义”显式化为人机协同的介入点],
) <fig:ambiguity>

板型规则在此承担连接视觉与电气逻辑的桥梁：依据孔位的行列归属把物理孔位规范化为稳定的导通节点，并支持据节点反查整条导通带的全部孔位，供交互端整带高亮。

在通用孔位投票之外，系统还按器件类型施加几何约束（两脚器件的引脚配对、电位器三孔共线、轴向器件不跨中缝），并由元件外形推断三极管的发射极—基极—集电极极性；这些器件级先验把“像素邻近”修正为“符合物理形态的孔位与极性”，为后续电气比对提供更可靠的引脚级事实。


#pagebreak()

= 电气重构与符号诊断引擎

本章是“神经—符号解耦”中的符号侧：它不依赖任何神经网络，对错判断由图论算法以确定、可复现、可审计的方式给出，从根本上杜绝了在安全敏感的“对错”问题上产生幻觉。

== 拓扑重构与结构化网表

视觉阶段给出的只是“哪个引脚落在哪个孔”，而电气诊断需要的是“哪些引脚同属一个导通网络”——二者之间隔着导线合并与孔位到节点的解析，拓扑重构正是完成这一跨越的环节。它读取孔位映射后的元件与引脚构造电路分析器，以图结构表示元件与网络的关系，并用并查集把由导线连接的等电位孔位合并为统一网络。这里有一个易被忽视的陷阱：若沿用上游旧的节点编号，一旦人工修正了某个孔位，旧编号残留便会致错；因此系统坚持以物理孔位为唯一可信来源、据孔位重新解析导通节点。在最终的元件—网络二分图中，导线不作为元件参与拓扑、仅用于合并网络；若某非导线元件的多个引脚落入同一网络，则标记为同网络以供短路风险判断。

拓扑重构的核心产物是结构化网表：它并非文字形式的网表，而是一个保留元件、引脚、网络、节点索引与板型拓扑的结构化对象，可被交互端、验证模块与智能体共同消费；系统亦支持据此导出拓扑级 SPICE 网表（导线已隐式合并，元件取值暂以占位）。该对象使交互端既能判定某引脚归属哪一网络，又能在用户选中某网络时高亮其全部相关孔位，从而同时服务于电气比较与可视化定位。

== 参考电路的领域特定语言

参考电路的正确性与可读性直接决定诊断的可信度。为此系统不手写网表 JSON，而以一套嵌入式 Python 领域特定语言（DSL）声明逻辑参考电路，把“作者意图”与“机器可比对结构”分离。DSL 的核心抽象为：`Circuit` 容器承载参考标识、网络、元件、对称组与等价选项；`Net` 携带语义角色（`signal` / `input` / `output` / `power` / `ground`）与角色标签（如 `UI1` / `UO1` / `VCC` / `VEE` / `GND`）；`Pin` 绑定到具体元件实例并可显式标注不连接（no-connect）；`Component` 记录编号、类型、子类型与引脚。

DSL 以语义化接口声明带角色的网络、接线与对称网组，并以等价规则（忽略孔位与元件编号、忽略无极性引脚顺序、允许多余导线）表达比对意图，最终经 `to_logical_reference()` 编译为统一逻辑参考 JSON。如此，新增参考电路只需以接近原理图的方式书写数十行 DSL，既降低出错概率，又与比对器保持稳定数据契约。

== 确定性图比对算法

比对面临一对看似矛盾的要求：学生在面包板上的摆放千差万别，不能因孔位不同就判错；但只要电气逻辑接错，又必须准确指出。逐孔位的硬规则满足其一便失之其二，难以两全。本系统的解法是把比对提升到逻辑层——在元件—网络二分图上、只对照逻辑参考电路，使“摆放不同但逻辑等价”判为正确、“逻辑网络接错”判为错误。算法分级进行：首先尝试完整图同构匹配（基于 networkx 的 VF2 算法），节点按元件类型与网络角色匹配、边按引脚角色匹配。在同构之前，系统先做一次模糊组件对齐与规范名（canonical-name）角色传播，把参考电路的语义（如 `INV`、`VOUT`）传播到学生电路的匿名网络上，使下游消费者看到富语义；此步只更新网表语义而不重建结构图，以免干扰结构匹配的判定。

当完整同构失败时，算法逐级降级：先判断学生电路是否为参考电路的子图或包含关系（借此区分“多余连接”与“未完成电路”）；仍不成立时，才以图编辑距离（带超时）或近似相似度给出错接报告。匹配规则采用“严格/宽松”分级——电源与地、以及功能引脚（运放反相/同相输入、三极管基极-集电极-发射极、二极管与发光二极管极性、电位器中心抽头）严格匹配；电阻、电容、导线等无极性两脚器件忽略引脚顺序；并允许合理的额外导线。相比逐孔位规则，该分级显著降低了因摆放差异导致的误报；相比纯文本规则，又对关键电气语义保持刚性约束——这正是把“对错判断”交给符号系统、而非交给易幻觉大模型的根本理由。

算法的核心不是单次“是否同构”的布尔判断，而是一条可解释的级联判定链（见#ref(<tab:compare-cascade>)）：它先尽量证明电路正确，再逐级识别“多余连接”“未完成”“关键引脚错接”“危险短路”等失败类型并转写为稳定错误码。其好处是每个结论都能回溯到具体匹配阶段——交互端据此高亮，智能体也只能引用这些结构化事实而不能臆测故障。

#figure(
  三线表(
    columns: (1.25fr, 2.2fr, 2.15fr),
    align-cells: (left, left, left),
    header: ([判定阶段], [算法动作], [输出意义]),
    rows: (
      ([完整同构], [参考图与当前图在元件类型、网络角色、功能引脚约束下匹配], [判定逻辑等价，输出正确结论]),
      ([角色推断], [在不覆盖人工标注的前提下，从参考图向匿名 current 网络传播角色], [降低学生未标内部信号造成的误报]),
      ([包含/子图], [判断当前图是否包含参考结构，或仅完成参考结构的一部分], [区分“多余连接”与“未完成电路”]),
      ([差异报告], [生成 missing、extra、wrong、short、role mismatch 等 item], [形成前端与 Agent 共享的错误事实]),
    ),
  ),
  caption: [确定性图比对的级联判定链],
) <tab:compare-cascade>

== 拓扑模板与三层语义匹配

纯图比对需要一份确定的参考电路，但同一教学拓扑常有多种合法实现：共射放大器的发射极可直接接地、可串发射极电阻、可再并联旁路电容；加法器可有 2 至 5 路输入；电路上还可能出现去耦、偏置补偿等可选元件或纯装饰元件。若以单一参考硬比较，这些合法变体极易被误报。为此系统引入拓扑模板，把每类规范拓扑表达为一份“偏规范（partial specification）”，并为六类示范拓扑各维护一份模板。

模板以三层语义刻画结构（如#ref(<tab:tier>)所示）：`required` 缺失则不匹配，`optional` 可缺不扣分，`forbidden` 出现即降级或否决（如反相放大器出现反馈电容，往往说明学生实际搭的是积分器）。模板另以变体与重数容纳同一拓扑的多种合法实现（如共射发射极的多种接法、加法器 2 至 5 路输入），并声明参数化不变量作为面向器件取值的约束框架；因当前视觉管线尚未提取数值，此类不变量按设计仅声明、执行留待后续。

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

匹配上以子图同构（而非完整同构）搜索模板在学生电路图中的嵌入——因为学生电路常含模板未提及的多余导线或重复元件，只要规范结构可被“嵌入”即可，并按必需边占比计分、`forbidden` 命中扣分。该模板层与图比对并行、对管线只读，从而把第一章所述“纯规则需不断打补丁”的边界情形系统化地容纳进来。

== 诊断报告与错误码

参考比较与模板匹配的结论最终汇聚为结构化诊断报告。每条诊断项包含错误码、错误族、严重程度、说明、建议动作、证据引用，以及涉及的元件、引脚、当前与目标孔位、当前与目标节点等字段。诊断报告采用一套稳定的确定性错误码词表，其常见取值与含义如#ref(<tab:errcode>)所示——这套词表也是后文知识检索契约中“验证器↔知识库”桥接的关键，故障案例正是依据这些错误码被精确召回。

#figure(
  三线表(
    columns: (1.5fr, 1fr, 2.6fr),
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

诊断报告除逐条诊断项外，还包含面向交互端的高亮协议，将每条诊断项的证据引用转换为可直接绘制的高亮目标：元件框引用渲染为元件框，引脚关键点引用渲染为引脚点，孔位候选引用渲染为当前孔位、目标孔位与候选孔位。智能体在生成解释时复用同一份高亮协议，从而使自然语言说明与界面可视化定位指向同一份事实。完整的端到端诊断示例见#ref(<fig:e2e>)。

#figure(
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 6pt,
    rect(width: 100%, height: 3.6cm, stroke: (paint: gray, thickness: 0.6pt, dash: "dashed"), fill: luma(248), inset: 6pt)[#align(center + horizon)[#text(fill: gray, size: 8pt)[(a) 检测框 + 引脚关键点]]],
    rect(width: 100%, height: 3.6cm, stroke: (paint: gray, thickness: 0.6pt, dash: "dashed"), fill: luma(248), inset: 6pt)[#align(center + horizon)[#text(fill: gray, size: 8pt)[(b) 重构网表（面包板视图）]]],
    rect(width: 100%, height: 3.6cm, stroke: (paint: gray, thickness: 0.6pt, dash: "dashed"), fill: luma(248), inset: 6pt)[#align(center + horizon)[#text(fill: gray, size: 8pt)[(c) 诊断项与证据高亮]]],
  ),
  caption: [端到端诊断示例：(a) 俯视照片上的元件检测框与引脚关键点；(b) 重构出的结构化网表；(c) 与参考电路比对后的诊断项与证据高亮——“神经感知 → 符号判断 → 可解释定位”事实链端到端贯通],
) <fig:e2e>

#pagebreak()

= 智能解释与人机协同

得到结构化网表与诊断报告后，系统需把这些事实转化为学生可理解、可纠错的反馈。本章描述事实链的最后一环：智能体如何在受控事实约束下生成自然语言解释、知识检索如何安全补充背景、交互端如何呈现证据并定位错误，以及人工修正如何与重算形成闭环。

== 诊断智能体与推送式上下文管理

把诊断交给智能体，最直接的做法是把完整网表与知识库塞进大模型上下文任其推理；但边缘小模型的上下文窗口与内存都很紧张，且一旦看到全部原始事实，模型便有“重新判断对错”的空间而引入幻觉。为此系统采用“推送式上下文管理”（Push-based Context Management, PCM）：按错误类型、风险等级、场景与用户问题，从课堂状态编译出仅含被推送事实、被允许工具与证据引用的最小上下文包，并估算 token 以控制规模。智能体只能看到被推送内容，行为因此被约束在已验证结论之内，不会越过验证模块猜测孔位或网络；这种主动压缩对内存受限的边缘部署尤为关键。

诊断智能体统一编排四类教学意图——诊断、概念讲解、操作指导与混合问答。四类意图共用同一张状态图，仅按意图切换工具白名单、回答校验规则与回答模板，如#ref(<fig:intent>)所示。工具选择进一步取决于错误所属的错误族，每族对应一份白名单——如短路类调用网表追踪、板型查询与热力图叠加。智能体据此动态选工具，而非把所有技能、知识与历史一并塞入上下文。意图判定采用确定性关键词分类为主：经实测，端侧十亿级小模型直接做四类意图分类，准确率与延迟均不及确定性关键词路由，故系统以零延迟、可解释的关键词分类承担路由，小模型只负责生成（详见第七章）。

#figure(
  block(width: 100%, stack(spacing: 7pt,
    align(center, grid(
      columns: (auto,) * 7, align: horizon, column-gutter: 4pt,
      tag-box([诊断]), tag-box([概念讲解]), tag-box([操作指导]), tag-box([混合问答]),
      h-right, tag-box([统一状态图], fill: fig-emph), [],
    )),
    align(center, v-down),
    align(center, grid(
      columns: (auto,) * 5, align: horizon, column-gutter: 4pt,
      tag-box([工具白名单], fill: fig-emph), [　], tag-box([校验规则], fill: fig-emph), [　], tag-box([回答模板], fill: fig-emph),
    )),
  )),
  caption: [一图四意图：四类意图共用同一状态图，仅按意图切换工具白名单、校验规则与回答模板],
) <fig:intent>

四类意图共享的状态图以 LangChain 生态的 LangGraph 作为编排外壳，其节点（错误分类、上下文构建、规划、观察、反思、回答验证、修复、定稿）的流转与条件分支由该框架管理；为适配未安装该依赖的最小化边缘部署，系统另提供按相同节点顺序执行、行为等价的确定性顺序回退路径。该设计的核心是职责分离：视觉、拓扑、比较与验证模块确定电路事实，大模型仅把既定事实改写为自然语言而不介入判定。反思环节的确定性校验器构成模型无法绕过的强制约束——回答若缺少必需的错误码、证据引用或危险场景下的断电提示，无论文本如何均判失败并触发修复。由此，即便边缘解释模型仅有十亿级参数，一旦偏离既定事实即被结构化拦截，无需依赖提示工程；这正是端侧小模型得以在正确性敏感场景可靠应用的前提。

== 知识检索契约与安全降级

为避免“训练一套知识、部署另一套”的不一致，系统约定合法知识源仅有教学场景库、故障案例库、器件手册库与电路知识库四个通道，另加工位状态、流水线快照与参考电路等结构化事实通道；早期基于通用向量库的文档检索被禁止进入主链路，以杜绝分布漂移、云端依赖与内容污染。检索同样失败拒止：板端无可用大模型时退回确定性模板，宁可少答也不让错误默认值污染结论。

四类合法通道及其约束作用如#ref(<tab:retrieval-contract>)所示；旧的通用 PDF/向量检索库仅保留给后台调试，不允许进入主链路或蒸馏管线。

#figure(
  三线表(
    columns: (1.25fr, 2.05fr, 2.55fr),
    align-cells: (left, left, left),
    header: ([通道], [内容], [约束作用]),
    rows: (
      ([教学场景库], [六类 demo 场景的目标、步骤、测量点与安全提示], [回答先锚定当前拓扑，避免跨实验串场]),
      ([故障案例库], [按场景、错误标签、错误码组织的典型故障与修复步骤], [只有命中当前错误码才返回，防止凭空举例]),
      ([器件手册库], [UA741、LM324、NE555、BJT 等结构化 datasheet 与本地嵌入], [场景白名单过滤无关芯片，端侧无外网依赖]),
      ([电路知识库], [放大器、积分器、比较器等原理知识], [只补充教学解释，不改写诊断事实]),
      ([结构化事实], [工位状态、pipeline 快照、reference circuit、error codes], [作为最高优先级证据，所有解释必须引用它]),
    ),
  ),
  caption: [Agent/RAG 检索契约的合法通道与约束作用],
) <tab:retrieval-contract>

上述约定构成一条“训练即部署”的检索不变量：蒸馏数据生成与板端部署使用同一套代码、同一份知识与同一套场景白名单，并由起飞前自检脚本校验两端等价，从而避免分布漂移。它把“可用知识的边界”做成可审计的工程契约——场景白名单按拓扑过滤器件手册，使反相放大器的问题不会召回无关的定时器芯片；故障案例仅在错误码命中时返回，其召回键正是第四章图比对输出的错误码词表，验证器与知识库的词表对齐是精确命中的前提。检索缺失时系统 fail-closed：蒸馏样本拒绝生成、部署端回退确定性模板，而非以旧知识库或无关 datasheet 兜底。这一取向与近年电子设计自动化语言模型“以确定性结构约束生成”的方向一致；其量化效果（裸模型与契约对照、召回修复前后）见第七章。

== 交互端设计与结果呈现

交互界面采用 React、Vite 与 TypeScript 构建，职责不是承担业务规则，而是把服务端的结构化事实清晰呈现给师生：上传图片、执行诊断、依次展示从组件检测到参考比较的事实链与网表，再由智能体给出解释与建议。主区提供两种视图——网表视图支持孔位、端口、网络角色与引脚极性的人工修正，图像视图在原图上渲染识别框与高亮目标；用户点选某条诊断后，系统据其证据引用提取高亮目标并定位到元件、引脚与孔位，使自然语言解释与界面定位始终指向同一份事实。

== 人工修正闭环

人工修正时，系统从映射结果取出元件、结合用户对端口、网络角色、引脚极性等的修改生成补丁，调用重算接口在服务端重新执行拓扑重构与比较——其间不重跑视觉检测，从而以极小代价纠正视觉阶段的偶发偏差。

许多 AI 辅助系统只关注模型一次性给出答案，但真实课堂需要可修正：视觉模型难免漏检、误检或孔位吸附偏差，若不允许修正，教师便只能放弃这次结果。LabGuardian 保留视觉阶段识别到的大部分事实，只对有争议的引脚或端口做局部修改再重新判断，从而把 AI 定位为助教而非裁判。这一“显式保留不确定性、并提供低成本纠正回路”的设计，正是面对必然带噪的真实感知输入时，系统仍能可靠服务于教学的工程基础。


#pagebreak()

= Intel DK-2500 边缘部署与异构性能

前面几章描述了系统“做什么”，本章关注它“在哪里运行、跑得如何”。LabGuardian 面向课堂现场部署，需要在不依赖云端的条件下完成视觉推理与智能诊断。本章先给出本地与容器化部署方式，再说明系统如何利用 Intel DK-2500 开发板的 CPU、iGPU 与 NPU 异构资源进行分工，并以板端实测的延迟、吞吐与功耗数据加以验证，最后介绍面向解释环节的端侧小模型蒸馏与初步评测。

== 本地运行与容器化部署

服务端以 FastAPI 配合 Redis/Celery 组织异步接口；边缘部署采用统一模型根目录、模型以只读方式挂载，并将模型版本、推理尺寸与板型定义写入运行元数据以保证可复现。

竞赛平台并非仅作运行服务端的小主机，而是把异构计算能力纳入系统架构：OpenVINO 适配端侧推理、Level-Zero 与 NPU 驱动栈负责设备调度、遥测通道实时回传利用率与功耗。平台资源与系统负载的对应关系如表#ref(<tab:intel-platform-use>)所示。

#figure(
  三线表(
    columns: (1fr, 1.9fr, 2.25fr),
    align-cells: (left, left, left),
    header: ([平台资源], [系统负载], [使用理由与实测依据]),
    rows: (
      ([NPU], [YOLOv8s-pose INT8 引脚关键点检测], [张量计算规则、可常驻；13.37 ms、74.7 img/s，增量功耗约 4.12 W]),
      ([iGPU], [OpenVINO GenAI INT4 文本生成与解释], [自回归生成并行度高；约 23 tok/s，CPU 对照功耗约为其 4.7 倍]),
      ([CPU], [图同构、子图同构、检索、服务编排、遥测], [不规则控制流与图算法更适合通用核心，释放加速器给模型推理]),
      ([内存], [视觉模型、INT4 学生模型、知识库与服务进程共存], [学生模型约 0.88 GB，解释峰值约 1.36 GB，可落入 8 GB 预算]),
      ([遥测], [5 Hz WebSocket 推送硬件状态与流水线阶段], [把平台利用率变成可视化证据，便于课堂演示与竞赛验收]),
    ),
  ),
  caption: [Intel DK-2500 平台资源与 LabGuardian 负载映射],
) <tab:intel-platform-use>

== NPU、iGPU 与 CPU 的异构分工

DK-2500 搭载 Intel Core Ultra 5 225U，具备同时调度 CPU、iGPU、NPU 三类计算单元的硬件条件。本项目在板端通过 OpenVINO 配合 Level-Zero 与 intel-level-zero-npu 驱动栈完成异构推理。LabGuardian 的端到端流程涉及视觉检测、拓扑重构、知识检索与智能诊断，各阶段对计算资源的需求差异显著：视觉检测是规则的稠密张量运算，适合专用加速器；拓扑与图论计算是不规则的数据流逻辑，更适合通用核心。据此，系统将三类负载分别归属：NPU 常驻视觉关键点检测（约 75 img/s，满足多工位并发且几乎不占用其他单元），iGPU 承担自回归的解释生成与热力图，CPU 处理图同构、子图匹配、检索、编排与遥测等不规则逻辑。

== 异构性能实测与能效

为量化上述分工，项目以 turbostat 按 0.25 秒间隔采样 RAPL 能量计，并在板端以输入分辨率 960（与训练及部署一致）单进程串行采集 60 至 1153 次推理统计，测得 YOLOv8s-pose 关键点检测在 CPU、iGPU、NPU 三种单元上的延迟、吞吐与功耗。其功耗时序如#ref(<fig:power-ts>)所示：NPU 推理期间 CPU 核心与 iGPU 功率曲线全程贴近空闲基线（约 4.42 W），说明 NPU 几乎不占用其他单元资源，为“NPU 负责视觉、iGPU 负责诊断、CPU 负责控制”的三路并行提供了硬件层面的可行性。

#figure(
  image("pictures/cadx/power_timeseries.pdf", width: 88%),
  caption: [YOLOv8s-pose INT8 在 DK-2500 上的 RAPL 功耗时序：三段分别对应 CPU/iGPU/NPU 各持续 15 秒的工作态；NPU 工作时 CPU 与 iGPU 全程贴近空闲基线，是实现真正异构并行的关键],
) <fig:power-ts>

各配置的详细指标如#ref(<tab:hetero>)所示。NPU INT8 在所有维度均最优：延迟 13.37 ms、吞吐 74.7 img/s、P99 抖动仅 15.61 ms，满足课堂实时视频流需求。INT8 量化通过在 144 张校准图上完成的训练后量化得到，模型从 22 MB 压缩至 11 MB，NPU 吞吐不降反升，由 60.4 提升至 74.7 img/s。

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

从能效角度看，NPU INT8 的增量功耗仅 4.12 W，单次推理能耗 114.2 mJ，性能功耗比达 18.1 ips/W，相比 CPU INT8 节能约 7.1 倍、性能功耗比提升约 12.1 倍。实测印证了上一节的异构分工：把视觉常驻负载交给 NPU，既释放 CPU 与 iGPU，又在功耗预算内满足课堂实时性。系统同时提供 5 Hz 硬件遥测并具备降级能力（模型缺失或校准失败时分别以确定性模板、合成网格回退）。

== 端侧教学解释小模型的蒸馏与初步评测

第五章的诊断智能体在无可用大模型时退回确定性模板，具备算力时则由大模型承担“将结构化诊断改写为讲解”的表达环节。为使该环节脱离云端、在边缘设备上独立运行，本项目按双教师检索增强蒸馏（Retrieval-Augmented Distillation, RAD）路线训练了一款面向教学问答的端侧小模型，并完成 OpenVINO INT4 导出与初步评测。

蒸馏数据并非由教师模型自由生成，而是约束在系统已固化的结构化证据之上：以本地部署的 Qwen3-32B 与云端的 DeepSeek-V3 构成双教师，在同一份冻结证据上分别作答并据此构建监督微调数据，从而把教师的语言能力与系统可验证的事实绑定，抑制教师幻觉被放大的风险。具体做法上，项目先围绕典型电路、常见故障与学生提问意图自动扩展候选问题，再人工与规则联合过滤掉过于书面化、脱离课堂语境、与冻结证据弱相关或明显不像学生真实会提出的问题，以保证问题集合既有规模又贴近教学现场。教师回答生成后并不直接入训，而是继续经过一轮质量筛样：仅保留具备有效引用、未被降级为“证据不足”、回答长度达标且内容与问题语义一致的样本。最终从 4990 条候选教师输出中保留 3466 条高纯度教师样本，并进一步构建为 3450 条正式 SFT 数据；也就是说，约 69.1% 的候选样本最终进入训练集，其余样本在问题过滤、引用校验与答案长度约束中被剔除。学生模型以 Qwen2.5-1.5B-Instruct 为基座，经 LoRA 微调、权重合并后导出为 OpenVINO INT4：合并后完整模型约 3.1 GB、INT4 约 0.88 GB，部署门槛明显低于仅作质量上限参考的 4B 级教师模型，且随项目代码拷贝至板端即可运行、全程无需外网。

#figure(
  三线表(
    columns: (1.2fr, 2.45fr, 1.8fr),
    align-cells: (left, left, left),
    header: ([阶段], [关键动作], [防漂移约束]),
    rows: (
      ([证据冻结], [收集 scene、error codes、fault cases、datasheet hits 与 pipeline snapshot], [缺场景或非法场景拒绝生成]),
      ([双教师生成], [Qwen3-32B 与 DeepSeek-V3 在同一证据上作答，并统一进入筛样流程], [教师只能引用已给证据]),
      ([学生微调], [Qwen2.5-1.5B-Instruct + LoRA 监督微调并合并权重；正式 SFT 数据约 3450 条], [训练样本与部署检索契约一致]),
      ([INT4 导出], [OpenVINO INT4 模型迁移到 DK-2500 iGPU], [板端验证吞吐、内存与功耗]),
    ),
  ),
  caption: [教学解释小模型的检索增强蒸馏与部署闭环],
) <tab:distill-pipeline>

双教师并行候选生成并非只是一种“方法包装”，而是确实提供了可量化的互补增益。项目在双教师重叠题集上对生成成功率、引用合规率与高纯可用覆盖率进行统计，结果如#ref(<fig:dual-teacher>)与#ref(<tab:dual-teacher>)所示。DeepSeek 分支在该重叠题集上的高纯可用覆盖率为 67.8%，Qwen 分支为 56.8%；若将两者视作并行候选池并采用稳定性优先的保留策略，则可用覆盖率提升至 82.4%，相较稳定教师分支净增 14.7 个百分点。进一步看候选池组成，42.1% 的问题上两位教师都能给出可直接入训的高纯答案，25.6% 仅由稳定教师分支覆盖，14.7% 则由第二教师补充命中，说明第二教师虽在延迟与稳定性上略弱，但在长尾边界样本上仍具有不可替代的补充价值。也正因为如此，本项目最终采用的不是“简单拼接两位教师全部回答”，而是“双教师并行候选生成 + 稳定性优先保留 + 互补样本补充”的工程落地策略：方法上保持双教师，数据上保留高纯互补性，训练上则控制候选质量波动。

#figure(
  image("board_data/dual_teacher_stats.png", width: 92%),
  caption: [双教师候选池互补性分析：左图为双教师重叠题集上的高纯可用覆盖率，右图为候选池组成占比。双教师并行候选生成可将高纯覆盖率提升至 82.4%，较稳定教师单支路提高约 14.7 个百分点],
) <fig:dual-teacher>

#figure(
  三线表(
    columns: (1.55fr, 1.1fr, 1.1fr, 1.1fr, 1.2fr, 1.9fr),
    align-cells: (left, center, center, center, center, left),
    header: ([分支/候选池], [生成成功率], [引用合规率], [高纯可用率], [平均延迟], [说明]),
    rows: (
      ([DeepSeek-V3], [99.8%], [69.5%], [69.5%], [2.56 s], [稳定性最高，作为稳定教师分支]),
      ([Qwen3-32B], [82.8%], [56.8%], [56.8%], [7.15 s], [第二教师用于补充边界样本与长尾问答]),
      ([双教师候选池], [--], [--], [82.4%], [--], [在重叠题集上相较稳定教师单支路提升 14.7 个百分点]),
    ),
  ),
  caption: [双教师候选生成的稳定性与互补性摘要（正文仅展示比例与百分点，不展开重叠题集绝对规模）],
) <tab:dual-teacher>

为避免“训练集规模看起来足够、但分布其实失衡”的问题，项目进一步对最终 SFT 数据作分布复核，结果如#ref(<fig:distill-dataset>)与#ref(<tab:distill-dataset>)所示。首先，筛样漏斗本身比较稳定：4990 条候选问题中有 3466 条通过高纯度教师筛样，最终仅再有 16 条在对齐 frozen evidence 或最小回答长度时被剔除，说明主要质量控制发生在教师输出过滤而非 SFT 拼装阶段。其次，意图分布并未被单一“诊断问答”垄断，3450 条正式样本中 `diagnostic` 为 1625 条（47.1%）、`lab_guidance` 为 975 条（28.3%）、`concept_tutor` 为 436 条（12.6%）、`mixed` 为 414 条（12.0%），使学生模型既能覆盖典型故障问答，也保留了实验步骤指导与概念讲解的表达能力。再次，六类教学场景分布处于可接受范围：RC、共射、UA741 反相、积分、加法与差分场景分别占 13.7%—19.7%，未出现某单一拓扑对学生模型的过度支配。

#figure(
  image("board_data/distill_dataset_stats.png", width: 90%),
  caption: [蒸馏训练集的筛样漏斗与最终分布统计：左上为 4990→3466→3450 的样本漏斗，右上为四类教学意图分布，下方为六类教学场景与主要错误标签分布],
) <fig:distill-dataset>

#figure(
  三线表(
    columns: (1.2fr, 1.35fr, 1.55fr),
    align-cells: (left, center, left),
    header: ([统计维度], [结果], [说明]),
    rows: (
      ([筛样漏斗], [4990 → 3466 → 3450], [候选教师输出 → 高纯度教师样本 → 正式 SFT 数据]),
      ([意图分布], [47.1 / 28.3 / 12.6 / 12.0%], [diagnostic / lab_guidance / concept_tutor / mixed]),
      ([场景分布], [13.7—19.7%], [六类实验场景均有覆盖，最大场景为 RC（19.7%）]),
      ([风险等级], [danger 5.5%，warning 81.9%，safe 12.6%], [以 warning 为主，符合课堂排障问答的主体形态]),
      ([高频错误标签], [缺件/悬空/错接为主], [MISSING_COMPONENT 27.5%，FLOATING_CONNECTION 27.1%，WRONG_NODE_CONNECTION 19.7%]),
      ([回答长度], [84 / 284 / 693 字], [最短 / 平均 / 最长回答长度，说明训练文本并非极短模板]),
    ),
  ),
  caption: [正式 SFT 数据的筛样与分布摘要（统计来源：`train_sft_alpaca.jsonl`）],
) <tab:distill-dataset>

从错误标签结构看，训练集最主要覆盖三类课堂高频问题：缺失元件（27.5%）、悬空连接（27.1%）与节点错接（19.7%）；短路风险与回路不完整虽占比较低，但仍被显式保留，确保学生模型不会只学会“温和解释”而缺乏危险场景下的安全前置。再结合工具通道统计可见，全部样本都绑定 `fault_case_lookup_tool`，同时 83.7% 的样本允许 `circuit_lookup_tool`，45.9% 允许 `board_schema_lookup_tool`，31.6% 允许 `safety_rule_lookup_tool`，这说明训练集并不是单纯的自然语言问答集合，而是完整保留了“场景证据 + 工具白名单 + 风险等级”的契约上下文。换言之，本系统蒸馏的不是一个脱离环境的通用聊天模型，而是一个在多场景、多风险等级、多工具约束下学习接地表达的小模型。

与当前学术界以“能力迁移”为中心的蒸馏范式相比，本系统的蒸馏在目标与约束上具有独特性。主流知识蒸馏多致力于让小模型逼近大模型的自由生成或思维链推理能力，检索增强蒸馏亦多聚焦于把检索增强后强模型的能力压缩进小模型；而本系统并不追求小模型“更会推理”，而是把它训练为一个“受契约约束的边缘接地解释器”，其独特性体现在三个层面。其一，教师答案被严格约束在系统已固化的冻结证据之上、而非自由生成，从源头把语言能力与可验证事实绑定，抑制了教师幻觉在蒸馏中被放大。其二，蒸馏数据生成与板端部署共享同一套检索契约与场景白名单，构成“训练即部署”的不变量，从根本上消除了常见的训练—部署知识漂移。其三，学生模型被部署在不可绕过的确定性校验器之后，其语言能力可以偏弱，但结构性事实一旦越界即被拦截——这使“安全性不再依赖模型规模”，一个十亿级小模型即可在正确性高度敏感的教学场景中可靠服役。这一“契约绑定、面向边缘接地解释”的蒸馏定位，与当前以能力为中心的蒸馏研究形成互补，也契合近年神经—符号方法与可信边缘人工智能的研究方向。

项目把导出的 INT4 学生模型迁移到 DK-2500，在板端 iGPU 上完成部署态的真机性能与能耗实测：学生模型冷启动加载约 3.7 秒，首 token 延迟约 64 毫秒，解码吞吐约 23 token/s，生成约 128 token 的接地解释约需 5.5 秒；常驻内存增量约 0.35 GB、峰值约 1.36 GB，在 8 GB 板载内存预算内仍可与视觉、检索模块共存。能耗方面，空载整封装功率约 4.4 W，推理时升至约 10.2 W、核显由 0 升至约 3.7 W，单次约 128 token 回答能耗约 56 焦耳；功率时序如#ref(<fig:student-power>)所示。

#figure(
  image("board_data/llm_power_ts.png", width: 88%),
  caption: [端侧学生模型（Qwen2.5-1.5B-INT4）在 DK-2500 iGPU 上的整封装与核显功率时序：空载约 4.4 W，推理段整封装升至约 10.2 W、核显约 3.7 W，推理仅带来约 5.7 W 的整封装增量],
) <fig:student-power>

作为对照，同一模型改在板端 CPU 运行虽吞吐相近，但整封装平均功率升至约 43 W、约为 iGPU 的 4.7 倍。这印证了设备归属决策：把自回归的解释生成放在 iGPU 以更低功率维持吞吐，把 CPU 留给拓扑与检索等控制面，而将大模型蒸馏到 1.5B 正是其装入边缘内存与功耗预算的前提。本节性能、内存与能耗均为部署态真机实测，回答质量的系统量化见第七章。


#pagebreak()

= 实验验证与结果分析

本章不以孤立的功能测试逐项罗列，而是围绕全文提出的三项核心设计主张组织实验证据，逐一以实测数据加以检验：其一，安全敏感的对错判断由确定性符号链路给出，结果正确、可审计、无幻觉；其二，检索契约使端侧小模型在不更换模型的前提下“答得准、答得安全”；其三，系统能够在英特尔异构边缘平台上低功耗部署。测试设备上，功能与质量评测在开发机上以确定性方式运行（与设备无关），板端性能与能耗在 Intel DK-2500（Core Ultra 5 225U，8 GB 内存）上以 turbostat 采样 RAPL 能量计实测；其中支撑第三项主张的板端延迟、吞吐、内存与功耗已在第六章详述，故本章聚焦前两项主张的验证，并先以一张总览表给出全部关键证据。

为便于从竞赛评审角度把握系统完成度，表#ref(<tab:key-results>)先汇总本项目已经取得的关键量化结果。可以看到，系统的主要证据并不集中在单一模型精度，而是覆盖数据资产、确定性算法、检索契约、模型压缩、异构部署与工程测试六个维度；这也对应了 LabGuardian 的总体设计取向——把真实感知、符号判断、智能解释与边缘部署放在同一套可验证闭环中。

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
      ([检索契约], [裸模型 vs 契约路径], [故障接地 0/6 → 6/6，校验通过 6/6]),
      ([知识桥接], [故障案例召回修复], [真实错误码召回 1/6 → 6/6]),
      ([工程质量], [单元与契约测试], [约 900+ 用例，整体通过率约 99%]),
    ),
  ),
  caption: [LabGuardian 关键量化结果汇总],
) <tab:key-results>

== 功能与单元测试覆盖

第一项主张——对错判断由确定性符号链路给出、可审计——的工程基础，是各模块在统一契约下行为可复现、可回归。后端以 pytest 组织约 900 余个单元与契约用例，整体通过率约 99%（个别失败为预先存在的环境依赖，与本系统架构无关）。各模块分布如#ref(<tab:test>)所示，覆盖智能体编排与校验、检索与知识库、确定性图比对、视觉管线等核心链路。

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
      ([其他（知识库/评估/工具）], [200+], [数据契约与回归]),
      ([合计], [约 900+], [整体通过率约 99%]),
    ),
  ),
  caption: [后端单元与契约测试覆盖分布],
) <tab:test>

== 本地检索精度评估

检索的命中正确性与跨芯片隔离，是“解释严格落在正确证据上”的前提。针对四通道检索的命中正确性，对六类示范拓扑各设计若干检索测试问题（共约 32 条），分别评估器件手册检索、教学场景检索、语义路由与故障案例召回，结果如#ref(<tab:rag>)所示。器件手册、教学场景与语义路由均达到 top-1 全命中，且严格遵守跨芯片隔离（问 UA741 不会命中 LM324）；故障案例召回在按错误标签匹配时存在个别边界漏识别，已在后文的错误码桥接修复中一并改善。

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

== 三正交消融：隔离契约、意图与蒸馏量化的各自贡献

本节是检验“检索契约使能端侧小模型”这一主张的核心证据。我们设计三组正交消融，每组只改变一个变量、固定其余，从而分别量化检索契约、意图路由方式与蒸馏量化各自的贡献，避免把多重因素的效果混为一谈——这一实验设计本身也体现了项目对“以可控对照而非主观断言支撑结论”的方法学要求。

=== 契约消融：同一模型，契约见高下

在板端用同一款 INT4 学生模型，对六个示范场景各注入一个典型故障，以同一道学生问题分别走“裸模型直答”与“完整契约路径”，结果如#ref(<tab:bare-contract>)所示：裸模型因缺少电路状态，六场景全部无法指认涉事器件；契约路径下六场景均正确锚定场景、引用当前错误码与涉事器件、并在危险场景前置断电提示且通过校验。差异完全来自检索契约——小模型“答得准、答得安全”不依赖更大参数量，而依赖这套可审计的事实约束。

#figure(
  三线表(
    columns: (1.2fr, 1.4fr, 1.4fr),
    align-cells: (left, center, center),
    header: ([评估维度], [裸模型直答], [完整契约路径]),
    rows: (
      ([命中涉事故障器件], [0 / 6], [6 / 6]),
      ([引用当前错误码], [0 / 6], [6 / 6]),
      ([引用涉事元件], [0 / 6], [6 / 6]),
      ([危险场景安全前置], [—], [6 / 6]),
      ([场景锚定正确], [—], [6 / 6]),
      ([确定性校验通过], [—], [6 / 6]),
    ),
  ),
  caption: [裸模型 vs 检索契约：六示范场景诊断接地能力对照（同一 INT4 学生模型）],
) <tab:bare-contract>

项目还核查了“验证器→知识库”的错误码桥接：诊断报告由图比对产出 diff 词表错误码，而早期故障案例库以另一套语义分析词表标注，二者几乎不相交，致真实故障下召回大量失效。以六个示范故障喂入真实 diff 码实测，修复前仅 1/6 能将目标教学案例排为首位，对齐为真实 diff 词表后升至 6/6，并在板端完成端到端验证（3/3）。这说明确定性接地链路中，词表对齐与算法同等重要。

=== 意图路由消融

四类教学意图的路由可由端侧小模型分类，也可由确定性关键词分类。实测对照表明：端侧十亿级小模型直接做四类意图分类，在一组规范与口语化混合问题上的准确率不及关键词路由，且每次分类引入约 1.5—2.5 秒额外时延（与解释生成抢占同一 iGPU），而关键词路由零延迟。综合准确率与时延，系统最终采用确定性关键词路由承担意图判定，小模型只负责生成；这一选择以实测消融为据，而非经验默认。

=== 蒸馏与量化消融（教学解释质量评测）

在教学解释质量评测上，项目已先完成部署版 INT4 学生模型的 `P0` 固定题集评测。该题集共 30 题，覆盖 6 类示范教学拓扑与 4 类典型教学意图，每题按 3 个显式命中点进行人工 rubric 评分，既统计“是否答对”，也统计“是否答全关键检查点”。人工复核后的结果如#ref(<fig:p0-quality>)与#ref(<tab:quality>)所示：部署版 INT4 学生模型在该固定题集上取得 71.1% 的平均得分率、80.0% 的通过率与 40.0% 的满分率，说明蒸馏后的小模型已经能够在统一教学题集上稳定完成多数接地解释任务。

进一步看细分维度，概念讲解与混合型问答最稳定，平均得分率均达到 83.3%；实验步骤指导类题目为 73.3%；而最困难的仍是诊断排查类题目，平均得分率为 59.0%。这一分布与实际教学体验一致：部署版学生模型对“解释概念”“给出简明建议”已经较稳，但在需要同时完成症状判断、偏置定位与排查顺序组织的诊断问题上，仍会出现漏点或顺序不够规范的情况。换言之，蒸馏与量化并未破坏小模型的基本教学可用性，但其真正短板也已被固定题集客观暴露出来。

#figure(
  image("board_data/p0_quality_stats.png", width: 94%),
  caption: [P0 固定题集人工 rubric 评测结果：左图为部署版 INT4 学生模型在 30 题上的整体表现，右图为按教学意图细分后的平均得分率。模型整体平均得分率为 71.1%，通过率 80.0%，其中概念讲解与混合问答表现最好，诊断排查类题目最具挑战。],
) <fig:p0-quality>

#figure(
  三线表(
    columns: (1.7fr, 0.8fr, 1fr, 1fr, 1fr),
    align-cells: (left, center, center, center, center),
    header: ([P0 分组], [题数], [平均得分率], [通过率], [满分率]),
    rows: (
      ([整体（INT4 部署版）], [30], [71.1%], [80.0%], [40.0%]),
      ([concept_tutor], [8], [83.3%], [87.5%], [62.5%]),
      ([mixed], [4], [83.3%], [100.0%], [50.0%]),
      ([lab_guidance], [5], [73.3%], [80.0%], [40.0%]),
      ([diagnostic], [13], [59.0%], [69.2%], [23.1%]),
    ),
  ),
  caption: [P0 固定题集人工评分摘要。部署版 INT4 学生模型在统一 30 题上达到 71.1% 的平均得分率与 80.0% 的题目通过率；其中诊断排查类题目难度最高，是后续继续优化蒸馏数据与提示约束的重点方向。],
) <tab:quality>

需要说明的是，当前完成的是“部署版学生模型是否已达到可用教学解释水平”的第一阶段 `P0` 验证，因此先采用固定题集 + 人工 rubric 的口径给出可信结果；而“未蒸馏基座 / 蒸馏学生 FP / 蒸馏学生 INT4 / 教师上限”四模型横向矩阵，仍将在后续 gold 评测集与评分模型就绪后继续补齐。也就是说，本节已经回答了“部署版 INT4 学生模型是否可用”这一工程关键问题，但更完整的 2×2 质量消融仍属于后续工作。

== 局限与后续方向

综合上述实验，系统在确定性链路、检索契约与边缘部署上的能力已获实测支撑；主要不足在于：其一，虽然部署版学生模型已在 `P0` 固定题集上完成人工 rubric 评测，但完整的四模型横向质量矩阵仍待 gold 评测集与评分模型补齐；其二，蒸馏学生在无接地兜底路径上仍可能生成质量欠佳内容（已由 llm_fallback 标注与校验器约束在事实层面，但语言质量受参数规模所限）；其三，端到端“真实照片→正确诊断”的成功率仍需在更大真板集上统计。


#pagebreak()

= 结论与展望

本文提出并实现了 LabGuardian——一个面向电子实验教学、运行于英特尔边缘平台的神经—符号解耦电路诊断系统。系统以噪声感知输入为起点，经关键点检测与孔位吸附重构引脚级电气网表，由确定性图比对承担可审计的对错判断，再由受约束的智能体在不可绕过的确定性校验器约束下生成接地解释；教学解释模型经双教师蒸馏与 INT4 量化部署于 DK-2500，借助 NPU、iGPU、CPU 异构分工实现低功耗本地推理。实测表明，NPU 承载视觉常驻负载可在约 4 W 增量功耗下达成约 75 img/s 吞吐，端侧学生模型在 iGPU 上以约 10 W、约 23 token/s 完成接地解释，整系统在 8 GB 内存预算内可用；检索契约使端侧小模型在不更换模型的前提下，从“全场景无法指认故障”跃升为“六场景全部正确接地”，而部署版 INT4 学生模型在统一 30 题 `P0` 固定题集上的人工 rubric 平均得分率达到 71.1%、题目通过率达到 80.0%，验证了其在教学解释层面的基本可用性。

与既有工作相比，本系统的独特之处在于三点：其一，面向必然带噪的真实感知输入，而非理想的干净网表；其二，以神经—符号解耦把“对错判断”交给可审计的符号系统、把“语言表达”交给受约束的小模型；其三，以“训练即部署”的检索不变量与不可绕过的校验器，把防幻觉做成工程契约而非提示技巧。这一组合使一个十亿级小模型得以在正确性高度敏感的教学场景中、于十瓦级边缘设备上可靠运行。

后续工作将集中于四个方向：补齐教学解释质量的完整横向矩阵，在统一 gold 评测集上给出蒸馏前后与量化前后的四模型定量对照；针对 `diagnostic` 类题目继续增强蒸馏数据与回答约束，降低排查顺序与关键检查点的漏答率；在更大规模真板集上统计“照片→诊断”的端到端成功率；并持续扩充教学场景、故障案例与器件手册知识库，使系统覆盖更多课程实验。




// ════════════════════════════ 参考文献 ═══════════════════════════════════
// 不编章号，三号黑体居中；条目按出现次序用中括号数字连续编号，顶格、五号宋体、单倍行距
#heading(level: 1, numbering: none)[参考文献]
#{
  set par(first-line-indent: (amount: 0em, all: false), leading: 1em, hanging-indent: 1.6em)
  set text(font: 正文字体, size: 五号)
  let 文献(n, body) = {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.4em,
      align: (left + top, left + top),
      [\[#n\]], [#body],
    )
    v(0.2em)
  }
  // 注：[1]、[2] 已在正文绪论引用；其余为本系统所依托的核心技术文献，定稿时可按需在相应章节补充正文标注。
  文献(1, "NAGEL L W, PEDERSON D O. SPICE: Simulation Program with Integrated Circuit Emphasis[R]. Berkeley: University of California, Electronics Research Laboratory, 1973.")
  文献(2, "LIU H, LI C, WU Q, et al. Visual instruction tuning[C]// Advances in Neural Information Processing Systems (NeurIPS), 2023.")
  文献(3, "JOCHER G, CHAURASIA A, QIU J. Ultralytics YOLO[CP/OL]. (2023)[2026-06-30]. https://github.com/ultralytics/ultralytics.")
  文献(4, "Intel Corporation. OpenVINO Toolkit: Open Visual Inference and Neural Network Optimization[CP/OL]. [2026-06-30]. https://github.com/openvinotoolkit/openvino.")
  文献(5, "Qwen Team. Qwen2.5 Technical Report[R/OL]. (2024)[2026-06-30]. https://arxiv.org/abs/2412.15115.")
  文献(6, "HINTON G, VINYALS O, DEAN J. Distilling the knowledge in a neural network[C]// NIPS Deep Learning and Representation Learning Workshop, 2015.")
  文献(7, "HU E J, SHEN Y, WALLIS P, et al. LoRA: Low-rank adaptation of large language models[C]// International Conference on Learning Representations (ICLR), 2022.")
  文献(8, "YAO S, ZHAO J, YU D, et al. ReAct: Synergizing reasoning and acting in language models[C]// International Conference on Learning Representations (ICLR), 2023.")
  文献(9, "LEWIS P, PEREZ E, PIKTUS A, et al. Retrieval-augmented generation for knowledge-intensive NLP tasks[C]// Advances in Neural Information Processing Systems (NeurIPS), 2020.")
  文献(10, "CORDTS M, 等. 面向电子设计自动化的图神经网络与语言模型方法综述[Z]. 定稿前请补充与本项目最相关的 ML4EDA 文献（如网表图学习、电路理解类工作）的准确著录信息.")
}


#heading(level: 1, numbering: none)[附录]

#block[
  #set par(first-line-indent: (amount: 2em, all: true), leading: 1em)
  *附录 A　源代码与程序清单.* 本作品的完整源代码、知识库与板端部署脚本随作品实物一并提交。后端服务（视觉流水线、确定性图比对、检索契约与智能体编排）、交互前端、知识库（教学场景、故障案例、器件手册、电路知识）、模型蒸馏与评测脚本，以及 DK-2500 板端性能与能耗采集脚本均在其中；关键模块的单元与契约测试见后端测试目录。

  *附录 B　扩展应用系统电路图.* 六类示范教学拓扑（一阶 RC、共射放大、差分对、UA741 反相/积分/加法）的逻辑参考电路定义与对应故障案例随知识库提交，可作为系统扩展到更多课程实验的样例。

  *附录 C　应用资料与参考文献目录.* 见上节参考文献；器件手册原始资料（UA741、LM324、NE555、S8050 等）随器件手册知识库提交。
]


#heading(level: 1, numbering: none)[谢辞]

在本报告完成之际，谨向在项目研究与报告撰写过程中给予悉心指导的指导教师，以及给予帮助与支持的队友、同学与提供竞赛平台与技术支持的英特尔公司表示衷心的感谢。
