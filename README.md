# TP09 — Kubernetes: Pods, Deployments y Services

## Arquitectura del Proyecto
- **Namespace:** `devops-portfolio`
- **Postgres:** Deployment (1 réplica) + Secret + PVC (1Gi) + Service `ClusterIP` (:5432)
- **Backend (Flask):** Deployment (2 réplicas) + ConfigMap + Secret + `initContainer` + Service `ClusterIP` (:5000)
- **Frontend (Nginx):** Deployment (2 réplicas) + Service `NodePort` (:30080)

## Recursos Kubernetes
| Recurso | Función |
| --- | --- |
| `Namespace` | Aislamiento lógico de recursos (`devops-portfolio`) |
| `Secret` | Almacenamiento codificado en Base64 de credenciales |
| `ConfigMap` | Variables de entorno no sensibles de la aplicación |
| `PersistentVolumeClaim` | Solicitud de volumen persistente (1Gi) para Postgres |
| `Deployment` | Control declarativo y réplicas de los Pods |
| `Service ClusterIP` | Exposición interna para comunicación inter-pod |
| `Service NodePort` | Exposición del frontend al exterior en el puerto 30080 |
| `initContainer` | Verificación de disponibilidad de la base de datos previa al inicio |

## Despliegue y Verificación
```bash
# Desplegar toda la infraestructura
bash scripts/deploy.sh

# Ejecutar test automatizado
bash scripts/verificar.sh
