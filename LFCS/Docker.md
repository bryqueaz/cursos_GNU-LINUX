# Proceso de instalación de Docker

  - yum install bash-completion
  - yum install epel-release
  - yum install yum-utils
  - yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  - yum install docker-ce docker-ce-cli containerd.io
  - systemctl enable docker
  - systemctl start docker

# Comandos para docker

- docker container ls -a  // muestra los contenedores activos y no activos
- docker ps  // muestra los contenedores
- docker image ls -a // muestra la imagenes descargadas
- docker search apache // para buscar imagenes
- docker search nginx
- docker pull httpd // descarga la imagen de apache
- docker run --name miprimer_container_opachito --restart=always httpd  // Crea un contenedor con la imagen de apache, con restart automatico y con el nombre miprimer_container_opachito
- docker container stop miprimer_container_opachito // detener un container
- docker container start miprimer_container_opachito // levantar contenedor
-  docker container rm miprimer_container_opachito // como eliminar con contenedor
- docker run --name miprimer_container_opachito --restart=always -d  httpd // levanta un contenedor en background
- docker exec -it miprimer_container_opachito bash // para conectar a la instancia de un docker
- docker inspect miprimer_container_opachito // obtener la configuracion del contenedor
- docker run --name miprimer_container_opachito --restart=always -v /var/www/html:/usr/local/apache2/htdocs -d  httpd // crea un contenedor donde se publica el public directory de apache
- docker run --name mitercer_container_apachito --restart=always -p 8090:80 -d httpd // para publicar el puerto 80 del contenedor en el puertp 8090 del host
