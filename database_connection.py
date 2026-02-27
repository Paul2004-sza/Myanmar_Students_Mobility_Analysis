import os
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

def get_engine():
    connection_url = URL.create(
        drivername="mysql+pymysql",
        username=os.getenv("DB_USERNAME"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        database=os.getenv("DB_NAME"),
    )

    engine = create_engine(connection_url)
    return engine


def load_data():
    engine = get_engine()
    df = pd.read_sql("SELECT * FROM survey_responses", engine)
    return df