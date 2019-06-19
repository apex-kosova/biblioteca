CREATE TABLE autor (
	id			NUMBER NOT NULL,
	nombres		VARCHAR2(20) NOT NULL,
	apellidos	VARCHAR2(20) NOT NULL,
	fecha_nacimiento	DATE,
	nacionalidad		VARCHAR2(20)
);

ALTER TABLE autor ADD CONSTRAINT autor_pk PRIMARY KEY ( id );

CREATE TABLE escribe (
	id			NUMBER NOT NULL,
	autor_id	NUMBER NOT NULL,
	libro_id	NUMBER NOT NULL
);

ALTER TABLE escribe ADD CONSTRAINT escribe_pk PRIMARY KEY ( id );

ALTER TABLE escribe
	ADD CONSTRAINT escribe_autor_fk FOREIGN KEY ( autor_id )
		REFERENCES autor ( id );

ALTER TABLE escribe
	ADD CONSTRAINT escribe_libro_fk FOREIGN KEY ( libro_id )
		REFERENCES libro ( id );

ALTER TABLE ejemplar ADD estado varchar2(20) DEFAULT 'Disponible';

ALTER TABLE libro DROP COLUMN autor;
ALTER TABLE libro MODIFY descripcion VARCHAR2(200);

ALTER TABLE alumno
	MODIFY (email					VARCHAR2(40) NOT NULL,
					provincia			VARCHAR2(40),
					distrito			VARCHAR2(40),
					avcallejiron	VARCHAR2(40));

CREATE SEQUENCE autor_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER autor_id_trg BEFORE
	INSERT ON autor
	FOR EACH ROW
	WHEN ( new.id IS NULL )
BEGIN
	:new.id := autor_id_seq.nextval;
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

CREATE OR REPLACE TRIGGER prestamo_after_insert
AFTER INSERT
	ON prestamo
	FOR EACH ROW
DECLARE
BEGIN
UPDATE
	ejemplar set estado = 'Prestado' where id = :new.EJEMPLAR_ID;
END;
/
