CREATE TABLE bib_autor (
	id      NUMBER NOT NULL,
	nombre  VARCHAR2(40) NOT NULL,
	fecha_ncmto    DATE,
	pais_natal     VARCHAR2(20)
);

ALTER TABLE bib_autor ADD CONSTRAINT bib_autor_pk PRIMARY KEY ( id );
ALTER TABLE bib_autor ADD CONSTRAINT bib_autor_uk UNIQUE ( nombre );

CREATE TABLE bib_categoria (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL
);

ALTER TABLE bib_categoria ADD CONSTRAINT bib_categoria_pk PRIMARY KEY ( id );
ALTER TABLE bib_categoria ADD CONSTRAINT bib_categoria_uk UNIQUE ( nombre );

CREATE TABLE bib_editorial (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2(20) NOT NULL,
    direccion    VARCHAR2(40),
    telefono      VARCHAR2(9)
);

ALTER TABLE bib_editorial ADD CONSTRAINT bib_editorial_pk PRIMARY KEY ( id );
ALTER TABLE bib_editorial ADD CONSTRAINT bib_editorial_uk UNIQUE ( nombre );

CREATE TABLE bib_libro (
    id                NUMBER NOT NULL,
    isbn              CHAR(10) NOT NULL,
    titulo            VARCHAR2(40) NOT NULL,
    fecha_publicacion DATE,
    descripcion       VARCHAR2(200),
    bib_editorial_id      NUMBER NOT NULL,
    bib_categoria_id      NUMBER NOT NULL
);

ALTER TABLE bib_libro ADD CONSTRAINT bib_libro_pk PRIMARY KEY ( id );
ALTER TABLE bib_libro ADD CONSTRAINT bib_libro_uk UNIQUE ( isbn );

CREATE TABLE bib_escribe (
	id			NUMBER NOT NULL,
	bib_autor_id	NUMBER NOT NULL,
	bib_libro_id	NUMBER NOT NULL
);

ALTER TABLE bib_escribe ADD CONSTRAINT bib_escribe_pk PRIMARY KEY ( id );

CREATE TABLE bib_ejemplar (
    id      NUMBER NOT NULL,
    estado  NUMBER DEFAULT ON NULL 1,
    bib_libro_id NUMBER NOT NULL
);

ALTER TABLE bib_ejemplar ADD CONSTRAINT bib_ejemplar_pk PRIMARY KEY ( id );

CREATE TABLE bib_alumno (
    id                NUMBER NOT NULL,
    cui               CHAR(8) NOT NULL,
    nombres           VARCHAR2(20) NOT NULL,
    apellidos         VARCHAR2(20) NOT NULL,
    email             VARCHAR2(40) NOT NULL,
    celular           VARCHAR2(9),
    fecha_nacimiento  DATE,
    provincia         VARCHAR2(40),
    distrito          VARCHAR2(40),
    avcallejiron      VARCHAR2(40),
    acerca_de         VARCHAR2(200)
);

ALTER TABLE bib_alumno ADD CONSTRAINT bib_alumno_pk PRIMARY KEY ( id );
ALTER TABLE bib_alumno ADD CONSTRAINT bib_alumno_uk UNIQUE ( cui );

CREATE TABLE bib_prestamo (
    id                NUMBER NOT NULL,
    fecha_entrega     DATE NOT NULL,
    fecha_devolucion  DATE NOT NULL,
    comentarios       VARCHAR2(50),
    bib_ejemplar_id       NUMBER NOT NULL,
    bib_alumno_id         NUMBER NOT NULL
);

ALTER TABLE bib_prestamo ADD CONSTRAINT bib_prestamo_pk PRIMARY KEY ( id );

CREATE TABLE bib_sancion (
    id           NUMBER NOT NULL,
    bib_alumno_id    NUMBER NOT NULL
);

ALTER TABLE bib_sancion ADD CONSTRAINT bib_sancion_pk PRIMARY KEY ( id );

CREATE TABLE bib_grupo (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL
);

ALTER TABLE bib_grupo ADD CONSTRAINT bib_grupo_pk PRIMARY KEY ( id );
ALTER TABLE bib_grupo ADD CONSTRAINT bib_grupo_uk UNIQUE ( nombre );

CREATE TABLE bib_usuario (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2(10) NOT NULL,
    contrasena   VARCHAR2(10) NOT NULL,
    bib_grupo_id	 NUMBER NOT NULL
);

ALTER TABLE bib_usuario ADD CONSTRAINT bib_usuario_pk PRIMARY KEY ( id );
ALTER TABLE bib_usuario ADD CONSTRAINT bib_usuario_uk UNIQUE ( nombre );

ALTER TABLE bib_ejemplar
    ADD CONSTRAINT bib_ejemplar_bib_libro_fk FOREIGN KEY ( bib_libro_id )
        REFERENCES bib_libro ( id );

ALTER TABLE bib_escribe
	ADD CONSTRAINT bib_escribe_bib_autor_fk FOREIGN KEY ( bib_autor_id )
		REFERENCES bib_autor ( id );

ALTER TABLE bib_escribe
	ADD CONSTRAINT bib_escribe_bib_libro_fk FOREIGN KEY ( bib_libro_id )
		REFERENCES bib_libro ( id );

ALTER TABLE bib_libro
    ADD CONSTRAINT bib_libro_bib_categoria_fk FOREIGN KEY (bib_categoria_id )
        REFERENCES bib_categoria ( id );

ALTER TABLE bib_libro
    ADD CONSTRAINT bib_libro_bib_editorial_fk FOREIGN KEY ( bib_editorial_id )
        REFERENCES bib_editorial ( id );

ALTER TABLE bib_prestamo
    ADD CONSTRAINT bib_prestamo_bib_alumno_fk FOREIGN KEY ( bib_alumno_id )
        REFERENCES bib_alumno ( id );

ALTER TABLE bib_prestamo
    ADD CONSTRAINT bib_prestamo_bib_ejemplar_fk FOREIGN KEY ( bib_ejemplar_id )
        REFERENCES bib_ejemplar ( id );

ALTER TABLE bib_sancion
    ADD CONSTRAINT bib_sancion_bib_alumno_fk FOREIGN KEY ( bib_alumno_id )
        REFERENCES bib_alumno ( id );

ALTER TABLE bib_usuario
    ADD CONSTRAINT bib_grupo_bib_usuario_fk FOREIGN KEY ( bib_grupo_id )
        REFERENCES bib_grupo ( id );

CREATE SEQUENCE bib_alumno_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_alumno_id_trg BEFORE
    INSERT ON bib_alumno
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_alumno_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_autor_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_autor_id_trg BEFORE
	INSERT ON bib_autor
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := bib_autor_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_categoria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_categoria_id_trg BEFORE
    INSERT ON bib_categoria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_categoria_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_editorial_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_editorial_id_trg BEFORE
    INSERT ON bib_editorial
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_editorial_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_ejemplar_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_ejemplar_id_trg BEFORE
    INSERT ON bib_ejemplar
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_ejemplar_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_escribe_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_escribe_id_trg BEFORE
	INSERT ON bib_escribe
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := bib_escribe_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_grupo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_grupo_id_trg BEFORE
    INSERT ON bib_grupo
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_grupo_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_libro_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_libro_id_trg BEFORE
    INSERT ON bib_libro
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_libro_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_prestamo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_prestamo_id_trg BEFORE
    INSERT ON bib_prestamo
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_prestamo_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_sancion_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_sancion_id_trg BEFORE
    INSERT ON bib_sancion
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_sancion_id_seq.nextval;
END;
/

CREATE SEQUENCE bib_usuario_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bib_usuario_id_trg BEFORE
    INSERT ON bib_usuario
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bib_usuario_id_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER bib_prestamo_after_insert
AFTER INSERT
	ON bib_prestamo
	FOR EACH ROW
DECLARE
BEGIN
UPDATE
	bib_ejemplar set estado = 2 where id = :new.bib_ejemplar_ID;
END;
/

CREATE OR REPLACE PROCEDURE bib_send_libros_prestados
IS
BEGIN
  FOR c1 IN (SELECT e.id
             ,      p.bib_alumno_id
             ,      TO_CHAR(p.fecha_entrega, 'DD "de" MONTH') start_time
             ,      TO_CHAR(p.fecha_devolucion, 'DD MONTH "del" YYYY') due_date
             FROM bib_prestamo p
             ,    bib_ejemplar e
             WHERE p.bib_ejemplar_id = e.id
             AND   TRUNC(p.fecha_devolucion) < SYSDATE
             AND   e.estado = 2
            ) LOOP
    FOR c2 IN (SELECT nombres
               ,      email
               FROM bib_alumno a
               WHERE a.id = c1.bib_alumno_id
               AND   a.email IS NOT NULL
              ) LOOP
      apex_mail.send (
        p_to                 => c2.email,
        p_template_static_id => 'PRESTADOS',
        p_placeholders       => '{' ||
        '    "APPLICATION_LINK":' || apex_json.stringify( apex_util.prepare_url(p_url => 'f?p=:'||v('APP_ID')||':1:' )) ||
        '   ,"START_DATE":'       || apex_json.stringify( c1.start_time ) ||
        '   ,"DUE_DATE":'         || apex_json.stringify( c1.due_date ) ||
        '   ,"INVITEE":'          || apex_json.stringify( c2.nombres ) ||
        '   ,"BIB_LIBRO":'        || apex_json.stringify( c1.id ) ||
        '}' );
    END LOOP;
  END LOOP;
END;