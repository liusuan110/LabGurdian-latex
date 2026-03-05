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
  LabGuardian 是一套面向高校理工科基础实验课程的边缘 AI 智能助教系统，旨在解决实验教学中师生比严重失衡、理论与工程认知鸿沟突出、现有辅助手段缺乏实物感知能力等结构性矛盾。系统以竞赛指定平台 DK-2500（Intel Core Ultra 5 225U）为硬件基底，采用 Vision → Logic → AI → GUI 四层分层架构，外加 Teacher 教师教室协同模块，实现了"看见电路→理解拓扑→给出建议→班级协同"的端到端闭环。
]

#par[
  在视觉感知层，系统基于 YOLOv8-OBB 旋转目标检测模型识别面包板上 9 类电子元器件，通过 OpenVINO 部署于 iGPU 实现毫秒级推理，采用 Image-only 高分辨率图片分析架构，支持 1-3 张图片多图 IoU 融合以消除遮挡盲区。系统设计了三级引脚定位策略：以 YOLO-Pose 关键点检测为主（直接预测引脚像素坐标），当元件遮挡导致关键点置信度不足时，启用局部视觉验证算法（仅分析元件附近 10-30 个孔洞的对比度特征判断占用状态），最后回退至几何候选约束匹配，实现元件引脚到面包板孔位的精确映射。在逻辑推理层，系统设计了四级鲁棒面包板校准管线与基于 NetworkX 的电路拓扑构建引擎，采用 VF2++ 子图同构与 GED 图编辑距离实现多级电路验证，支持 IC 多引脚 Hub 节点建模与 4 轨道电源轨学生标注。在认知层，系统部署离线双引擎（Qwen2.5-1.5B INT4 NPU 推理 → 规则模板兜底），结合 ChromaDB RAG 检索增强与 OCR 芯片自动识读，确保全离线环境下提供结构化的智能问答与指导。
]

#par[
  系统充分利用 Intel Core Ultra 的 CPU + iGPU + NPU 三单元协同能力，实现"专芯专用、负载解耦"的异构调度，全部推理计算在边缘设备完成，图片数据不出域。预期关键指标包括：元器件识别 mAP\@0.5 ≥ 80%、单张图片端到端分析延迟 < 5 s、支持 9 类元器件识别。
]

// 关键词 — 五号宋体, 逗号分开, 最后一个关键字后面无标点符号
#keywords(
  "边缘AI",
  "旋转目标检测",
  "关键点引脚定位",
  "电路拓扑分析",
  "异构计算",
  "Intel OpenVINO",
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

高校电子类基础实验（电路分析、模拟/数字电子技术）是工程素养培养的核心环节，但当前实验教学面临三重结构性矛盾：

*（1）师生比失衡。*实验课师生比普遍达 1:30 以上，学生遇到接线故障平均需等待 5–10 分钟才能获得教师介入，"指导真空期"消磨探索热情、降低教学效率。

*（2）认知鸿沟。*初学者难以将二维电路原理图映射至三维面包板空间，每学期因极性反接、短路等操作失误导致的芯片损坏率高达 8%–15%。

*（3）辅助手段局限。*Multisim/Proteus 等仿真软件无法感知实物接线；示波器等仪器只显示电气参数，无法从视觉层面定位"哪根线接错了"。

目前国内外尚无针对面包板电路实验场景、将计算机视觉与图论分析和大语言模型融合的开源 AI 辅助教学系统。这正是 LabGuardian 的创新空间所在。

== 竞赛契合度与平台优势

本项目与 2026 英特尔杯嵌入式系统专题邀请赛的核心要求高度契合。竞赛指定硬件平台 DK-2500 搭载 Intel Core Ultra 5 225U 处理器，其 CPU + iGPU + NPU 三单元异构架构，恰好为 LabGuardian 的多模态 AI 负载提供了理想的硬件基底——视觉推理走 iGPU、LLM 推理走 NPU、图论计算走 CPU P-Core，实现"专芯专用、负载解耦"。

== 应用前景

LabGuardian 将学习反馈从"事后纠错"前移至"过程引导"，学生拍摄面包板照片即可获得详细的纠错分析报告。系统作为"第一道防线"拦截基础连接错误，降低芯片损坏率、释放教师精力。教师教室模块将系统从单机工具升级为班级级教学管理平台，全部推理计算在 DK-2500 边缘设备完成，图片数据不出域，天然适配弱网与数据合规场景。该技术框架可复用于电子装配质检、PCB 审查等工业场景，具备良好的迁移性与产业化潜力。


// ============================================================
// 第二部分  项目设计方案
// ============================================================

= 项目设计方案 <sec:design>

== 研究开发内容

本系统定位为部署在每个实验台上的"全能电子助教"，核心功能覆盖"看、想、说、管"四大维度：

*（1）电路智能纠错。*通过高分辨率俯拍图片分析面包板，自动识别 9 类元器件布局与连线，将识别到的电路拓扑与标准模板进行图同构对比，检测短路、断路、极性反接等错误，在标注图上高亮标注错误位置并输出结构化诊断报告。

*（2）智能知识问答。*集成离线大语言模型并结合 RAG 检索增强生成，系统结合当前检测上下文与知识库检索结果生成结构化回答。

*（3）芯片自动识读与班级协同。*OCR 引擎识别 IC 芯片丝印型号并关联引脚数据库；教师端 Web 看板实现一对多实时监控、风险告警与指导下发。

== 硬件平台与异构调度

系统部署于竞赛指定平台 DK-2500，其核心硬件规格如@tab:dk2500 所示。

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

LabGuardian 采用"专芯专用、负载解耦"的异构调度策略：视觉感知模型经 OpenVINO GPU 插件部署于 iGPU；Qwen2.5-1.5B INT4 量化 LLM 通过 `LLMPipeline` 部署于 NPU；VF2++ 图同构等逻辑计算交由 CPU P-Core 处理。具体调度关系见@fig:arch。

== 系统架构

系统采用 Vision → Logic → AI → GUI 四层分层架构，外加 Teacher 教师协同模块，整体架构如@fig:arch 所示。各层通过 IoC 服务注册容器解耦，低层不依赖高层，任意一层可独立替换或测试。

#figure(
  image("pictures/system_architecture.png", width: 100%),
  caption: [LabGuardian 系统总体架构图],
) <fig:arch>

=== 视觉感知层（Vision）→ iGPU

视觉感知层负责从高分辨率俯拍图片中识别面包板上的电子元器件并精确定位其引脚插入孔位。系统采用 Image-only 架构，支持上传 1-3 张图片进行多图 IoU 融合分析，以消除单张图片中的遮挡盲区。

*（一）YOLOv8-OBB 元件检测。*核心模型为 YOLOv8-OBB（旋转目标检测），可识别 9 类元器件：电阻、LED、电容、二极管、导线、按钮、三极管、IC 芯片、电位器。选择 OBB 而非传统 HBB，是因为面包板上元件多为倾斜或垂直插入，旋转框能精确描述元件角度与长宽比，有效解决密集元件间的 IoU 粘连问题。引脚推算算法根据 OBB 几何特征，取短边中点沿长轴方向延伸得到引脚像素坐标，9 类元件采用差异化延伸系数以适应不同物理尺寸。

// TODO: 替换为实际图片 pictures/yolo_detection_demo.png
#figure(
  rect(width: 80%, height: 3.5cm, stroke: 0.5pt + gray)[
    #set align(center + horizon)
    #set par(first-line-indent: 0em)
    #text(size: 9pt, fill: gray)[
      【图片占位】YOLO 检测结果展示 \
      建议内容：一张元件丰富的面包板照片，标注全部 9 类检测框（OBB 旋转框）\
      左图：原始照片；右图：OBB 检测标注结果（含类别名称与置信度）
    ]
  ],
  caption: [YOLOv8-OBB 旋转目标检测效果],
) <fig:yolo-demo>

*（二）导线骨架化端点精炼。*对导线类检测，系统引入 `WireAnalyzer` 替代 OBB 短边中点估计。流程为：HSV 颜色分割排除背景 → 形态学清理 → Zhang-Suen 骨架化 → 8-邻域端点检测 → 凸包最远点对选择。同时对导线 HSV 分布投票进行颜色分类（支持红/蓝/绿/黄/橙/黑/白 7 色），为导线交叉场景提供区分能力。

*（三）三级引脚定位策略 — 核心创新。*

确定引脚具体插入面包板哪个孔洞是电路建模的关键前提。传统几何最近邻方法在密集元件场景下误匹配严重，本系统设计了三级渐进式引脚定位策略（流程见@fig:pinhole）：*策略 1* — YOLO-Pose 关键点检测，模型直接输出引脚像素坐标及置信度，置信度 > 0.6 时直接采用；*策略 2* — 当关键点因遮挡而置信度不足时，对附近 10–30 个孔洞执行局部对比度分析，综合占用分、距离分与电气约束选出最佳引脚对；*策略 3* — 几何候选约束匹配作为回退兜底，评分函数综合像素距离与面包板电气约束（同组短路重罚、跨度异常惩罚等）。三级降级确保任何场景均有可用结果，所有元件类型共享统一约束评分模块。

#figure(
  image("pictures/pinhole_pipeline.png", width: 100%),
  caption: [三级引脚定位策略流程图],
) <fig:pinhole>

*实验效果。*在 3 个真实面包板场景中，局部视觉验证 + 几何约束匹配相比纯几何方法显著降低引脚定位假阳性，如@tab:pinhole-result 所示。待 YOLO-Pose 模型训练完成后，预期准确率将进一步提升。

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center,
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*场景*], [*纯几何方法*], [*局部视觉+约束*], [*降低比例*],
    ),
    table.hline(stroke: 0.75pt),
    [Scene 1], [75 个假阳性], [18 个], [76%],
    [Scene 3], [214 个假阳性], [93 个], [56%],
    [Scene 5], [87 个假阳性], [72 个], [17%],
    table.hline(stroke: 1.5pt),
  ),
  caption: [引脚定位假阳性对比（纯几何 vs 局部视觉+约束）],
) <tab:pinhole-result>

=== 逻辑推理层（Logic）→ CPU

逻辑层实现从"像素坐标"到"电气连接关系"的关键转换，包含三个子模块。

*（一）面包板校准器（Calibrator）。*校准器检测面包板上所有孔洞位置并建立标准化网格坐标系，设计了四级检测管线：L1 对称圆网格检测（`cv2.findCirclesGrid`）→ L2 多参数 Blob 集成检测（3 组参数 × 9 个阈值 = 27 候选图）→ L3 霍夫圆补漏 → L4 轮廓几何兜底。检测后经 NMS 去重 + RANSAC 网格拟合剔除离群并补全缺失孔位，前置 CLAHE 光照归一化确保鲁棒性。v5.1 新增中缝感知列中心精炼——检测 e-f 列间凹槽间隙，两侧独立拟合 5+5 列中心，消除凹槽宽度对列坐标的偏差。

*（二）电路分析器（CircuitAnalyzer）。*基于 NetworkX 图论引擎将元件检测结果转化为电路拓扑图 $G = (V, E)$。顶点 $V$ 为电气节点（面包板纵向 5 孔导通组、4 条电源轨道），边 $E$ 为元器件连接。引脚对选择采用约束评分函数，综合欧氏距离、同组短路重罚（+100）、同行惩罚（+15）和跨度异常惩罚。极性解析器利用 OBB 旋转角度推断 LED/二极管正负极、三极管 B/C/E 引脚（采用 E-B + B-C 双结分离建模）。IC 引脚通过 OCR 识别丝印型号后查询内置引脚数据库（LM324/LM358/NE5532），以 Hub 中心节点模型纳入拓扑图。电源轨建模为 4 条独立轨道，由学生在 GUI 中主动标注用途（VCC/GND/自定义电压）。

*（三）电路验证器（CircuitValidator）。*实现标准电路与实测电路的精确对比，采用多级诊断管线：L0 快速预检（$O(1)$ 图签名）→ L1 带极性 VF2++ 全图同构 → L2 子图同构 → L2.5 仅极性诊断 → L3 GED 图编辑距离（自定义代价函数）。此外集成 6 项独立静态诊断：LED 无限流电阻、同组短路、极性未知、三极管缺引脚、浮空节点、断路子图。所有诊断结果输出结构化报告，含错误类型、位置坐标、修复建议与风险等级。

=== 认知层（AI）→ NPU/CPU

*（一）双引擎离线推理策略。*主引擎 — 本地 NPU 推理（Qwen2.5-1.5B INT4，基于 OpenVINO GenAI `LLMPipeline` 部署），完全离线且能力强大；兜底引擎 — 规则引擎（集成 11 种元件知识 + 6 种错误模板 + 50+ 中文别名），在极端端侧环境下提供零依赖备用响应。系统自动探测环境并按优先级选择后端，将检测上下文注入 LLM Prompt 生成结构化建议，保障数据绝对不出域。

*（二）RAG 检索增强。*基于 ChromaDB + text2vec-base-chinese 构建知识检索系统（400 字/块、80 字重叠、HNSW 索引），预装 6 篇专业文档，教师可上传自定义文档扩展。

*（三）OCR 芯片识读。*PaddleOCR → EasyOCR 双引擎回退，内置 13 种芯片型号正则纠错，识别后自动触发 RAG 知识检索与引脚数据库查表。

=== 教师教室模块与交互层

*教师教室模块（Teacher）。*基于 FastAPI + WebSocket 构建班级级教学管理平台：每个学生端每 5 秒发送心跳包，教师通过 Vue 3 Web 看板实时监控全班各工位进度、风险告警与错误统计，并可向指定工位推送指导消息，直接回应"师生比失衡"痛点。

*交互层（GUI）。*基于 PySide6 构建 PyDracula 暗色主题界面，五页面路由（图片上传/分析结果/AI 助手/电路验证/设置）。采用 `QThread` + 信号槽多线程分离，`ImageAnalysisWorker` 负责完整分析管线，`LLMWorker` 负责异步问答，线程间通过 ReadWriteLock + 快照机制保证安全。

== 技术关键及主要特色

*（1）三级渐进式引脚定位策略（核心创新）。*以 YOLO-Pose 关键点检测为主策略，直接预测引脚像素坐标；元件遮挡时降级为局部视觉验证（仅分析附近 10-30 个孔洞的对比度特征），最后回退至几何候选约束匹配。三级降级确保任何场景都有可用结果，统一电气约束模块消除代码重复。实测局部视觉+约束方案较纯几何方法假阳性降低 17%–76%。

*（2）OBB 旋转检测与导线骨架化。*OBB 提供旋转角度参数精确分割倾斜元件，9 类元件差异化延伸系数推算引脚坐标。导线类引入 Zhang-Suen 骨架化端点精炼 + HSV 颜色分类，解决弯曲导线端点定位问题。

*（3）鲁棒面包板校准。*四级检测级联 + NMS + CLAHE + RANSAC 网格拟合 + 中缝感知列精炼，适应不同光照与面包板型号。

*（4）极性感知的拓扑验证。*VF2++ 子图同构 + GED 图编辑距离，不仅检测"少了一个 LED"，更能诊断"LED 接反了"或"三极管 B/C/E 接错"。度序列预拒绝以 $O(n log n)$ 避免指数级最坏情况。

*（5）IC 多引脚 Hub 建模。*OCR 识别 DIP 芯片丝印后查询引脚数据库，以中心虚拟节点建模 N 个引脚，实现运放等复杂器件的完整电气拓扑。

*（6）RAG + 离线双引擎。*ChromaDB 向量检索注入本地 LLM 上下文，NPU 推理与规则引擎相辅相成，保证 100% 离线可用且数据不出域。

*（7）全 Intel 异构部署。*深度绑定 OpenVINO 生态，YOLO 走 iGPU、LLM 走 NPU、图论走 CPU，DK-2500 平台"代码不改、插件切换"无缝迁移。

== 预期目标

本项目的关键性能指标（KPI）如@tab:kpi 所示。

#figure(
  table(
    columns: (1fr, 1fr, 1.5fr),
    align: (center, center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*指标*], [*目标值*], [*说明*],
    ),
    table.hline(stroke: 0.75pt),
    [元器件识别率], [mAP\@0.5 ≥ 80%], [含遮挡与光照变化场景],
    [单图分析延迟], [< 5 s], [从图片上传到分析报告输出],
    [LLM 首字生成], [< 3 s], [NPU 离线推理条件下],
    [支持元器件], [9 类], [电阻/LED/电容/二极管/导线/按钮/三极管/IC/电位器],
    [引脚定位假阳性], [降低 17%–76%], [局部视觉+约束 vs 纯几何方法],
    [多图融合], [1-3 张], [IoU 融合消除遮挡盲区],
    [教室并发], [≥ 30 台], [WebSocket 长连接],
    table.hline(stroke: 1.5pt),
  ),
  caption: [LabGuardian 关键性能指标（KPI）],
) <tab:kpi>

== 项目实施方案与进度安排

项目采用"PC 原型先行 → DK-2500 无缝移植"策略，利用 OpenVINO 硬件抽象层实现"代码不改、插件切换"的平滑迁移。

#figure(
  table(
    columns: (1.2fr, 1fr, 2fr),
    align: (center, center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*时间*], [*阶段*], [*核心交付物*],
    ),
    table.hline(stroke: 0.75pt),
    [2 月—3 月 5 日], [数据与模型], [9 类 OBB 标注数据集 + YOLOv8-OBB 训练模型],
    [3 月 5 日—15 日], [软件开发], [四层架构 + 三级引脚定位 + RAG + GUI],
    [3 月 15 日—25 日], [初选材料], [方案报告 + PPT + Demo 视频],
    [4 月初—5 月中], [平台移植], [DK-2500 全链路跑通 + iGPU/NPU 验证],
    [5 月中—6 月底], [功能打磨], [最终作品 + 中英文报告 + 压力测试],
    table.hline(stroke: 1.5pt),
  ),
  caption: [项目进度安排],
) <tab:schedule>


// ============================================================
// 第三部分  团队组成
// ============================================================

= 团队组成 <sec:team>

== 团队成员组成

// TODO: 填写团队成员信息

== 成员特长与分工

// TODO: 填写成员分工
