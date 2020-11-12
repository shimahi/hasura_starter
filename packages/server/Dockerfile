FROM python:3.8-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY pyproject.toml poetry.lock ./

RUN python -m pip install --upgrade pip \
  pip install poetry \
  && poetry config virtualenvs.create false \
  && poetry install --no-dev

COPY . .

CMD uvicorn main:app --host 0.0.0.0  --app-dir ./app --port ${PORT}
