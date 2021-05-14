# Clona el repo por ssh o https

```
git clone git@git.gridshield.net:bryan/pruebas.git
```
# Ver el estado del repositorio y cambios realizados en el working directory
```
git status
```
# Ve el branch actual
```
git branch
```
# Ver todos branch locales y remotos
```
git branch -a 
```
# Ver branch remotos
```
git branch -r
```
# muestra donde apunta el remoto
# http://gitready.com/intermediate/2009/02/13/list-remote-branches.html
```
git remote 
```
# muestra la configuracion del remoto origin
```
git remote show origin
```
# muestra la configuracion de todas las ramas remtas
```
git ls-remote
```
# crear un branch local sobre un remoto
```
git checkout -b branch_vpn  origin/5-crear-directorio-de-imagenes
```
# hacer un pull, antes de trabajar para ver que es lo nuevo en la rama
```
git pull
```

# Se incluyen archivos y directios al repositorio
Para luego subir los cambios al repo local y remoto

# incluir archivos al stagin local
```
git add .
```
# hacer un commit al repo
```
git commit -m "[+] Se incluye archivo de configuracion del OpenVPN"
```
# Ver los logs del commit
```
git log
```
# hacer un push remoto a la rama  5-crear-directorio-de-imagenes
```
git push origin HEAD:5-crear-directorio-de-imagenes

```
# Cambiar el nombre y el correo de un repo 
```
git config user.name "Bryan Quesada Azofeifa"
git config user.email "bryanquesa@gmail.com"
```
# Cambiar el nombre y el correo de un repo de manera global
```
git config --global user.name "Bryan Quesada Azofeifa"
git config --global user.email "bryanquesa@gmail.com"
```

