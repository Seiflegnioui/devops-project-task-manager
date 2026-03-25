#!/bin/bash

# Script de compilation du rapport LaTeX
# Usage: ./compile_rapport.sh

echo "================================"
echo "Compilation du rapport DevOps"
echo "================================"
echo ""

# Vérifier si pdflatex est installé
if ! command -v pdflatex &> /dev/null
then
    echo "❌ pdflatex n'est pas installé"
    echo "Sur Windows, installez MiKTeX (https://miktex.org/)"
    echo "Sur Linux: apt-get install texlive-full"
    echo "Sur Mac: brew install basictex"
    exit 1
fi

echo "✓ pdflatex trouvé"
echo ""

# Compilation
echo "📝 Compilation du rapport..."
pdflatex -interaction=nonstopmode -output-directory=. rapport_projet_devops.tex > /dev/null 2>&1

# Deuxième compilation pour générer la table des matières
echo "📝 Deuxième compilation (table des matières)..."
pdflatex -interaction=nonstopmode -output-directory=. rapport_projet_devops.tex > /dev/null 2>&1

# Vérifier le résultat
if [ -f "rapport_projet_devops.pdf" ]; then
    echo ""
    echo "✅ Compilation réussie!"
    echo "📄 PDF généré: rapport_projet_devops.pdf"
    echo ""
    # Afficher la taille du fichier
    SIZE=$(du -h rapport_projet_devops.pdf | cut -f1)
    echo "📊 Taille du rapport: $SIZE"
else
    echo ""
    echo "❌ Erreur lors de la compilation"
    echo "Vérifiez les erreurs ci-dessus"
    exit 1
fi

# Nettoyage des fichiers temporaires (optionnel)
echo ""
echo "🧹 Nettoyage des fichiers temporaires..."
rm -f *.aux *.log *.toc *.out 2>/dev/null

echo "✅ Terminé!"
