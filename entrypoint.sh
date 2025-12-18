#!/bin/sh
set -e

echo "Starting Ollama..."
ollama serve &

# Wait for the API to start
echo "Waiting for Ollama API..."
until curl -s http://127.0.0.1:11434/api/tags >/dev/null 2>&1; do
  sleep 2
done

echo "Pulling model ${OLLAMA_MODEL:-qwen3:8b} ..."
ollama pull "${OLLAMA_MODEL:-qwen3:8b}" || echo "Model pull failed (continuing)"

# Keep Ollama running in foreground so container stays alive
echo "Ollama is ready and serving..."
wait -n