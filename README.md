Sure! Here's the final `README.md` content tailored specifically for your project at [`https://github.com/AssahiAbdelhak/k8s`](https://github.com/AssahiAbdelhak/k8s):

---

```markdown
# 🍓 Fruit Store App – Full Stack Deployment with Kubernetes

This is a full-stack fruit store application composed of a **React frontend**, a **Flask backend**, and a **PostgreSQL database**, all deployed using **Kubernetes**.

The frontend was originally a public project cloned from another developer's GitHub repository. I extended it by replacing the static data with dynamic content fetched from a Flask API I built.
```

````
## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/AssahiAbdelhak/k8s.git
cd k8s
````

---

## 🧠 Kubernetes Deployment Instructions

> ✅ **Apply the following Kubernetes manifests in the specified order:**

### a. PostgreSQL (Database)

```bash
kubectl apply -f k8s/db/service.yaml
kubectl apply -f k8s/db/statefulset.yaml
```

Wait until the pod is running:

```bash
kubectl get pods
```

---

### b. Flask Backend

```bash
kubectl apply -f k8s/backend/service.yaml
kubectl apply -f k8s/backend/deployment.yaml
```

**Forward the port** (since the service is of type `LoadBalancer`):

```bash
kubectl port-forward service/flask-app-service 5000:5000
```

---

### c. React Frontend

```bash
kubectl apply -f k8s/frontend/service.yaml
kubectl apply -f k8s/frontend/deployment.yaml
```

**Forward the port**:

```bash
kubectl port-forward service/react-app-service 3000:3000
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## 🛠️ Initialize the Database

To create the database schema:

```bash
# Get into the PostgreSQL pod
kubectl exec -it postgres-0 -- /bin/bash

# Inside the pod
psql -U <your-username> -d <your-database-name>

# Paste the contents of create_tables.sql located in 58s/base/config here
```




---

## 📎 Helpful Commands

```bash
kubectl get all
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- /bin/bash
```

---

## 📎 Repo

GitHub Repository: [AssahiAbdelhak/k8s](https://github.com/AssahiAbdelhak/k8s)
