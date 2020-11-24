### Proceso de instalación de Docker

  - yum install bash-completion
  - yum install epel-release
  - yum install yum-utils
  - yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  - yum install docker-ce docker-ce-cli containerd.io
  - systemctl enable docker
  - systemctl start docker

### Comandos para docker

- docker container ls -a  // muestra los contenedores activos y no activos
- docker ps  // // muestra los contenedores
- docker image ls -a // muestra la imagenes descargadas en mi docker
