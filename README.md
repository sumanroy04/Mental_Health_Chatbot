# 🧠 Patronus AI - Streamlit RAG Chatbot (Standalone Edition)

Patronus AI is a modern, responsive mental health chatbot companion built using **Streamlit**, **LangChain**, and **Groq**. This standalone edition provides a focused, lightweight client-side setup for RAG (Retrieval-Augmented Generation) based conversations, utilizing clinical guidelines and policy documentation to offer informed and structured support.

---

## ✨ Features

- **📖 Knowledge Base (RAG)**: Conversational responses are grounded in a local **Chroma DB** vector database loaded with WHO clinical guidelines, national mental health policies, and healthcare service manuals (over 20 PDF documents are preloaded).
- **⚡ Advanced LLM Reasoning**: Integrated with **Groq** using the fast and powerful `llama-3.3-70b-versatile` model.
- **🎨 Interactive Tone & Focus Controls**:
  - **Mood Tuning**: Choose your mood (**Happy**, **Calm**, **Okay**, **Sad**, and **Stressed**) to adapt the assistant's voice and pace.
  - **Topic Focus**: Center discussion around specific areas (**Study Stress**, **Sleep Issues**, **Relationships**, or **Anxiety**).
- **🆘 Automated Crisis Safeguard**: Monitors inputs for self-harm and distress indicators. When triggered, it presents a highly visible HTML card containing India's national crisis helplines (including *Tele-MANAS*, *KIRAN*, *Vandrevala Foundation*, and *iCALL*).
- **🌙 Premium UI & UX**: Fully custom modern layout with styled sidebars, rounded interactive chips, support for **Light / Dark Mode**, and smooth micro-animations.
- **💾 Session Controls**: Reset conversation history or save/download logs directly from the UI.

---

## 📁 Directory Structure

```
streamlit_only/
├── backend/
│   ├── streamlit_app.py      # Main Streamlit UI entry point
│   ├── app/
│   │   ├── __init__.py       # Package initializer
│   │   ├── config.py         # Paths and API configurations
│   │   └── constants.py      # System prompts, Mood & Topic configurations
│   └── chatbot/
│       ├── __init__.py       # Package initializer
│       ├── knowledge_base.py # Chroma DB setup & document preprocessing
│       ├── processor.py      # Text filters, emoji removal, and crisis detection rules
│       ├── rag_engine.py     # Conversational retrieval chain structure
│       └── response.py       # API and LLM response router
├── data-storage/             # Local data directory for files and databases
│   ├── data/                 # PDF manuals and documents used for RAG grounding
│   ├── images/               # Visual assets (banners, icons)
│   └── vector_db_dir/        # Persisted Chroma DB files
├── requirements.txt          # Python dependencies
├── .env.example              # Environment variables template
└── run_streamlit.ps1         # Windows PowerShell launcher script
```

---

## 🛠️ Prerequisites

1. **Python**: Python 3.10 or 3.11 is recommended.
2. **Groq API Key**: Needed for LLM reasoning. Obtain one from the [Groq Console](https://console.groq.com/).
3. **Tesseract OCR (Optional)**: Required on Windows if you plan to extract text from scanned PDFs. The application searches for `C:\Program Files\Tesseract-OCR\tesseract.exe` by default.

---

## 🚀 Running the Application

### Option A: Automatic Setup (Windows PowerShell)

The project includes a launcher script that handles setting up folder structures, copying local configurations/data-storage from a parent directory (if present), creating a virtual environment, and starting the server.

1. Open PowerShell in the project directory.
2. Execute the launcher script:
   ```powershell
   ./run_streamlit.ps1
   ```
3. If this is your first run, a new `.env` file will be created. Open it and fill in your `GROQ_API_KEY`.

---

### Option B: Manual Setup (Any OS)

If you are on macOS/Linux, or prefer executing step-by-step:

#### 1. Setup Data Folders & Env File
- Create a directory named `data-storage` containing three subfolders: `data`, `images`, and `vector_db_dir`. Place your reference PDFs in `data-storage/data/` and UI images in `data-storage/images/`.
- Copy `.env.example` to `.env`:
  ```bash
  cp .env.example .env
  ```
- Open `.env` and configure your API key:
  ```env
  GROQ_API_KEY=your_actual_groq_api_key
  ```

#### 2. Create and Activate Virtual Environment
```bash
python -m venv .venv

# Windows:
.venv\Scripts\activate

# macOS / Linux:
source .venv/bin/activate
```

#### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

#### 4. Run the App
```bash
streamlit run backend/streamlit_app.py
```

---

## 🔄 Rebuilding the Knowledge Base (ChromaDB)

The Chroma DB vector store is automatically loaded from the `data-storage/vector_db_dir` directory. If you add new PDF manuals to `data-storage/data/` or modify existing ones, you can rebuild the database by running:

```bash
# Ensure your virtual environment is activated and you are in the project root
python -c "from backend.chatbot.knowledge_base import rebuild_vectorstore; rebuild_vectorstore()"
```
This command parses all PDF documents under `data-storage/data/`, splits them, runs local embeddings via `HuggingFaceEmbeddings` (using sentence-transformers), and saves the index to `data-storage/vector_db_dir`.

---

## 🔒 Safety and Medical Disclaimer

Patronus AI is an informational tool designed to support general mental well-being and provide educational resources. It does **not** provide clinical diagnosis, medical prescriptions, or therapy. 

If you or someone you know is in immediate distress or having thoughts of self-harm, please refer to the emergency contact resources loaded directly within the app or dial **112** (in India) immediately.
