# Sistema de gestión de biblioteca

## Instalación
Este proyecto hace uso de una [caja de vagrant](https://github.com/oracle/vagrant-boxes/tree/master/OracleAPEX), la cual nos provee la plataforma de desarrollo APEX de Oracle.
### Prerequisitos
1. Instalar [VirtualBox de Oracle](https://www.virtualbox.org/wiki/Downloads).
2. Instalar [Vagrant](https://vagrantup.com/).
### Ejecución
1. Clonar este repositorio.
2. Moverse al directorio clonado (carpeta principal).
3. Descargar el instalador de la base de datos Oracle XE en formato .rpm y guardarlo en la carpeta principal. [https://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html](https://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html)
4. Descargar el instalador de APEX de Oracle y guardarlo en la carpeta principal. [https://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html](https://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html)
5. Descargar el instalador de ORDS y guardarlo en la carpeta principal. [https://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/index.html](https://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/index.html)
6. Ejecutar `vagrant up`.
## Oracle APEX
Para acceder a la plataforma de desarrollo dirigirse a la siguiente URL:
* `http://localhost:8080/ords/`
* `Workspace: internal`
* `Username: admin`
* `Password: <contraseña maestra>`
### Conectando a Oracle
* Hostname: `localhost`
* Port: `1521`
* SID: `XE`
* PDB: `XEPDB1`
* OEM port: `5500`
* APEX Admin port: `8080`
* Las contraseña maestra es: A%TrabInter%19
### La máquina virtual
* Puedes usar `sudo su - oracle` para cambiar al usuario oracle.
* El directorio de instalación de Oracle es `/opt/oracle/`.

## Lista de tareas pendientes
1. Habilitar selección de varios autores en formulario para agregar libro.
2. Tabla _escribe_ debería tener como única fila (entrada) la combinación de *autor_id* y *libro_id*.