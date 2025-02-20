> You can access Open WebUI (port: 8080), search for a model in the top-left "Select a model" section, and pull it from ollama.com. (For a list of available models, visit <https://ollama.com/models>). If the model isn't available, download it from Hugging Face and import it manually.

| Port | Type (HTTP/TCP) | Function     |
|------|-----------------|--------------|
| 22   | TCP             | SSH          |
| 8080 | HTTP            | Open WebUI |
| 8888 | HTTP            | JupyterLab  |
| 11434 | HTTP            | Ollama API  |

| Environment Variable     | Description                                                                 | Default      |
|--------------------------|-----------------------------------------------------------------------------|--------------|
| `JUPYTERLAB_PASSWORD`    | Password for JupyterLab. If unset, no password is required.                 | (Not Set)    |
| `TIME_ZONE`              | System timezone. Defaults to `Etc/UTC` if unset.                            | `Etc/UTC`    |
| `OLLAMA_MODELS`          | Path to the models directory.                                               | `/workspace/models` |
| `DATA_DIR`               | (Open WebUI) Base directory for data storage.                              | `/workspace/data` |
| `WEBUI_AUTH`             | (Open WebUI) Enables (`True`) or disables (`False`) authentication. `False` runs Single-User Mode (no login). | `False` |

> Refer to the official docs to add environment variables for Ollama or Open WebUI if needed.

#### **Using WEBUI_AUTH**

If set to False, authentication is disabled for your Open WebUI instance. However, this can only be done on fresh installations with no existing users. If users are registered, authentication cannot be disabled. Ensure the database is empty before turning off `WEBUI_AUTH`.

#### **Using TIME_ZONE**  

Find available time zones <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> (e.g., `America/New_York`, `Asia/Seoul`).

| Application | Log file                         |
|-------------|----------------------------------|
| JupyterLab  | /workspace/logs/jupyterlab.log |
| Ollama | /workspace/logs/ollama.log |

**For suggestions or issues, leave feedback at <https://github.com/somb1/Ollama-Open-WebUI-RP/issues>**

---

### **Pre-Installed Components**

#### **Base System**

- **OS**: Ubuntu 22.04
- **Framework**: Ollama + Open WebUI + JupyterLab
- **Python**: 3.11
- **Libraries**:
  - PyTorch 2.6.0
  - CUDA 12.4
  - huggingface_hub
  - hf_transfer
