FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Run on port 80 so container platform can map it easily
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
