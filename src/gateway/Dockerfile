FROM python:3.10-slim-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential \
    && pip install --nocache-dir --upgrage pip

WORKDIR /app
COPY ./src/gateway/requirements.txt /app/
RUN pip install --no-cache-dir --requirement /app/requirements.txt

COPY ./scr/gateway/. /app/

EXPOSE 8080

CMD ["python3", "server.py"]