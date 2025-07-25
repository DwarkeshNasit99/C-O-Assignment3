# cdevops-gitea Development Deployment Script for Windows

Write-Host "Starting cdevops-gitea Development Deployment" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Check if kubectl is available
try {
    kubectl version --client | Out-Null
    Write-Host "kubectl is available" -ForegroundColor Green
} catch {
    Write-Host "kubectl is not installed. Please install kubectl first." -ForegroundColor Red
    exit 1
}

# Check if helm is available
try {
    helm version | Out-Null
    Write-Host "helm is available" -ForegroundColor Green
} catch {
    Write-Host "helm is not installed. Please install Helm 3.x first." -ForegroundColor Red
    exit 1
}

# Check if Kubernetes cluster is accessible
try {
    kubectl cluster-info | Out-Null
    Write-Host "Kubernetes cluster is accessible" -ForegroundColor Green
} catch {
    Write-Host "Kubernetes cluster is not accessible. Please ensure you have a running cluster." -ForegroundColor Red
    exit 1
}

# Add Gitea chart repository
Write-Host "Adding Gitea chart repository..." -ForegroundColor Yellow
helm repo add gitea-charts https://dl.gitea.com/charts/
helm repo update

# Deploy Gitea in development mode
Write-Host "Deploying Gitea in development mode..." -ForegroundColor Yellow
helm install gitea gitea-charts/gitea -f gitea/values.yaml --namespace default --create-namespace

Write-Host ""
Write-Host "Gitea deployment started!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Wait for pods to be ready: kubectl get pods -w" -ForegroundColor White
Write-Host "2. Access Gitea: kubectl port-forward svc/gitea-http 3000:3000" -ForegroundColor White
Write-Host "3. Visit: http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "Default credentials:" -ForegroundColor Cyan
Write-Host "- Username: testuser" -ForegroundColor White
Write-Host "- Password: admin@123" -ForegroundColor White
Write-Host "- Email: admin@admin.com" -ForegroundColor White 