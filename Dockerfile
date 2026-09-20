FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN addgroup --system ironlatch \
    && adduser --system --ingroup ironlatch ironlatch

COPY requirements.txt .

RUN pip install \
    --no-cache-dir \
    --disable-pip-version-check \
    -r requirements.txt \
    && pip uninstall -y pip setuptools

COPY --chown=ironlatch:ironlatch app ./app

USER ironlatch

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
