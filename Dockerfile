FROM python:3.13-slim

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

EXPOSE 5000

RUN useradd --create-home appuser
USER appuser

CMD ["python", "app.py"]