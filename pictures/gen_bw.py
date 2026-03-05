import urllib.request

def generate_mermaid_kroki(markup, filename):
    url = "https://kroki.io/mermaid/png"
    print(f"Generating {filename}...")
    headers = {
        'User-Agent': 'Mozilla/5.0',
        'Content-Type': 'text/plain; charset=utf-8'
    }
    req = urllib.request.Request(url, data=markup.encode('utf-8'), headers=headers, method='POST')
    try:
        with urllib.request.urlopen(req) as response:
            if response.status == 200:
                with open(filename, 'wb') as f:
                    f.write(response.read())
                print(f"Saved {filename}")
            else:
                print(f"Failed: {response.status}")
    except Exception as e:
        print(f"Error: {e}")

# ============================================================
# 图 1: 系统总体架构图 — 横向, 黑白, 简洁
# ============================================================
arch_markup = """%%{init:{'theme':'base','themeVariables':{'primaryColor':'#ffffff','primaryBorderColor':'#000000','primaryTextColor':'#000000','lineColor':'#000000','secondaryColor':'#ffffff','tertiaryColor':'#ffffff','fontFamily':'SimSun,serif','fontSize':'24px'}}}%%
flowchart LR
    subgraph L1[视觉感知层]
        V[YOLOv8-OBB 检测<br>三级引脚定位]
    end
    subgraph L2[逻辑推理层]
        L[面包板校准<br>拓扑构建与验证]
    end
    subgraph L3[认知层]
        A[离线 LLM 推理<br>RAG 检索增强]
    end
    subgraph L4[交互层]
        G[PySide6 GUI<br>五页面路由]
    end

    V -->|元件与孔位| L -->|电路网表| A -->|诊断建议| G

    V -.- iGPU([iGPU])
    L -.- CPU([CPU])
    A -.- NPU([NPU])

    G ===|WebSocket| T[Teacher<br>教师看板]
"""

# ============================================================
# 图 2: 三级引脚定位策略 — 横向, 黑白, 简洁
# ============================================================
pinhole_markup = """%%{init:{'theme':'base','themeVariables':{'primaryColor':'#ffffff','primaryBorderColor':'#000000','primaryTextColor':'#000000','lineColor':'#000000','secondaryColor':'#ffffff','tertiaryColor':'#ffffff','fontFamily':'SimSun,serif','fontSize':'24px'}}}%%
flowchart LR
    In([OBB 检测结果]) --> D{关键点<br>置信度}

    D -->|"> 0.6"| S1[YOLO-Pose<br>关键点检测]
    D -->|"≤ 0.6"| S2[局部视觉<br>对比度验证]
    S2 --> C{匹配<br>成功?}
    C -->|是| O2[引脚对]
    C -->|否| S3[几何候选<br>约束匹配]
    S3 --> O3[引脚对]

    S1 --> O1[引脚对]
    O1 --> M([电路建模])
    O2 --> M
    O3 --> M
"""

generate_mermaid_kroki(arch_markup, "system_architecture.png")
generate_mermaid_kroki(pinhole_markup, "pinhole_pipeline.png")
