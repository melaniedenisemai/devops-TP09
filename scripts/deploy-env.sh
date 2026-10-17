#!/bin/bash
set -euo pipefail
ENV="${1:-}"
if [ "$ENV" != "staging" ] && [ "$ENV" != "production" ]; then
    echo "Uso: $0 [staging|production]"
    exit 1
fi
echo -e "\n=== Desplegando en Namespace: $ENV ==="

kubectl apply -f k8s/base/01-secret.yml -n "$ENV"
kubectl apply -f k8s/base/02-pvc.yml -n "$ENV"
kubectl apply -f k8s/base/03-postgres-deployment.yml -n "$ENV"
kubectl apply -f k8s/base/04-postgres-service.yml -n "$ENV"
kubectl apply -f k8s/base/05-configmap.yml -n "$ENV"
kubectl apply -f k8s/base/06-backend-deployment.yml -n "$ENV"
kubectl apply -f k8s/base/07-backend-service.yml -n "$ENV"
kubectl apply -f k8s/base/08-frontend-deployment.yml -n "$ENV"
kubectl apply -f k8s/base/09-frontend-service.yml -n "$ENV"

echo "Esperando consolidacion del despliegue en $ENV..."
kubectl rollout status deployment/notes-backend -n "$ENV" --timeout=90s
echo -e "[OK] Despliegue completado con exito en $ENV\n"
