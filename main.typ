// ============================================================
// 2026 年英特尔杯大学生电子设计竞赛嵌入式系统专题邀请赛
// 初选项目设计方案书 — Typst 模板
// ============================================================

// ============================================================
// 字体配置 — 跨平台兼容 (Windows / macOS / Linux)
// ============================================================
// Windows: SimSun / SimHei / KaiTi
// macOS:   Songti SC / Heiti SC / Kaiti SC
// Linux:   Noto Serif SC / Noto Sans SC

#let 正文字体 = ("Times New Roman", "SimSun", "Songti SC", "Source Han Serif SC")
#let 标题字体 = ("Times New Roman", "SimHei", "Heiti SC", "Noto Sans SC")
#let 楷体字体 = ("Times New Roman", "KaiTi", "Kaiti SC", "STKaiti")
#let 纯楷体 = ("KaiTi", "Kaiti SC", "STKaiti")
#let 宋体 = ("SimSun", "Songti SC", "Source Han Serif SC")

// ============================================================
// 全局页面设置
// ============================================================
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  // 页脚: "第 X 页 共 Y 页"
  footer: context {
    set align(center)
    set text(size: 10.5pt, font: 宋体)
    [第 #counter(page).display() 页 共 #counter(page).final().at(0) 页]
  },
)

// 正文默认: 五号宋体 (10.5pt), 首行缩进 2 字符, 单倍行距
#set text(
  size: 10.5pt,
  font: 正文字体,
  lang: "zh",
  region: "cn",
)
#set par(
  first-line-indent: 2em,
  leading: 1em,          // 单倍行距
  justify: true,
)

// ============================================================
// 标题格式
// ============================================================

// 一级标题: "第X部分" 黑体三号(16pt), 居中
#show heading.where(level: 1): it => {
  // 每章重置公式、图、表计数器
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  set text(size: 16pt, font: 标题字体, weight: "bold")
  set align(center)
  v(24pt)
  {
    let num = counter(heading).display()
    [#num #h(0.5em) #it.body]
  }
  v(16pt)
}

// 二级标题: 黑体四号(14pt), 缩进2格
#show heading.where(level: 2): it => {
  set text(size: 14pt, font: 标题字体, weight: "bold")
  v(12pt)
  {
    h(2em)
    let nums = counter(heading).display("1.1")
    [#nums #h(0.5em) #it.body]
  }
  v(6pt)
}

// 三级标题: 小四宋体(12pt), 缩进2格
#show heading.where(level: 3): it => {
  set text(size: 12pt, font: 正文字体)
  v(6pt)
  {
    h(2em)
    let nums = counter(heading).display("1.1.1")
    [#nums #h(0.5em) #it.body]
  }
  v(3pt)
}

// 自定义标题编号: 一级用汉字序数 "第一部分", 二/三级用阿拉伯数字
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    [第#(("", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十").at(n.first()))部分]
  } else {
    numbering("1.1.1", ..n)
  }
})

// ============================================================
// 图表标题格式: 五号宋体加粗, 居中
// ============================================================
#show figure.caption: it => {
  set text(size: 10.5pt, font: 正文字体, weight: "bold")
  it
}

// ============================================================
// 公式编号: (章-序号), 如 (2-1)
// ============================================================
#set math.equation(numbering: num =>
  context [(#counter(heading).get().first()\-#num)]
)

// ============================================================
// 图表编号: 按章节编号, 如 "图 2-1", "表2-1"
// ============================================================
#set figure(
  numbering: num =>
    context [#counter(heading).get().first()\-#num],
)
#show figure.where(kind: image): set figure(supplement: [图])
#show figure.where(kind: table): set figure(supplement: [表])

// 三线表: 表标题置于表格上方
#show figure.where(kind: table): set figure.caption(position: top)

// ============================================================
// 辅助函数
// ============================================================

// 字号快捷函数
#let 五号 = 10.5pt
#let 小四 = 12pt
#let 四号 = 14pt
#let 小三 = 15pt
#let 三号 = 16pt
#let 小二 = 18pt
#let 二号 = 22pt

// 宋体文字块
#let songti(body) = text(font: 正文字体, body)
// 黑体文字块
#let heiti(body) = text(font: 标题字体, body)
// 楷体文字块
#let kaiti(body) = text(font: 楷体字体, body)

// 关键词命令
#let keywords(..args) = {
  let kws = args.pos()
  v(6pt)
  set par(first-line-indent: 0em)
  text(size: 五号, font: 正文字体)[
    *关键词：*#kws.join("，")
  ]
}


// ╔══════════════════════════════════════════════════════════╗
// ║                       正 文 开 始                        ║
// ╚══════════════════════════════════════════════════════════╝


// ============================================================
// 第 1 页: 封面
// ============================================================

#page[
  #set align(center)
  #v(1cm)
  #text(size: 四号, font: 标题字体)[
    2026 年英特尔杯大学生电子设计竞赛嵌入式系统专题邀请赛
  ]
  #v(0.3cm)
  #text(size: 四号, font: "Times New Roman")[
    2026 Intel Cup Undergraduate Electronic Design Contest
  ]
  #v(0.15cm)
  #text(size: 四号, font: "Times New Roman")[
    \- Embedded System Design Invitational Contest
  ]
  #v(1.5cm)
  #text(size: 二号, font: 纯楷体, weight: "bold")[
    初选项目设计方案书
  ]
  #v(3cm)
  // TODO: 插入赛事 LOGO 图片
  // #image("esic_logo.png", width: 4cm)
  // #text(size: 小四, font: "Times New Roman")[Intel Cup Embedded System Design Contest]
  #v(2cm)
  #text(size: 四号, font: 楷体字体, weight: "bold")[
    项目题目：#underline[#h(1em)LabGuardian：基于边缘AI的智能实验助教系统#h(1em)]
  ]
  #v(2cm)
  #text(size: 四号, font: 楷体字体)[
    #grid(
      columns: (auto, auto),
      column-gutter: 0.5em,
      row-gutter: 14pt,
      [学生姓名：], underline[#h(6cm)],
      [指导教师：], underline[#h(6cm)],
      [参赛学校：], underline[#h(6cm)],
    )
  ]
]


// ============================================================
// 第 2 页: 题目 + 摘要
// ============================================================

// 项目题目 — 黑体三号, 居中
#align(center)[
  #text(size: 三号, font: 标题字体, weight: "bold")[
    LabGuardian：基于边缘AI的智能实验助教系统
  ]
]

#v(1.5cm)

// "摘要" 标题 — 黑体三号, 居中
#align(center)[
  #text(size: 三号, font: 标题字体, weight: "bold")[
    摘要
  ]
]

#v(12pt)

// 摘要正文 — 五号宋体, 首行缩进2字, 单倍行距
#par[
  LabGuardian 是一套面向高校电子类基础实验的全周期边缘 AI 智能助教系统。项目聚焦工程教育中物理空间认知鸿沟与走线遮挡痛点，贯通了从"面包板原型验证"到"PCB 成品制造"的教学闭环。系统以竞赛指定平台 DK-2500（Intel Core Ultra 5 225U）为算力中枢，融合 Android 移动端构建了"感知 → 重构 → 知识 → 调度 → 诊断 → 协同"六层递进的多模态智能 Agent 架构。
]

#par[
  在视觉感知层，系统以关键点检测替代传统端到端目标检测框，通过学生 Android 端多角度拍摄解决物理遮挡难题；结合 YOLO-Pose 关键点锚定与单应性空间映射（Homography），通过 Snap-to-Grid 网格吸附算法实现隐蔽引脚精准定位。在逻辑重构层，DFS 图论算法将物理坐标转化为工业标准 SPICE 电气网表，实现逻辑透明、可逐步追溯的规则校验。在智能诊断层，系统引入 PCM（Push-Based Context Management）技能挂载架构与 RAG（Retrieval-Augmented Generation）芯片知识库：CPU 侧管线充当意图控制面，当拓扑分析发现短路等异常时，动态从本地芯片技术手册知识库检索引脚规格与典型电路，并将精选的诊断技能（Skills）与知识片段定向推送给 NPU 上的视觉大模型（VLM），实现"大模型解耦与上下文实时编译"，使系统在极低 Token 消耗下具备灵活扩展检测能力。
]

#par[
  系统充分利用 Intel Core Ultra 的 CPU、iGPU 和 NPU 协同能力，实现"视觉检测、知识检索、智能诊断"异构分工运行。全部推理与知识检索在 DK-2500 本地完成，数据不离开实验台。端到端诊断时延控制在 2 秒以内，细化为视觉推理、拓扑校验、知识增强与热力图告警四个可观测阶段，便于现场展示异构协同效果。
]

// 关键词 — 五号宋体, 逗号分开, 最后一个关键字后面无标点符号
#keywords(
  "边缘AI",
  "PCM 技能挂载",
  "RAG 芯片知识增强",
  "SPICE 网表生成",
  "零样本检测",
  "异构计算",
)




#pagebreak()


// ============================================================
// 第 3 页: 目录 (可选)
// ============================================================

#align(center)[
  #text(size: 三号, font: 标题字体, weight: "bold")[
    目#h(2em)录
  ]
]
#v(6pt)

// 一级条目加粗 + 点号引导符 (Typst 0.13 写法)
#show outline.entry: it => {
  set text(weight: if it.level == 1 { "bold" } else { "regular" })
  it.indented(it.prefix(), [
    #it.body()
    #box(width: 1fr, repeat[.])
    #it.page()
  ])
}

#outline(
  title: none,
  indent: 2em,
)

#pagebreak()


// ============================================================
// 第一部分  项目背景
// ============================================================

= 项目背景 <sec:background>

== 行业痛点与需求分析

高校电子类基础实验（电路分析、模拟/数字电子技术）是培养学生工程素养的核心环节。然而，当前实验教学不仅面临 1:30 以上的师生比失衡，更在"物理实操"层面存在三个亟待解决的结构性问题：

*（1）空间遮挡导致的拓扑提取瓶颈。*真实的电路实验中，错综复杂的杜邦线常将底层元器件与引脚完全遮挡。传统纯视觉 AI 算法（如 YOLO 目标检测）在面对引脚级微小目标时易产生特征丢失与定位偏移，难以还原真实的电气网络连接。

*（2）电路逻辑诊断与微观缺陷研判困难。*初学者难以将二维电路原理图映射至三维面包板空间，每学期因极性反接、短路等操作失误导致的芯片损坏率达 8%–15%。

*（3）"原型设计"与"制造检验"环节脱节。*现有教学工具多局限于面包板实验，缺乏对后续 PCB 焊接制造环节的检验能力，无法形成完整的电子工程教学全周期闭环。

目前国内外尚无针对面包板电路实验场景、融合计算机视觉、图论分析与视觉大语言模型的开源 AI 辅助教学系统，这正是 LabGuardian 的创新切入点。

== 竞赛契合度与平台优势

本项目与 2026 英特尔杯嵌入式系统专题邀请赛的核心要求高度契合。竞赛指定硬件平台 DK-2500 搭载 Intel Core Ultra 5 225U 处理器（12C14T，基础功耗 15W），配备双通道 DDR5 16GB 内存与 M.2 SSD 128GB 存储，运行 Ubuntu 22.04 LTS。其 CPU + iGPU + NPU 三单元异构架构，结合 OpenVINO 工具套件，为多模态 AI 负载的分层卸载提供了理想的硬件基础：

- *iGPU（高并发视觉感知）*：通过 OpenVINO FP16 精度加速 YOLO-Pose 关键点检测，并行运行基于 Intel Anomalib 的 PCB 零样本缺陷热力图算法，保障视觉锚点的高帧率提取。
- *NPU（大模型认知与微观诊断）*：专项承载视觉大模型（VLM），在降低整机功耗的同时实现复杂缺陷特征的零样本区域标注。
- *CPU P-Core / E-Core（控制面与拓扑引擎）*：承担高逻辑复杂度的控制面运算——PCM 意图路由、RAG 知识检索、单应性映射与图论拓扑重构。

  系统基于事件驱动机制实现计算单元的按需调度，确保在 16GB 共享内存下各模型流畅运行，充分体现 Intel 异构硬件的工程应用价值。

== 应用前景

LabGuardian 将学习反馈从"事后纠错"前移至"过程引导"，构建了"面包板原型验证 → PCB 成品制造"的全周期教学辅助闭环。借助 PCM 技能挂载与 RAG 芯片知识库，系统支持灵活扩展芯片型号与实验场景，新增元器件仅需导入技术手册即可适配。全部推理与知识检索在 DK-2500 本地离线完成，满足教学场景的弱网与隐私需求。主演示链路为"多模态感知 + 知识增强异构推理 + 教师协同看板"，评委在现场无需额外网络即可观察完整的端到端诊断效果。


// ============================================================
// 第二部分  项目设计方案
// ============================================================

= 项目设计方案 <sec:design>

== 研究开发内容

本项目立足于高校电子基础实验与工程实践，针对传统纯视觉检测在"引脚重度遮挡"与"长尾微观缺陷"上的先天瓶颈，以及边缘端大模型上下文窗口有限的核心矛盾，设计并实现了一套知识驱动的多模态边缘智能 Agent 系统。核心研发内容收敛为六大模块：

*（1）多视角融合的电路数字孪生。*以"Android 移动端多角度拍摄"替代传统单视角端到端检测的不可解释模式，系统自动提取元件物理锚点并结合单应性空间映射（Homography），重构出抗遮挡的电路拓扑网络。

*（2）基于图论的 SPICE 电气网表生成。*基于 Snap-to-Grid 吸附坐标，利用 DFS 与连通分量图论算法，将离散物理元器件自动重构为工业标准 SPICE 电气网表，实现逻辑透明、可逐步追溯的规则校验。

*（3）PCM 技能挂载架构（Push-Based Context Management）。*为打破边缘端 NPU 上下文窗口的硬约束，系统并不将所有硬件查错指令（Skills）全量注入大模型，而是通过 CPU 构建意图控制面：当拓扑发现短路时动态提取"热力图生成 Skill"与"引脚排故 Skill"，定向推送给 NPU 上的大模型，实现上下文实时编译与无限工具库扩展。

*（4）RAG 芯片知识库增强（Retrieval-Augmented Generation）。*通过对芯片技术手册（Datasheet）的结构化解析与本地向量化索引，系统实现了从"硬编码单芯片"到"动态知识驱动多芯片"的跨越：检测到 IC 型号后自动检索引脚定义、绝对最大额定值与典型应用电路，为诊断提供精准的工程知识支撑。

*（5）基于 VLM 的零样本微观诊断。*面向传统 YOLO 无法定义的微观长尾缺陷，引入视觉大模型结合 PCM 推送的精选 Skills 与 RAG 检索的芯片知识，实现零样本（Zero-shot）的定性裁决与引脚级结构化报告生成。

*（6）事件触发式无监督热力图。*集成 Intel Anomalib 框架输出像素级热力图，将高亮异常区域作为结构化诊断线索推送至学生端，形成"所见即所得"的视觉预警闭环。

== 硬件平台与异构计算调度

系统以竞赛指定平台 DK-2500，其核心硬件规格如@tab:dk2500 所示。

#figure(
  table(
    columns: (1fr, 2.5fr),
    align: (center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*硬件资源*], [*规格参数*],
    ),
    table.hline(stroke: 0.75pt),
    [处理器], [Intel Core Ultra 5 225U（12C14T，P-Core 4.8GHz，基础功耗 15W）],
    [内存 / 存储], [双通道 DDR5 16GB / M.2 2280 SSD 128GB],
    [集成显卡], [Intel Graphics（iGPU），支持 OpenVINO GPU 插件],
    [神经网络处理器], [Intel NPU，支持 OpenVINO NPU 插件与 NPUW 编译缓存],
    [操作系统], [Ubuntu 22.04 LTS],
    table.hline(stroke: 1.5pt),
  ),
  caption: [DK-2500 开发套件核心硬件规格],
) <tab:dk2500>

为打破纯深度学习模型在边缘端的内存与帧率瓶颈，本项目通过 OpenVINO 工具链实现了*"感知-拓扑-认知"三级异构解耦部署*，不引入冗余的文本生成大模型（LLM），将 NPU 算力集中用于视觉大模型（VLM）的图文推理。具体调度方案如@tab:dispatch 所示。

#figure(
  table(
    columns: (0.8fr, 1.5fr, 1.2fr, 2fr),
    align: (center, center, center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*计算单元*], [*负载类型与核心算法*], [*部署方式*], [*核心职责*],
    ),
    table.hline(stroke: 0.75pt),
    [iGPU], [高并发视觉感知\ YOLOv8-Pose 关键点网络], [OpenVINO GPU 插件\ FP16 自动量化], [高帧率（>30FPS）元器件检测，精准提取抗遮挡物理锚点（如芯片四角定点）。],
    [CPU\ P-Core], [意图控制面与图论引擎\ PCM + RAG + NetworkX], [原生指令集加速\ 超低延迟实时计算], [PCM 意图路由、RAG 芯片知识检索、Snap-to-Grid 网格吸附、DFS 拓扑遍历与 SPICE 网表生成。],
    [NPU], [零样本多模态认知\ VLM / Anomalib], [OpenVINO NPU 插件\ INT8 / INT4 量化], [按需触发：处理宏观逻辑无法覆盖的微观缺陷（烧焦/虚焊）及 PCB 异常热力图生成。],
    table.hline(stroke: 1.5pt),
  ),
  caption: [DK-2500 边缘异构算力调度分配],
) <tab:dispatch>

== 系统架构

LabGuardian 系统立足于 Intel Core Ultra 的"CPU+iGPU+NPU"异构算力底座，构建了一套*"感知 ➔ 提取 ➔ 重构 ➔ 知识调度 ➔ 智能诊断 ➔ 多端协同"*的知识驱动边缘 Agent 架构。核心创新在于：CPU 侧管线不仅完成拓扑重构，更充当 PCM 意图控制面，动态从 RAG 芯片知识库检索工程知识、精选诊断 Skills 后推送给 NPU 大模型，实现"上下文实时编译"。系统数据流与控制流划分为以下六个高度解耦的逻辑层级：

=== 1. 视觉多角度传感层（Multi-View Sensing Layer）

系统不依赖固定俯拍摄像头，而是以学生手中的 Android 智能手机作为视觉数据的唯一入口。面对布线密集的高遮挡区域，学生只需围绕电路板进行多角度拍摄（全局图 + 死角侧视图），通过移动端一键推流至边缘服务器，在零额外硬件的前提下有效消除单图视角盲区。

=== 2. 异构视觉特征提取层（Vision Feature Extraction Layer —— iGPU）

系统部署 OpenVINO FP16 量化加速的 YOLO-Pose 关键点网络，以关键点检测替代传统目标检测框，并发处理多视角图像群，仅提取物理上不易被遮挡的核心锚点（如杜邦线绝缘套管底边中心、DIP 芯片特定凹槽）。利用 iGPU 并行浮点运算实时完成多视角特征点云降噪与融合对齐，向下层输出稳定的几何特征点集。

=== 3. 绝对坐标映射与图论重构层（Topology Reconstruction Layer —— CPU）

本层是系统可解释的数学逻辑核心，负责将视觉层的不确定性输出转化为确定性的代数推演：

*单应性虚拟网格（Homography Grid）*：利用 OpenCV 提取全局图中面包板的四角特征，计算单应性矩阵，将带有透视畸变的实拍图像与关键点统一映射至 60×10 的标准物理孔位二维数组。

*Snap-to-Grid 引脚吸附与先验字典*：对 iGPU 输出的浮点型视觉锚点，通过最小欧氏距离计算，将其吸附至最近的整数型物理孔位。对于多引脚芯片，系统查阅元件先验字典（如 DIP 封装引脚间距 2.54mm 规则），由已检测锚点精确推算其余引脚孔位，实现遮挡区域的逻辑补全。

*DFS 图论遍历与 SPICE 网表生成*：基于 NetworkX 库构建二分图，将吸附后的物理元件建模为节点，孔位互连关系建模为边，通过深度优先搜索与连通分量算法自动生成工业标准 SPICE 电气网表，并执行电气规则检查（ERC）。

#figure(
  image("pictures/ui_netlist.jpg", width: 50%),
  caption: [从图像像素级特征到基于图论的 SPICE 网表代数重构流程],
) <fig:netlist>

=== 4. PCM 意图控制面与知识增强层（Intent Control & Knowledge Layer —— CPU）

本层是系统区别于传统视觉检测方案的核心创新。针对边缘端 NPU 上下文窗口极为有限的硬约束（相比云端 128K tokens，NPU 端仅数千 tokens），系统引入 PCM（Push-Based Context Management）技能挂载架构，将 CPU 侧管线提升为意图控制面：

*PCM Skills 动态路由*：系统并不将全部硬件查错指令（Skills）全量注入大模型。当第三层拓扑分析输出风险等级与结构化诊断线索后，PCM Skill Router 根据意图类型动态提取对应的最小技能子集——例如发现短路时仅推送"热力图生成 Skill"与"引脚排故 Skill"，极性反接时推送"极性诊断 Skill"与"安全建议 Skill"。这种控制面驱动的工具过滤机制，使工具/Skills 注册表可无限增长而不增加单次推理的 Token 开销。

*RAG 芯片知识检索*：当拓扑阶段识别出芯片型号（如 UA741），系统从本地芯片技术手册知识库（基于 FAISS 向量索引 + 结构化元数据）中自动检索该芯片的引脚定义、绝对最大额定值与典型应用电路。检索采用"结构化精确过滤（芯片型号 + 引脚号）+ 语义向量召回（应用电路）"混合策略，确保安全关键参数零幻觉。新增芯片型号只需导入 Datasheet，无需修改代码。

*上下文实时编译（Context Compiler）*：在 NPU 上下文预算内，将精选 Skills 描述、RAG 检索的知识片段与当前网表拓扑证据编译为最小必要的 Prompt，推送给下层 NPU 大模型。该机制使系统在保持低 Token 消耗的同时，支持灵活扩展工业检测 Skills 与芯片型号。

=== 5. NPU 零样本多模态诊断层（VLM Diagnostic Layer —— NPU）

NPU 上的视觉大模型不再需要"理解一切"，而是接收第四层编译好的精准上下文后执行聚焦诊断：

*Skills 驱动的 VLM 微观排故*：VLM 接收 PCM 推送的技能描述与 RAG 芯片知识，结合疑似错误局部区域（ROI）图像，以零样本方式推断微观缺陷（如针脚未剥皮、电阻烧焦），并生成引脚级结构化诊断报告。

*Anomalib 热力图生成*：在 PCB 焊接排故中，系统利用 Intel Anomalib 黄金模板对齐机制生成像素级热力图，高亮标注短路或连锡区域。热力图与网络拓扑叠加后形成精准的空间定位输入，为 VLM 诊断提供视觉证据链。

#figure(
  image("pictures/pcb_heatmap.png", width: 90%),
  caption: [基于 Intel Anomalib 框架生成的 PCB 无监督异常检测：黄金模板对齐、测试缺陷标注、像素级热力图与叠加输出],
) <fig:heatmap>

=== 6. 多端协同层（Multi-Terminal Synergy Layer）

系统建立"学生端结构化排故 + 服务器端核心运算 + 教师端全局调度"的三端协同机制：学生上传多视角照片后，服务器完成全链路解算并下发热力图与结构化诊断卡片，直观标注故障的确切物理坐标；教师后台展示实训室全局态势看板（出错统计、实时风险预警、异构硬件负载监控），辅助教师精准定位教学薄弱环节。

== 技术关键及主要特色

*（1）PCM 技能挂载：大模型解耦与上下文实时编译。*借鉴前沿 PCM（Push-Based Context Management）架构思想，CPU 侧管线充当意图控制面对诊断 Skills 进行动态路由，Context Compiler 在 NPU 上下文预算内完成实时编译。该机制突破了边缘端大模型上下文窗口的硬瓶颈，实现了"有限算力 + 无限工具库"的工程解耦。

*（2）RAG 芯片知识库：从硬编码到知识驱动。*通过对芯片技术手册的结构化解析、本地向量化索引与混合检索策略，系统实现了安全关键领域的零幻觉知识增强。新增芯片型号只需导入 Datasheet，无需修改代码，具备极强的可扩展性。

*（3）可解释的 SPICE 电气网络重构。*创新地将"YOLO-Pose 关键点锚定"、"单应性网格吸附（Snap-to-Grid）"与"图论连通分量遍历"深度融合，将受遮挡影响的不透明视觉预测拆解为可解释、可复现的确定性代数推演。

*（4）面向 NPU 的专属 VLM 推理。*不引入通用聊天大模型，将 NPU 算力集中用于视觉大模型，配合 PCM 推送的精选 Skills 与 RAG 知识实现零样本微观缺陷诊断，兼顾推理精度与功耗控制。

*（5）三端协同的多视角抗遮挡数字孪生。*"学生端 + 服务器端 + 教师端"教学闭环，通过学生多角度拍摄有效消除物理遮挡盲区。

*（6）从原型到量产的全生命周期赋能。*依托 Intel Anomalib 框架横向扩展 PCB AOI 能力，无需残次品数据即可输出高精度焊接缺陷热力图。

== 已完成工作（截至 3 月 25 日）

当前项目已完成核心算法管线（Pipeline）验证与 PCM/RAG 架构原型设计，跑通了"感知 → 重构 → 知识增强 → 诊断 → 协同"全链路演示。前文架构所展示的数据流（如@fig:netlist 、@fig:heatmap 所示）均已完成端到端闭环串调。具体模块成果如@tab:done 所示。

#v(0.5em)

#figure(
  table(
    columns: (1fr, 3fr),
    align: (center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*模块*], [*已完成内容*],
    ),
    table.hline(stroke: 0.75pt),
    [视觉孪生网络], [YOLOv8-Pose 关键点约束提取、Homography 绝对映射打通。],
    [图论网表生成], [Bipartite Graph 网表 DFS 生成机制与节点级电气检查打通。],
    [PCM 架构], [意图控制面原型实现，Skill Router 与 Context Compiler 模块设计完成。],
    [RAG 知识库], [UA741 等芯片手册结构化解析与本地 FAISS 向量索引原型验证。],
    [无监督 AOI], [Intel Anomalib 集成验证，WinCLIP 黄金模板零样本缺陷检测打通。],
    [多端协同], [实验台大屏与 Android 无线多视角图传测试完毕。],
    table.hline(stroke: 1.5pt),
  ),
  caption: [已完成工作清单（截至 3 月 25 日）],
) <tab:done>

== 后续开发方案与进度安排

项目进入复赛后，开发重点从"原理探索"全面转向"平台移植与稳态打磨"，计划于 6 月底完成全面封版：

*（1）PCM + RAG 工程落地：*完善 Skill Router 的意图路由规则与 Context Compiler 的 Token 预算分配策略；扩充芯片知识库至 NE555、LM358 等 10+ 款常用教学芯片，实现 Datasheet 半自动解析入库。

*（2）DK-2500 深度移植与异构调度：*依托 OpenVINO 完成 FP16/INT8 模型量化，将 PCM 控制面与 RAG 向量检索统一部署于 CPU、高并发视觉网络部署于 iGPU、VLM 推理部署于 NPU，夯实三单元异构流水线。

*（3）视觉算法优化与数据集扩充：*持续采集遮挡与强弱光照异常样本，扩增 YOLO-Pose 与 Anomalib 数据集，打磨多图融合算法的极限遮挡鲁棒性。

*（4）多端交互深化与盲测验收：*补充经典数模/运放电路等实验模板，进行大量破坏性错接盲测；优化学生端诊断卡片交互与教师端全局看板功能，确保现场演示万无一失。


// ============================================================
// 第三部分  团队组成
// ============================================================

= 团队组成 <sec:team>

== 团队成员组成

// TODO: 填写团队成员信息

== 成员特长与分工

// TODO: 填写成员分工
