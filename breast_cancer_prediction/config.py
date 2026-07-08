import os
import sys
from pathlib import Path

from dotenv import load_dotenv
from loguru import logger

# Use UTF-8 on Windows so Rich/log output can print emoji and other Unicode.
if sys.platform == "win32":
    os.environ.setdefault("PYTHONIOENCODING", "utf-8")
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8")
            except (AttributeError, OSError, ValueError):
                pass

# Load environment variables from .env file if it exists
load_dotenv()

try:
    # Paths
    logger.info("config.py: START")
    PROJ_ROOT = Path(__file__).resolve().parents[1]
    logger.info(f"PROJ_ROOT path is: {PROJ_ROOT}")

    # data paths
    DATA_DIR = PROJ_ROOT / "data"
    RAW_DATA_DIR = DATA_DIR / "raw"
    INTERIM_DATA_DIR = DATA_DIR / "interim"
    PROCESSED_DATA_DIR = DATA_DIR / "processed"
    RESULT_DATA_DIR = DATA_DIR / "result"

    # model path (pkl)
    MODELS_DIR = PROJ_ROOT / "models"

    # figure paths
    REPORTS_DIR = PROJ_ROOT / "reports"
    FIGURES_DIR = REPORTS_DIR / "figures"
    
    logger.info("config.py: DONE")
except Exception:
    logger.info("config.py error occured.")
