
CREATE SEQUENCE public.lugares_id_lugares_seq_4;

CREATE TABLE public.lugares (
                id_lugares INTEGER NOT NULL DEFAULT nextval('public.lugares_id_lugares_seq_4'),
                nombre VARCHAR(200) NOT NULL,
                direccion VARCHAR(300) NOT NULL,
                departamento VARCHAR(100) NOT NULL,
                provincia VARCHAR(100) NOT NULL,
                url VARCHAR(200) NOT NULL,
                latitud NUMERIC NOT NULL,
                longitud NUMERIC NOT NULL,
                municipio VARCHAR(100) NOT NULL,
                CONSTRAINT lugares_pk PRIMARY KEY (id_lugares)
);


ALTER SEQUENCE public.lugares_id_lugares_seq_4 OWNED BY public.lugares.id_lugares;

CREATE SEQUENCE public.fotos_id_fotos_seq;

CREATE TABLE public.fotos (
                id_fotos INTEGER NOT NULL DEFAULT nextval('public.fotos_id_fotos_seq'),
                descripcion VARCHAR(200) NOT NULL,
                url VARCHAR(300) NOT NULL,
                id_lugares INTEGER NOT NULL,
                CONSTRAINT fotos_pk PRIMARY KEY (id_fotos)
);


ALTER SEQUENCE public.fotos_id_fotos_seq OWNED BY public.fotos.id_fotos;

CREATE SEQUENCE public.horarios_id_horarios_seq;

CREATE TABLE public.horarios (
                id_horarios INTEGER NOT NULL DEFAULT nextval('public.horarios_id_horarios_seq'),
                dia VARCHAR(50) NOT NULL,
                inicio TIME NOT NULL,
                fin TIME NOT NULL,
                id_lugares INTEGER NOT NULL,
                CONSTRAINT horarios_pk PRIMARY KEY (id_horarios)
);


ALTER SEQUENCE public.horarios_id_horarios_seq OWNED BY public.horarios.id_horarios;

CREATE TABLE public.funcionalidades (
                id_funcionalidades INTEGER NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                CONSTRAINT funcionalidades_pk PRIMARY KEY (id_funcionalidades)
);


CREATE SEQUENCE public.roles_id_rol_seq;

CREATE TABLE public.roles (
                id_rol INTEGER NOT NULL DEFAULT nextval('public.roles_id_rol_seq'),
                nombre VARCHAR(100) NOT NULL,
                CONSTRAINT roles_pk PRIMARY KEY (id_rol)
);


ALTER SEQUENCE public.roles_id_rol_seq OWNED BY public.roles.id_rol;

CREATE TABLE public.privilegios (
                id_rol INTEGER NOT NULL,
                id_funcionalidades INTEGER NOT NULL,
                CONSTRAINT privilegios_pk PRIMARY KEY (id_rol, id_funcionalidades)
);


CREATE TABLE public.personas (
                id_persona INTEGER NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                primer_apellido VARCHAR(100) NOT NULL,
                ci INTEGER NOT NULL,
                fecha_nacimiento DATE NOT NULL,
                genero VARCHAR(50) NOT NULL,
                telefono_fijo INTEGER,
                celular INTEGER,
                segundo_apellido VARCHAR(100),
                complemento_ci VARCHAR,
                correo_electronico VARCHAR(100) NOT NULL,
                CONSTRAINT personas_pk PRIMARY KEY (id_persona)
);


CREATE TABLE public.usuarios (
                id_persona INTEGER NOT NULL,
                usuario VARCHAR(50) NOT NULL,
                contrasena VARCHAR(200) NOT NULL,
                CONSTRAINT usuarios_pk PRIMARY KEY (id_persona)
);


CREATE UNIQUE INDEX usuarios_idx
 ON public.usuarios
 ( usuario );

CREATE TABLE public.favoritos (
                id_persona INTEGER NOT NULL,
                id_lugares INTEGER NOT NULL,
                CONSTRAINT favoritos_pk PRIMARY KEY (id_persona, id_lugares)
);


CREATE SEQUENCE public.comentarios_id_comentarios_seq;

CREATE TABLE public.comentarios (
                id_comentarios INTEGER NOT NULL DEFAULT nextval('public.comentarios_id_comentarios_seq'),
                comentario VARCHAR(500) NOT NULL,
                calificacion INTEGER NOT NULL,
                fecha_comentario DATE NOT NULL,
                id_persona INTEGER NOT NULL,
                id_comentarios_1 INTEGER NOT NULL,
                id_lugares INTEGER NOT NULL,
                CONSTRAINT comentarios_pk PRIMARY KEY (id_comentarios)
);


ALTER SEQUENCE public.comentarios_id_comentarios_seq OWNED BY public.comentarios.id_comentarios;

CREATE TABLE public.cuentas (
                id_rol INTEGER NOT NULL,
                id_persona INTEGER NOT NULL,
                CONSTRAINT cuentas_pk PRIMARY KEY (id_rol, id_persona)
);


ALTER TABLE public.favoritos ADD CONSTRAINT lugares_favoritos_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.horarios ADD CONSTRAINT lugares_horarios_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fotos ADD CONSTRAINT lugares_fotos_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comentarios ADD CONSTRAINT lugares_comentarios_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.privilegios ADD CONSTRAINT funcionalidades_privilegios_fk
FOREIGN KEY (id_funcionalidades)
REFERENCES public.funcionalidades (id_funcionalidades)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cuentas ADD CONSTRAINT roles_cuentas_fk
FOREIGN KEY (id_rol)
REFERENCES public.roles (id_rol)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.privilegios ADD CONSTRAINT roles_privilegios_fk
FOREIGN KEY (id_rol)
REFERENCES public.roles (id_rol)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.usuarios ADD CONSTRAINT personas_usuarios_fk
FOREIGN KEY (id_persona)
REFERENCES public.personas (id_persona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cuentas ADD CONSTRAINT usuarios_cuentas_fk
FOREIGN KEY (id_persona)
REFERENCES public.usuarios (id_persona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comentarios ADD CONSTRAINT usuarios_comentarios_fk
FOREIGN KEY (id_persona)
REFERENCES public.usuarios (id_persona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.favoritos ADD CONSTRAINT usuarios_favoritos_fk
FOREIGN KEY (id_persona)
REFERENCES public.usuarios (id_persona)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comentarios ADD CONSTRAINT comentarios_comentarios_fk
FOREIGN KEY (id_comentarios_1)
REFERENCES public.comentarios (id_comentarios)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
