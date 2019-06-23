CREATE TABLE autor (
	id			NUMBER NOT NULL,
	nombres		VARCHAR2(20) NOT NULL,
	apellidos	VARCHAR2(20) NOT NULL,
	fecha_nacimiento	DATE,
	nacionalidad		VARCHAR2(20)
);

ALTER TABLE autor ADD CONSTRAINT autor_pk PRIMARY KEY ( id );

CREATE TABLE categoria (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id );

CREATE TABLE editorial (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2(20) NOT NULL,
    direccion    VARCHAR2(40) NOT NULL
);

ALTER TABLE editorial ADD CONSTRAINT editorial_pk PRIMARY KEY ( id );

CREATE TABLE libro (
    id                NUMBER NOT NULL,
    isbn              CHAR(10) NOT NULL,
    titulo            VARCHAR2(40) NOT NULL,
    fecha_publicacion DATE,
    descripcion       VARCHAR2(200),
    editorial_id      NUMBER NOT NULL,
    categoria_id      NUMBER NOT NULL
);

ALTER TABLE libro ADD CONSTRAINT libro_pk PRIMARY KEY ( id );
ALTER TABLE libro ADD CONSTRAINT libro_uk UNIQUE ( isbn );

CREATE TABLE escribe (
	id			NUMBER NOT NULL,
	autor_id	NUMBER NOT NULL,
	libro_id	NUMBER NOT NULL
);

ALTER TABLE escribe ADD CONSTRAINT escribe_pk PRIMARY KEY ( id );

CREATE TABLE ejemplar (
    id           NUMBER NOT NULL,
    libro_id	 NUMBER NOT NULL,
    estado       NUMBER DEFAULT (1)
);

ALTER TABLE ejemplar ADD CONSTRAINT ejemplar_pk PRIMARY KEY ( id );

CREATE TABLE alumno (
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

ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY ( id );
ALTER TABLE alumno ADD CONSTRAINT alumno_uk UNIQUE ( cui );

CREATE TABLE prestamo (
    id                NUMBER NOT NULL,
    fecha_entrega     DATE NOT NULL,
    fecha_devolucion  DATE NOT NULL,
    comentarios       VARCHAR2(50),
    ejemplar_id       NUMBER NOT NULL,
    alumno_id         NUMBER NOT NULL
);

ALTER TABLE prestamo ADD CONSTRAINT prestamo_pk PRIMARY KEY ( id );

CREATE TABLE sancion (
    id           NUMBER NOT NULL,
    alumno_id    NUMBER NOT NULL
);

ALTER TABLE sancion ADD CONSTRAINT sancion_pk PRIMARY KEY ( id );

CREATE TABLE grupo (
    id       NUMBER NOT NULL,
    nombre   VARCHAR2(20) NOT NULL
);

ALTER TABLE grupo ADD CONSTRAINT grupo_pk PRIMARY KEY ( id );

CREATE TABLE usuario (
    id           NUMBER NOT NULL,
    nombre       VARCHAR2(10),
    contrasena   VARCHAR2(10),
    grupo_id	 NUMBER NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id );

ALTER TABLE ejemplar
    ADD CONSTRAINT ejemplar_libro_fk FOREIGN KEY ( libro_id )
        REFERENCES libro ( id );

ALTER TABLE escribe
	ADD CONSTRAINT escribe_autor_fk FOREIGN KEY ( autor_id )
		REFERENCES autor ( id );

ALTER TABLE escribe
	ADD CONSTRAINT escribe_libro_fk FOREIGN KEY ( libro_id )
		REFERENCES libro ( id );

ALTER TABLE libro
    ADD CONSTRAINT libro_categoria_fk FOREIGN KEY (categoria_id )
        REFERENCES categoria ( id );

ALTER TABLE libro
    ADD CONSTRAINT libro_editorial_fk FOREIGN KEY ( editorial_id )
        REFERENCES editorial ( id );

ALTER TABLE prestamo
    ADD CONSTRAINT prestamo_alumno_fk FOREIGN KEY ( alumno_id )
        REFERENCES alumno ( id );

ALTER TABLE prestamo
    ADD CONSTRAINT prestamo_ejemplar_fk FOREIGN KEY ( ejemplar_id )
        REFERENCES ejemplar ( id );

ALTER TABLE sancion
    ADD CONSTRAINT sancion_alumno_fk FOREIGN KEY ( alumno_id )
        REFERENCES alumno ( id );

ALTER TABLE usuario
    ADD CONSTRAINT grupo_usuario_fk FOREIGN KEY ( grupo_id )
        REFERENCES grupo ( id );

CREATE SEQUENCE alumno_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER alumno_id_trg BEFORE
    INSERT ON alumno
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := alumno_id_seq.nextval;
END;
/

CREATE SEQUENCE autor_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER autor_id_trg BEFORE
	INSERT ON autor
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := autor_id_seq.nextval;
END;
/

CREATE SEQUENCE categoria_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER categoria_id_trg BEFORE
    INSERT ON categoria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := categoria_id_seq.nextval;
END;
/

CREATE SEQUENCE editorial_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER editorial_id_trg BEFORE
    INSERT ON editorial
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := editorial_id_seq.nextval;
END;
/

CREATE SEQUENCE ejemplar_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER ejemplar_id_trg BEFORE
    INSERT ON ejemplar
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := ejemplar_id_seq.nextval;
END;
/

CREATE SEQUENCE escribe_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER escribe_id_trg BEFORE
	INSERT ON escribe
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := escribe_id_seq.nextval;
END;
/

CREATE SEQUENCE grupo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER grupo_id_trg BEFORE
    INSERT ON grupo
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := grupo_id_seq.nextval;
END;
/

CREATE SEQUENCE libro_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER libro_id_trg BEFORE
    INSERT ON libro
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := libro_id_seq.nextval;
END;
/

CREATE SEQUENCE prestamo_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER prestamo_id_trg BEFORE
    INSERT ON prestamo
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := prestamo_id_seq.nextval;
END;
/

CREATE SEQUENCE sancion_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER sancion_id_trg BEFORE
    INSERT ON sancion
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := sancion_id_seq.nextval;
END;
/

CREATE SEQUENCE usuario_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER usuario_id_trg BEFORE
    INSERT ON usuario
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := usuario_id_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER prestamo_after_insert
AFTER INSERT
	ON prestamo
	FOR EACH ROW
DECLARE
BEGIN
UPDATE
	ejemplar set estado = 2 where id = :new.EJEMPLAR_ID;
END;
/
