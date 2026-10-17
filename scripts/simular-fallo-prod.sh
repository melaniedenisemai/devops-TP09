#!/bin/bash
set -euo pipefail
echo -e "\033[1;31m=== LANZANDO RELEASE CORRUPTO EN PRODUCCION ===\033[0m"
kubectl set image deployment/notes-backend backend=redis:alpine-nonexistent -n production
