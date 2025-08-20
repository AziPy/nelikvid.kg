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

# Используем официальный образ Python
# Используем официальный образ Python
FROM python:3.12-slim

# Рабочая директория
WORKDIR /app

# Системные зависимости для сборки пакетов
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Poetry
RUN pip install --no-cache-dir poetry

# Копируем файлы зависимостей
COPY pyproject.toml ./
COPY poetry.lock* ./

# Настройка Poetry и установка зависимостей
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Копируем весь проект
COPY . .

# Пробрасываем порт 5000
EXPOSE 5000

# Запуск Django dev-сервера
CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:5000"]
