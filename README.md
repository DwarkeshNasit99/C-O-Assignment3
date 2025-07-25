# Assignment 3 - Orchestration with Gitea

A Kubernetes-based Git service deployment using Gitea, demonstrating container orchestration from development (SQLite) to production (MySQL) with public exposure via ngrok.


## Quick Start

### Development Mode (SQLite) - WORKING
```bash
# Deploy Gitea with SQLite database
helm repo add gitea-charts https://dl.gitea.com/charts/
helm install gitea gitea-charts/gitea -f gitea/values.yaml --namespace default --create-namespace

# Wait for pod to be ready
kubectl get pods -w

# Access Gitea
kubectl port-forward svc/gitea-http 3000:3000
# Visit: http://localhost:3000
```

### Production Mode (MySQL + ngrok) - CONFIGURED
```bash
# Deploy production environment
ansible-playbook prod-up.yml

# Setup ngrok for public access
kubectl edit configmap ngrok-config -n ngrok
# Replace YOUR_NGROK_AUTH_TOKEN with your actual token
kubectl rollout restart deployment ngrok -n ngrok

# Access ngrok web interface
kubectl port-forward svc/ngrok 4040:80 -n ngrok
# Visit: http://localhost:4040 to get your public URL
```

## What Has Been Completed

### 1. **Gitea Helm Chart with Persistent Data** 
- Helm charts properly configured
- Persistent Volume Claims (PVC) set up for both development and production
- Repository data persistence enabled with appropriate storage sizes
- Development mode (SQLite) working with persistent storage

### 2. **External Database Configuration** 
- MySQL database configuration in `prod/values.yaml`
- Database connection parameters properly set
- Production deployment scripts ready
- Database credentials and settings configured

### 3. **ngrok Public Exposure Setup** 
- ngrok successfully installed and configured
- Public tunnel established: `https://f18c9cc30ef8.ngrok-free.app`
- Local Gitea accessible at `localhost:3000`
- Public access working via ngrok tunnel
- Separate ngrok deployment (as required by assignment)

### 4. **README.md Accuracy** 
- Comprehensive documentation
- Clear step-by-step instructions

## Management Commands

### Check Status
```bash
kubectl get pods
kubectl get services
kubectl get pvc
```

### View Logs
```bash
kubectl logs <pod-name>
kubectl logs <pod-name> -f  # Follow logs
```

### Cleanup
```bash
# Development cleanup
ansible-playbook down.yml

# Production cleanup
ansible-playbook prod-down.yml

# Manual cleanup
helm uninstall gitea
kubectl delete pvc --all
```

## Public Access Setup - WORKING

### Current Status: **PUBLIC ACCESS ACTIVE**
- **Public URL**: `https://f18c9cc30ef8.ngrok-free.app`
- **Local URL**: `http://localhost:3000`
- **Status**: **WORKING** - Gitea accessible from anywhere on the internet

### Setup Process (Completed):
1. **Install ngrok** - Version 3.24.0 installed
2. **Start ngrok tunnel** - `ngrok http 3000`
3. **Deploy Gitea** - Kubernetes deployment with persistent storage
4. **Port forward** - `kubectl port-forward svc/gitea-http 3000:3000`
5. **Access verified** - Both local and public access working

### For New Deployment:
1. **Get ngrok auth token** from [dashboard.ngrok.com](https://dashboard.ngrok.com/get-started/f18c9cc30ef8)

2. **Update ngrok configuration:**
   ```bash
   kubectl edit configmap ngrok-config -n ngrok
   ```

3. **Restart ngrok:**
   ```bash
   kubectl rollout restart deployment ngrok -n ngrok
   ```

4. **Access ngrok interface:**
   ```bash
   kubectl port-forward svc/ngrok 4040:80 -n ngrok
   # Visit: http://localhost:4040
   ```

5. **Gitea will be available at:** `https://f18c9cc30ef8.ngrok-free.app`
