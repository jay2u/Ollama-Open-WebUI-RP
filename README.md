> You can access Open WebUI (port: 8080), search for a model in the top-left "Select a model" section, and pull it from ollama.com. (For a list of available models, visit <https://ollama.com/models>). 

> If you can't find a model you like, you can download one directly from Huggingface and import it manually.

| Port | Type (HTTP/TCP) | Function     |
|------|-----------------|--------------|
| 22   | TCP             | SSH          |
| 8080 | HTTP            | Open WebUI |
| 8888 | HTTP            | JupyterLab  |
| 11434 | HTTP            | Ollama API  |

| Environment Variable     | Description                                                                 | Default      |
|--------------------------|-----------------------------------------------------------------------------|--------------|
| `JUPYTERLAB_PASSWORD`    | Set a password for JupyterLab. If not set, no password is required.         | (Not Set - No Password) |
| `TIME_ZONE`           | Sets the system timezone. If not set, defaults to `Etc/UTC`.                | `Etc/UTC`    |
| `OLLAMA_MODELS` | The path to the models directory.| `/workspace/models` |
| `DATA_DIR` | (Open WebUI) Specifies the base directory for data storage, including uploads, cache, vector database, etc. | `/workspace/data` |

> If necessary, you can refer to the official docs to add environment variables for Ollama or Open WebUI.

#### **How to use TIME_ZONE**

- Available time zones can be found at <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> (e.g., `America/New_York`, `Asia/Seoul`).

| Application | Log file                         |
|-------------|----------------------------------|
| JupyterLab  | /workspace/logs/jupyterlab.log |
| Ollama | /workspace/logs/ollama.log |

**If you have any suggestions or issues, please leave feedback at <https://github.com/somb1/Ollama-Open-WebUI-RP/issues>**

---

### **Pre-Installed Components**

#### **Base System**

- **OS**: Ubuntu 22.04
- **Framework**: Ollama + Open WebUI + JupyterLab
- **Python**: 3.11
- **Libraries**:
  - PyTorch 2.6.0
  - CUDA 12.4