FROM python:3.10-slim-bullseye

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential default-libmysqlclient-dev \
    && pip install --no-cache-dir --upgrade pip

WORKDIR /app
#If you are running build command for this service use this COPY command to avoid context error.
COPY ./src/auth/requirements.txt /app
#in case you are running command in same directory use thsi COPY command instead.

## COPY ./requirements.txt /app

RUN pip install --no-cache-dir --requirement /app/requirements.txt

COPY . /app

EXPOSE 5000

CMD ["python3", "server.py"]