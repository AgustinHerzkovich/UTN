# Comandos de Git
## 1. Configuración inicial
- **Configurar nombre de usuario**
``` bash
git config --global user.name "Nombre"
```
- **Configurar email**
``` bash
git config --global user.email "Mail"
```
## 2. Inicializar un repositorio vacío
- **Crear repositorio vacío**
``` bash
git init
```
## 3. Verificar el estado del repositorio
- **Verificar estado de los archivos**
``` bash
git status
```
## 4. Añadir archivos al área de preparación (staging)
- **Añadir archivo al área de preparación**
``` bash
git add <archivo>
```
- **Añadir todos los archivos modificados al área de preparación**
``` bash
git add .
```
## 5. Hacer un commit
- **Crear commit con los cambios preparados**
``` bash
git commit -m "Mensaje"
```
## 6. Ver el historial de commits
- **Mostrar historial de commits**
``` bash
git log
```
- **Mostrar historial de commits en una línea**
``` bash
git log --oneline
```
## 7. Clonar un repositorio
- **Clonar repositorio**
``` bash
git clone <url-repo>
```
## 8. Ramas (branches)
- **Mostrar ramas locales**
``` bash
git branch
```
- **Crear rama local**
``` bash
git branch <rama>
```
- **Traer las ramas remotas al local**
``` bash
git fetch
```
- **Cambiar de rama**
``` bash
git checkout <rama>
```
- **Crear y cambiar de rama**
``` bash
git checkout -b <rama>
```
- **Eliminar rama**
``` bash
git branch -d <rama>
```
## 9. Fusionar ramas (merge)
- **Fusionar rama con la actual**
``` bash
git merge <rama>
```
## 10. Sincronización con repositorio remoto
- **Mostrar repositorios remotos**
``` bash
git remote -v
```
- **Añade un repositorio remoto con el alias origin**
``` bash
git remote add origin <url-repo>
```
- **Sube los commits de la rama especificada al repositorio remoto**
``` bash
git push origin <rama>
```
- **Trae los cambios de la rama remota y los fusiona con la local**
``` bash
git pull origin <rama>
```
## 11. Descartar cambios
- **Restaura el archivo al último commit descartando los cambios sin subir**
``` bash
git checkout -- <archivo>
```
- **Revierte todos los cambios al último commit**
``` bash
git reset --hard
```
- **Muestra diferencias entre los archivos modificados y la última versión de ellos subida**
``` bash
git diff
```
- **Elimina un archivo del repositorio remoto y lo marca para ser eliminado en el próximo commit**
``` bash
git rm <archivo>
```
## 12. Tags
- **Ver todos los tags**
``` bash
git tag
```
- **Ver detalles de un tag**
``` bash
git show <tag>
```
- **Listar tags con más información**
``` bash
git show-ref --tags
```