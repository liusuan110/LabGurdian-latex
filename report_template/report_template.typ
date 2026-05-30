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
#let 竞赛年份        = "2024"
#let 报告题目        = "二甲醚清洁燃料均质压燃燃烧数值模拟研究"
#let 英文题目        = "NUMERICAL SIMULATION OF HOMOGENEOUS CHARGE COMPRESSION IGNITION COMBUSTION FUELED WITH DIMETHYL ETHER"
#let 学生姓名        = ""
#let 指导教师        = ""
#let 参赛学校        = ""

#let 中文摘要 = [
  均质充量压缩着火（HCCI）燃烧，作为一种能有效实现高效低污染的燃烧方式，能够使发动机同时保持较高的燃油经济性和动力性能，而且能有效降低发动机的 NO#sub[x] 和碳烟排放。此外 HCCI 燃烧的一个显著特点是燃料的着火时刻和燃烧过程主要受化学动力学控制，基于这个特点，发动机结构参数和工况的改变将显著地影响着 HCCI 发动机的着火和燃烧过程，本文以新型发动机燃用燃料二甲醚（DME）为例，对 HCCI 发动机燃用 DME 的着火和燃烧过程进行了研究。研究采用由美国 Lawrence Livermore 国家实验室提出的 DME 详细化学动力学反应机理及其开发的 HCT 化学动力学程序，且 DME 的详细氧化机理包括 399 个基元反应，涉及 79 个组分。为考虑壁面传热的影响，在 HCT 程序中增加了壁面传热子模型。采用该方法研究了压缩比、燃空当量比、进气充量加热、发动机转速、EGR 和燃料添加剂等因素对 HCCI 着火和燃烧的影响。结果表明，DME 的 HCCI 燃烧过程有明显的低温反应放热和高温反应放热两阶段；增大压缩比、燃空当量比、提高进气充量温度、添加 H#sub[2]O#sub[2]、H#sub[2]、CO 使着火提前；提高发动机转速、采用冷却 EGR、添加 CH#sub[4]、CH#sub[3]OH 使着火滞后。
]
#let 中文关键词 = ("均质充量压缩着火", "化学动力学", "数值模拟", "二甲醚", "EGR")

#let 英文摘要 = [
  HCCI (Homogenous Charge Compression Ignition) combustion has advantages in terms of efficiency and reduced emission. HCCI combustion can not only ensure both the high economic and dynamic quality of the engine, but also efficiently reduce the NO#sub[x] and smoke emission. Moreover, one of the remarkable characteristics of HCCI combustion is that the ignition and combustion process are controlled by the chemical kinetics, so the HCCI ignition time can vary significantly with the changes of engine configuration parameters and operating conditions. In this work numerical scheme for the ignition and combustion process of DME homogeneous charge compression ignition is studied. The detailed reaction mechanism of DME proposed by American Lawrence Livermore National Laboratory (LLNL) and the HCT chemical kinetics code developed by LLNL are used to investigate the ignition and combustion processes of an HCCI engine fueled with DME. The new kinetic mechanism for DME consists of 79 species and 399 reactions. To consider the effect of wall heat transfer, a wall heat transfer model is added into the HCT code. By this method, the effects of the compression ratio, the fuel-air equivalence ratio, the intake charge heating, the engine speed, EGR and fuel additive on the HCCI ignition and combustion are studied. The results show that the HCCI combustion fueled with DME consists of a low temperature reaction heat release period and a high temperature reaction heat release period. It is also founded that increasing the compression ration, the equivalence ratio, the intake charge temperature and the content of H#sub[2]O#sub[2], H#sub[2] or CO cause advanced ignition timing. Increasing the engine speed, adoption of cold EGR and the content of CH#sub[4] or CH#sub[3]OH will delay the ignition timing.
]
#let 英文关键词 = ("HCCI", "chemical kinetics", "numerical simulation", "DME", "EGR")


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

随着汽车工业的发展和汽车保有量的增加，汽车在大量消耗石油燃料的同时，尾气排出的有害气体还严重地污染了人们赖以生存的大气环境，实现能源与环境长期可持续发展是摆在汽车和内燃机工作者面前的重大课题。环保和能源是发动机工业需要解决的两个主要问题。目前，随着人们对环境污染重视程度的日益提高，各国越来越重视环境保护，现在已制定了将 NO#sub[x] 和 PM 视为大气污染物的强化法规，如美国加州在 1998 年生效的一项超低排放汽车法规规定汽车的 NO#sub[x]+HC 排放 < 2.5g/bph-hr，PM 排放 < 0.05g/bph-hr。为满足严格的排放要求，研究人员在各个相关领域进行了大量的研究工作，改进发动机的燃烧系统作为一个重要解决途径，也取得了一定进展#引[1]。

传统汽油机均质混合气，尾气排放污染物主要包括氮氧化物（NO#sub[x]）、碳氢化合物（HC）、一氧化碳（CO），可以通过三效催化后处理加以解决，但要达到欧 IV 及其以上标准仍存在较大困难，且汽油机的热效率低，在中低负荷工作时还有较大的泵气损失。柴油机热效率高，但排气中的 NO#sub[x] 和碳烟微粒排放物（PM）却难以折中，使用一种排放物减少的措施，往往导致另一排放物的增加。由于柴油机总体上富氧燃烧，NO#sub[x] 的催化处理技术尚未成熟，汽油机和柴油机的燃烧方式都不能解决碳烟和氮氧化物生成的 trade-off 关系，因而很难在这两种燃烧模式下通过改进燃烧来同时大量降低碳烟和氮氧化物的生成。

== HCCI 的数值模拟研究现状

HCCI 发动机的着火与燃烧过程与传统的火花塞点火式和压燃式发动机有着本质的区别，在 HCCI 发动机的着火燃烧过程中，燃料的化学反应动力学起着至关重要的作用。因此，相对于传统发动机数值模拟研究主要侧重于湍流混合与燃烧模型而言，HCCI 发动机燃烧模拟的焦点主要集中在燃料的反应机理和化学动力学模型上。

=== HCCI 数值模拟模型

目前 HCCI 数值模拟研究主要集中在单区、多区和多维模型上#引[2]。本节将从这三方面分别予以介绍：

#set enum(numbering: "(1)", indent: 2em)
+ 单区模型

  单区模型假设气缸内充量在空间上是均匀的，温度、压力和组分浓度处处相等，是最简单的 HCCI 模拟模型。

+ 双区和多区模型

  双区和多区模型将气缸内充量划分为若干区域，以考虑温度和浓度的不均匀分布对着火与燃烧过程的影响。

+ 多维模型

  多维模型将流体力学计算与化学动力学计算耦合，能够刻画缸内流动、传热与化学反应的空间分布。

== 本章小结

本章简要介绍了课题的研究背景与意义，综述了 HCCI 燃烧数值模拟的研究现状，并给出了本文的主要研究内容与章节安排。


= DME 均质充量压燃着火的数值模拟方法

== 二级标题

正文内容。本节阐述 DME 均质充量压燃着火数值模拟所采用的基本控制方程、化学动力学反应机理以及壁面传热子模型的处理方法。

=== 三级标题

正文内容。控制方程组由质量守恒、能量守恒及组分输运方程构成。以气缸内总质量为例，可由各组分质量求和得到，如式 (2-1) 所示。公式应另起一行，并在行末用圆括号标注编号：

$ m = sum_(k=1)^K m_k $

较长的公式如必须转行，最好在等号处转行；如做不到，则在 $+$、$-$、$times$、$div$ 等数学符号处转行，且数学符号置于转行处行首，上下式尽量在等号处对齐，如式 (2-2) 所示：

$
f(x, y) &= f(0,0) + 1/(1!) (x partial/(partial x) + y partial/(partial y)) f(0,0) \
        &+ 1/(2!) (x partial/(partial x) + y partial/(partial y))^2 f(0,0) + dots.h.c \
        &+ 1/(n!) (x partial/(partial x) + y partial/(partial y))^n f(0,0) + dots.h.c
$

计算所选取部分组分的热力学性质如#ref(<tab-thermo>)所示。表题写在表格上方居中，采用简明三线表，表内中文用五号宋体、英文用五号 Times New Roman。

#figure(
  三线表(
    columns: (1.6fr, 2fr, 2fr, 2fr),
    align-cells: (center, center, center, center),
    header: ([组分], [$H_f$(kcal/mol)], [$S_f$(kcal/mol)], [$C_p$(kcal/mol)]),
    rows: (
      ([A1], [100], [100], [100]),
      ([A2], [],    [],    []),
      ([A3], [],    [],    []),
      ([A4], [100], [100], [100]),
      ([A5], [],    [],    []),
      ([A6], [],    [],    []),
      ([A7], [],    [],    []),
      ([A8], [],    [],    []),
    ),
  ),
  caption: [选取组分的热力学性质],
) <tab-thermo>

// 说明：若一张表格须跨页接写，可省略表题、重复表头，并在续表右上方标注“续表 2-1”。
// Typst 中可对 table.header 设置 repeat: true 以在分页时自动重复表头。

模拟得到的气缸压力随曲轴转角变化的曲线与试验结果的对比如#ref(<fig-cyl>)所示。图序和图题写在图的下方居中，五号宋体加黑。

#figure(
  image("assets/fig2-1.jpg", width: 62%),
  caption: [气缸压力随曲轴转角变化的曲线],
) <fig-cyl>


// ── 演示“第五章”：用计数器跳号以复现模板中 第二章 → 第五章 的效果 ──
#counter(heading).update(4)
= 结论

正文内容。本文采用 HCT 化学动力学程序对 DME 均质充量压燃着火与燃烧过程进行了数值模拟，主要得到以下结论：增大压缩比、提高燃空当量比与进气充量温度均使着火提前；提高发动机转速、采用冷却 EGR 则使着火滞后。所建立的方法可为 HCCI 发动机的燃烧组织与控制提供参考。


// ════════════════════════════ 参考文献 ═══════════════════════════════════
// 不编章号，三号黑体居中；条目按出现次序用中括号数字连续编号，顶格、五号宋体、单倍行距
#heading(level: 1, numbering: none)[参考文献]
#{
  set par(first-line-indent: (amount: 0em, all: false), leading: 1em, hanging-indent: 1.6em)
  set text(font: 正文字体, size: 五号)
  // body 用字符串字面量，避免文中的 "//"（如 http:// 与 [S]//）被解析为注释
  let 文献(n, body) = {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.4em,
      align: (left + top, left + top),
      [\[#n\]], [#body],
    )
    v(0.2em)
  }
  文献(1, "蒋有绪, 郭泉水, 马娟, 等. 中国森林群落分类及其群落学特征[M]. 北京: 科学出版社, 1998: 11-12.")
  文献(2, "中国力学学会. 第 3 届全国实验流体力学学术会议论文集[C]. 天津: ** 出版社, 1990: 20-24.")
  文献(3, "World Health Organization. Factors regulating the immune response: report of WHO Scientific Group[R]. Geneva: WHO, 1970.")
  文献(4, "张志祥. 间断动力系统的随机扰动及其在守恒律方程中的应用[D]. 北京: 北京大学数学学院, 1998: 50-55.")
  文献(5, "河北绿洲生态环境科技有限公司. 一种荒漠化地区生态植被综合培育种植方法: 中国, 01129210.5[P/OL]. 2001-10-24[2002-05-28]. http://211.152.9.47/sipoasp/zljs/hyjs-yxnew.asp?recid=01129210.5&leixin.")
  文献(6, "国家标准局信息分类编码研究所. GB/T 2659-1986 世界各国和地区名称代码[S]// 全国文献工作标准化技术委员会. 文献工作国家标准汇编: 3. 北京: 中国标准出版社, 1988: 59-92.")
  文献(7, "李炳穆. 理想的图书馆员和信息专家的素质与形象[J]. 图书情报工作, 2000(2): 5-8.")
  文献(8, "丁文祥. 数字革命与竞争国际化[N]. 中国青年报, 2000-11-20(15).")
  文献(9, "江向东. 互联网环境下的信息处理与图书管理系统解决方案[J/OL]. 情报学报, 1999, 18(2); 4[2000-01-18]. http://www.chinainfo.gov.cn/periodical/gbxb/gbxb99/gbxb990203.")
  文献(10, "CHRISTINE M. Plant physiology: plant biology in the Genome Era[J/OL]. Science, 1998, 281: 331-332[1998-09-23]. http://www.sciencemag.org/cgi/collection/anatmorp.")
}


// ════════════════════════════ 谢  辞 ═════════════════════════════════════
#heading(level: 1, numbering: none)[谢辞]

正文内容。在本报告完成之际，谨向在项目研究与报告撰写过程中给予悉心指导的指导教师，以及给予帮助与支持的队友和同学们表示衷心的感谢。
