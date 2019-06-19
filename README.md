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
   1. Guardar la contraseña auto-generada al término de la ejecución de este comando.
### Oracle APEX
Para acceder a la plataforma de desarrollo dirigirse a la siguiente URL:
* `http://localhost:8080/ords/`
* `Workspace: internal`
* `Username: admin`
* `Password: <auto-generada>`

La primera vez se le pedirá que cambie la contraseña por defecto de `admin`.
### Conectando a Oracle
* Hostname: `localhost`
* Port: `1521`
* SID: `XE`
* PDB: `XEPDB1`
* OEM port: `5500`
* APEX Admin port: `8080`

## Lista de tareas pendientes
1. Habilitar selección de varios autores en formulario para agregar libro.
2. Crear un _job_ para que envie un mensaje por correo a los alumnos cuyos libros prestados no son devueltos a tiempo.
3. (Mejora) Ejemplares deberían usar números para identificar los _estados_.