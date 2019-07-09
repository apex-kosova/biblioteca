CREATE TABLE biblio_autor (
	id			NUMBER NOT NULL,
	nombres		VARCHAR2(20) NOT NULL,
	apellidos	VARCHAR2(20) NOT NULL,
	fecha_nacimiento	DATE,
	nacionalidad		VARCHAR2(20)
);

ALTER TABLE biblio_autor ADD CONSTRAINT biblio_autor_pk PRIMARY KEY ( id );

CREATE TABLE biblio_categoria (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL
);

ALTER TABLE biblio_categoria ADD CONSTRAINT biblio_categoria_pk PRIMARY KEY ( id );

CREATE TABLE biblio_editorial (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2(20) NOT NULL,
    direccion    VARCHAR2(40) NOT NULL
);

ALTER TABLE biblio_editorial ADD CONSTRAINT biblio_editorial_pk PRIMARY KEY ( id );

CREATE TABLE biblio_libro (
    id                NUMBER NOT NULL,
    isbn              CHAR(10) NOT NULL,
    titulo            VARCHAR2(40) NOT NULL,
    fecha_publicacion DATE,
    descripcion       VARCHAR2(200),
    biblio_editorial_id      NUMBER NOT NULL,
    biblio_categoria_id      NUMBER NOT NULL
);

ALTER TABLE biblio_libro ADD CONSTRAINT biblio_libro_pk PRIMARY KEY ( id );
ALTER TABLE biblio_libro ADD CONSTRAINT biblio_libro_uk UNIQUE ( isbn );

CREATE TABLE biblio_escribe (
	id			NUMBER NOT NULL,
	biblio_autor_id	NUMBER NOT NULL,
	biblio_libro_id	NUMBER NOT NULL
);

ALTER TABLE biblio_escribe ADD CONSTRAINT biblio_escribe_pk PRIMARY KEY ( id );

CREATE TABLE biblio_ejemplar (
    id           NUMBER NOT NULL,
    biblio_libro_id	 NUMBER NOT NULL,
    estado       NUMBER DEFAULT (1)
);

ALTER TABLE biblio_ejemplar ADD CONSTRAINT biblio_ejemplar_pk PRIMARY KEY ( id );

CREATE TABLE biblio_alumno (
    id                NUMBER NOT NULL,
    cui               CHAR(8) NOT NULL,
    nombres           VARCHAR2(20) NOT NULL,
    apellidos         VARCHAR2(20) NOT NULL,
    email             VARCHAR2(40) NOT NULL,
    fecha_nacimiento  DATE,
    provincia         VARCHAR2(40),
    distrito          VARCHAR2(40),
    avcallejiron      VARCHAR2(40)
);

ALTER TABLE biblio_alumno ADD CONSTRAINT biblio_alumno_pk PRIMARY KEY ( id );
ALTER TABLE biblio_alumno ADD CONSTRAINT biblio_alumno_uk UNIQUE ( cui );

CREATE TABLE biblio_prestamo (
    id                NUMBER NOT NULL,
    fecha_entrega     DATE NOT NULL,
    fecha_devolucion  DATE NOT NULL,
    comentarios       VARCHAR2(50),
    biblio_ejemplar_id       NUMBER NOT NULL,
    biblio_alumno_id         NUMBER NOT NULL
);

ALTER TABLE biblio_prestamo ADD CONSTRAINT biblio_prestamo_pk PRIMARY KEY ( id );

CREATE TABLE biblio_sancion (
    id           NUMBER NOT NULL,
    biblio_alumno_id    NUMBER NOT NULL
);

ALTER TABLE biblio_sancion ADD CONSTRAINT biblio_sancion_pk PRIMARY KEY ( id );

CREATE TABLE biblio_grupo (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL
);

ALTER TABLE biblio_grupo ADD CONSTRAINT biblio_grupo_pk PRIMARY KEY ( id );

CREATE TABLE biblio_usuario (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2(10),
    contrasena   VARCHAR2(10),
    biblio_grupo_id	 NUMBER NOT NULL
);

ALTER TABLE biblio_usuario ADD CONSTRAINT biblio_usuario_pk PRIMARY KEY ( id );

ALTER TABLE biblio_ejemplar
    ADD CONSTRAINT biblio_ejemplar_biblio_libro_fk FOREIGN KEY ( biblio_libro_id )
        REFERENCES biblio_libro ( id );

ALTER TABLE biblio_escribe
	ADD CONSTRAINT biblio_escribe_biblio_autor_fk FOREIGN KEY ( biblio_autor_id )
		REFERENCES biblio_autor ( id );

ALTER TABLE biblio_escribe
	ADD CONSTRAINT biblio_escribe_biblio_libro_fk FOREIGN KEY ( biblio_libro_id )
		REFERENCES biblio_libro ( id );

ALTER TABLE biblio_libro
    ADD CONSTRAINT biblio_libro_biblio_categoria_fk FOREIGN KEY (biblio_categoria_id )
        REFERENCES biblio_categoria ( id );

ALTER TABLE biblio_libro
    ADD CONSTRAINT biblio_libro_biblio_editorial_fk FOREIGN KEY ( biblio_editorial_id )
        REFERENCES biblio_editorial ( id );

ALTER TABLE biblio_prestamo
    ADD CONSTRAINT biblio_prestamo_biblio_alumno_fk FOREIGN KEY ( biblio_alumno_id )
        REFERENCES biblio_alumno ( id );

ALTER TABLE biblio_prestamo
    ADD CONSTRAINT biblio_prestamo_biblio_ejemplar_fk FOREIGN KEY ( biblio_ejemplar_id )
        REFERENCES biblio_ejemplar ( id );

ALTER TABLE biblio_sancion
    ADD CONSTRAINT biblio_sancion_biblio_alumno_fk FOREIGN KEY ( biblio_alumno_id )
        REFERENCES biblio_alumno ( id );

ALTER TABLE biblio_usuario
    ADD CONSTRAINT biblio_grupo_biblio_usuario_fk FOREIGN KEY ( biblio_grupo_id )
        REFERENCES biblio_grupo ( id );

CREATE SEQUENCE biblio_alumno_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_alumno_id_trg BEFORE
    INSERT ON biblio_alumno
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_alumno_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_autor_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_autor_id_trg BEFORE
	INSERT ON biblio_autor
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := biblio_autor_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_categoria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_categoria_id_trg BEFORE
    INSERT ON biblio_categoria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_categoria_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_editorial_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_editorial_id_trg BEFORE
    INSERT ON biblio_editorial
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_editorial_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_ejemplar_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_ejemplar_id_trg BEFORE
    INSERT ON biblio_ejemplar
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_ejemplar_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_escribe_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_escribe_id_trg BEFORE
	INSERT ON biblio_escribe
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := biblio_escribe_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_grupo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_grupo_id_trg BEFORE
    INSERT ON biblio_grupo
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_grupo_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_libro_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_libro_id_trg BEFORE
    INSERT ON biblio_libro
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_libro_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_prestamo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_prestamo_id_trg BEFORE
    INSERT ON biblio_prestamo
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_prestamo_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_sancion_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_sancion_id_trg BEFORE
    INSERT ON biblio_sancion
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_sancion_id_seq.nextval;
END;
/

CREATE SEQUENCE biblio_usuario_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER biblio_usuario_id_trg BEFORE
    INSERT ON biblio_usuario
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := biblio_usuario_id_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER biblio_prestamo_after_insert
AFTER INSERT
	ON biblio_prestamo
	FOR EACH ROW
DECLARE
BEGIN
UPDATE
	biblio_ejemplar set estado = 2 where id = :new.biblio_ejemplar_ID;
END;
/

CREATE OR REPLACE PROCEDURE "BIBLIO_SEND_LIBROS_PRESTADOS"
IS
BEGIN
  FOR c1 IN (SELECT e.id
             ,      p.biblio_alumno_id
             ,      TO_CHAR(p.fecha_devolucion, 'DD MONTH "del" YYYY') due_date
             FROM biblio_prestamo p
             ,    biblio_ejemplar e
             WHERE p.biblio_ejemplar_id = e.id
             AND   TRUNC(p.fecha_devolucion) < SYSDATE
             AND   e.estado = 2
            ) LOOP
    FOR c2 IN (SELECT nombres
               ,      email
               FROM biblio_alumno a
               WHERE a.id = c1.biblio_alumno_id
               AND   a.email IS NOT NULL
              ) LOOP
      apex_mail.send (
        p_to                 => c2.email,
        p_template_static_id => 'PRESTADOS',
        p_placeholders       => '{' ||
        '    "APPLICATION_LINK":' || apex_json.stringify( apex_util.prepare_url(p_url => 'f?p=:'||v('APP_ID')||':1:' )) ||
        '   ,"DUE_DATE":'         || apex_json.stringify( c1.due_date ) ||
        '   ,"INVITEE":'          || apex_json.stringify( c2.nombres ) ||
        '   ,"biblio_libro":'            || apex_json.stringify( c1.id ) ||
        '}' );
    END LOOP;
  END LOOP;
END;