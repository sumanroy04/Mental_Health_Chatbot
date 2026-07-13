# Patronus AI - Streamlit Application (Standalone Edition)

This directory contains only the code and dependencies required to run the **Streamlit** client for Patronus AI. The FastAPI server and React frontends have been excluded to keep the setup minimal and focused.

## Directory Structure

```
streamlit_only/
├── backend/
│   ├── streamlit_app.py      # Streamlit Main App entry point
│   ├── app/
│   │   ├── __init__.py       # Package init (isolated)
│   │   ├── config.py         # App Paths & API keys loader
│   │   └── constants.py      # Tone, system and topic prompts
│   └── chatbot/
│       ├── __init__.py       # Package init
│       ├── knowledge_base.py # RAG/Vector store utilities
│       ├── processor.py      # Text processing & crisis classification
│       ├── rag_engine.py     # LangChain conversation chains config
│       └── response.py       # API reply generator
├── requirements.txt          # Python dependencies
├── .env.example              # Template for API keys
└── run_streamlit.ps1         # Setup and launcher script
```

## Running the Application

### 1. Automatically (Windows PowerShell)

Run the launcher script. It will automatically copy your existing `data-storage` and `.env` files from the main project workspace, create a virtual environment, install the dependencies, and start the app:

```powershell
./run_streamlit.ps1
```

### 2. Manually (Any OS)

If you are not using PowerShell or prefer to run it step-by-step:

1. **Copy the `data-storage` directory** containing the PDF files, images, and built vector database (`vector_db_dir`) from the parent project into the `streamlit_only` folder:
   ```bash
   cp -r ../data-storage ./data-storage
   ```
2. **Copy or create your `.env` file**:
   ```bash
   cp ../.env ./.env
   # OR copy .env.example to .env and fill in your GROQ_API_KEY
   ```
3. **Setup and activate a virtual environment**:
   ```bash
   python -m venv .venv
   # Windows:
   .venv\Scripts\activate
   # macOS/Linux:
   source .venv/bin/activate
   ```
4. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```
5. **Run the Streamlit application**:
   ```bash
   streamlit run backend/streamlit_app.py
   ```
