## Используем официальный образ Python
#FROM python:3.12-slim
#
## Устанавливаем рабочую директорию
#WORKDIR /app
#
## Устанавливаем poetry
#RUN pip install --no-cache-dir poetry
#
## Копируем pyproject.toml и poetry.lock (чтобы зависимости кешировались правильно)
#COPY pyproject.toml poetry.lock* ./
#
## Устанавливаем зависимости (без виртуального окружения внутри контейнера)
#RUN poetry config virtualenvs.create false \
#    && poetry install --no-interaction --no-ansi
#
## Копируем исходники
#COPY . .
#
## Запуск приложения
#CMD ["poetry", "run", "python", "app.py"]



FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock* ./


RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi


COPY . .

EXPOSE 5000

CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:5000"]
