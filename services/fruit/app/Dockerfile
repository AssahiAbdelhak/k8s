FROM python

WORKDIR /app

COPY requirements.txt ./requirements.txt

RUN pip install -r ./requirements.txt

COPY *.py ./

COPY db/connection.py ./db/connection.py
COPY db/functions.py ./db/functions.py

EXPOSE 5000

CMD ["python", "main.py"]