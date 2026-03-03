// ============================================================
// 2026 年英特尔杯大学生电子设计竞赛嵌入式系统专题邀请赛
// 初选项目设计方案书 — Typst 模板
// ============================================================

// ============================================================
// 全局页面设置
// ============================================================
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  // 页脚: "第 X 页 共 Y 页"
  footer: context {
    set align(center)
    set text(size: 10.5pt, font: "SimSun")
    [第 #counter(page).display() 页 共 #counter(page).final().at(0) 页]
  },
)

// ============================================================
// 字体配置
// ============================================================
// 正文默认: 五号宋体 (10.5pt), 首行缩进 2 字符, 单倍行距
#set text(
  size: 10.5pt,
  font: ("Times New Roman", "SimSun"),
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
  set text(size: 16pt, font: ("Times New Roman", "SimHei"), weight: "bold")
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
  set text(size: 14pt, font: ("Times New Roman", "SimHei"), weight: "bold")
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
  set text(size: 12pt, font: ("Times New Roman", "SimSun"))
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
  set text(size: 10.5pt, font: ("Times New Roman", "SimSun"), weight: "bold")
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
#let songti(body) = text(font: ("Times New Roman", "SimSun"), body)
// 黑体文字块
#let heiti(body) = text(font: ("Times New Roman", "SimHei"), body)
// 楷体文字块
#let kaiti(body) = text(font: ("Times New Roman", "KaiTi"), body)

// 关键词命令
#let keywords(..args) = {
  let kws = args.pos()
  v(6pt)
  set par(first-line-indent: 0em)
  text(size: 五号, font: ("Times New Roman", "SimSun"))[
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
  #text(size: 四号, font: ("Times New Roman", "SimHei"))[
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
  #text(size: 二号, font: "KaiTi", weight: "bold")[
    初选项目设计方案书
  ]
  #v(3cm)
  // TODO: 插入赛事 LOGO 图片
  // #image("esic_logo.png", width: 4cm)
  // #text(size: 小四, font: "Times New Roman")[Intel Cup Embedded System Design Contest]
  #v(2cm)
  #text(size: 四号, font: ("Times New Roman", "KaiTi"), weight: "bold")[
    项目题目：#underline[#h(1em)LabGuardian：基于边缘AI的智能实验助教系统#h(1em)]
  ]
  #v(2cm)
  #text(size: 四号, font: ("Times New Roman", "KaiTi"))[
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
  #text(size: 三号, font: ("Times New Roman", "SimHei"), weight: "bold")[
    LabGuardian：基于边缘AI的智能实验助教系统
  ]
]

#v(1.5cm)

// "摘要" 标题 — 黑体三号, 居中
#align(center)[
  #text(size: 三号, font: ("Times New Roman", "SimHei"), weight: "bold")[
    摘要
  ]
]

#v(12pt)

// 摘要正文 — 五号宋体, 首行缩进2字, 单倍行距
#par[
  LabGuardian 是一套面向高校理工科基础实验课程的边缘 AI 智能助教系统，旨在解决实验教学中师生比严重失衡、理论与工程认知鸿沟突出、现有辅助手段缺乏实物感知能力等结构性矛盾。系统以竞赛指定平台 DK-2500（Intel Core Ultra 5 225U）为硬件基底，采用 Vision → Logic → AI → GUI 四层分层架构，外加 Teacher 教师教室协同模块，实现了"看见电路→理解拓扑→给出建议→班级协同"的端到端闭环。
]

#par[
  在视觉感知层，系统基于 YOLOv8-OBB 旋转目标检测模型识别面包板上 9 类电子元器件，通过 OpenVINO 部署于 iGPU 实现毫秒级推理，采用 Image-only 高分辨率图片分析架构，支持 1-3 张图片多图 IoU 融合以消除遮挡盲区。导线检测引入骨架化端点精炼与 HSV 颜色分类算法，替代传统 OBB 短边中点估计。在逻辑推理层，系统设计了四级鲁棒面包板校准管线与基于 NetworkX 的电路拓扑构建引擎，采用 VF2++ 子图同构与 GED 图编辑距离实现多级电路验证，集成极性感知诊断，支持 IC 多引脚 Hub 节点建模（OCR 丝印识别 + 引脚数据库查表），电源轨采用学生主动标注模式（4 条独立轨道，支持自定义电压标签），可定位短路、断路、极性反接、引脚错位等常见错误。在认知层，系统部署三级降级 LLM 引擎（云端 API → Qwen2.5-1.5B INT4 NPU 推理 → 规则模板），结合 ChromaDB RAG 检索增强与 OCR 芯片自动识读，确保离线环境下仍可提供智能问答。教师教室模块通过 FastAPI + WebSocket 实现班级级实时监控、风险告警与指导下发。
]

#par[
  系统充分利用 Intel Core Ultra 的 CPU + iGPU + NPU 三单元协同能力，实现"专芯专用、负载解耦"的异构调度，全部推理计算在边缘设备完成，图片数据不出域。预期关键指标包括：元器件识别 mAP\@0.5 ≥ 80%、单张图片端到端分析延迟 < 5 s、支持 9 类元器件识别。
]

// 关键词 — 五号宋体, 逗号分开, 最后一个关键字后面无标点符号
#keywords(
  "边缘AI",
  "旋转目标检测",
  "电路拓扑分析",
  "异构计算",
  "Intel OpenVINO",
  "实验教学",
)

#pagebreak()


// ============================================================
// 第 3 页: 目录 (可选)
// ============================================================

#align(center)[
  #text(size: 三号, font: ("Times New Roman", "SimHei"), weight: "bold")[
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

本项目与 2026 英特尔杯嵌入式系统专题邀请赛的核心要求高度契合。竞赛指定硬件平台 DK-2500 搭载 Intel Core Ultra 5 225U 处理器（12 核 14 线程，基础功耗 15W），配备 16GB DDR5 内存、128GB SSD、4 路千兆以太网、4 路 USB 3.2 及 40-Pin JTAG 扩展接口，运行 Ubuntu 22.04 操作系统。其 CPU + iGPU（Intel Graphics）+ NPU 三单元异构架构，恰好为 LabGuardian 的多模态 AI 负载提供了理想的硬件基底——视觉推理走 iGPU、LLM 推理走 NPU、图论计算走 CPU P-Core，实现"专芯专用、负载解耦"。

== 应用前景

LabGuardian 将学习反馈从"事后纠错"前移至"过程引导"，学生拍摄面包板照片即可获得详细的纠错分析报告，帮助其从"做完实验"升级为"吃透原理"。系统作为"第一道防线"拦截基础连接错误，降低芯片损坏率、释放教师精力。教师教室模块进一步将系统从单机工具升级为班级级教学管理平台，教师可同时监控全班各工位进度与风险状态，一对多实时指导。全部推理计算在 DK-2500 边缘设备完成，图片数据不出域，天然适配弱网与数据合规场景。该技术框架可复用于电子装配质检、PCB 审查等工业场景，具备良好的迁移性与产业化潜力。


// ============================================================
// 第二部分  项目设计方案
// ============================================================

= 项目设计方案 <sec:design>

== 研究开发内容

本系统定位为部署在每个实验台上的"全能电子助教"，核心功能覆盖"看、想、说、管"四大维度：

*（1）实时电路纠错。*通过高分辨率俯拍图片分析面包板，自动识别元器件布局与连线，将识别到的电路拓扑与标准模板进行图同构对比，检测短路、断路、极性反接等错误，在标注图上高亮标注错误位置并输出结构化诊断报告。

*（2）智能知识问答。*集成离线大语言模型（LLM）并结合 RAG 检索增强生成，学生可通过自然语言询问元器件参数、电路原理等问题，系统结合当前检测上下文（元件清单、连接状态、OCR 芯片型号）与知识库检索结果生成结构化回答。

*（3）芯片自动识读。*OCR 引擎实时识别面包板上 IC 芯片的丝印型号（如 NE555、LM741、SS8050），自动关联知识库中的引脚图与使用指南，为拓扑验证提供元件特征补充。

*（4）班级协同管理。*通过教师端 Web 看板实现一对多实时监控——教师可同时查看全班各工位的进度、风险告警与错误统计，并通过 WebSocket 向指定工位推送指导消息，将系统从"单机助教"升级为"班级级教学管理平台"。

== 硬件平台与异构调度

系统部署于竞赛指定平台 DK-2500，其核心硬件规格如表 2-1 所示。

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
    [外设接口], [4×USB 3.2（含 1×Type-C）/ DP 1.4a / HDMI 2.1 / 4×GbE LAN],
    [扩展接口], [40-Pin JTAG（GPIO/PWM/UART/I2C/SPI）/ M.2 E-Key WiFi],
    [操作系统], [Ubuntu 22.04 LTS],
    table.hline(stroke: 1.5pt),
  ),
  caption: [DK-2500 开发套件核心硬件规格],
) <tab:dk2500>

LabGuardian 采用"专芯专用、负载解耦"的异构调度策略，将三类 AI 负载精确映射至 DK-2500 的三个计算单元：

*（1）视觉感知 → iGPU。*YOLOv8-OBB 模型通过 OpenVINO GPU 插件部署于集成显卡，利用 GPU 并行浮点能力实现毫秒级推理，纯 CPU 推理帧率仅为个位数。

*（2）知识推理 → NPU。*Qwen2.5-1.5B INT4 量化模型通过 OpenVINO GenAI 的 `LLMPipeline` 部署于 NPU，利用其低功耗持续矩阵运算能力，避免与 YOLO 推理争抢 iGPU 资源。首次加载后执行 2-token 暖机预热 JIT 编译，配合 `NPUW_CACHE_DIR` 持久化编译产物，后续启动零编译延迟。

*（3）逻辑仲裁 → CPU P-Core。*VF2++ 子图同构、GED 图编辑距离、NetworkX 拓扑构建等复杂分支计算交由性能核处理。

// TODO: 插入异构调度架构图（建议绘制：CPU/iGPU/NPU 三列，各标注对应任务与 OpenVINO 插件）
// #figure(
//   image("pictures/heterogeneous_dispatch.png", width: 85%),
//   caption: [Intel Core Ultra 异构调度架构],
// ) <fig:hetero>

== 系统架构

系统采用四层分层架构——Vision（视觉感知）→ Logic（逻辑推理）→ AI（认知引擎）→ GUI（交互界面），外加 Teacher（教师教室）协同模块。整体代码量约 10,900 行 / 45 个 Python 源文件，通过 IoC 服务注册容器（AppContext）实现模块间解耦。

// TODO: 插入系统总体架构图（建议绘制：四层架构 + Teacher 模块 + 数据流箭头）
// #figure(
//   image("pictures/system_architecture.png", width: 90%),
//   caption: [LabGuardian 系统总体架构图],
// ) <fig:arch>

=== 视觉感知层（Vision）→ iGPU

视觉感知层负责从高分辨率俯拍图片中识别面包板上的电子元器件。系统采用 Image-only 架构，支持上传 1-3 张图片进行多图融合分析，以消除单张图片中的遮挡盲区。核心模型为 YOLOv8-OBB（旋转目标检测），可识别 9 类元器件：电阻（RESISTOR）、LED、电容（CAPACITOR）、二极管（DIODE）、导线（Wire）、按钮（Push\_Button）、三极管（TRANSISTOR）、IC 芯片（IC\_DIP）、电位器（POTENTIOMETER）。选择 OBB 而非传统水平框（HBB），是因为面包板上元件多为倾斜或垂直插入，旋转框能精确描述元件角度与长宽比，有效解决密集元件间的 IoU 粘连问题。

// TODO: 插入 OBB 与 HBB 对比示意图
// #figure(
//   image("pictures/obb_vs_hbb.png", width: 75%),
//   caption: [OBB 旋转框与 HBB 水平框在面包板场景中的对比],
// ) <fig:obb-vs-hbb>

OBB 检测结果结构化为 `Detection` 数据类，包含类别、置信度、OBB 四角点坐标及推算引脚坐标。引脚推算算法根据 OBB 几何特征，取短边中点沿长轴方向延伸得到元件两端引脚像素坐标，且不同元件类型采用差异化延伸系数（电阻 0.10、LED 0.08、二极管 0.10、导线 0.02、按钮 0.06、三极管 0.10、IC 0.02、电位器 0.08），以适应不同元件的物理尺寸特征。

对于导线类检测，系统引入 `WireAnalyzer` 骨架化端点精炼算法，替代传统 OBB 短边中点估计。具体流程为：HSV 颜色分割排除面包板白色背景 → 形态学清理（闭运算填补断裂 + 开运算去噪 + 保留最大连通域）→ Zhang-Suen 骨架化 → 8-邻域连接度端点检测 → 凸包最远点对选择。同时对导线像素 HSV 分布投票进行颜色分类（支持红/蓝/绿/黄/橙/黑/白），为导线交叉场景提供颜色区分能力。

多图融合算法以第 1 张图片为基准，后续图片与基准做 IoU 匹配：IoU $>= 0.3$ 视为同一元件（取置信度更高者），IoU $< 0.3$ 视为新元件（被前图遮挡），从而在不增加硬件成本的前提下提升检测召回率。

=== 逻辑推理层（Logic）→ CPU

逻辑层实现从"像素坐标"到"电气连接关系"的关键转换，是系统技术深度的核心体现，包含三个子模块。

*（一）面包板校准器（Calibrator）。*面包板表面由规则排列的金属孔洞构成，校准器的任务是精确检测所有孔洞位置并建立标准化网格坐标系。系统设计了四级检测 + RANSAC 后处理的鲁棒管线：

- *L1: 对称圆网格检测。*调用 `cv2.findCirclesGrid` 尝试一次性检测完整网格，精度最高但对光照敏感。
- *L2: 多参数 Blob 集成检测。*使用 3 组 `SimpleBlobDetector` 参数 × 9 个二值化阈值 = 27 个候选图并行检测，取并集最大化召回率。
- *L3: 霍夫圆补漏。*`HoughCircles` 对 L1/L2 遗漏区域进行补充检测。
- *L4: 轮廓几何分析兜底。*基于面积与圆度约束的轮廓分析作为最终保底。

检测完成后，通过 NMS 去重消除级联检测的重复项，再以 RANSAC 网格拟合（容差 0.35）剔除离群点并插值补全缺失孔位。整个管线前置 CLAHE（限制对比度自适应直方图均衡化）光照归一化预处理，确保在不同光照条件下均能稳定工作。引脚到最近孔位的映射采用 `np.argpartition` 实现 $O(N)$ Top-K 候选检索，避免全排序开销。

// TODO: 插入面包板校准管线流程图（L1→L2→L3→L4→NMS→RANSAC）
// #figure(
//   image("pictures/calibration_pipeline.png", width: 85%),
//   caption: [面包板四级校准管线流程],
// ) <fig:calib>

*（二）电路分析器（CircuitAnalyzer）。*基于 NetworkX 图论引擎，将元件检测结果转化为电路拓扑图 $G = (V, E)$。顶点集 $V$ 为电气节点——根据面包板导通规则（纵向 5 孔导通、电源轨横向导通），同一导通组内的孔位合并为单一节点；边集 $E$ 为元器件连接。引脚对选择采用四因子约束评分函数：

$ S(p_1, p_2) = d(p_1, p_2) + alpha dot P_"group" + beta dot P_"row" + gamma dot P_"span" $ <eq:pin-score>

其中 $d$ 为欧氏距离，$P_"group" = 100$ 为同组短路重罚（两脚插在同一导通组即短路），$P_"row" = 50 times 0.3$ 为同行惩罚，$P_"span" = 20$ 为跨度异常惩罚（跨越超过 10 行视为异常）。系统选择得分最低的引脚对作为最优映射。

电路分析器还集成了两项关键子功能：

- *极性解析器（PolarityResolver）。*利用 OBB 旋转角度与长轴方向推断二极管/LED 正负极方向（FORWARD/REVERSE），利用视觉检测的 pin3 位置或行中点插值推断三极管 B/C/E 引脚。三极管采用 E-B junction + B-C junction 分离建模，精确表达 BJT 结结构，而非简化的 pin1→pin2 两端建模。变阻器同理，pin1/pin2/pin3 分别映射为 Terminal\_A、Terminal\_B、Wiper 三引脚。IC 引脚映射则通过 OCR 识别丝印型号后查询引脚数据库（内置 LM324/LM358/NE5532 等常见运放），自动计算 DIP 封装全引脚坐标并以 Hub 节点模型纳入拓扑图。

- *电源轨精细建模。*全尺寸面包板上下各有 2 条电源轨道（共 4 条），不同实验的用途不同。系统将 4 条轨道建模为 `RAIL_TOP_1`、`RAIL_TOP_2`、`RAIL_BOTTOM_1`、`RAIL_BOTTOM_2` 四个独立节点，由学生在 GUI 中主动标注每条轨道的用途（VCC +5V / +3.3V / +12V / GND / 自定义），消除了自动推断可能带来的错误。

*（三）电路验证器（CircuitValidator）。*实现标准电路与实测电路的精确对比，采用多级诊断管线：

- *L0 快速预检。*计算图签名——$O(1)$ 结构不变量（节点数、边数、排序度序列、元件类型计数），签名不一致则提前拒绝，避免进入开销更大的同构算法。

- *L1 带极性 VF2++ 全图同构。*给定标准电路图 $G_"ref"$ 与实测电路图 $G_"det"$，求解同构映射 $phi: V(G_"ref") -> V(G_"det")$，使得：
$ forall (u, v) in E(G_"ref"): (phi(u), phi(v)) in E(G_"det") $ <eq:vf2>
同构匹配中同时验证边上元件的极性属性一致性。

- *L2 子图同构。*当全图同构失败时，放宽为子图同构搜索，尝试在实测图中找到标准图的嵌入。
- *L2.5 仅极性诊断。*当拓扑结构正确但极性可能错误时，单独检查极性赋值。
- *L3 GED（图编辑距离）。*当上述级别均无法匹配时，计算将 $G_"det"$ 变换为 $G_"ref"$ 所需的最小编辑操作数。自定义代价函数：极性错误 = 0.5、类型不匹配 = 1.5、kind 不匹配 = 2.0。对于大规模图，采用近似 GED 算法——基于节点类型余弦相似度、度序列 L1 距离、边比率三维相似度进行快速评估。

此外，验证器还集成 6 项独立静态诊断：LED 无限流电阻检测、极性未知警告、同组短路检测、三极管缺失 pin3 检测、浮空节点检测、断开子图检测。所有诊断结果统一输出为结构化报告，包含错误类型、位置坐标、修复建议与风险等级（DANGER/WARNING/SAFE）。

// TODO: 插入电路验证多级诊断流程图（L0→L1→L2→L2.5→L3 + 6项独立检查）
// #figure(
//   image("pictures/validation_pipeline.png", width: 85%),
//   caption: [电路验证多级诊断管线],
// ) <fig:validation>

=== 认知层（AI）→ NPU/CPU

认知层为系统提供"理解"与"表达"能力，包含三个引擎。

*（一）三级降级 LLM 引擎。*确保任何网络条件下均可提供智能问答：

- *Level 1 — 云端 API。*通过 OpenAI 兼容接口调用 DeepSeek/Qwen 等大模型，能力最强。
- *Level 2 — 本地 NPU 推理。*使用 `openvino_genai.LLMPipeline` 在 NPU 上运行 Qwen2.5-1.5B-Instruct INT4 量化模型，完全离线。首次加载执行 2-token 暖机预热 JIT 编译，配合 `NPUW_CACHE_DIR` 缓存编译产物。竞赛模式下阻断 HuggingFace 下载，强制全离线运行。
- *Level 3 — 规则引擎。*内置 11 种元件知识条目、6 种错误模式模板、50+ 中文别名映射的规则引擎，零依赖兜底。

系统自动探测网络状态，按 Cloud → Local → Rule 顺序选择最优后端，切换对用户透明。系统将检测上下文（元件清单、置信度、风险事件、电路描述快照）注入 LLM System Prompt，输出结构化建议（现象/证据/原因/下一步/风险），并对高风险建议启用白名单过滤。

*（二）RAG 检索增强生成引擎。*基于 ChromaDB 向量数据库与 `text2vec-base-chinese` 中文嵌入模型构建知识检索系统：

- *文档分块：*400 字/块、80 字重叠、段落感知分割，确保语义完整性。支持 Markdown 与 PDF（PyMuPDF → pdfplumber 双引擎回退）格式。
- *增量索引：*以 MD5 文件哈希前 12 位作为文档 ID，已索引文件自动跳过，支持热更新。
- *相似度检索：*HNSW 索引 + 余弦距离，最低相似度阈值 0.35，Top-K 结果注入 LLM 上下文窗口。
- *内置知识库：*预装 6 篇专业文档（模拟实验指南、芯片引脚手册、NE555 使用指南、运放基础、SS8050/SS8550 三极管数据手册），教师可上传自定义 PDF/Markdown 扩展。

*（三）OCR 芯片识读引擎。*采用 PaddleOCR（主）→ EasyOCR（备）双引擎回退架构，每 30 帧触发一次 OCR 检测。内置 13 种常见芯片型号正则纠错表（LM741、NE555、SS8050 等），修正 OCR 误识别。识别到新芯片型号后自动触发 RAG 知识检索，将引脚图与使用指南推送至 UI 面板。OCR 结果通过空间网格缓存（键值 `{cx//50}_{cy//50}`）避免对同位置芯片重复识读。

// TODO: 插入 RAG 检索流程图（文档分块→向量化→ChromaDB→LLM 上下文注入）
// #figure(
//   image("pictures/rag_pipeline.png", width: 80%),
//   caption: [RAG 检索增强生成流程],
// ) <fig:rag>

=== 教师教室模块（Teacher）→ Web

教师教室模块将 LabGuardian 从单机工具升级为班级级教学管理平台，直接回应了"师生比失衡"这一核心痛点。

*服务端。*基于 FastAPI 构建 RESTful API（12 个端点）+ WebSocket 实时通信，主要功能包括：

- *心跳监控：*每个学生端每 5 秒发送心跳包（携带进度百分比、匹配相似度、错误列表与 160×120 缩略图 base64），10 秒未心跳标记为离线。
- *风险告警聚合：*基于关键词的三级风险分类（DANGER: 短路/烧毁/无限流电阻；WARNING: 极性反接/浮空节点等），按严重度排序后推送教师端。
- *进度排名：*按进度降序 → 耗时升序双维度排序，实时呈现全班完成情况。
- *错误直方图：*班级级错误类型聚合统计，帮助教师发现共性问题并针对性讲解。
- *实时指导下发：*教师通过 WebSocket 向指定工位或全班广播文字指导消息，学生端即时弹出提示。

*前端。*基于 Vue 3 + Vite 构建 SPA 单页应用，包含班级总览、工位详情、排名视图、统计分析四个页面。教师无需安装客户端，通过浏览器即可访问。各工位通过 hostname 自动生成 station_id，实现零配置部署。

// TODO: 插入教师端 Web 看板截图或架构图
// #figure(
//   image("pictures/teacher_dashboard.png", width: 85%),
//   caption: [教师教室模块架构与 Web 看板],
// ) <fig:teacher>

=== 交互层（GUI）→ PySide6

基于 PySide6（Qt6）构建 PyDracula 风格暗色主题界面，采用自定义无边框标题栏 + 侧边栏导航 + `QStackedWidget` 五页面路由（图片上传/分析结果/AI 助手/电路验证/设置）。

核心采用 `QThread` + 信号槽机制实现多线程分离：`ImageAnalysisWorker` 负责图片分析管线（YOLO 检测 → Wire 骨架端点精炼 → 多图 IoU 融合 → 校准映射 → IC OCR + 引脚数据库 → 电路拓扑建模 → 极性解析 → 电路验证 → 标注绘制 → 结构化报告生成），`LLMWorker` 负责异步问答，`ModelLoaderWorker` 负责模型加载。线程间共享数据通过 ReadWriteLock（写者优先）保护，电路描述采用快照机制——LLM 线程在写锁内复制字符串后释放锁，实现零锁竞争的异步问答。图片上传页面支持 3 个缩略图槽位、置信度滑块与分辨率选择（640/960/1280），分析结果以标注图 + 结构化报告双面板呈现。电路验证页面新增电源轨配置 UI，每条轨道提供预设下拉（VCC +5V / +3.3V / +12V / GND）与自定义输入框。

// TODO: 插入 GUI 界面截图
// #figure(
//   image("pictures/gui_screenshot.png", width: 85%),
//   caption: [LabGuardian 学生端界面],
// ) <fig:gui>

== 技术关键及主要特色

*（1）OBB 旋转检测与差异化引脚推算。*传统水平框在面包板场景中引入大量背景噪声导致引脚粘连，OBB 提供旋转角度参数 $theta$，精确分割细长导线与倾斜电阻。系统为 9 类元件设计差异化延伸系数，从 OBB 几何直接推算两端引脚像素坐标，无须额外关键点检测模型。对导线类检测进一步引入骨架化端点精炼（Zhang-Suen 算法），辅以 HSV 颜色分类，解决弯曲导线端点定位与同色交叉区分问题。

// TODO: 插入 OBB 检测效果对比图
// #figure(
//   image("pictures/obb_detection_demo.png", width: 75%),
//   caption: [OBB 检测效果示例],
// ) <fig:obb-demo>

*（2）鲁棒面包板校准管线。*四级检测级联（精确→模糊）+ NMS 去重 + CLAHE 光照归一化 + RANSAC 网格拟合，适应不同光照/面包板型号，引脚到孔位映射误差控制在 ±1 格以内。

*（3）极性感知的拓扑验证与 GED 诊断。*在 VF2++ 子图同构基础上引入元件极性与引脚角色信息，不仅检测"少了一个 LED"，更能诊断"LED 接反了"或"三极管 B/C/E 接错"。当同构匹配失败时，GED 图编辑距离以自定义代价函数量化电路差异，参考 EDA 领域 LVS（Layout vs. Schematic）方法论。度序列预拒绝以 $O(n log n)$ 复杂度提前过滤不可能匹配的图对，避免 VF2++ 的指数级最坏情况。

*（4）RAG + LLM 三级降级保证离线可用。*ChromaDB 向量检索将知识库上下文注入 LLM 提示词，LLM 引擎按 Cloud→Local→Rule 三级降级，本地推理走 NPU 加速，竞赛模式强制全离线。

*（5）OCR 芯片识读联动 RAG。*双引擎 OCR + 13 种正则纠错识别芯片丝印，自动触发知识库检索推送引脚图，形成"视觉识别→知识检索→智能问答"的闭环。

*（6）电源轨精细建模与学生标注。*面包板 4 条电源轨道独立建模，学生在 GUI 中主动标注每条轨道用途（VCC/GND/自定义电压），消除自动推断的不确定性，适应 +5V、+3.3V、双电源等多样化实验配置。

*（7）IC 多引脚自动建模。*OCR 识别芯片丝印型号后查询内置引脚数据库（LM324/LM358/NE5532），自动计算 DIP 封装全引脚坐标，以 Hub 节点模型纳入拓扑图，实现运放电路等多引脚 IC 的完整电气建模。

*（8）Image-only 高精度分析。*采用手机高分辨率俯拍图片替代低分辨率视频流，支持 1-3 张多图 IoU 融合消除遮挡盲区，在牺牲实时性的前提下大幅提升检测准确率，系统复杂度降低 40%。

*（9）教师教室协同。*FastAPI + WebSocket 实时双向通信，Vue 3 Web 看板实现班级级监控、风险告警、进度排名与实时指导下发，直接解决师生比失衡问题。

*（10）全 Intel 原生工具链。*深度绑定 OpenVINO 生态：模型导出为 IR 格式，YOLO 走 iGPU 插件，LLM 走 NPU 插件，NNCF 量化压缩，DK-2500 平台"代码不改、插件切换"无缝迁移。

== 预期目标

本项目的关键性能指标（KPI）如表 2-2 所示。

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
    [LLM 首字生成时间], [< 3 s], [NPU 离线推理条件下],
    [支持元器件种类], [9 类], [电阻/LED/电容/二极管/导线/按钮/三极管/IC/电位器],
    [系统连续运行稳定性], [≥ 2 小时], [无崩溃、无内存泄漏],
    [多图融合支持], [1-3 张], [IoU 融合消除遮挡盲区],
    [教室并发工位数], [≥ 30 台], [WebSocket 长连接],
    table.hline(stroke: 1.5pt),
  ),
  caption: [LabGuardian 关键性能指标（KPI）],
) <tab:kpi>

== 项目实施方案与技术路线

项目采用敏捷开发模式，分三个阶段推进，核心思路为"PC 原型先行 → DK-2500 无缝移植"——利用 Intel Core Ultra 与 PC 的 x86 指令集兼容性，通过 OpenVINO 硬件抽象层实现"代码不改、插件切换"的平滑迁移。

*阶段 A：初选冲刺（2026.02—2026.03）。*完成数据采集与标注（200–300 张多环境面包板照片，9 类 OBB 标注，含三极管/IC/电位器）、YOLO 模型训练（yolov8s-obb, epochs=300, imgsz=1280）、Image-only 四层架构模块化开发（图片上传分析引擎、导线骨架端点检测、IC 多引脚建模、4 轨道电源轨学生标注）、RAG 知识库构建、PySide6 GUI 开发、设计方案书撰写。

*阶段 B：平台移植（2026.04—2026.05）。*在 DK-2500（Ubuntu 22.04）上搭建 OpenVINO 运行时环境，完成 YOLO 模型 OpenVINO IR 导出（FP16/INT8）并验证 iGPU 推理帧率（目标 ≥ 15 FPS \@ 960p），LLM 模型 NPU 部署，摄像头 V4L2 适配，教师教室模块局域网联调。

*阶段 C：功能打磨（2026.05—2026.06）。*开发一键纠错、安全预检（LED 无限流电阻告警）、面包板自动检测（Canny→dilate→contour 最大四边形）等差异化功能；完成系统性能调优、中英文报告撰写、压力测试（连续运行 2 小时、断网环境验证、30 工位并发测试）。

// TODO: 插入技术路线甘特图
// #figure(
//   image("pictures/tech_roadmap.png", width: 90%),
//   caption: [项目技术路线图],
// ) <fig:roadmap>

== 进度安排

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
    [2 月 10 日—3 月 5 日], [数据与模型], [标注数据集 + YOLOv8-OBB 训练模型],
    [3 月 5 日—3 月 15 日], [软件开发], [四层架构 + RAG + 教室模块 + GUI],
    [3 月 15 日—3 月 25 日], [初选材料], [方案报告 + PPT + Demo 视频],
    [4 月初—5 月中], [平台移植], [DK-2500 全链路跑通 + iGPU/NPU 验证],
    [5 月中—6 月 30 日], [功能打磨], [最终作品 + 中英文报告 + 压力测试],
    table.hline(stroke: 1.5pt),
  ),
  caption: [项目进度安排],
) <tab:schedule>

== 异常处理与降级策略

系统针对评审现场可能出现的异常情况设计了完整的降级路径，核心原则为"不断流、可恢复、可追溯"：

- *图片分析异常。*单张图片检测结果不佳时，支持上传多张不同角度图片进行多图 IoU 融合，提升检测召回率。
- *OpenVINO 编译失败。*按 iGPU → NPU → CPU 级联回退，确保推理不中断。
- *LLM 延迟过大。*切换规则模板优先模式，先输出基础建议，LLM 响应到达后追加详细解释。
- *模型加载失败。*使用 yolov8n 轻量模型回退，LLM 按 Qwen2.5→MiniCPM→Phi-3→TinyLlama 优先级自动发现可用模型。
- *OCR 引擎异常。*PaddleOCR → EasyOCR → 无 OCR 三级回退，基础检测功能不受影响。

所有异常事件均记录日志，支持事后回溯分析。


// ============================================================
// 第三部分  团队组成
// ============================================================

= 团队组成 <sec:team>

== 团队成员组成

// TODO: 填写团队成员信息

== 成员特长与分工

// TODO: 填写成员分工
