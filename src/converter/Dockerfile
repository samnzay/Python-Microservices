FROM python:3.10-slim-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential ffmpeg \
    && pip install --no-cache-dir --upgrade pip

WORKDIR /app
COPY ./src/converter/requirements.txt /app/
RUN pip install --no-cache-dir --requirement /app/requirements.txt

COPY ./src/converter/. /app


CMD ["python3", "consummer.py"] 