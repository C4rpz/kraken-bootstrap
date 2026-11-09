FROM python:3.12-slim
WORKDIR /app

# Dépendances d'abord : cette couche reste en cache tant que requirements.txt ne change pas
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Utilisateur non-root (uid 1000) ; /app lui appartient pour créer ./output
RUN useradd --create-home --uid 1000 app && chown app:app /app
COPY --chown=app:app app ./app
COPY --chown=app:app data ./data
USER app

ENV OUTPUT_DIR=output
CMD ["python", "-m", "app.main"]
