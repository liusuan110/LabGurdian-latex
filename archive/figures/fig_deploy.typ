#import "../../defs.typ": *

// DK-2500 异构调度图（学术极简版）
#figure(
  acad-card(
    grid(
      columns: 1,
      gutter: 6pt,
      // 顶部：用户输入
      align(center, acad-card(
        fill: acad-bg-plain, stroke: acad-ink,
        [📷 学生上传电路照片 · 💬 学生提问  #acad-note[(Android / Web)]]
      )),
      align(center, acad-arrow),
      // 中间：DK-2500 三单元
      grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 8pt,
        align: center,
        acad-card(label: "iGPU",
          fill: acad-bg-plain, stroke: acad-ink,
          [OpenVINO FP16\
           #acad-note[YOLO-Pose 关键点检测\
           Snap-to-Grid 网格吸附\
           PCB 缺陷热力图]
          ]),
        acad-card(label: "NPU",
          fill: acad-bg-emphasis, stroke: acad-ink,
          [OpenVINO INT4 (AWQ)\
           #acad-note[Gemma3-4B 端侧推理\
           表达层 Polish\
           ~2-5s / 次 (规划)]
          ]),
        acad-card(label: "CPU",
          fill: acad-bg-plain, stroke: acad-ink,
          [Pure Python\
           #acad-note[GNN-A 推理 (1ms)\
           Template VF2 匹配\
           LangGraph 编排\
           RAG 检索]
          ]),
      ),
      align(center, acad-arrow),
      // 底部：输出
      grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 8pt,
        align: center,
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [拓扑识别 + confidence band]),
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [自然语言诊断 + 教学解释]),
        acad-card(fill: acad-bg-plain, stroke: acad-ink,
          [Edit Script + 高亮协议]),
      ),
      align(center, acad-note[
        #strong[关键约束]：全部推理本地完成 · 数据不离开实验台 · 端到端目标 $<$ 2s
      ]),
    ),
    fill: white, stroke: acad-ink, inset: 8pt,
  ),
  caption: [DK-2500 异构计算单元调度。Intel Core Ultra 5 225U 的 iGPU / NPU / CPU 三单元各司其职。OpenVINO 工具套件统一抽象异构后端。NPU 列以浅蓝衬底标识为承载 LLM 推理的关键加速器。],
) <fig:deploy>
