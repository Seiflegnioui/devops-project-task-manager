@echo off
REM Script de compilation du rapport LaTeX pour Windows
REM Usage: compile_rapport.bat

echo.
echo ================================
echo Compilation du rapport DevOps
echo ================================
echo.

REM Vérifier si pdflatex est installé
where pdflatex >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ pdflatex n'est pas installé
    echo.
    echo Installez MiKTeX depuis: https://miktex.org/
    echo.
    pause
    exit /b 1
)

echo ✓ pdflatex trouvé
echo.

REM Compilation
echo 📝 Compilation du rapport (1/2)...
pdflatex -interaction=nonstopmode -output-directory=. rapport_projet_devops.tex >nul 2>&1

REM Deuxième compilation pour la table des matières
echo 📝 Compilation du rapport (2/2 - table des matières)...
pdflatex -interaction=nonstopmode -output-directory=. rapport_projet_devops.tex >nul 2>&1

REM Vérifier le résultat
if exist "rapport_projet_devops.pdf" (
    echo.
    echo ✅ Compilation réussie!
    echo 📄 PDF généré: rapport_projet_devops.pdf
    echo.
    for %%A in (rapport_projet_devops.pdf) do (
        echo 📊 Taille du rapport: %%~zA bytes
    )
) else (
    echo.
    echo ❌ Erreur lors de la compilation
    echo Vérifiez la syntaxe LaTeX
    echo.
    pause
    exit /b 1
)

REM Nettoyage optionnel
echo.
echo 🧹 Nettoyage des fichiers temporaires...
del /Q *.aux *.log *.toc *.out 2>nul

echo ✅ Terminé!
echo.
pause
