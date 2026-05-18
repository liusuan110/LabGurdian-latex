
// ============================================================
// LabGuardian-GNN 独立论文稿 — Typst 版本
// ============================================================

#import "defs.typ": *

#let 正文字体 = ("Times New Roman", "SimSun", "Songti SC", "Source Han Serif SC")
#let 标题字体 = ("Times New Roman", "SimHei", "Heiti SC", "Noto Sans SC")
#let 宋体 = ("SimSun", "Songti SC", "Source Han Serif SC")

#set page(
  paper: "a4",
  margin: (top: 2.4cm, bottom: 2.4cm, left: 2.4cm, right: 2.4cm),
  footer: context {
    set align(center)
    set text(size: 10.5pt, font: 宋体)
    [第 #counter(page).display() 页 共 #counter(page).final().at(0) 页]
  },
)
#set text(size: 10.5pt, font: 正文字体, lang: "zh", region: "cn")
#set par(first-line-indent: 2em, leading: 1em, justify: true)
#set heading(numbering: "1.1")
#set figure(numbering: "1-1")
#show figure.caption: set text(size: 10pt, font: 正文字体, weight: "bold")
#show heading.where(level: 1): it => {
  set text(size: 16pt, font: 标题字体, weight: "bold")
  set align(center)
  v(18pt)
  it
  v(12pt)
}
#show heading.where(level: 2): it => {
  set text(size: 14pt, font: 标题字体, weight: "bold")
  v(10pt)
  it
  v(5pt)
}

#let code(x) = text(font: "Menlo", size: 9.5pt)[#x]
#let emphmetric(x) = strong(x)

#align(center)[
  #text(size: 19pt, font: 标题字体, weight: "bold")[面向面包板电路实验的学习辅助拓扑纠错：]
  #linebreak()
  #text(size: 19pt, font: 标题字体, weight: "bold")[LabGuardian-GNN 的设计与评估]
]
#v(0.8cm)
#align(center)[#text(size: 11pt)[LabGuardian 项目组]]
#align(center)[#text(size: 10pt)[2026年5月]]
#v(0.8cm)

#align(center)[#text(size: 14pt, font: 标题字体, weight: "bold")[摘要]]
#v(8pt)
面向高校电子基础实验的智能助教系统需要在复杂、易错且具有工程约束的面包板场景中判断学生电路是否与参考电路一致。传统规则比较器可利用图同构与引脚角色规则给出确定性结论，但在多余元件、弱角色标注、输入输出网络重映射等边界情形上，单纯依赖手写规则容易出现语义过宽或诊断粒度不足的问题。本文围绕 LabGuardian 项目中已实现的 GNN 拓扑纠错模块，提出一种以端口级异构电路图为基础、以 SEAL 局部子图学习为核心、以规则比较器为安全裁决层的学习辅助诊断框架。系统将元件、引脚和电气网络显式建模为 HeteroCircuitGraph，并把学生电路中的每条观测连接转换为局部 SEAL 子图，以预测该连接是否正确，同时为缺失连接任务生成候选目标排序。在 7 个参考电路、12 类扰动算子和 4200 个样本构成的合成数据集上，模型在整条留出的运放缓冲器 OOD 测试集上达到 WRONG_EDGE F1=0.993、MISSING_EDGE top-3=1.000。进一步的端到端评估显示，规则路径经过 GNN 驱动的风险分析和语义修正后，test 与 val 两个 split 的 false pass rate 均降至 0.0000，平均 GNN 推理开销约 1 ms。实验还表明，训练 fixture 多样性比继续叠加模型结构更能提升跨电路泛化能力。该工作为面包板实验中的可解释、可回归、可部署电路拓扑纠错提供了一条工程可落地路径。

#v(6pt)
#strong[关键词：] 图神经网络；SEAL；电路拓扑；面包板实验；智能助教；图同构

#pagebreak()
#outline(title: [目录])
#pagebreak()

= 引言

电子类基础实验的核心目标不仅是让学生得到一个正确输出，更是让学生理解从原理图到物理接线的映射过程。面包板实验具有明显的教学价值，但也天然带来连接状态不可见、引脚角色容易混淆、错误排查高度依赖教师经验等问题。对于一个智能实验助教而言，视觉检测只能回答“看到了什么元件和导线”，真正的诊断难点在于回答“这些连接在电气拓扑上是否合理”。因此，LabGuardian 后端将物理电路重构为网表和图结构，再与参考电路进行图同构、角色约束与差异报告生成。

在项目早期，确定性规则比较器承担了主要判定工作。它的优点是可解释、可控、易于写入教学报告；缺点也同样明显：一旦遇到“参考子图仍存在但学生额外接入了关键网络”“两个信号网在无标签图中被同构吸收”“局部连接错误但整体拓扑仍看似相似”等情况，规则语义需要不断补丁化。另一方面，直接用端到端深度学习替代规则判断又不适合教学安全场景，因为模型输出难以作为最终 pass/fail 的唯一依据。

本文采用折中且工程友好的设计：规则比较器仍然是最终裁决层，GNN 作为学习辅助层提供边级概率、热点定位与规则分歧提示。这样的设计把确定性规则和统计学习各自放在擅长的位置上：规则负责教学语义和安全边界，GNN 负责从大量合成错接样本中学习局部拓扑模式。@fig:pipeline 给出了整体流程。

#include "pictures/gnn/fig1_pipeline.typ"

本文的主要贡献如下：

+ 提出面向面包板电路纠错的端口级异构图表示，将元件、引脚与电气网络分离建模，保留极性、IC 引脚角色和网络语义等诊断关键信息。
+ 将 SEAL 链路预测思想迁移到学生电路连接诊断中，把“观测边是否正确”和“缺失连接应指向何处”转化为局部子图学习与候选排序任务。
+ 构建 ref-disjoint 的合成评估管线和 nightly evaluator，将模型指标、规则 false pass 红线和端到端报告质量纳入同一套可回归测试闭环。

= 方法

== 端口级异构电路图表示

传统电路图比较常把元件视为边、网络视为节点，或者把元件和网络构成二部图。对于教学纠错，这种表示仍然过粗，因为许多错误发生在元件引脚层面：例如二极管正负极反接、三极管 B/C/E 接错、UA741 的反相输入和输出节点混接等。LabGuardian-GNN 因此采用 HeteroCircuitGraph 表示，将电路拆成 component、port、net 三类节点，并显式连接 component--port 与 port--net 两类边，如 @fig:hcg 所示。

#include "pictures/gnn/fig2_hcg.typ"

在该表示中，component 节点携带元件类别、子型号和极性信息；port 节点携带标准化引脚角色、对称类别、是否极性敏感等特征；net 节点携带 power、ground、input、output、signal 等网络角色及 role label。这样的分层设计避免了把“元件存在”和“某个引脚接到某个网络”混为一谈，使模型能够对细粒度接线行为学习概率分布。

== SEAL 子图任务定义

SEAL（Subgraph Extraction and Labeling）最初用于链路预测任务，其核心思想是：判断一条候选边是否存在，不需要让模型一次性理解整张大图，而是围绕目标两端节点抽取局部封闭子图，并通过双半径节点标记（DRNL）编码节点相对于目标端点的位置关系。本文将这一思想用于电路连接诊断：对于学生电路中的每条观测 port--net 边，抽取以目标 port 与目标 net 为锚点的局部子图，预测该观测边是否为参考电路中的正确连接。

形式化地，给定参考图 $G_r$ 和学生图 $G_s$，对学生图中的观测边 $e=(p,n)$ 构造 SEAL 样本 $S_e$。模型输出

$ hat(y)_e = f_theta(S_e), quad hat(y)_e in [0,1] $

其中 $hat(y)_e$ 表示该连接正确的概率。对于缺失连接任务，系统将同一目标 port 与多个候选 net 组成候选集合，按照 $hat(y)$ 排序，计算 top-k 命中率。这样的设计与教学反馈天然对应：错误边给出“这根线可疑”，缺失连接给出“这根线可能应该接到哪里”。

== CircuitMatchNet 与推理集成

当前实现中的 CircuitMatchNet 采用 SEAL DGCNN 作为主头，输入为局部子图节点特征与边结构，输出边正确概率。P2.5 阶段的 SpiceNetlist 预训练权重可加载为 backbone 初始化；P3 阶段在合成扰动数据上进行监督微调。P3.2 又加入 prebaked dataset，将重构后的 SEAL 样本预先写盘，使训练从运行时 replay 转为 O(1) tensor lookup，大幅降低训练迭代成本。

在 P4 集成中，GNNAdvisor 被接入规则比较器 orchestrator。它不会改写 #code("logic_correct")、#code("is_correct") 或 #code("is_match") 等最终判定字段，而是把 edge predictions、hotspots、graph similarity、inference time 和 disagreement flag 写入报告中的 #code("summary.gnn")。当规则判为通过但 GNN 检出低置信连接时，系统生成 advisory warning；最终是否 pass/fail 仍由规则路径负责。这一设计降低了模型误判的安全风险，也使 GNN 输出保持可解释。

= 数据集与训练管线

== 合成样本生成

由于真实学生接线数据在项目当前阶段仍处于采集与格式对齐过程中，GNN 训练采用可控的 synthetic pipeline。系统先从标准 reference fixture 构建参考 HCG，再通过扰动算子生成学生电路，最后由 label builder 产生 SEAL 训练标签。@fig:dataset-flow 展示了数据生成闭环。

#include "pictures/gnn/fig3_dataset_flow.typ"

当前数据集包含 7 个 reference circuits：all-signal、voltage divider、RC low-pass、NPN switch、UA741 buffer、UA741 inverting amplifier 与 LM358 dual buffer。其中 #code("opamp_buffer") 整条电路被留作 OOD test reference，不进入训练和验证。扰动算子覆盖 identity、symmetric pin swap、wrong connection、pin reversed、missing component、extra component、floating net、short circuit、power swapped、input/output swapped、extra wire bridge 与 chained 共 12 类。

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 2.4fr),
    inset: 6pt,
    align: center,
    table.header(strong[划分], strong[reference 数], strong[sample 数], strong[占比], strong[说明]),
    [Train], [6], [3240], [77.1%], [六个训练 reference 的扰动样本],
    [Val], [6], [360], [8.6%], [与 train 同 reference，不同样本],
    [Test], [1], [600], [14.3%], [#code("opamp_buffer") 整条留出],
    [Total], [7], [4200], [100%], [12 类 perturbation 覆盖],
  ),
  kind: table,
  caption: [GNN 合成数据集与 ref-disjoint 划分统计],
) <tab:dataset>

这种划分比随机 sample split 更严格，因为测试集要求模型迁移到未见过的完整参考电路。它更接近真实课堂中的需求：系统不应只记住某个固定模板的扰动，而应学习跨电路的连接语义。

== fixture diversity 的作用

项目初期的 4-ref 数据集在验证集上已经能达到较高 F1，但在 held-out op-amp 测试集上表现明显不足。后续加入 UA741 反相放大器和 NPN switch 后，测试 F1 从 0.700 提升到 0.827；再加入 LM358 dual buffer 后，测试 F1 进一步提升到 0.993。@fig:fixture-diversity 表明，训练 fixture 多样性是当前设置下提升 OOD 泛化的主要杠杆。

#include "pictures/gnn/fig4_fixture_diversity.typ"

该结果也改变了后续工程优先级：与其继续增加模型参数或复杂 head，不如优先覆盖更多电路类型、IC 子型号和教学常见错误模式。对于电子实验助教而言，数据课程设计本身就是模型能力的一部分。

= 实验结果

== P3 模型指标

@tab:p3-metrics 汇总了当前 P3 follow-up v2 模型在验证集和 held-out test 集上的主要指标。两个计划验收门分别为 WRONG_EDGE F1 $>= 0.88$ 与 MISSING_EDGE top-3 $>= 0.85$。当前模型在 val 和 test 上均超过门限，其中 test WRONG_EDGE F1 达到 0.993，MISSING_EDGE top-3 达到 1.000。

#figure(
  table(
    columns: (1.2fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr),
    inset: 6pt,
    align: center,
    table.header(strong[Split], strong[WRONG_EDGE F1], strong[WRONG_EDGE AUC], strong[MISSING top-1], strong[MISSING top-3]),
    [Val best], [0.950], [0.990], [0.861], [1.000],
    [Test OOD], [0.993], [1.000], [1.000], [1.000],
    [Gate], [0.880], [--], [--], [0.850],
  ),
  kind: table,
  caption: [P3 CircuitMatchNet 主要指标],
) <tab:p3-metrics>

从训练历史看，模型在前 5 个 epoch 内已经越过 F1 门限，随后主要提升来自排序质量和 OOD 稳定性。由于测试集是完整留出的 op-amp buffer，而训练集包含另一类 op-amp 与 LM358 双运放，模型并不是记忆测试模板，而是在相近但不同的 IC port 语义上完成迁移。

== 消融实验

@fig:ablation 和 @tab:ablation 给出了 P3 follow-up ablation 的结果。原计划预期预训练和 DRNL 都应带来显著收益，但实验显示二者在当前数据规模与任务设置下并未形成稳定正贡献：no-pretrain 的 val F1 与 baseline 几乎持平，no-DRNL 在 test F1 上反而更高。该现象说明模型结构组件不是当前主要瓶颈，训练 reference 的覆盖范围和扰动分布更关键。

#include "pictures/gnn/fig5_ablation.typ"

#figure(
  table(
    columns: (1.3fr, 1fr, 1fr, 1fr, 1fr),
    inset: 6pt,
    align: center,
    table.header(strong[配置], strong[Val F1], strong[Val top-3], strong[Test F1], strong[Test top-3]),
    [Baseline], [0.941], [1.000], [0.854], [0.800],
    [No pretrain], [0.946], [1.000], [0.832], [0.600],
    [No DRNL], [0.943], [1.000], [0.918], [0.800],
  ),
  kind: table,
  caption: [P3 follow-up ablation 对比],
) <tab:ablation>

这里的结论不是“预训练或 DRNL 永远无用”，而是更具体的工程判断：在当前面包板电路合成分布中，预训练语料与目标扰动分布不完全一致，DRNL 也可能强化局部位置记忆，从而削弱 OOD 泛化。因此后续改进应先扩展真实或 pseudo-real 数据，再决定是否继续增加架构复杂度。

== P4/P5 端到端评估

P4 将 GNNAdvisor 接入 orchestrator 后，系统进入端到端评估阶段。P5 evaluator 同时统计规则比较器、GNN observed-edge 指标和 combined report 行为。经过 R1、R2、R6 等规则语义修正后，test 与 val 两个 split 的 false pass rate 均达到 0.0000，满足计划中 $<= 0.005$ 的红线要求。@fig:p4-p5-loop 展示了该闭环。

#include "pictures/gnn/fig6_p4_p5_loop.typ"

#figure(
  table(
    columns: (1fr, 1fr, 1.3fr, 1.3fr, 1.2fr, 1.4fr),
    inset: 6pt,
    align: center,
    table.header(strong[Split], strong[样本数], strong[Rule false pass], strong[Rule false fail], strong[Rule accuracy], strong[GNN 平均耗时/ms]),
    [Test], [600], [0.0000], [0.0000], [1.000], [1.01],
    [Val], [360], [0.0000], [0.0000], [1.000], [1.13],
  ),
  kind: table,
  caption: [P5 端到端 evaluator 指标],
) <tab:p5-metrics>

需要强调的是，false pass 降为 0 并不是因为 GNN 直接覆盖了规则判定，而是 GNN 风险分析暴露了规则路径中的语义漏洞，随后通过关键网络额外连接提升、完整 production payload 评估、role label 传播等确定性修复完成闭环。GNN 的价值在这里体现为“发现规则盲区”和“提供边级证据”，而不是黑箱替代规则系统。

= 讨论

== 为什么 SEAL 适合电路接线诊断

面包板电路纠错具有明显的局部性：一根错误导线通常只影响某个 port 与其附近 nets、components 的连接关系。SEAL 正好利用这种局部性，把全图判断拆成目标边附近的子图分类。相比直接对整图做 graph classification，SEAL 有三个优势：第一，训练样本数量从“每个电路一个样本”扩展为“每条候选连接一个样本”；第二，输出天然对应可解释的边级反馈；第三，局部子图大小较小，适合在 CPU 上进行毫秒级推理。

与此同时，电路图又比一般社交网络链路预测更有结构先验。port type、polarity、net role 和 IC pin map 都能作为强特征注入节点表示。LabGuardian-GNN 的关键不是把 SEAL 原样套用，而是将电路工程语义压入 HCG 和 label builder，让模型学习的是“电路连接是否合理”，而不是抽象图中的边是否存在。

== 规则与学习的边界

在教学系统中，直接让模型决定 pass/fail 存在风险。一个 false fail 会误伤正确学生，一个 false pass 则可能放过危险接线。因此本文采用 advisory-first 策略：GNN 输出概率和热点，规则比较器输出最终结论。这样的架构牺牲了一部分端到端学习的简洁性，但换来了可解释性、可审计性和可回归测试能力。

P5 风险登记中的演化过程也说明了这种设计的好处。早期 evaluator 发现规则 false pass 高达 0.3057；进一步分析后定位到 equivalent-with-extra 语义、payload 缺失导致的浅路径评估、role label 丢失等问题。修复后规则本身达到 100% accuracy，GNN 仍保留为未来真实数据漂移下的辅助感知层。这种“模型发现问题，规则固化知识”的工作流很适合竞赛和教学部署。

== 从 synthetic 到 real-student netlist

当前结果主要基于 synthetic perturbation pipeline。虽然该管线覆盖了多类典型错接，但真实学生数据会包含更复杂的噪声：元件命名不一致、导线遗漏、前端识别置信度波动、面包板孔位映射误差和非标准调试接法等。因此，后续工作不应等待完整真实数据集才启动，而应先用现有 synthetic pipeline 导出 pseudo-real #code("cur_netlist_v2")，再叠加生产噪声，最后接入真实前端导出的 netlist。

这个方向的目标不是立即重训模型，而是先量化 simulation-to-real drift：规则 false pass 是否回升、GNN suspicious edge 分布是否偏移、哪些 perturbation 与真实错误最接近。只有完成这一步，后续加入 NE555、LM358 更多变体或真实学生作业采集才有明确依据。

= 结论

本文围绕 LabGuardian 项目中的 GNN 电路拓扑纠错模块，构建了一套从端口级异构图表示、SEAL 子图学习、合成数据集生成、模型训练消融到规则比较器融合与 P5 evaluator 的完整工程闭环。实验表明，在 7 个参考电路和 4200 个合成样本上，CircuitMatchNet 能够在 held-out op-amp 测试集上达到 WRONG_EDGE F1=0.993 和 MISSING_EDGE top-3=1.000；端到端规则评估在 test 与 val 两个 split 上均达到 false pass 0.0000。更重要的是，项目过程揭示了一个对后续研发很有价值的结论：在当前任务中，训练 fixture 多样性比继续增加模型复杂度更能提升泛化。

因此，LabGuardian-GNN 的意义不仅在于引入图神经网络模型，也在于提供了一种安全可解释的工程范式：让规则系统保持最终裁决，让 GNN 提供局部证据和风险提示，让 evaluator/nightly 持续约束 false pass 红线。后续工作将围绕真实学生 netlist 摄入、pseudo-real 噪声建模和更多 IC 子型号扩展展开，以进一步验证该方法在真实课堂环境中的鲁棒性。

= 参考文献

#par(first-line-indent: 0pt)[
[1] Zhang, M. and Chen, Y. Link Prediction Based on Graph Neural Networks. NeurIPS, 2018.\
[2] Fey, M. and Lenssen, J. E. Fast Graph Representation Learning with PyTorch Geometric. ICLR Workshop, 2019.\
[3] Cordella, L. P., Foggia, P., Sansone, C. and Vento, M. A Subgraph Isomorphism Algorithm for Matching Large Graphs. IEEE TPAMI, 2004.
]
