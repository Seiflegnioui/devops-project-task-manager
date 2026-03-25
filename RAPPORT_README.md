# Guide de Compilation du Rapport DevOps

## 📋 Vue d'ensemble

Ce document contient les instructions pour compiler le rapport académique LaTeX du projet DevOps. Le rapport fait plus de 40 pages et couvre tous les aspects du projet.

## 📄 Fichiers du rapport

- **rapport_projet_devops.tex** : Source LaTeX principal
- **compile_rapport.sh** : Script de compilation pour Linux/Mac
- **compile_rapport.bat** : Script de compilation pour Windows

## 🔧 Configuration requise

### Sur Windows

1. **Installer MiKTeX**
   - Télécharger depuis : https://miktex.org/
   - Suivre l'installateur standard
   - Sélectionner "Install missing packages on-the-fly"

2. **Alternatively: Installer TeX Live**
   - https://www.tug.org/texlive/
   - Plus complet mais plus volumineux

### Sur Linux

```bash
# Ubuntu/Debian
sudo apt-get install texlive-full

# ou version minimale
sudo apt-get install texlive texlive-latex-extra texlive-fonts-recommended

# Fedora
sudo dnf install texlive-scheme-full
```

### Sur macOS

```bash
# Avec Homebrew
brew install basictex

# ou installer MacTeX
# https://www.tug.org/mactex/
```

## 📝 Compilation

### Option 1: Utiliser les scripts (recommandé)

#### Windows
```bash
compile_rapport.bat
```

#### Linux/Mac
```bash
chmod +x compile_rapport.sh
./compile_rapport.sh
```

### Option 2: Compilation manuelle

#### Commande simple
```bash
pdflatex rapport_projet_devops.tex
pdflatex rapport_projet_devops.tex
```

#### Avec options avancées
```bash
pdflatex -interaction=nonstopmode -output-directory=. rapport_projet_devops.tex
pdflatex -interaction=nonstopmode -output-directory=. rapport_projet_devops.tex
```

#### Avec xelatex (meilleur support des polices)
```bash
xelatex -interaction=nonstopmode rapport_projet_devops.tex
xelatex -interaction=nonstopmode rapport_projet_devops.tex
```

## ✅ Résultat

Après compilation réussie, vous obtiendrez :
- **rapport_projet_devops.pdf** : Le rapport complet en PDF

## 📊 Contenu du rapport

Le rapport inclut :

### Sections principales
1. **Introduction** - Contexte et objectifs
2. **Architecture générale** - Vue d'ensemble du projet
3. **Application Flask** - Détails de l'API REST
4. **Docker** - Containerisation et Dockerfile
5. **Terraform** - Infrastructure as Code
6. **Ansible** - Configuration automatisée
7. **Kubernetes** - Orchestration de conteneurs
8. **CI/CD** - Pipelines GitHub Actions
9. **Guide de déploiement** - Instructions complètes
10. **Maintenance et monitoring** - Bonnes pratiques

### Annexes
- Code source complet
- Configurations Terraform
- Manifests Kubernetes
- Résumé des commandes
- Ressources et références

## 🐛 Troubleshooting

### Erreur: "pdflatex not found"
- **Cause**: LaTeX n'est pas installé
- **Solution**: Installer MiKTeX, TeX Live ou MacTeX (voir configuration)

### Erreur: "Package not found"
- **Cause**: Packages LaTeX manquants
- **Solution**: 
  - MiKTeX : Activer "Install missing packages on-the-fly"
  - TeX Live : Installer texlive-full

### Erreur de compilation (erreurs de balises)
- **Cause**: Problèmes de syntaxe LaTeX
- **Solution**: 
  - Vérifier le fichier source
  - Chercher les caractères spéciaux mal échappés

### Le PDF ne se génère pas
- Essayer la compilation manuelle avec messages détaillés:
```bash
pdflatex -interaction=errorstopmode rapport_projet_devops.tex
```

## 📖 Édition du rapport

Pour modifier le rapport :

1. Ouvrir `rapport_projet_devops.tex` dans un éditeur
2. Éditeurs recommandés:
   - **VS Code** avec extension LaTeX Workshop
   - **Overleaf** (https://overleaf.com) - en ligne
   - **TeXStudio** (https://texstudio.org)
   - **WinEdt** (Windows)
   - **MacTeX Editor** (Mac)

3. Recompiler après modifications

## 📌 Notes importantes

- La compilation est exécutée **deux fois** pour générer correctement la table des matières
- Les fichiers temporaires (.aux, .log, .toc, .out) sont automatiquement nettoyés
- L'encoding UTF-8 est utilisé pour les caractères spéciaux français
- Le rapport utilise environ 40-50 pages

## 🔗 Ressources

- **Tutoriels LaTeX** : https://www.latex-tutorial.com/
- **Overleaf Documentation** : https://www.overleaf.com/learn
- **LaTeX Documentation** : https://www.ctan.org/

## Auteurs du projet

- LEGNIOUI SIFEDDINE
- LOUAT OUSSAMA
- AYOUB AFRAOUI
- KAWTAR ELBEJJAJI

## 📅 Date de création

Rapport généré pour le module MEIA - Cloud DevOps Engineering
