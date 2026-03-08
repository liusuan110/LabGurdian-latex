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

本项目与 2026 英特尔杯嵌入式系统专题邀请赛的核心要求高度契合。竞赛指定硬件平台 DK-2500 搭载 Intel Core Ultra 5 225U 处理器（12C14T，基础功耗 15W），配备双通道 DDR5 16GB 内存与 M.2 SSD 128GB 存储，运行 Ubuntu 22.04 LTS。其 CPU + iGPU + NPU 三单元异构架构，恰好为 LabGuardian 的多模态 AI 负载提供了理想的硬件基底：

- *iGPU*：通过 OpenVINO GPU 插件部署 YOLOv8-OBB 视觉推理，利用 `ov::Core::compile_model("GPU")` 实现 FP16 自动量化与异步推理队列，单帧推理延迟约 40-80 ms。
- *NPU*：通过 OpenVINO GenAI `LLMPipeline` 部署 Qwen2.5-1.5B INT4 量化模型，利用 NPUW 编译缓存加速首次加载，实现离线大语言模型推理。
- *CPU P-Core*：承担 NetworkX 图论计算（VF2++ 子图同构、GED 图编辑距离）、OpenCV 图像预处理与 FastAPI 服务调度。

系统基于 OpenVINO 硬件抽象层开发，通过 `device="GPU"` / `device="NPU"` / `device="CPU"` 参数切换后端，实现 PC 开发机与 DK-2500 之间"代码零修改、插件即切换"的无缝迁移。

== 应用前景

LabGuardian 将学习反馈从"事后纠错"前移至"过程引导"，学生通过 Android 客户端拍摄面包板照片，图片经 REST API 发送至部署在实验台上的 DK-2500 边缘服务器，经四级流水线处理后返回结构化诊断报告与标注图。教师通过 Electron 桌面端 Web 看板实时监控全班工位状态、风险告警与进度排名，并可向指定工位推送指导消息。全部推理计算在 DK-2500 边缘设备完成，图片数据不出域，天然适配弱网与数据合规场景。

系统已形成完整的三端工程体系（Server + Android + Electron），具备清晰的 API 契约与模块边界，可复用于电子装配质检、PCB 审查等工业场景。


// ============================================================
// 第二部分  项目设计方案
// ============================================================

= 项目设计方案 <sec:design>

== 研究开发内容

本系统定位为部署在每个实验台 DK-2500 上的"全能电子助教"，采用 C/S 多端架构，核心功能覆盖四大维度：

*（1）电路智能纠错（Server 端）。*通过 FastAPI 四级流水线处理高分辨率俯拍图片，自动识别 9 类元器件布局与连线，将识别到的电路拓扑与标准模板进行图同构对比，检测短路、断路、极性反接等错误，输出结构化诊断报告。Server 端部署于 DK-2500，通过 OpenVINO 调度 iGPU/NPU/CPU 三单元。

*（2）学生移动端（Android）。*基于 Jetpack Compose + CameraX 的原生 Android 应用，学生拍摄面包板照片后通过 Retrofit REST 客户端提交至 Server，实时接收分析结果与教师指导消息。

*（3）教师监控端（Electron + Vue 3）。*教师端 Web 看板实现一对多实时监控，显示全班各工位进度、风险告警与错误统计，支持向指定工位推送指导消息与全班广播。

*（4）智能知识问答与芯片识读。*集成离线大语言模型（NPU 推理）结合 RAG 检索增强生成，OCR 引擎识别 IC 芯片丝印型号并关联引脚数据库。

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

LabGuardian 采用"专芯专用、负载解耦"的异构调度策略，具体调度关系如@tab:dispatch 所示。

#figure(
  table(
    columns: (1fr, 1.5fr, 2fr),
    align: (center, center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*计算单元*], [*负载类型*], [*部署方式*],
    ),
    table.hline(stroke: 0.75pt),
    [iGPU], [YOLOv8-OBB 视觉推理], [OpenVINO GPU 插件，FP16 自动量化],
    [NPU], [Qwen2.5-1.5B LLM 推理], [OpenVINO GenAI LLMPipeline，INT4 量化],
    [CPU P-Core], [图论 + 图像预处理 + API 服务], [NetworkX / OpenCV / FastAPI],
    table.hline(stroke: 1.5pt),
  ),
  caption: [DK-2500 三单元异构调度分配],
) <tab:dispatch>

== 系统架构

系统采用 Server（DK-2500）+ Android 学生端 + Electron 教师端的三端架构。Server 内部为 Vision → Logic → AI → GUI 四层分层设计，外加 Teacher 教师协同模块。各层通过 IoC 服务注册容器解耦，低层不依赖高层，任意一层可独立替换或测试。三端通过 RESTful API 与 WebSocket 通信，API 契约由 OpenAPI/Swagger 自动生成文档。

=== 视觉感知层（Vision）→ iGPU

视觉感知层负责从高分辨率俯拍图片中识别面包板上的电子元器件并精确定位其引脚插入孔位。系统采用 Image-only 架构，支持上传 1-3 张图片进行多图 IoU 融合分析，以消除单张图片中的遮挡盲区。

*（一）YOLOv8-OBB 元件检测。*核心模型为 YOLOv8-OBB（旋转目标检测），可识别 9 类元器件：电阻、LED、电容、二极管、导线、按钮、三极管、IC 芯片、电位器。选择 OBB 而非传统 HBB，是因为面包板上元件多为倾斜或垂直插入，旋转框能精确描述元件角度与长宽比，有效解决密集元件间的 IoU 粘连问题。引脚推算算法根据 OBB 几何特征，取短边中点沿长轴方向延伸得到引脚像素坐标，9 类元件采用差异化延伸系数以适应不同物理尺寸。

导线类检测引入 `WireAnalyzer` 替代 OBB 短边中点估计，流程为：HSV 颜色分割排除背景 → 形态学清理 → Zhang-Suen 骨架化 → 8-邻域端点检测 → 凸包最远点对选择，同时对导线 HSV 分布投票进行颜色分类（支持 7 色），为导线交叉场景提供区分能力。

*（二）三级引脚定位策略 — 核心创新。*

确定引脚具体插入面包板哪个孔洞是电路建模的关键前提。传统几何最近邻方法在密集元件场景下误匹配严重，本系统设计了三级渐进式引脚定位策略（流程见@fig:pinhole）：*策略 1* — YOLO-Pose 关键点检测，模型直接输出引脚像素坐标及置信度，置信度 > 0.6 时直接采用；*策略 2* — 当关键点因遮挡而置信度不足时，对附近 10–30 个孔洞执行局部对比度分析，综合占用分、距离分与电气约束选出最佳引脚对；*策略 3* — 几何候选约束匹配作为回退兜底，评分函数综合像素距离与面包板电气约束（同组短路重罚、跨度异常惩罚等）。三级降级确保任何场景均有可用结果，所有元件类型共享统一约束评分模块。

#figure(
  image("pictures/pinhole_pipeline.png", width: 100%),
  caption: [三级引脚定位策略流程图],
) <fig:pinhole>

*实验效果。*在真实面包板场景中，局部视觉验证 + 几何约束匹配相比纯几何方法可显著降低引脚定位假阳性。待 YOLO-Pose 模型训练完成后，预期准确率将进一步提升。

=== 逻辑推理层（Logic）→ CPU

逻辑层实现从"像素坐标"到"电气连接关系"的关键转换，包含三个子模块。

*（一）面包板校准器（Calibrator）。*校准器检测面包板上所有孔洞位置并建立标准化网格坐标系，设计了四级检测管线：L1 对称圆网格检测（`cv2.findCirclesGrid`）→ L2 多参数 Blob 集成检测（3 组参数 × 9 个阈值 = 27 候选图）→ L3 霍夫圆补漏 → L4 轮廓几何兜底。检测后经 NMS 去重 + RANSAC 网格拟合剔除离群并补全缺失孔位，前置 CLAHE 光照归一化确保鲁棒性。v5.1 新增中缝感知列中心精炼——检测 e-f 列间凹槽间隙，两侧独立拟合 5+5 列中心，消除凹槽宽度对列坐标的偏差。

*（二）电路分析器（CircuitAnalyzer）。*基于 NetworkX 图论引擎将元件检测结果转化为电路拓扑图 $G = (V, E)$。顶点 $V$ 为电气节点（面包板纵向 5 孔导通组、4 条电源轨道），边 $E$ 为元器件连接。引脚对选择采用约束评分函数，综合欧氏距离、同组短路重罚（+100）、同行惩罚（+15）和跨度异常惩罚。极性解析器利用 OBB 旋转角度推断 LED/二极管正负极、三极管 B/C/E 引脚（采用 E-B + B-C 双结分离建模）。IC 引脚通过 OCR 识别丝印型号后查询内置引脚数据库（LM324/LM358/NE5532），以 Hub 中心节点模型纳入拓扑图。电源轨建模为 4 条独立轨道，由学生在 GUI 中主动标注用途（VCC/GND/自定义电压）。

*（三）电路验证器（CircuitValidator）。*实现标准电路与实测电路的精确对比，采用多级诊断管线：L0 快速预检（$O(1)$ 图签名）→ L1 带极性 VF2++ 全图同构 → L2 子图同构 → L2.5 仅极性诊断 → L3 GED 图编辑距离（自定义代价函数）。此外集成 6 项独立静态诊断：LED 无限流电阻、同组短路、极性未知、三极管缺引脚、浮空节点、断路子图。所有诊断结果输出结构化报告，含错误类型、位置坐标、修复建议与风险等级。

=== 认知层（AI）→ NPU/CPU

*（一）双引擎离线推理策略。*主引擎 — 本地 NPU 推理（Qwen2.5-1.5B INT4，基于 OpenVINO GenAI `LLMPipeline` 部署），完全离线且能力强大；兜底引擎 — 规则引擎（集成 11 种元件知识 + 6 种错误模板 + 50+ 中文别名），在极端端侧环境下提供零依赖备用响应。系统自动探测环境并按优先级选择后端，将检测上下文注入 LLM Prompt 生成结构化建议，保障数据绝对不出域。

*（二）RAG 检索增强。*基于 ChromaDB + text2vec-base-chinese 构建知识检索系统（400 字/块、80 字重叠、HNSW 索引），预装 6 篇专业文档，教师可上传自定义文档扩展。

*（三）OCR 芯片识读。*PaddleOCR → EasyOCR 双引擎回退，内置 13 种芯片型号正则纠错，识别后自动触发 RAG 知识检索与引脚数据库查表。

=== 多端协同架构

*Server 端（DK-2500，Python/FastAPI）。*作为整个系统的计算核心部署于竞赛平台 DK-2500，对外暴露 RESTful API + WebSocket 接口。已实现 12 个 API 端点，涵盖流水线执行（同步/异步）、教室状态管理（心跳/排名/告警/统计）与指导消息下发。Celery + Redis 提供可选的异步任务队列，同步模式亦可独立运行。核心 API 端点如@tab:api 所示。

#figure(
  table(
    columns: (1.5fr, 0.6fr, 2fr),
    align: (left, center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*端点*], [*方法*], [*功能*],
    ),
    table.hline(stroke: 0.75pt),
    [`/pipeline/run`], [POST], [同步执行四级分析流水线],
    [`/pipeline/submit`], [POST], [异步提交（Celery 任务队列）],
    [`/classroom/heartbeat`], [POST], [学生端心跳上报（进度/风险/元件数）],
    [`/classroom/stations`], [GET], [教师端查询全班工位状态],
    [`/classroom/ranking`], [GET], [进度排行榜],
    [`/classroom/alerts`], [GET], [活跃风险告警列表],
    [`/classroom/station/{id}/guidance`], [POST], [向指定工位推送指导消息],
    [`/classroom/broadcast`], [POST], [全班广播消息],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Server 端核心 API 端点],
) <tab:api>

*学生端（Android，Kotlin/Jetpack Compose）。*采用 MVVM + Clean Architecture 分层设计，模块化为 `:app`、`:core:network`、`:core:data`、`:core:model`、`:core:ui`、`:feature:camera`、`:feature:dashboard`、`:feature:guidance` 共 8 个 Gradle 模块。CameraX 负责图片采集，Retrofit + OkHttp 负责 REST 通信，Hilt 依赖注入，DataStore 持久化用户配置。已实现 Dashboard（自身状态+班级排名）、Camera（拍照+流水线提交+结果展示）、Guidance（指导消息接收）三大功能页面。

*教师端（Electron + Vue 3）。*基于 electron-vite 构建跨平台桌面应用，Pinia 状态管理 + Vue Router 四页面路由。实现教室总览（统计卡片+工位网格）、工位详情（缩略图+诊断数据）、排行榜、统计分析四个视图，支持向指定工位发送指导消息与全班广播。Axios 客户端每 2 秒轮询 Server API 获取最新教室状态。

三端通过统一的 OpenAPI 契约通信，Server 端 Swagger 文档自动生成，Android 端可通过脚本自动生成 Retrofit 接口代码。

== 技术关键及主要特色

*（1）三级渐进式引脚定位策略（核心创新）。*以 YOLO-Pose 关键点检测为主策略，直接预测引脚像素坐标；元件遮挡时降级为局部视觉验证（仅分析附近 10-30 个孔洞的对比度特征），最后回退至几何候选约束匹配。三级降级确保任何场景都有可用结果，统一电气约束模块消除代码重复。实测局部视觉+约束方案较纯几何方法假阳性降低 17%–76%。

*（2）OBB 旋转检测与导线骨架化。*OBB 提供旋转角度参数精确分割倾斜元件，9 类元件差异化延伸系数推算引脚坐标。导线类引入 Zhang-Suen 骨架化端点精炼 + HSV 颜色分类，解决弯曲导线端点定位问题。

*（3）鲁棒面包板校准。*四级检测级联 + NMS + CLAHE + RANSAC 网格拟合 + 中缝感知列精炼，适应不同光照与面包板型号。

*（4）极性感知的拓扑验证。*VF2++ 子图同构 + GED 图编辑距离，不仅检测"少了一个 LED"，更能诊断"LED 接反了"或"三极管 B/C/E 接错"。度序列预拒绝以 $O(n log n)$ 避免指数级最坏情况。

*（5）IC 多引脚 Hub 建模。*OCR 识别 DIP 芯片丝印后查询引脚数据库，以中心虚拟节点建模 N 个引脚，实现运放等复杂器件的完整电气拓扑。

*（6）RAG + 离线双引擎。*ChromaDB 向量检索注入本地 LLM 上下文，NPU 推理与规则引擎相辅相成，保证 100% 离线可用且数据不出域。

*（7）全 Intel 异构部署与平台深度绑定。*系统从架构层面围绕 DK-2500 的 Intel Core Ultra 异构能力设计：OpenVINO `ov::Core` 统一模型编译接口，`compile_model(model, "GPU")` / `"NPU"` / `"CPU"` 一行切换后端；GenAI `LLMPipeline` 封装 NPU 推理全流程；NPUW 编译缓存加速模型二次加载。PC 开发期间使用 `device="CPU"` 调试，部署 DK-2500 仅需修改配置文件中的 `device` 字段即可完成迁移，无需改动任何业务代码。

*（8）三端工程化体系。*Server（FastAPI，12 个 API 端点）+ Android（Kotlin/Compose，8 个 Gradle 模块）+ Electron（Vue 3，4 个视图页面），通过 OpenAPI 契约解耦，具备完整的多端协同开发与独立测试能力。

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

== 已完成工作（截至 3 月 25 日）

当前项目已完成 PC 端原型开发与初选材料提交，具体工程成果如@tab:done 所示。

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
    [Server 端], [FastAPI 四级流水线（S1 检测→S2 映射→S3 拓扑→S4 验证）全部就绪；12 个 REST API 端点；教室状态管理；Celery 异步任务可选],
    [视觉算法], [YOLOv8-OBB 9 类元件检测模型；四级面包板校准管线；导线骨架化端点精炼；局部视觉+约束引脚定位],
    [逻辑推理], [NetworkX 拓扑构建引擎；极性解析器；IC Hub 节点建模；VF2++ / GED 多级电路验证；6 项静态诊断],
    [Android 端], [8 模块 Clean Architecture 骨架；Dashboard / Camera / Guidance 三个功能页面；CameraX + Retrofit 通信],
    [Electron 端], [教室总览 / 工位详情 / 排行榜 / 统计 四个视图；Pinia 状态管理；指导消息下发与广播],
    table.hline(stroke: 1.5pt),
  ),
  caption: [已完成工作清单（截至 3 月 25 日）],
) <tab:done>

== 项目实施方案与进度安排

项目采用"PC 原型先行 → DK-2500 无缝移植"策略，利用 OpenVINO 硬件抽象层实现"代码不改、插件切换"的平滑迁移。3 月 25 日后进入复赛开发阶段，核心任务为三条并行主线：*视觉算法优化*、*多端功能完善*与*竞赛平台移植*。

#figure(
  table(
    columns: (1.2fr, 0.8fr, 2.5fr),
    align: (center, center, left),
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header(
      [*时间*], [*阶段*], [*核心交付物*],
    ),
    table.hline(stroke: 0.75pt),
    [2 月—3 月 25 日], [原型开发\ + 初选], [✅ 已完成：9 类 OBB 模型 + 四层架构 + 三端骨架 + 初选材料],
    table.hline(stroke: 0.5pt + gray),
    [3.25—4.10], [视觉算法\ 优化（一）], [YOLO-Pose 关键点检测模型标注与训练；三级引脚定位全链路打通；OBB 增量训练 mAP\@0.5 ≥ 85%],
    [3.25—4.10], [DK-2500\ 环境搭建], [Ubuntu 22.04 + OpenVINO Runtime + GPU/NPU 插件验证；YOLO IR 格式导出并在 iGPU 跑通],
    [4.10—4.30], [平台移植\ + 性能调优], [四级流水线 DK-2500 全链路跑通；iGPU 推理优化（< 100 ms/帧）；NPU LLM 验证；三单元并发压力测试],
    [4.10—4.30], [Android 端\ 功能完善], [WebSocket 实时指导；电源轨标注交互；分析结果详情页优化；多图管理；服务器配置],
    [5.1—5.20], [Electron 端\ 功能完善], [WebSocket 替代轮询；标准电路模板管理；工位视频流预览；数据导出与历史记录],
    [5.1—5.20], [视觉算法\ 优化（二）], [多图 IoU 融合优化；IC OCR + 引脚数据库扩展；复杂电路场景验证],
    [5.20—6.10], [系统集成\ 联调], [三端联调（30 台并发）；端到端 KPI 达标；异常鲁棒性测试；DK-2500 开机自启动脚本],
    [6.10—6.30], [作品打磨\ + 文档], [最终作品封装；中英文技术报告；演示视频；决赛现场方案],
    table.hline(stroke: 1.5pt),
  ),
  caption: [项目进度安排（含复赛开发计划）],
) <tab:schedule>

=== 三条开发主线详细说明

*主线一：视觉算法优化。*当前 YOLO-OBB 检测模型已具备基本能力，下一步重点为：（1）训练 YOLO-Pose 关键点检测模型，使三级引脚定位策略的第一级（直接预测引脚坐标）投入实用，目标是 80% 以上元件无需降级至局部视觉验证；（2）扩充训练数据集至 2000+ 张，覆盖多种光照条件与面包板型号；（3）利用 DK-2500 iGPU 进行模型推理性能调优，确保单帧端到端延迟 < 5 s。

*主线二：多端功能完善。*Android 学生端需完成 WebSocket 实时通信、电源轨交互标注、分析结果可视化优化等功能，使其从"可用原型"升级为"完整产品"。Electron 教师端需将 2 秒轮询升级为 WebSocket 实时推送，新增标准电路模板管理、历史数据查看等教学管理功能。两端均需完成与 DK-2500 Server 的联调验证。

*主线三：竞赛平台移植。*这是决定项目能否参赛的关键路径。DK-2500 移植的核心工作包括：（1）OpenVINO GPU/NPU 插件的安装与驱动验证；（2）YOLO 模型导出为 IR 格式并验证 iGPU 推理精度无损；（3）LLM 模型 INT4 量化后在 NPU 上的推理速度与质量验证；（4）三单元并发调度下的系统稳定性测试。


// ============================================================
// 第三部分  团队组成
// ============================================================

= 团队组成 <sec:team>

== 团队成员组成

// TODO: 填写团队成员信息

== 成员特长与分工

// TODO: 填写成员分工
