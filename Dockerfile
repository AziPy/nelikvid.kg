# Python 3.12 slim
FROM python:3.12-slim

# Рабочая директория
WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Poetry
RUN pip install --no-cache-dir "poetry>=1.5"

# Копируем только pyproject.toml и poetry.lock (для кэширования зависимостей)
COPY pyproject.toml poetry.lock* ./

# Устанавливаем зависимости без создания виртуального окружения
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Копируем весь проект
COPY . .

# Открываем порт для Django
EXPOSE 5000

# Команда запуска Django
CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:5000"]
