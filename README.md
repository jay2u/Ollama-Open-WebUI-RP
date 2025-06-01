> 🔄 Updated every 8 hours to always stay on the latest version.
> You can access Open WebUI (port: 8080), search for a model in the top-left "Select a model" section, and pull it from ollama.com. (For a list of available models, visit **<https://ollama.com/models>**) \
> If the model isn't available, download it from Hugging Face and import it manually.

### 🔌 Exposed Ports

| Port | Type | Purpose    |
| ---- | ---- | ---------- |
| 22   | TCP  | SSH        |
| 8080 | HTTP | Open WebUI |
| 8888 | HTTP | JupyterLab |

### 🏷️ Tag Structure

* `cu124`, `cu126`, `cu128`: CUDA version (12.4 / 12.6 / 12.8)

---

### 🧱 Image Matrix

| Image Name                                      | CUDA |
| ----------------------------------------------- | ---- |
| `sombi/ollama-open-webui:base-torch2.7.0-cu124` | 12.4 |
| `sombi/ollama-open-webui:base-torch2.7.0-cu126` | 12.6 |
| `sombi/ollama-open-webui:base-torch2.7.0-cu128` | 12.8 |

To change images: Go to **Edit Pod/Template** → Set `Container Image`.

---

### ⚙️ Environment Variables

| Variable                 | Description                                                                                 | Default   |
| ------------------------ | ------------------------------------------------------------------------------------------- | --------- |
| `JUPYTERLAB_PASSWORD`    | Password for JupyterLab                                                         | (unset)   |
| `TIME_ZONE`              | [Timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) (e.g., `Asia/Seoul`)                                                               | `Etc/UTC` |
| `OLLAMA_MODELS`          | Path to the models directory.                                               | `/workspace/models` |
| `DATA_DIR`               | (Open WebUI) Base directory for data storage.                              | `/workspace/data` |
| `WEBUI_AUTH`             | (Open WebUI) Enables (`True`) or disables (`False`) authentication. `False` runs Single-User Mode (no login). | `False` |

To set: **Edit Pod/Template** → **Add Environment Variable** (Key/Value)

> Refer to the official docs to add environment variables for [**Ollama**](https://github.com/ollama/ollama/issues/2941#issuecomment-2322778733) or [**Open WebUI**](https://docs.openwebui.com/getting-started/env-configuration) if needed.
> For `WEBUI_AUTH`, If set to False, authentication is disabled for your Open WebUI instance. However, this can only be done on fresh installations with no existing users. If users are registered, authentication cannot be disabled. Ensure the database is empty before turning off `WEBUI_AUTH`.

### 📁 Logs

| App        | Location                       |
|------------|--------------------------------|
| JupyterLab | /workspace/logs/jupyterlab.log |
| Ollama     | /workspace/logs/ollama.log     |

---

### 🧩 Pre-Installed Components

#### **System**

* **OS**: Ubuntu 22.04
* **Python**: 3.11
* **Framework**: Ollama + Open WebUI + JupyterLab
* **Libraries**: PyTorch 2.7.0, CUDA (12.4–12.8), Triton, [hf\_hub](https://huggingface.co/docs/huggingface_hub), [nvtop](https://github.com/Syllo/nvtop)

---

💬 Feedback & Issues → [GitHub Issues](https://github.com/somb1/Ollama-Open-WebUI-RP/issues)

---
