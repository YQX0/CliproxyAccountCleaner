FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY CliproxyAccountCleaner.py /app/
COPY cliproxy_web_mode.py /app/
COPY config.example.json /app/config.json

RUN pip install --no-cache-dir requests aiohttp

EXPOSE 8765

# 启动时优先使用 Secret File，否则用默认配置
CMD ["sh", "-c", "[ -f /etc/secrets/config.json ] && cp /etc/secrets/config.json /app/config.json; python CliproxyAccountCleaner.py --host 0.0.0.0 --port ${PORT:-8765} --no-browser"]
