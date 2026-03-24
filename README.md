# Projet DevOps : Task Manager API

Ce projet est la réalisation finale du module de DevOps. Il permet de déployer une API REST Flask (Task Manager) sur une infrastructure Azure en utilisant Docker, Terraform, Ansible, Kubernetes (K3s) et un pipeline complet d'intégration et déploiement continus (CI/CD) sur GitHub Actions.

## Découpage des dossiers
- **`app/`** : Code de l'API Flask (en Python) avec le `requirements.txt`.
- **`Dockerfile`** : Fichier pour packager l'API dans un conteneur et gérer ses dépendances.
- **`terraform/`** : Infrastructure as Code pour Provisionner deux Machines Virtuelles (Master et Worker) sur Azure.
- **`ansible/`** : Playbook de configuration pour installer Docker et initialiser un cluster K3s sur nos serveurs.
- **`kubernetes/`** : Manifests (Deployment & Service) pour déployer notre API conteneurisée sur le cluster existant.
- **`.github/workflows/`** : Pipeline CI/CD pour builder, push l'image sur Dockerhub, puis la déployer avec Kubernetes.

## Déploiement étape par étape

### 1. Prérequis Globaux
- Un compte **Azure** (Free Tier est suffisant).
- La ligne de commande **Azure CLI** (`az`) installée et connectée (`az login`).
- Un compte sur **Docker Hub**.
- L'outil de versionnement GitLab/GitHub, et Terraform et Ansible en local.

### 2. Création de l'infrastructure via Terraform
1. Ouvrez un terminal dans le répertoire du projet.
2. Allez dans le dossier Terraform :
   ```bash
   cd terraform
   ```
3. Initialisez l'environnement :
   ```bash
   terraform init
   ```
4. Lancez le déploiement Azure de l'infrastructure :
   ```bash
   terraform apply --auto-approve
   ```
Cette étape générera :
- 2 VMs Azure Ubuntu (master et worker).
- Une clé privée dans `terraform/id_rsa_devops` pour le SSH.
- Un répertoire dynamique `ansible/inventory.ini` listant les IPs des machines.

### 3. Configuration automatique par Ansible
1. Allez dans le répertoire `ansible/` :
   ```bash
   cd ../ansible
   ```
2. Ajoutez les permissions nécessaires et appliquez le playbook :
   ```bash
   chmod 600 ../terraform/id_rsa_devops
   export ANSIBLE_HOST_KEY_CHECKING=False
   ansible-playbook -i inventory.ini playbook.yml
   ```
Suite au succès de l'exécution :
- Docker et K3s seront installés sur les 2 nodes.
- Un fichier `kubeconfig.yaml` sera importé dans la racine du dossier projet pour interagir avec le cluster via kubectl.

### 4. Configuration CI/CD Cloud via GitHub Actions
Poussez le projet complet sur un nouveau repository GitHub. 

Dans GitHub, allez dans **Settings > Secrets and variables > Actions > New repository secret**, et configurez ces secrets :
1. `DOCKER_USERNAME` : Votre pseudo Docker Hub (ex: `johndoe`).
2. `DOCKER_PASSWORD` : Le mot de passe (ou Access Token) de Docker Hub.
3. `KUBECONFIG` : Le contenu littéral entier du fichier `kubeconfig.yaml` qui se trouve à la racine. 
   ⭐ **TRÈS IMPORTANT** : Remplacez impérativement `127.0.0.1` par l'adresse IP "master_public_ip" (produite par les logs Terraform) à l'intérieur de ce fichier juste avant de le copier/coller dans Github.

Un commit/push déclenchera dorénavant `.github/workflows/ci-cd.yml` de façon autonome !

### 5. Utilisation et tests
L'application est publiquement accessible sur l'une des machines Azure en utilisant le **NodePort `30080`**.
Ouvrez votre navigateur ou utilisez `curl` :

```bash
# Vérifier la santé du service :
curl http://<IP_PUBLIQUE_MASTER_OU_WORKER>:30080/health

# Récupérer les tâches :
curl http://<IP_PUBLIQUE_MASTER_OU_WORKER>:30080/tasks

# Publier une tâche :
curl -X POST -H "Content-Type: application/json" -d '{"title":"Projet final de DevOps validé"}' http://<IP_PUBLIQUE_MASTER_OU_WORKER>:30080/tasks
```
