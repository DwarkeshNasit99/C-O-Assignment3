@echo off
REM cdevops-gitea Development Deployment Script for Windows (Batch Version)
REM This script deploys Gitea in development mode using kubectl and helm directly

echo Starting cdevops-gitea Development Deployment
echo =============================================

REM Check if kubectl is available
kubectl version --client >nul 2>&1
if errorlevel 1 (
    echo kubectl is not installed. Please install kubectl first.
    pause
    exit /b 1
)

REM Check if helm is available
helm version >nul 2>&1
if errorlevel 1 (
    echo helm is not installed. Please install Helm 3.x first.
    pause
    exit /b 1
)

REM Check if Kubernetes cluster is accessible
kubectl cluster-info >nul 2>&1
if errorlevel 1 (
    echo Kubernetes cluster is not accessible. Please ensure Docker Desktop Kubernetes is running.
    echo.
    echo To fix this:
    echo 1. Open Docker Desktop
    echo 2. Go to Settings -^> Kubernetes
    echo 3. Ensure "Enable Kubernetes" is checked
    echo 4. Click "Apply ^& Restart"
    echo 5. Wait for Kubernetes to start
    echo.
    pause
    exit /b 1
)

echo Prerequisites check passed!

REM Add Gitea chart repository
echo Adding Gitea chart repository...
helm repo add gitea-charts https://dl.gitea.com/charts/
helm repo update

REM Deploy Gitea in development mode
echo Deploying Gitea in development mode...
helm install gitea gitea-charts/gitea -f gitea/values.yaml --namespace default --create-namespace

echo.
echo Gitea deployment started!
echo.
echo Next steps:
echo 1. Wait for pods to be ready: kubectl get pods -w
echo 2. Access Gitea: kubectl port-forward svc/gitea-http 3000:3000
echo 3. Visit: http://localhost:3000
echo.
echo Default credentials:
echo - Username: testuser
echo - Password: admin@123
echo - Email: admin@admin.com
echo.
pause 