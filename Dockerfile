# Используем Python 3.12
FROM python:3.12-slim

WORKDIR /app

# Системные зависимости
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Poetry
RUN pip install --no-cache-dir poetry

# Копируем pyproject.toml и poetry.lock (если есть)
COPY pyproject.toml poetry.lock* ./

# Настройка Poetry и установка зависимостей
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Копируем весь проект
COPY . .

# Пробрасываем порт
EXPOSE 5000

# Запуск dev-сервера Django
CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:5000"]
