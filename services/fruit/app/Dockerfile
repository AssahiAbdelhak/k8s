FROM python:3.13-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r ./requirements.txt

COPY main.py ./
COPY routes.py ./

COPY db/connection.py ./db/connection.py
COPY db/functions.py ./db/functions.py

EXPOSE 5000

CMD ["python", "main.py"]