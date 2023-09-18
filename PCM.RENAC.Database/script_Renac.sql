/*

	unaccent(text)

	Si la función unaccent(text) no está disponible en tu base de datos PostgreSQL, es posible que la extensión unaccent no esté instalada correctamente o no esté habilitada.

	*	SELECT * FROM pg_extension WHERE extname = 'unaccent';

	Si no se devuelve ninguna fila, significa que la extensión no está instalada. Instalar la extensión: Si la extensión unaccent no está instalada, puedes instalarla utilizando el siguiente comando como superusuario:

	*	CREATE EXTENSION IF NOT EXISTS unaccent;

	Verificar la habilitación de la extensión:

	*	SELECT * FROM pg_extension WHERE extname = 'unaccent' AND extstate = 'u';

	Si no se devuelve ninguna fila, significa que la extensión está instalada pero no está habilitada

	*	ALTER EXTENSION unaccent SET SCHEMA public;

*/


CREATE SEQUENCE renac.sec_tipo_asiento
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_parametricas_renac
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_informe_renac
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_asiento_circunscripcion
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_tipo_modificacion_asiento
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_asiento_modificacion
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_circunscripcion_origen_destino
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_derivacion_renac
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_informe_derivacion
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_tipo_documento_renac
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE renac.sec_documento_derivacion
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;


CREATE TABLE renac."TIPO_ASIENTO" (
	"idTipoAsiento" int4 NOT NULL DEFAULT nextval('renac.sec_tipo_asiento'::regclass),
	"codigo" integer NULL,
	"descripcion" varchar(250) NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_TIPO_ASIENTO" PRIMARY KEY ("idTipoAsiento")
);

CREATE TABLE renac."PARAMETRICAS_RENAC" (
	"idParametricasRenac" int4 NOT NULL DEFAULT nextval('renac.sec_parametricas_renac'::regclass),
	"idPadre" integer NULL,
	"idGrupo" integer NULL,
	"codigo" varchar(5) NULL,
	"descripcion" varchar(80) NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_PARAMETRICAS_RENAC" PRIMARY KEY ("idParametricasRenac")
);

CREATE TABLE renac."INFORME_RENAC" (
	"idInformeRenac" int4 NOT NULL DEFAULT nextval('renac.sec_informe_renac'::regclass),	
	"idCircunscripcion" int4 NOT NULL,
	"idEstadoDerivacion" integer NULL,
	"numero" varchar(100) NULL,
	"fecha" date NULL,
	"descripcion" varchar(250) NULL,	
	"urlinformesustento" varchar(850) NULL,
	"nombreinformesustento" varchar(250) NULL,
	"evaluacionFavorable" boolean NULL,
	"informefavorablearchivo" varchar(250) NULL,
	"informeFavorableNumero" varchar(50) NULL,
	"informeFavorableFecha" timestamp NULL,
	"fechaSolicitudInformacion" timestamp NULL,
	"oficioSolicitudNumero" varchar(20) NULL,
	"oficioSolicitudFecha"  timestamp NULL,
	"oficioSolicitudArchivo" varchar(250) NULL,
	"evidenciaSolicitudFecha" timestamp NULL,
	"evidenciaSolicitudArchivo" varchar(250) NULL,
	"oficioAnotacionNumero" varchar(50) NULL,
	"oficioAnotacionFecha" timestamp NULL,
	"oficioAnotacionArchivo" varchar(250) NULL,
	"evidenciaAnotacionFecha" timestamp NULL,
	"evidenciaAnotacionArchivo" varchar(250) NULL,
	"constanciaAnotacionArchivo" varchar(250) NULL,
	"constanciaAnotacionFirmadaFecha" timestamp NULL,
	"constanciaAnotacionFirmadaArchivo" varchar(250) NULL,
	"solicitudGore" bool NULL DEFAULT false,
	"respuestaGoreNumero" varchar(20) NULL,
	"respuestaGoreFecha" timestamp NULL,
	"respuestaGoreArchivo" varchar(250) NULL,
	"procesoAnotacionCerrado" bool NULL DEFAULT false,
	"archivado" bool NULL DEFAULT false,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_INFORME_RENAC" PRIMARY KEY ("idInformeRenac"),
	CONSTRAINT "FK_ESTADO_DERIVACION" FOREIGN KEY ("idEstadoDerivacion") REFERENCES renac."PARAMETRICAS_RENAC"("idParametricasRenac")
);

CREATE TABLE renac."ASIENTO_CIRCUNSCRIPCION" (
	"idAsientoCircunscripcion" int4 NOT NULL DEFAULT nextval('renac.sec_asiento_circunscripcion'::regclass),
	"idInformeRenac" int4 NOT NULL,
	"idTipoAsiento" int4 NOT NULL,	
	"idDispositivo" int4 NOT NULL,	
	"numeroAsiento"  varchar(10) NULL,
	"descripcion" varchar(250) NULL,
	"nombreCircunscripcion" varchar(200) NULL,
	"nombreCapital" varchar(200) NULL,
	"nombreProvincia" varchar(200) NULL,
	"nombreDepartamento" varchar(200) NULL,
	"informacionComplementaria" varchar(250) NULL,
	"fechaAnotacion" timestamp NULL,	
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_ASIENTO_CIRCUNSCRIPCION" PRIMARY KEY ("idAsientoCircunscripcion"),
	CONSTRAINT "FK_INFORME_RENAC" FOREIGN KEY ("idInformeRenac") REFERENCES renac."INFORME_RENAC"("idInformeRenac"),
	CONSTRAINT "FK_TIPO_ASIENTO" FOREIGN KEY ("idTipoAsiento") REFERENCES renac."TIPO_ASIENTO"("idTipoAsiento")	
);

CREATE TABLE renac."TIPO_MODIFICACION_ASIENTO" (
	"idTipoModificacionAsiento" int4 NOT NULL DEFAULT nextval('renac.sec_tipo_modificacion_asiento'::regclass),
	"descripcion" varchar(250) NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_TIPO_MODIFICACION_ASIENTO" PRIMARY KEY ("idTipoModificacionAsiento")
);

CREATE TABLE renac."ASIENTO_MODIFICACION" (
	"idAsientoModificacion" int4 NOT NULL DEFAULT nextval('renac.sec_asiento_modificacion'::regclass),
	"idAsientoCircunscripcion" int4 NOT NULL,
	"idTipoModificacionAsiento" int4 NOT NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_ASIENTO_MODIFICACION" PRIMARY KEY ("idAsientoModificacion"),
	CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION" FOREIGN KEY ("idAsientoCircunscripcion") REFERENCES renac."ASIENTO_CIRCUNSCRIPCION"("idAsientoCircunscripcion"),
	CONSTRAINT "FK_TIPO_MODIFICACION_ASIENTO" FOREIGN KEY ("idTipoModificacionAsiento") REFERENCES renac."TIPO_MODIFICACION_ASIENTO"("idTipoModificacionAsiento")
);


CREATE TABLE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" (
	"idCircunscripcionOrigenDestino" int4 NOT NULL DEFAULT nextval('renac.sec_circunscripcion_origen_destino'::regclass),
	"idAsientoCircunscripcion" int4 NOT NULL,
	"nombreCircunscripcion"  varchar(150) NULL,
	"origenDestino"  varchar(150) NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_CIRCUNSCRIPCION_ORIGEN_DESTINO" PRIMARY KEY ("idCircunscripcionOrigenDestino"),
	CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION" FOREIGN KEY ("idAsientoCircunscripcion") REFERENCES renac."ASIENTO_CIRCUNSCRIPCION"("idAsientoCircunscripcion")
);


CREATE TABLE renac."DERIVACION_RENAC" (
	"idDerivacionRenac" int4 NOT NULL DEFAULT nextval('renac.sec_derivacion_renac'::regclass),
	"idDerivacionOrigen" int4 NULL,
	"idDerivacionDestino" int4 NULL,
	"idEspecialistaSsatdot" varchar(20) NULL,
	"fechaDerivacion" timestamp NULL,
	"usuarioOrigen" varchar(50) NULL,
	"usuarioDestino" varchar(50) NULL,
	"observacion" varchar(350) NULL,
	"esRetorno" bool NULL DEFAULT false,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_DERIVACION_RENAC" PRIMARY KEY ("idDerivacionRenac")
);


CREATE TABLE renac."INFORME_DERIVACION" (
	"idInformeDerivacion" int4 NOT NULL DEFAULT nextval('renac.sec_informe_derivacion'::regclass),
	"idInformeRenac" int4 NOT NULL,
	"idDerivacionRenac" int4 NOT NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_INFORME_DERIVACION" PRIMARY KEY ("idInformeDerivacion"),
	CONSTRAINT "FK_INFORME_RENAC" FOREIGN KEY ("idInformeRenac") REFERENCES renac."INFORME_RENAC"("idInformeRenac"),
	CONSTRAINT "FK_DERIVACION_RENAC" FOREIGN KEY ("idDerivacionRenac") REFERENCES renac."DERIVACION_RENAC"("idDerivacionRenac")
);


CREATE TABLE renac."TIPO_DOCUMENTO_RENAC" (
	"idTipoDocumentoRenac" int4 NOT NULL DEFAULT nextval('renac.sec_tipo_documento_renac'::regclass),
	"codigo" integer NULL,
	"descripcion" varchar(250) NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_TIPO_DOCUMENTO_RENAC" PRIMARY KEY ("idTipoDocumentoRenac")
);


CREATE TABLE renac."DOCUMENTO_DERIVACION" (
	"idDocumentoDerivacion" int4 NOT NULL DEFAULT nextval('renac.sec_documento_derivacion'::regclass),
	"idDerivacionRenac" int4 NOT NULL,
	"idTipoDocumentoRenac" int4 NULL,
	"rutaDocumento" varchar(250) NULL,
	"nombreDocumento" varchar(250) NULL,
	"fechaDocumento" timestamp NULL,
	"numeroDocumento" varchar(30) NULL,
	"activo" bool NULL DEFAULT true,
	"fechaReg" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	"fechaMod" timestamp NULL,
	"usuarioReg" varchar(50) NULL,
	"usuarioMod" varchar(50) NULL,
	CONSTRAINT "PK_DOCUMENTO_DERIVACION" PRIMARY KEY ("idDocumentoDerivacion"),
	CONSTRAINT "FK_DERIVACION_RENAC" FOREIGN KEY ("idDerivacionRenac") REFERENCES renac."DERIVACION_RENAC"("idDerivacionRenac"),
	CONSTRAINT "FK_TIPO_DOCUMENTO_RENAC" FOREIGN KEY ("idTipoDocumentoRenac") REFERENCES renac."TIPO_DOCUMENTO_RENAC"("idTipoDocumentoRenac")
);


CREATE OR REPLACE PROCEDURE renac.usp_tipo_asiento_seleccionar(IN p_idtipoasiento integer, OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idTipoAsiento",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM
			renac."TIPO_ASIENTO" A
		where
			(p_idtipoasiento = 0 or A."idTipoAsiento" = p_idtipoasiento) AND
			A."activo" = true;
		
end;
$procedure$;

CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_seleccionar(
	IN p_idinformerenac integer, 
	OUT p_cursor refcursor
)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."fecha",
			A."descripcion",
			A."urlinformesustento",
			A."nombreinformesustento",
			A."evaluacionFavorable",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM
			renac."INFORME_RENAC" A
		where
			p_idinformerenac = 0 or A."idInformeRenac" = p_idinformerenac AND
			A."activo" = true;
		
end;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."fecha",
			A."descripcion",
			A."urlinformesustento",
			A."nombreinformesustento",
			A."evaluacionFavorable",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN A."idEstadoDerivacion" IS NULL OR A."idEstadoDerivacion" = 0 THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			B."iTipCircunscripcion"
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;






CREATE OR REPLACE FUNCTION renac.fn_informe_renac_seleccionar(p_idinformerenac int)
RETURNS TABLE (
    idInformeRenac integer,
    idCircunscripcion integer,
	idEstadoDerivacion integer,
    numero varchar,
    fecha date,
    descripcion varchar,
    urlinformesustento varchar,
    nombreinformesustento varchar,
	evaluacionFavorable	boolean,
	fechaSolicitudInformacion timestamp,
    oficioSolicitudNumero varchar,
    oficioSolicitudFecha timestamp,
    oficioSolicitudArchivo varchar,
    evidenciaSolicitudFecha timestamp,
    evidenciaSolicitudArchivo varchar,
	constanciaAnotacionArchivo varchar,
    respuestaGoreNumero varchar,
    respuestaGoreFecha timestamp,
    respuestaGoreArchivo varchar,
    activo boolean,
    fechaReg timestamp,
    fechaMod timestamp,
    usuarioReg varchar,
    usuarioMod varchar,
    vNomCircunscripcion varchar,
    iTipCircunscripcion integer,
	nombrecircunscripcion text,
	tipocircunscripcion_id integer,
	tipocircunscripcion_descripcion varchar,
	tipocircunscripcion_abreviatura varchar,
	esderivado boolean,
	solicituddiastranscurridos varchar
) AS $$
BEGIN
    RETURN QUERY
		SELECT 
			A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."fecha",
			A."descripcion",
			A."urlinformesustento",
			A."nombreinformesustento",
			A."evaluacionFavorable",
			A."fechaSolicitudInformacion",
			A."oficioSolicitudNumero",
			A."oficioSolicitudFecha",
			A."oficioSolicitudArchivo",
			A."evidenciaSolicitudFecha",
			A."evidenciaSolicitudArchivo",
			A."constanciaAnotacionArchivo",
            A."respuestaGoreNumero",
            A."respuestaGoreFecha",
            A."respuestaGoreArchivo",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			B."vNomCircunscripcion",
			B."iTipCircunscripcion",
			CASE
					WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
					WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
					ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
				END AS nombrecircunscripcion,
			E."IdTabla" AS tipocircunscripcion_id,
			E."Descripcion" AS tipocircunscripcion_descripcion,
			E."Abreviado" AS tipocircunscripcion_abreviatura,
			CASE
				WHEN (A."idEstadoDerivacion" IS NULL OR A."idEstadoDerivacion" = 0 OR (F."codigo" = '10' and F."idGrupo" = 1001)) THEN false
				ELSE true
			END AS esderivado,
            CASE
                WHEN A."evidenciaSolicitudFecha" IS NULL THEN '-'
                ELSE 
                CASE
                    WHEN DATE(A."evidenciaSolicitudFecha") = CURRENT_DATE THEN '0'
                ELSE  CAST(EXTRACT(DAY FROM AGE(CURRENT_DATE, A."evidenciaSolicitudFecha")) AS VARCHAR)
                END
            END AS "solicituddiastranscurridos"

		FROM 
			renac."INFORME_RENAC" A INNER JOIN
			renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion" LEFT JOIN
			renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion" LEFT JOIN
			renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion" INNER JOIN
			renlim."PARTABLA" E ON B."iTipCircunscripcion" = E."IdTabla" LEFT JOIN
			renac."PARAMETRICAS_RENAC" F ON A."idEstadoDerivacion" = F."idParametricasRenac"

		WHERE 
			A."idInformeRenac" =  p_idinformerenac;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_actualizar(
    IN p_idinformerenac integer, 
	IN p_idestadoderivacion integer,
	IN p_idcircunscripcion integer, 
	IN p_numero character varying,  
	IN p_fecha timestamp without time zone,
	IN p_descripcion character varying, 
	IN p_urlinformesustento character varying,
	IN p_nombreinformesustento character varying,
	IN p_evaluacionfavorable boolean,
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."INFORME_RENAC" WHERE "idInformeRenac" = p_idinformerenac) THEN
        p_error := true;
        p_message := 'El tipo de asiento no existe';
       
     -- Si existe un informe con las mismas caracteristicas
    ELSIF EXISTS(SELECT 1 FROM renac."INFORME_RENAC" WHERE TRIM(LOWER("numero")) = TRIM(LOWER(p_numero)) AND "activo" = true AND "idInformeRenac" <> p_idinformerenac) THEN
        p_error := true;
        p_message := 'El informe ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."INFORME_RENAC" 
		SET 
			"idCircunscripcion" = P_idcircunscripcion,
			"idEstadoDerivacion" = CASE WHEN p_idestadoderivacion IS NOT NULL THEN p_idestadoderivacion ELSE "idEstadoDerivacion" END,
			"numero" = p_numero,
			"fecha" = p_fecha,
			"descripcion" = CASE WHEN p_descripcion IS NOT NULL THEN p_descripcion ELSE "descripcion" END,
			"urlinformesustento" = CASE WHEN p_urlinformesustento IS NOT NULL THEN p_urlinformesustento ELSE "urlinformesustento" END,
			"nombreinformesustento" = CASE WHEN p_nombreinformesustento IS NOT NULL THEN p_nombreinformesustento ELSE "nombreinformesustento" END,
			"evaluacionFavorable" = CASE WHEN p_evaluacionfavorable IS NOT NULL THEN p_evaluacionfavorable ELSE "evaluacionFavorable" END,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idInformeRenac" = p_idinformerenac;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;


CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_insertar(
	IN p_idcircunscripcion integer,
	IN p_idestadoderivacion integer,
	IN p_numero character varying,
	IN p_fecha timestamp,
	IN p_descripcion character varying,
	IN p_urlinformesustento character varying,
	IN p_nombreinformesustento character varying,
	IN p_evaluacionfavorable boolean,
	IN p_usuarioreg character varying,
	IN p_activo boolean,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un informe existente
    IF EXISTS(SELECT 1 FROM renac."INFORME_RENAC" WHERE "idCircunscripcion" = P_idcircunscripcion AND TRIM(LOWER("p_numero")) = TRIM(LOWER(p_numero)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'El informe ya existe';
    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."INFORME_RENAC" 
			("idCircunscripcion", "idEstadoDerivacion", "numero", "fecha", "descripcion", "urlinformesustento", "nombreinformesustento", "evaluacionFavorable", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(P_idcircunscripcion, p_idestadoderivacion, p_numero, p_fecha, p_descripcion, p_urlinformesustento, p_nombreinformesustento, p_evaluacionfavorable, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_asiento_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,	
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor	
)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
            A."idTipoAsiento",
			A."codigo",
            A."descripcion",
            A."activo",
            A."fechaReg",
            A."fechaMod",
            A."usuarioReg",
            A."usuarioMod"
        FROM
            renac."TIPO_ASIENTO" A
		WHERE
			--(p_filtro IS NULL OR unaccent(lower(A.descripcion)) ILIKE '%' || unaccent(lower(p_filtro)) || '%') AND
		    (p_filtro IS NULL OR ( TRIM(COALESCE(A.descripcion, '')) ) ILIKE '%' || p_filtro || '%'  ) AND
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;		
   
    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;




CREATE OR REPLACE FUNCTION renac.fn_tipo_asiento_seleccionar(p_idtipoasiento int)
RETURNS SETOF renac."TIPO_ASIENTO" AS $$
BEGIN
    RETURN QUERY
    SELECT 
		"idTipoAsiento",
		"codigo",
		"descripcion",
		"activo",
		"fechaReg",
		"fechaMod",
		"usuarioReg",
		"usuarioMod"
    FROM renac."TIPO_ASIENTO"
    WHERE "idTipoAsiento" = p_idtipoasiento;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_asiento_actualizar(
    IN p_idtipoasiento integer, 
	IN p_codigo integer,
	IN p_descripcion character varying, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."TIPO_ASIENTO" WHERE "idTipoAsiento" = p_idtipoasiento) THEN
        p_error := true;
        p_message := 'El tipo de asiento no existe';
       
     -- Si existe un tipo de asiento con la misma descripcion
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_ASIENTO" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true AND "idTipoAsiento" <> p_idtipoasiento) THEN
        p_error := true;
        p_message := 'El nombre ya existe';

	-- Si existe un tipo de asiento con el mismo codigo
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_ASIENTO" WHERE "codigo" = p_codigo AND "activo" = true AND "idTipoAsiento" <> p_idtipoasiento) THEN
        p_error := true;
        p_message := 'El codigo ingresado ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."TIPO_ASIENTO" 
		SET 
			"codigo" = p_codigo,
			"descripcion" = p_descripcion,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idTipoAsiento" = p_idtipoasiento;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_asiento_insertar(
  IN p_codigo integer
, IN p_descripcion character varying
, IN p_usuarioreg character varying
, IN p_activo boolean
, OUT p_error boolean
, OUT p_message character varying)
 LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF EXISTS(SELECT 1 FROM renac."TIPO_ASIENTO" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'El tipo de asiento ya existe';

	-- Si existe un tipo de asiento con el mismo codigo
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_ASIENTO" WHERE "codigo" = p_codigo AND "activo" = true) THEN
        p_error := true;
        p_message := 'El codigo ingresado ya existe';

    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."TIPO_ASIENTO" 
			("codigo", "descripcion", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_codigo, p_descripcion, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_asiento_eliminar(IN p_idtipoasiento integer, IN p_usuariomod character varying
, OUT p_error boolean
, OUT p_message character varying)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."TIPO_ASIENTO" WHERE "idTipoAsiento" = p_idtipoasiento) THEN
        p_error := true;
        p_message := 'El tipo de asiento no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."TIPO_ASIENTO" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idTipoAsiento" = p_idtipoasiento;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;

CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_eliminar(
	IN p_idinformerenac integer, 
	IN p_usuariomod character varying,
	OUT p_error boolean,
	OUT p_message character varying
)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta eliminar un informe inexistente
    IF NOT EXISTS(SELECT 1 FROM renac."INFORME_RENAC" WHERE "idInformeRenac" = p_idinformerenac) THEN
        p_error := true;
        p_message := 'El informe no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."INFORME_RENAC" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idInformeRenac" = p_idinformerenac;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;

CREATE OR REPLACE PROCEDURE renac.usp_asiento_circunscripcion_insertar(	
	IN p_idinformerenac integer, 
	IN p_idtipoasiento integer, 
	IN p_iddispositivo integer,
	IN p_numeroasiento character varying,
	IN p_descripcion character varying, 
	IN p_nombrecircunscripcion character varying, 
	IN p_nombrecapital character varying, 
	IN p_nombreprovincia character varying, 
	IN p_nombredepartamento character varying, 
	IN p_informacioncomplementaria character varying, 	
	IN p_fechaanotacion timestamp,	
	IN p_detallesmodificacion character varying,
	IN p_circunscripcionorigenes character varying,
	IN p_circunscripciondestinos character varying,
	IN p_usuarioreg character varying,
	IN p_activo boolean,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

DECLARE
	v_idasientocircunscripcion integer;
	v_detallesmodificacion varchar;
	v_idsmodificacion integer[];
	v_idmodificacion integer;
	v_circunscripcionorigenes varchar;
	v_idscircunscripcionorigenes varchar[];
	v_idcircunscripcionorigenes varchar;
	v_circunscripciondestinos varchar;
	v_idscircunscripciondestinos varchar[];
	v_idcircunscripciondestinos varchar;

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar una descripcion existente
    IF EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'Ya existe un asiento con la misma descripcion';

	-- Si intenta insertar un nombre existente
    ELSIF EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE TRIM(LOWER("nombreCircunscripcion")) = TRIM(LOWER(p_nombrecircunscripcion)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'Ya existe un asiento con el mismo nombre';

	-- Si intenta insertar un numero de asiento existente
    ELSIF EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE TRIM(LOWER("numeroAsiento")) = TRIM(LOWER(p_numeroasiento)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'Ya existe un asiento con el mismo número';

    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN        	

  	   
		-- Realizar la insercion del asiento
	    INSERT INTO renac."ASIENTO_CIRCUNSCRIPCION" 
			("idInformeRenac", 
			 "idTipoAsiento", 
			 "idDispositivo",
			 "numeroAsiento",
			 "descripcion", 
			 "nombreCircunscripcion",
			 "nombreCapital",
			 "nombreProvincia",
			 "nombreDepartamento",
			 "informacionComplementaria",
			 "fechaAnotacion",			 
			 "activo", 
			 "fechaReg", 
			 "usuarioReg")
		VALUES 
			(p_idinformerenac, 
			 p_idtipoasiento, 
			 p_iddispositivo,
			 p_numeroasiento,
			 p_descripcion, 
			 p_nombrecircunscripcion, 
			 p_nombrecapital, 
			 p_nombreprovincia, 
			 p_nombredepartamento, 
			 p_informacioncomplementaria, 
			 p_fechaanotacion,
			 p_activo, 
			 CURRENT_TIMESTAMP, 
			 p_usuarioreg)
            RETURNING "idAsientoCircunscripcion" INTO v_idasientocircunscripcion;


			-- 1. Insertar los motivos de modificacion del asiento
			
			v_detallesmodificacion := p_detallesmodificacion;
			
			-- Validar si hay elementos en la lista
			IF v_detallesmodificacion <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_idsmodificacion := STRING_TO_ARRAY(v_detallesmodificacion, ',')::integer[];

				-- Insertar cada valor en la tabla ASIENTO_MODIFICACION
				FOREACH v_idmodificacion IN ARRAY v_idsmodificacion LOOP
					INSERT INTO renac."ASIENTO_MODIFICACION" 
					("idAsientoCircunscripcion", "idTipoModificacionAsiento", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idasientocircunscripcion, v_idmodificacion, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;


			-- 2. Insertar las circunscripciones de origen
			
			v_circunscripcionorigenes := p_circunscripcionorigenes;
			
			-- Validar si hay elementos en la lista
			IF v_circunscripcionorigenes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_idscircunscripcionorigenes := STRING_TO_ARRAY(v_circunscripcionorigenes, ',')::varchar[];

				-- Insertar cada valor en la tabla ASIENTO_CIRCUNSCRIPCION
				FOREACH v_idcircunscripcionorigenes IN ARRAY v_idscircunscripcionorigenes LOOP
					INSERT INTO renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" 
					("idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idasientocircunscripcion, v_idcircunscripcionorigenes, '1', p_activo, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;						
			END IF;


			-- 3. Insertar las circunscripciones de destino

			v_circunscripciondestinos := p_circunscripciondestinos;
			
			-- Validar si hay elementos en la lista
			IF v_circunscripciondestinos <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_idscircunscripciondestinos := STRING_TO_ARRAY(v_circunscripciondestinos, ',')::varchar[];

				-- Insertar cada valor en la tabla ASIENTO_CIRCUNSCRIPCION
				FOREACH v_idcircunscripciondestinos IN ARRAY v_idscircunscripciondestinos LOOP
					INSERT INTO renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" 
					("idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idasientocircunscripcion, v_idcircunscripciondestinos, '2', p_activo, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;						
			END IF;


		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_circunscripcion_actualizar(
    IN p_idasientocircunscripcion integer,
	IN p_idinformerenac integer, 
	IN p_idtipoasiento integer, 
	IN p_iddispositivo integer,
	IN p_numeroasiento character varying,
	IN p_descripcion character varying, 
	IN p_nombrecircunscripcion character varying, 
	IN p_nombrecapital character varying, 
	IN p_nombreprovincia character varying, 
	IN p_nombredepartamento character varying, 
	IN p_informacioncomplementaria character varying, 	
	IN p_fechaanotacion timestamp,	
	IN p_detallesmodificacion character varying,
	IN p_circunscripcionorigenes character varying,
	IN p_circunscripciondestinos character varying,
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$

DECLARE
	v_detallesmodificacion varchar;
	v_idsmodificacion integer[];
	v_idmodificacion integer;
	v_circunscripcionorigenes varchar;
	v_idscircunscripcionorigenes varchar[];
	v_idcircunscripcionorigenes varchar;
	v_circunscripciondestinos varchar;
	v_idscircunscripciondestinos varchar[];
	v_idcircunscripciondestinos varchar;

BEGIN
    
	-- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE "idAsientoCircunscripcion" = p_idasientocircunscripcion) THEN
        p_error := true;
        p_message := 'El asiento no existe';       

 	ELSIF EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true AND "idAsientoCircunscripcion" <> p_idasientocircunscripcion) THEN
        p_error := true;
        p_message := 'Ya existe un asiento con la misma descripcion';

	-- Si intenta insertar un nombre existente
    ELSIF EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE TRIM(LOWER("nombreCircunscripcion")) = TRIM(LOWER(p_nombrecircunscripcion)) AND "activo" = true AND "idAsientoCircunscripcion" <> p_idasientocircunscripcion) THEN
        p_error := true;
        p_message := 'Ya existe un asiento con el mismo nombre';

	-- Si intenta insertar un numero de asiento existente
    ELSIF EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE TRIM(LOWER("numeroAsiento")) = TRIM(LOWER(p_numeroasiento)) AND "activo" = true AND "idAsientoCircunscripcion" <> p_idasientocircunscripcion) THEN
        p_error := true;
        p_message := 'Ya existe un asiento con el mismo número';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."ASIENTO_CIRCUNSCRIPCION" 
		SET 
			"idInformeRenac" = p_idinformerenac,
			"idTipoAsiento" = p_idtipoasiento,
			"idDispositivo" = p_iddispositivo,
			"numeroAsiento" = p_numeroasiento,
			"descripcion" = p_descripcion,
			"nombreCircunscripcion" = p_nombrecircunscripcion,
			"nombreCapital" = p_nombrecapital,
			"nombreProvincia" = p_nombreprovincia,
			"nombreDepartamento" = p_nombredepartamento,
			"informacionComplementaria" = p_informacioncomplementaria,
			"fechaAnotacion" = p_fechaanotacion,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idAsientoCircunscripcion" = p_idasientocircunscripcion;
		

		-- 1. Actualizamos los motivos de modificacion del asiento

		v_detallesmodificacion := p_detallesmodificacion;

		-- Actualizar todos los registros a "activo = false"
		UPDATE renac."ASIENTO_MODIFICACION" SET "activo" = false where "idAsientoCircunscripcion" = p_idasientocircunscripcion;

		-- Validar si hay elementos en la lista
		IF v_detallesmodificacion <> '' THEN
			-- Convertir la cadena en un array de enteros
			v_idsmodificacion := STRING_TO_ARRAY(v_detallesmodificacion, ',')::integer[];		

			-- Actualizar los registros existentes e insertar los nuevos
			FOREACH v_idmodificacion IN ARRAY v_idsmodificacion LOOP
			-- Verificar si el registro ya existe
			IF EXISTS (
				SELECT 1 FROM renac."ASIENTO_MODIFICACION" WHERE "idTipoModificacionAsiento" = v_idmodificacion AND "idAsientoCircunscripcion" = p_idasientocircunscripcion
				) THEN
				-- Actualizar el registro existente a "activo = true"
				UPDATE renac."ASIENTO_MODIFICACION"
				SET "activo" = true, "usuarioMod" = p_usuariomod, "fechaMod" = CURRENT_TIMESTAMP
				WHERE "idTipoModificacionAsiento" = v_idmodificacion AND "idAsientoCircunscripcion" = p_idasientocircunscripcion;
			ELSE
				-- Insertar el nuevo registro
				INSERT INTO renac."ASIENTO_MODIFICACION" ("idAsientoCircunscripcion", "idTipoModificacionAsiento", "activo", "fechaReg", "usuarioReg")
				VALUES (p_idasientocircunscripcion, v_idmodificacion, true, CURRENT_TIMESTAMP, p_usuariomod);
			END IF;
			END LOOP;
		END IF;
		 

		-- 2. Actualizamos las circunscripciones de origen

		v_circunscripcionorigenes := p_circunscripcionorigenes;
		
		-- Actualizar todos los registros a "activo = false"
		UPDATE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" SET "activo" = false where "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "origenDestino" = '1';

		-- Validar si hay elementos en la lista
		IF v_circunscripcionorigenes <> '' THEN

			-- Convertir la cadena en un array de texto
			v_idscircunscripcionorigenes := STRING_TO_ARRAY(v_circunscripcionorigenes, ',')::varchar[];			

			-- Actualizar los registros existentes e insertar los nuevos
			FOREACH v_idcircunscripcionorigenes IN ARRAY v_idscircunscripcionorigenes LOOP

				-- Verificar si el registro ya existe
				IF EXISTS (
					SELECT 1 FROM renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" WHERE "nombreCircunscripcion" = v_idcircunscripcionorigenes AND "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "origenDestino" = '1'
					) THEN
					-- Actualizar el registro existente a "activo = true"
					UPDATE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
					SET "activo" = true, "usuarioMod" = p_usuariomod, "fechaMod" = CURRENT_TIMESTAMP
					WHERE "nombreCircunscripcion" = v_idcircunscripcionorigenes AND "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "origenDestino" = '1';
				ELSE
					-- Insertar el nuevo registro
					INSERT INTO renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" ("idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", "activo", "fechaReg", "usuarioReg")
					VALUES (p_idasientocircunscripcion, v_idcircunscripcionorigenes, '1', true, CURRENT_TIMESTAMP, p_usuariomod);
				END IF;

			END LOOP;

		END IF;

		-- 3. Actualizamos las circunscripciones de destino

		v_circunscripciondestinos := p_circunscripciondestinos;
		
		-- Actualizar todos los registros a "activo = false"
		UPDATE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" SET "activo" = false where "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "origenDestino" = '2';
		
		-- Validar si hay elementos en la lista
		IF v_circunscripciondestinos <> '' THEN

			-- Convertir la cadena en un array de texto
			v_idscircunscripciondestinos := STRING_TO_ARRAY(v_circunscripciondestinos, ',')::varchar[];

			-- Insertar cada valor en la tabla ASIENTO_CIRCUNSCRIPCION
			FOREACH v_idcircunscripciondestinos IN ARRAY v_idscircunscripciondestinos LOOP
			
				-- Verificar si el registro ya existe
				IF EXISTS (
					SELECT 1 FROM renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" WHERE "nombreCircunscripcion" = v_idcircunscripciondestinos AND "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "origenDestino" = '2'
					) THEN
					-- Actualizar el registro existente a "activo = true"
					UPDATE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
					SET "activo" = true, "usuarioMod" = p_usuariomod, "fechaMod" = CURRENT_TIMESTAMP
					WHERE "nombreCircunscripcion" = v_idcircunscripciondestinos AND "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "origenDestino" = '2';
				ELSE
					-- Insertar el nuevo registro
					INSERT INTO renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" 
					("idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", "activo", "fechaReg", "usuarioReg") VALUES 
					(p_idasientocircunscripcion, v_idcircunscripciondestinos, '2', true, CURRENT_TIMESTAMP, p_usuariomod);
				END IF;

			END LOOP;

		END IF;

		p_message := 'Actualizacion exitosa';
    
    END IF; 

END;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_circunscripcion_eliminar(
	IN p_idasientocircunscripcion integer, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."ASIENTO_CIRCUNSCRIPCION" WHERE "idAsientoCircunscripcion" = p_idasientocircunscripcion) THEN
        p_error := true;
        p_message := 'El asiento no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."ASIENTO_CIRCUNSCRIPCION" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idAsientoCircunscripcion" = p_idasientocircunscripcion;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;



CREATE OR REPLACE FUNCTION renac.fn_asiento_circunscripcion_seleccionar(p_idasientocircunscripcion int)
RETURNS TABLE (
	idAsientoCircunscripcion integer,
	idInformeRenac integer,
	idTipoAsiento integer,
	idDispositivo integer,
	numeroAsiento varchar,
	descripcion varchar,
	nombreCircunscripcion varchar,
	nombreCapital varchar,
	nombreProvincia varchar,
	nombreDepartamento varchar,
	informacionComplementaria varchar,
	fechaAnotacion timestamp,
	activo boolean,
	fechaReg timestamp,
	fechaMod timestamp,
	usuarioReg varchar,
	usuarioMod varchar,
	informerenac_idinformerenac integer,
	informerenac_idcircunscripcion integer,
	informerenac_numero varchar,
	informerenac_fecha date,
	informerenac_descripcion varchar,
	tipoasiento_idtipoasiento integer,
	tipoasiento_codigo integer,
	tipoasiento_descripcion varchar,
	norma_codnorma integer,
	norma_tipo integer,
	norma_numero varchar,
	norma_archivo varchar,
	norma_fecha date,
	tipodispositivo_descripcion varchar,
	detallesmodificacion text
) AS $$

BEGIN
    RETURN QUERY
    SELECT
	A."idAsientoCircunscripcion", 
	A."idInformeRenac", 
	A."idTipoAsiento",
	A."idDispositivo",
	A."numeroAsiento",
	A."descripcion", 
	A."nombreCircunscripcion", 
	A."nombreCapital", 
	A."nombreProvincia", 
	A."nombreDepartamento", 
	A."informacionComplementaria", 
	A."fechaAnotacion",
	A."activo",
	A."fechaReg",
	A."fechaMod",
	A."usuarioReg",
	A."usuarioMod",
	B."idInformeRenac" 		AS "informerenac_idinformerenac",
	B."idCircunscripcion" 	AS "informerenac_idcircunscripcion",
	B."numero" 				AS "informerenac_numero",
	B."fecha" 				AS "informerenac_fecha",
	B."descripcion" 		AS "informerenac_descripcion",
	C."idTipoAsiento" 		AS "tipoasiento_idtipoasiento",
	C."codigo" 				AS "tipoasiento_codigo",
	C."descripcion" 		AS "tipoasiento_descripcion",
	D."iCodNorma" 			AS "norma_codnorma",
	D."iTipo" 				AS "norma_tipo",
	D."vNumero" 			AS "norma_numero",
	D."vArchivo" 			AS "norma_archivo",
	D."dFecha" 				AS "norma_fecha",
	E."Descripcion" 		AS "tipodispositivo_descripcion",
	(
		SELECT STRING_AGG(CAST(tm."idTipoModificacionAsiento" AS VARCHAR), ', ')
		FROM renac."ASIENTO_MODIFICACION" am
		INNER JOIN renac."TIPO_MODIFICACION_ASIENTO" tm ON am."idTipoModificacionAsiento" = tm."idTipoModificacionAsiento"
		WHERE am."idAsientoCircunscripcion" = A."idAsientoCircunscripcion" AND am."activo" = true
	) AS "detallesmodificacion"
FROM
	renac."ASIENTO_CIRCUNSCRIPCION" A
	INNER JOIN renac."INFORME_RENAC" B ON (A."idInformeRenac" = B."idInformeRenac")
	INNER JOIN renac."TIPO_ASIENTO" C ON (A."idTipoAsiento" = C."idTipoAsiento")
	INNER JOIN renlim."NORMA" D ON (A."idDispositivo" = D."iCodNorma")
	INNER JOIN renlim."PARTABLA" E ON D."iTipo" = E."IdTabla"
WHERE
A."idAsientoCircunscripcion" = p_idasientocircunscripcion;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_circunscripcion_seleccionar(
	IN p_idasientocircunscripcion integer,
	IN p_idinformerenac integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idAsientoCircunscripcion", 
			A."idInformeRenac", 
			A."idTipoAsiento",
			A."idDispositivo",
			A."numeroAsiento",
			A."descripcion", 
			A."nombreCircunscripcion", 
			A."nombreCapital", 
			A."nombreProvincia", 
			A."nombreDepartamento", 
			A."informacionComplementaria", 
			A."fechaAnotacion",		
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			(
				SELECT STRING_AGG(tm.Descripcion, ', ')
				FROM renac."ASIENTO_MODIFICACION" am
				INNER JOIN renac."TIPO_MODIFICACION_ASIENTO" tm ON am."idTipoModificacionAsiento" = tm."idTipoModificacionAsiento"
				WHERE am."idAsientoCircunscripcion" = A."idAsientoCircunscripcion" AND am."activo" = true
			) AS "detalle_modificacion",
			B."idInformeRenac" AS "informerenac_idInformeRenac",
			B."idCircunscripcion" AS "informerenac_idcircunscripcion",
			B."numero" AS "informerenac_numero",
			B."fecha" AS "informerenac_fecha",
			B."descripcion" AS "informerenac_descripcion",
			C."idTipoAsiento" AS "tipoasiento_idtipoasiento",
			C."descripcion" AS "tipoasiento_descripcion",
			C."activo" AS "tipoasiento_activo",
			D."vNumero" AS "norma_numero",
			D."dFecha" AS "norma_fecha",
			D."vArchivo" AS "norma_archivo",
			E."Descripcion" AS "tipodispositivo_descripcion"	
		FROM
			renac."ASIENTO_CIRCUNSCRIPCION" A
			INNER JOIN renac."INFORME_RENAC" B ON (A."idInformeRenac" = B."idInformeRenac")
			INNER JOIN renac."TIPO_ASIENTO" C ON (A."idTipoAsiento" = C."idTipoAsiento")
			INNER JOIN renlim."NORMA" D ON (A."idDispositivo" = D."iCodNorma")
			INNER JOIN renlim."PARTABLA" E ON D."iTipo" = E."IdTabla"
		WHERE
			(p_idasientocircunscripcion = 0 OR p_idasientocircunscripcion = A."idAsientoCircunscripcion") AND
			(p_idinformerenac = 0 OR p_idinformerenac = A."idInformeRenac") AND
			A."activo" = true;
		
end;
$procedure$
;




CREATE OR REPLACE PROCEDURE renac.usp_asiento_circunscripcion_paginado(
	IN p_pagesize integer,
	IN p_pagenumber integer,
	IN p_idasientocircunscripcion integer,
	IN p_idinformerenac integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
       SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
            A."idAsientoCircunscripcion", 
			A."idInformeRenac", 
			A."idTipoAsiento",
			A."idDispositivo",
			A."numeroAsiento",
			A."descripcion", 
			A."nombreCircunscripcion", 
			A."nombreCapital", 
			A."nombreProvincia", 
			A."nombreDepartamento", 
			A."informacionComplementaria", 
			A."fechaAnotacion",		
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			(
				SELECT STRING_AGG(tm.Descripcion, ', ')
				FROM renac."ASIENTO_MODIFICACION" am
				INNER JOIN renac."TIPO_MODIFICACION_ASIENTO" tm ON am."idTipoModificacionAsiento" = tm."idTipoModificacionAsiento"
				WHERE am."idAsientoCircunscripcion" = A."idAsientoCircunscripcion" AND am."activo" = true
			) AS "detalle_modificacion",
			B."idInformeRenac" AS "informerenac_idInformeRenac",
			B."idCircunscripcion" AS "informerenac_idcircunscripcion",
			B."numero" AS "informerenac_numero",
			B."fecha" AS "informerenac_fecha",
			B."descripcion" AS "informerenac_descripcion",
			C."idTipoAsiento" AS "tipoasiento_idtipoasiento",
			C."descripcion" AS "tipoasiento_descripcion",
			C."activo" AS "tipoasiento_activo",
			D."vNumero" AS "norma_numero",
			D."dFecha" AS "norma_fecha",
			D."vArchivo" AS "norma_archivo",
			E."Descripcion" AS "tipodispositivo_descripcion"	
		FROM
			renac."ASIENTO_CIRCUNSCRIPCION" A
			INNER JOIN renac."INFORME_RENAC" B ON (A."idInformeRenac" = B."idInformeRenac")
			INNER JOIN renac."TIPO_ASIENTO" C ON (A."idTipoAsiento" = C."idTipoAsiento")
			INNER JOIN renlim."NORMA" D ON (A."idDispositivo" = D."iCodNorma")
			INNER JOIN renlim."PARTABLA" E ON D."iTipo" = E."IdTabla"
		WHERE
			(p_idasientocircunscripcion = 0 OR p_idasientocircunscripcion = A."idAsientoCircunscripcion") AND
			(p_idinformerenac = 0 OR p_idinformerenac = A."idInformeRenac") AND
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_modificacion_asiento_insertar(
  IN p_descripcion character varying
, IN p_usuarioreg character varying
, IN p_activo boolean
, OUT p_error boolean
, OUT p_message character varying)
 LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF EXISTS(SELECT 1 FROM renac."TIPO_MODIFICACION_ASIENTO" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'El tipo de modificacion ya existe';
    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."TIPO_MODIFICACION_ASIENTO" 
			("descripcion", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_descripcion, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_modificacion_asiento_actualizar(
    IN p_idtipomodificacionasiento integer, 
	IN p_descripcion character varying, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."TIPO_MODIFICACION_ASIENTO" WHERE "idTipoModificacionAsiento" = p_idtipomodificacionasiento) THEN
        p_error := true;
        p_message := 'El tipo de modificacion ya existe';
       
     -- Si existe el mismo nombre
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_MODIFICACION_ASIENTO" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true AND "idTipoModificacionAsiento" <> p_idtipomodificacionasiento) THEN
        p_error := true;
        p_message := 'El nombre ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."TIPO_MODIFICACION_ASIENTO" 
		SET 
			"descripcion" = p_descripcion,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idTipoModificacionAsiento" = p_idtipomodificacionasiento;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_modificacion_asiento_eliminar(
	IN p_idtipomodificacionasiento integer, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."TIPO_MODIFICACION_ASIENTO" WHERE "idTipoModificacionAsiento" = p_idtipomodificacionasiento) THEN
        p_error := true;
        p_message := 'El tipo de modificacion no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."TIPO_MODIFICACION_ASIENTO" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idTipoModificacionAsiento" = p_idtipomodificacionasiento;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;


CREATE OR REPLACE FUNCTION renac.fn_tipo_modificacion_asiento_seleccionar(p_idtipomodificacionasiento int)
RETURNS SETOF renac."TIPO_MODIFICACION_ASIENTO" AS $$
BEGIN
    RETURN QUERY
    SELECT 
		"idTipoModificacionAsiento",
		"descripcion",
		"activo",
		"fechaReg",
		"fechaMod",
		"usuarioReg",
		"usuarioMod"
    FROM 
		renac."TIPO_MODIFICACION_ASIENTO"
    WHERE 
		"idTipoModificacionAsiento" = p_idtipomodificacionasiento;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_modificacion_asiento_seleccionar(
	IN p_idtipomodificacionasiento integer, 
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idTipoModificacionAsiento",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM
			renac."TIPO_MODIFICACION_ASIENTO" A
		where
			(p_idtipomodificacionasiento = 0 or A."idTipoModificacionAsiento" = p_idtipomodificacionasiento) AND
			A."activo" = true;
		
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_modificacion_asiento_paginado(
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
            A."idTipoModificacionAsiento",
            A."descripcion",
            A."activo",
            A."fechaReg",
            A."fechaMod",
            A."usuarioReg",
            A."usuarioMod"
        FROM
            renac."TIPO_MODIFICACION_ASIENTO" A
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_modificacion_insertar(
  IN p_idasientocircunscripcion integer
, IN p_idtipomodificacionasiento integer
, IN p_usuarioreg character varying
, IN p_activo boolean
, OUT p_error boolean
, OUT p_message character varying)
 LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un existente
    IF EXISTS(SELECT 1 FROM renac."ASIENTO_MODIFICACION" WHERE "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "idTipoModificacionAsiento" = p_idtipomodificacionasiento AND "activo" = true) THEN
        p_error := true;
        p_message := 'El tipo de modificacion ya existe';
    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."ASIENTO_MODIFICACION" 
			("idAsientoCircunscripcion", "idTipoModificacionAsiento", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_idasientocircunscripcion, p_idtipomodificacionasiento, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_modificacion_actualizar(
    IN p_idasientomodificacion integer, 
	IN p_idasientocircunscripcion integer,
	IN p_idtipomodificacionasiento integer,
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."ASIENTO_MODIFICACION" WHERE "idAsientoModificacion" = p_idasientomodificacion) THEN
        p_error := true;
        p_message := 'El tipo de modificacion no existe';
       
     -- Si existe el mismo nombre
    ELSIF EXISTS(SELECT 1 FROM renac."ASIENTO_MODIFICACION" WHERE "idAsientoCircunscripcion" = p_idasientocircunscripcion AND "idTipoModificacionAsiento" = p_idtipomodificacionasiento AND "activo" = true AND "idAsientoModificacion" <> p_idasientomodificacion) THEN
        p_error := true;
        p_message := 'El nombre ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."ASIENTO_MODIFICACION" 
		SET 
			"idAsientoCircunscripcion" = p_idasientocircunscripcion,
			"idTipoModificacionAsiento" = p_idtipomodificacionasiento,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idAsientoModificacion" = p_idasientomodificacion;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_modificacion_eliminar(
	IN p_idasientomodificacion integer, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."ASIENTO_MODIFICACION" WHERE "idAsientoModificacion" = p_idasientomodificacion) THEN
        p_error := true;
        p_message := 'El tipo de modificacion no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."ASIENTO_MODIFICACION" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idAsientoModificacion" = p_idasientomodificacion;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;


CREATE OR REPLACE FUNCTION renac.fn_asiento_modificacion_seleccionar(p_idasientomodificacion int)
RETURNS SETOF renac."ASIENTO_MODIFICACION" AS $$
BEGIN
    RETURN QUERY
    SELECT 
		"idAsientoModificacion",
		"idAsientoCircunscripcion",
		"idTipoModificacionAsiento",
		"activo",
		"fechaReg",
		"fechaMod",
		"usuarioReg",
		"usuarioMod"
    FROM 
		renac."ASIENTO_MODIFICACION"
    WHERE 
		"idAsientoModificacion" = p_idasientomodificacion;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE renac.usp_asiento_modificacion_seleccionar(
	IN p_idasientomodificacion integer, 
	IN p_idasientocircunscripcion integer,
	IN p_idtipomodificacionasiento integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idAsientoModificacion",
			A."idAsientoCircunscripcion",
			A."idTipoModificacionAsiento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM
			renac."ASIENTO_MODIFICACION" A
		where
			(p_idasientomodificacion = 0 or A."idAsientoModificacion" = p_idasientomodificacion) AND
			(p_idasientocircunscripcion = 0 or A."idAsientoCircunscripcion" = p_idasientocircunscripcion) AND
			(p_idtipomodificacionasiento = 0 or A."idTipoModificacionAsiento" = p_idtipomodificacionasiento) AND
			A."activo" = true;
		
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_asiento_modificacion_paginado(
	IN p_idasientomodificacion integer, 
	IN p_idasientocircunscripcion integer,
	IN p_idtipomodificacionasiento integer,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
      		A."idAsientoModificacion",
			A."idAsientoCircunscripcion",
			A."idTipoModificacionAsiento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
        FROM
            renac."ASIENTO_MODIFICACION" A
		WHERE
			(p_idasientomodificacion = 0 or A."idAsientoModificacion" = p_idasientomodificacion) AND
			(p_idasientocircunscripcion = 0 or A."idAsientoCircunscripcion" = p_idasientocircunscripcion) AND
			(p_idtipomodificacionasiento = 0 or A."idTipoModificacionAsiento" = p_idtipomodificacionasiento) AND
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_circunscripcion_origen_destino_insertar(
  IN p_idasientocircunscripcion integer
, IN p_nombrecircunscripcion character varying
, IN p_origendestino character varying
, IN p_usuarioreg character varying
, IN p_activo boolean
, OUT p_error boolean
, OUT p_message character varying)
 LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un existente
    IF EXISTS(SELECT 1 FROM renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" WHERE 
	"idAsientoCircunscripcion" = p_idasientocircunscripcion AND 
	"nombreCircunscripcion" = p_nombrecircunscripcion AND 
	"origenDestino" = p_origendestino AND "activo" = true) THEN
        p_error := true;
        p_message := 'El oriden-destino para la circunscripcion ya existe';
    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" 
			("idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_idasientocircunscripcion, p_nombrecircunscripcion, p_origendestino, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_circunscripcion_origen_destino_actualizar(
    IN p_idcircunscripcionorigendestino integer, 
	IN p_idasientocircunscripcion integer,
	IN p_nombrecircunscripcion character varying,
	IN p_origendestino character varying,
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" WHERE "idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino) THEN
        p_error := true;
        p_message := 'El origen-destino de la circunscripcion no existe';
       
     -- Si existe el mismo nombre
    ELSIF EXISTS(SELECT 1 FROM renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" WHERE 
				"idAsientoCircunscripcion" = p_idasientocircunscripcion AND "nombreCircunscripcion" = p_nombrecircunscripcion AND 
				"origenDestino" = p_origendestino AND "activo" = true AND "idCircunscripcionOrigenDestino" <> p_idcircunscripcionorigendestino) THEN
        p_error := true;
        p_message := 'El origen-destino de la circunscripcion ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" 
		SET 
			"idAsientoCircunscripcion" = p_idasientocircunscripcion,
			"nombreCircunscripcion" = p_nombrecircunscripcion,
			"origenDestino" = p_origendestino,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;


CREATE OR REPLACE PROCEDURE renac.usp_circunscripcion_origen_destino_eliminar(
	IN p_idcircunscripcionorigendestino integer, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" WHERE "idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino) THEN
        p_error := true;
        p_message := 'El origen-destino de la circunscripcion no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;



CREATE OR REPLACE FUNCTION renac.fn_circunscripcion_origen_destino_seleccionar(p_idcircunscripcionorigendestino int)
RETURNS SETOF renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" AS $$
BEGIN
    RETURN QUERY
    SELECT 
		"idCircunscripcionOrigenDestino",
		"idAsientoCircunscripcion",
		"nombreCircunscripcion",
		"origenDestino",
		"activo",
		"fechaReg",
		"fechaMod",
		"usuarioReg",
		"usuarioMod"
    FROM 
		renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
    WHERE 
		"idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE renac.usp_circunscripcion_origen_destino_seleccionar(
	IN p_idcircunscripcionorigendestino integer, 
	IN p_idasientocircunscripcion integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idCircunscripcionOrigenDestino",
			A."idAsientoCircunscripcion",
			A."nombreCircunscripcion",
			A."origenDestino",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM
			renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" A
		WHERE
			(p_idcircunscripcionorigendestino = 0 or A."idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino) AND
			(p_idasientocircunscripcion = 0 or A."idAsientoCircunscripcion" = p_idasientocircunscripcion) AND
			A."activo" = true;
		
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_circunscripcion_origen_destino_paginado(
	IN p_idcircunscripcionorigendestino integer, 
	IN p_idasientocircunscripcion integer,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
      		A."idCircunscripcionOrigenDestino",
			A."idAsientoCircunscripcion",
			A."nombreCircunscripcion",
			A."origenDestino",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
        FROM
            renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" A
		WHERE
			(p_idcircunscripcionorigendestino = 0 or A."idCircunscripcionOrigenDestino" = p_idcircunscripcionorigendestino) AND
			(p_idasientocircunscripcion = 0 or A."idAsientoCircunscripcion" = p_idasientocircunscripcion) AND
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;


CREATE OR REPLACE FUNCTION renac.fn_derivacion_renac_seleccionar(p_idderivacionrenac int)
RETURNS TABLE (
    idDerivacionRenac integer,
	idDerivacionOrigen integer,
	idDerivacionDestino integer,
	idEspecialistaSsatdot varchar,
    fechaDerivacion timestamp,
    usuarioOrigen varchar,
    usuarioDestino varchar,
    observacion varchar,
    esRetorno boolean,
    activo boolean,
    fechaReg timestamp,
    fechaMod timestamp,
    usuarioReg varchar,
    usuarioMod varchar
) AS $$
BEGIN
    RETURN QUERY
		SELECT 
			A."idDerivacionRenac",
			A."idDerivacionOrigen",
			A."idDerivacionDestino",
			A."idEspecialistaSsatdot",
			A."fechaDerivacion",
			A."usuarioOrigen",
			A."usuarioDestino",
			A."observacion",
			A."esRetorno",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."DERIVACION_RENAC" A
		WHERE 
			A."idDerivacionRenac" =  p_idderivacionrenac;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_derivacion_renac_seleccionar(
    IN p_idderivacionrenac integer, 
    OUT p_cursor refcursor
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idDerivacionRenac",
			A."idDerivacionOrigen",
			A."idDerivacionDestino",
			A."idEspecialistaSsatdot",
			A."fechaDerivacion",
			A."usuarioOrigen",
			A."usuarioDestino",
			A."observacion",
			A."esRetorno",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."DERIVACION_RENAC" A
		where
			(p_idderivacionrenac = 0 or A."idDerivacionRenac" = p_idderivacionrenac) AND
			A."activo" = true;
		
end;
$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_derivacion_renac_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idDerivacionRenac",
			A."idDerivacionOrigen",
			A."idDerivacionDestino",
			A."idEspecialistaSsatdot",
			A."fechaDerivacion",
			A."usuarioOrigen",
			A."usuarioDestino",
			A."observacion",
			A."esRetorno",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
        FROM
            renac."DERIVACION_RENAC" A
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_derivacion_renac_actualizar(
    IN p_idderivacionrenac integer, 
	IN p_idderivacionorigen integer,
	IN p_idderivaciondestino integer,
	IN p_idespecialistassatdot character varying,
	IN p_fechaderivacion timestamp,
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
	IN p_observacion character varying,
	IN p_esretorno boolean,
	IN p_usuariomod character varying,
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."DERIVACION_RENAC" WHERE "idDerivacionRenac" = p_idderivacionrenac) THEN
        p_error := true;
        p_message := 'La derivacion que intenta actualizar no existe';       

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."DERIVACION_RENAC" 
		SET
			"idDerivacionOrigen" = CASE WHEN p_idderivacionorigen IS NOT NULL THEN p_idderivacionorigen ELSE "idDerivacionOrigen" END,
			"idDerivacionDestino" = CASE WHEN p_idderivaciondestino IS NOT NULL THEN p_idderivaciondestino ELSE "idDerivacionDestino" END,
			"idEspecialistaSsatdot" = CASE WHEN p_idespecialistassatdot IS NOT NULL THEN p_idespecialistassatdot ELSE "idEspecialistaSsatdot" END,
            "fechaDerivacion"= CASE WHEN p_fechaderivacion IS NOT NULL THEN p_fechaderivacion ELSE "fechaDerivacion" END,
            "usuarioOrigen"= CASE WHEN p_usuarioorigen IS NOT NULL THEN p_usuarioorigen ELSE "usuarioOrigen" END,
            "usuarioDestino"= CASE WHEN p_usuariodestino IS NOT NULL THEN p_usuariodestino ELSE "usuarioDestino" END,
            "observacion"= CASE WHEN p_observacion IS NOT NULL THEN p_observacion ELSE "observacion" END,
            "esRetorno"= CASE WHEN p_esretorno IS NOT NULL THEN p_esretorno ELSE "esRetorno" END,		
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idDerivacionRenac" = p_idderivacionrenac;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_derivacion_renac_insertar(
	IN p_idderivacionorigen integer,
	IN p_idderivaciondestino integer,
	IN p_idespecialistassatdot character varying,
	IN p_fechaderivacion timestamp, 
	IN p_usuarioorigen character varying,  
	IN p_usuariodestino character varying,
	IN p_observacion character varying, 
	IN p_esretorno boolean,
	IN p_usuarioreg character varying,
	IN p_activo boolean,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."DERIVACION_RENAC" 
			("idDerivacionOrigen", "idDerivacionDestino", "idEspecialistaSsatdot", "fechaDerivacion", "usuarioOrigen", "usuarioDestino", "observacion", "esRetorno", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_idderivacionorigen, p_idderivaciondestino, p_idespecialistassatdot, p_fechaderivacion, p_usuarioorigen, p_usuariodestino, p_observacion, p_esretorno, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_derivacion_renac_eliminar(
    IN p_idderivacionrenac integer, 
    IN p_usuariomod character varying, 
    OUT p_error boolean, 
    OUT p_message character varying
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."DERIVACION_RENAC" WHERE "idDerivacionRenac" = p_idderivacionrenac) THEN
        p_error := true;
        p_message := 'La derivación que intenta eliminar no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."DERIVACION_RENAC" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idDerivacionRenac" = p_idderivacionrenac;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;



CREATE OR REPLACE FUNCTION renac.fn_informe_derivacion_seleccionar(p_idinformederivacion int)
RETURNS TABLE (
    idInformeDerivacion integer,
    idInformeRenac integer,
    idDerivacionRenac integer,
    activo boolean,
    fechaReg timestamp,
    fechaMod timestamp,
    usuarioReg varchar,
    usuarioMod varchar
) AS $$
BEGIN
    RETURN QUERY
		SELECT 
			A."idInformeDerivacion",
			A."idInformeRenac",
			A."idDerivacionRenac",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."INFORME_DERIVACION" A
		WHERE 
			A."idInformeDerivacion" =  p_idinformederivacion;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_informe_derivacion_seleccionar(
    IN p_idinformederivacion integer, 
    OUT p_cursor refcursor
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idInformeDerivacion",
			A."idInformeRenac",
			A."idDerivacionRenac",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."INFORME_DERIVACION" A
		where
			(p_idinformederivacion = 0 or A."idInformeDerivacion" = p_idinformederivacion) AND
			A."activo" = true;
		
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_informe_derivacion_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeDerivacion",
			A."idInformeRenac",
			A."idDerivacionRenac",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."INFORME_DERIVACION" A
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_informe_derivacion_actualizar(
    IN p_idinformederivacion integer,
    IN p_idinformerenac integer,
    IN p_idderivacionrenac integer,
	in p_usuariomod character varying, 
	out p_error boolean, 
	out p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."INFORME_DERIVACION" WHERE "idInformeDerivacion" = p_idinformederivacion) THEN
        p_error := true;
        p_message := 'El informe de la derivacion que intenta actualizar no existe';

     -- Si existe un informe con las mismas caracteristicas
    ELSIF EXISTS(SELECT 1 FROM renac."INFORME_DERIVACION" WHERE "idInformeRenac" = p_idinformerenac AND "idDerivacionRenac" = p_idderivacionrenac AND "activo" = true AND "idInformeDerivacion" <> p_idinformederivacion) THEN
        p_error := true;
        p_message := 'El informe ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."INFORME_DERIVACION"
		SET
            "idInformeRenac"= CASE WHEN p_idinformerenac IS NOT NULL THEN p_idinformerenac ELSE "idInformeRenac" END,
            "idDerivacionRenac"= CASE WHEN p_idderivacionrenac IS NOT NULL THEN p_idderivacionrenac ELSE "idDerivacionRenac" END,      
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idInformeDerivacion" = p_idinformederivacion;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_informe_derivacion_insertar(
    IN p_idinformerenac integer,
    IN p_idderivacionrenac integer,
	IN p_usuarioreg character varying,
	IN p_activo boolean,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un informe existente
    IF EXISTS(SELECT 1 FROM renac."INFORME_DERIVACION" WHERE "idInformeRenac" = p_idinformerenac AND "idDerivacionRenac" = p_idderivacionrenac AND "activo" = true) THEN
        p_error := true;
        p_message := 'El informe ya existe';
    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."INFORME_DERIVACION" 
			("idInformeRenac", "idDerivacionRenac", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_idinformerenac, p_idderivacionrenac, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_informe_derivacion_eliminar(
    IN p_idinformederivacion integer, 
    IN p_usuariomod character varying, 
    OUT p_error boolean, 
    OUT p_message character varying
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."INFORME_DERIVACION" WHERE "idInformeDerivacion" = p_idinformederivacion) THEN
        p_error := true;
        p_message := 'El informe que intenta eliminar no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."INFORME_DERIVACION" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idInformeDerivacion" = p_idinformederivacion;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;



CREATE OR REPLACE FUNCTION renac.fn_tipo_documento_renac_seleccionar(p_idtipodocumentorenac int)
RETURNS TABLE (
    idTipoDocumentoRenac integer,
    codigo integer,
    descripcion varchar,
    activo boolean,
    fechaReg timestamp,
    fechaMod timestamp,
    usuarioReg varchar,
    usuarioMod varchar
) AS $$
BEGIN
    RETURN QUERY
		SELECT 
			A."idTipoDocumentoRenac",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."TIPO_DOCUMENTO_RENAC" A
		WHERE 
			A."idTipoDocumentoRenac" =  p_idtipodocumentorenac;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_tipo_documento_renac_seleccionar(
    IN p_idtipodocumentorenac integer, 
    OUT p_cursor refcursor
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idTipoDocumentoRenac",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."TIPO_DOCUMENTO_RENAC" A
		where
			(p_idtipodocumentorenac = 0 or A."idTipoDocumentoRenac" = p_idtipodocumentorenac) AND
			A."activo" = true;
		
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_documento_renac_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idTipoDocumentoRenac",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
        FROM
            renac."TIPO_DOCUMENTO_RENAC" A
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_documento_renac_actualizar(
    IN p_idtipodocumentorenac integer, 
	IN p_codigo integer,
	IN p_descripcion character varying, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."TIPO_DOCUMENTO_RENAC" WHERE "idTipoDocumentoRenac" = p_idtipodocumentorenac) THEN
        p_error := true;
        p_message := 'El tipo de documento no existe';
       
     -- Si existe un tipo de asiento con la misma descripcion
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_DOCUMENTO_RENAC" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true AND "idTipoDocumentoRenac" <> p_idtipodocumentorenac) THEN
        p_error := true;
        p_message := 'El nombre ya existe';

	-- Si existe un tipo de asiento con el mismo codigo
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_DOCUMENTO_RENAC" WHERE "codigo" = p_codigo AND "activo" = true AND "idTipoDocumentoRenac" <> p_idtipodocumentorenac) THEN
        p_error := true;
        p_message := 'El codigo ingresado ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."TIPO_DOCUMENTO_RENAC" 
		SET 
			"codigo" = p_codigo,
			"descripcion" = p_descripcion,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idTipoDocumentoRenac" = p_idtipodocumentorenac;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_tipo_documento_renac_insertar(
  IN p_codigo integer
, IN p_descripcion character varying
, IN p_usuarioreg character varying
, IN p_activo boolean
, OUT p_error boolean
, OUT p_message character varying)
 LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF EXISTS(SELECT 1 FROM renac."TIPO_DOCUMENTO_RENAC" WHERE TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true) THEN
        p_error := true;
        p_message := 'El tipo de asiento ya existe';

	-- Si existe un tipo de asiento con el mismo codigo
    ELSIF EXISTS(SELECT 1 FROM renac."TIPO_DOCUMENTO_RENAC" WHERE "codigo" = p_codigo AND "activo" = true) THEN
        p_error := true;
        p_message := 'El codigo ingresado ya existe';

    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."TIPO_DOCUMENTO_RENAC" 
			("codigo", "descripcion", "activo", "fechaReg", "usuarioReg")
		VALUES 
			(p_codigo, p_descripcion, p_activo, CURRENT_TIMESTAMP, p_usuarioreg);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_documento_renac_eliminar(
    IN p_idtipodocumentorenac integer, 
    IN p_usuariomod character varying, 
    OUT p_error boolean, 
    OUT p_message character varying
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."TIPO_DOCUMENTO_RENAC" WHERE "idTipoDocumentoRenac" = p_idtipodocumentorenac) THEN
        p_error := true;
        p_message := 'El tipo de documento no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."TIPO_DOCUMENTO_RENAC" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idTipoDocumentoRenac" = p_idtipodocumentorenac;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;


CREATE OR REPLACE FUNCTION renac.fn_documento_derivacion_seleccionar(p_iddocumentoderivacion int)
RETURNS TABLE (
    idDocumentoDerivacion integer,
    idDerivacionRenac integer,
    idTipoDocumentoRenac integer,
    rutaDocumento varchar,
    nombreDocumento varchar,
	fechaDocumento timestamp,
	numeroDocumento varchar,
    activo boolean,
    fechaReg timestamp,
    fechaMod timestamp,
    usuarioReg varchar,
    usuarioMod varchar
) AS $$
BEGIN
    RETURN QUERY
		SELECT 
			A."idDocumentoDerivacion",
            A."idDerivacionRenac",
            A."idTipoDocumentoRenac",
            A."rutaDocumento",
            A."nombreDocumento",
			A."fechaDocumento",
			A."numeroDocumento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."DOCUMENTO_DERIVACION" A
		WHERE 
			A."idDocumentoDerivacion" =  p_iddocumentoderivacion;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_documento_derivacion_seleccionar(
    IN p_iddocumentoderivacion integer, 
    OUT p_cursor refcursor
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idDocumentoDerivacion",
            A."idDerivacionRenac",
            A."idTipoDocumentoRenac",
            A."rutaDocumento",
            A."nombreDocumento",
			A."fechaDocumento",
			A."numeroDocumento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."DOCUMENTO_DERIVACION" A
		where
			(p_iddocumentoderivacion = 0 or A."idDocumentoDerivacion" = p_iddocumentoderivacion) AND
			A."activo" = true;
		
end;
$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_documento_derivacion_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idDocumentoDerivacion",
            A."idDerivacionRenac",
            A."idTipoDocumentoRenac",
            A."rutaDocumento",
            A."nombreDocumento",
			A."fechaDocumento",
			A."numeroDocumento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
        FROM
            renac."DOCUMENTO_DERIVACION" A
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_documento_derivacion_actualizar(
    IN p_iddocumentoderivacion integer, 
    IN p_idderivacionrenac integer,
    IN p_idtipodocumentorenac integer,
    IN p_rutadocumento varchar,
    IN p_nombredocumento varchar,
	IN p_fechadocumento timestamp,
	IN p_numerodocumento varchar,
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."DOCUMENTO_DERIVACION" WHERE "idDocumentoDerivacion" = p_iddocumentoderivacion) THEN
        p_error := true;
        p_message := 'El documento que intenta actualizar no existe';       

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."DOCUMENTO_DERIVACION" 
		SET
            "idDerivacionRenac"= CASE WHEN p_idderivacionrenac IS NOT NULL THEN p_idderivacionrenac ELSE "idDerivacionRenac" END,
            "idTipoDocumentoRenac"= CASE WHEN p_idtipodocumentorenac IS NOT NULL THEN p_idtipodocumentorenac ELSE "idTipoDocumentoRenac" END,
            "rutaDocumento"= CASE WHEN p_rutadocumento IS NOT NULL THEN p_rutadocumento ELSE "rutaDocumento" END,
            "nombreDocumento" = CASE WHEN p_nombredocumento IS NOT NULL THEN p_nombredocumento ELSE "nombreDocumento" END,
			"fechaDocumento" = CASE WHEN p_fechadocumento IS NOT NULL THEN p_fechadocumento ELSE "fechaDocumento" END,
			"numeroDocumento" = CASE WHEN p_numerodocumento IS NOT NULL THEN p_numerodocumento ELSE "numeroDocumento" END,			
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idDocumentoDerivacion" = p_iddocumentoderivacion;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_documento_derivacion_insertar(
	IN p_idderivacionrenac integer,
    IN p_idtipodocumentorenac integer,
    IN p_rutadocumento varchar,
    IN p_nombredocumento varchar,
	IN p_fechadocumento timestamp,
	IN p_numerodocumento varchar,
	IN p_usuarioreg character varying,
	IN p_activo boolean,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."DOCUMENTO_DERIVACION"(
			"idDerivacionRenac", 
			"idTipoDocumentoRenac", 
			"rutaDocumento", 
			"nombreDocumento",
			"fechaDocumento",
			"numeroDocumento",
			"activo", 
			"fechaReg", 
			"usuarioReg"
		)
		VALUES (
			p_idderivacionrenac, 
			p_idtipodocumentorenac, 
			p_rutadocumento, 
			p_nombredocumento,
			p_fechadocumento,
			p_numerodocumento,
			p_activo, 
			CURRENT_TIMESTAMP, 
			p_usuarioreg
		);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_documento_derivacion_eliminar(
    IN p_iddocumentoderivacion integer, 
    IN p_usuariomod character varying, 
    OUT p_error boolean, 
    OUT p_message character varying
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."DOCUMENTO_DERIVACION" WHERE "idDocumentoDerivacion" = p_iddocumentoderivacion) THEN
        p_error := true;
        p_message := 'El documento que intenta eliminar no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."DOCUMENTO_DERIVACION" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idDocumentoDerivacion" = p_iddocumentoderivacion;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;



CREATE OR REPLACE FUNCTION renac.fn_parametricas_renac_seleccionar(p_idparametricasrenac int)
RETURNS TABLE (
    idParametricasRenac integer,
	idPadre integer,
    idGrupo integer,
    codigo varchar,
    descripcion varchar,
    activo boolean,
    fechaReg timestamp,
    fechaMod timestamp,
    usuarioReg varchar,
    usuarioMod varchar
) AS $$
BEGIN
    RETURN QUERY
		SELECT 
			A."idParametricasRenac",
			A."idPadre",
			A."idGrupo",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."PARAMETRICAS_RENAC" A
		WHERE 
			A."idParametricasRenac" =  p_idparametricasrenac;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE renac.usp_parametricas_renac_seleccionar(
    IN p_idparametricasrenac integer, 
    OUT p_cursor refcursor
    )
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."idParametricasRenac",
			A."idPadre",
			A."idGrupo",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
		FROM 
			renac."PARAMETRICAS_RENAC" A
		where
			(p_idparametricasrenac = 0 or A."idParametricasRenac" = p_idparametricasrenac) AND
			A."activo" = true;
		
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_parametricas_renac_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
			A."idPadre",
          	A."idParametricasRenac",
			A."idGrupo",
			A."codigo",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod"
        FROM
            renac."PARAMETRICAS_RENAC" A
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_parametricas_renac_insertar(
	IN p_idpadre integer,
	IN p_idgrupo integer,
    IN p_codigo character varying,
    IN p_descripcion character varying,  
	IN p_usuarioreg character varying,
	IN p_activo boolean,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

begin	
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones


	IF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" = p_idgrupo AND TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true) THEN
		p_error := true;
		p_message := 'La descripcion ingresada ya existe';

	ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" IS NULL AND TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true) THEN
		p_error := true;
		p_message := 'La descripcion ingresada ya existe';

	ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" IS NULL AND TRIM(LOWER("codigo")) = TRIM(LOWER(p_codigo)) AND "activo" = true) THEN
		p_error := true;
		p_message := 'El codigo ingresado ya existe';

	ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" = p_idgrupo AND  TRIM(LOWER("codigo")) = TRIM(LOWER(p_codigo)) AND "activo" = true) THEN
		p_error := true;
		p_message := 'El codigo ingresado ya existe';

	END IF;

	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la insercion
	    INSERT INTO renac."PARAMETRICAS_RENAC"(
			"idPadre",
			"idGrupo", 
			"codigo",
			"descripcion", 
			"activo", 
			"fechaReg", 
			"usuarioReg"
			)
		VALUES (
			p_idpadre,
			p_idgrupo, 
			p_codigo, 
			p_descripcion, 
			p_activo, 
			CURRENT_TIMESTAMP, 
			p_usuarioreg
			);

		   p_message := 'registro exitoso';
		   p_error := false;
    
    END IF;	
	
end;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_parametricas_renac_actualizar(
	IN p_idparametricasrenac integer,
	IN p_idpadre integer,
	IN p_idgrupo integer,
    IN p_codigo character varying,
    IN p_descripcion character varying,  
	IN p_usuariomod character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    IF NOT EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idParametricasRenac" = p_idparametricasrenac) THEN
        p_error := true;
        p_message := 'El valor parametrico que intenta actualizar no existe';
       	   
    ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" = p_idgrupo AND TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true AND "idParametricasRenac" <> p_idparametricasrenac) THEN
        p_error := true;
		p_message := 'La descripcion ingresada ya existe';

	ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" IS NULL AND TRIM(LOWER("descripcion")) = TRIM(LOWER(p_descripcion)) AND "activo" = true AND "idParametricasRenac" <> p_idparametricasrenac) THEN
		p_error := true;
		p_message := 'La descripcion ingresada ya existe';

	ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" IS NULL AND TRIM(LOWER("codigo")) = TRIM(LOWER(p_codigo)) AND "activo" = true AND "idParametricasRenac" <> p_idparametricasrenac) THEN
		p_error := true;
		p_message := 'El codigo ingresado ya existe';

    ELSIF EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idGrupo" = p_idgrupo AND TRIM(LOWER("codigo")) = TRIM(LOWER(p_codigo)) AND "activo" = true AND "idParametricasRenac" <> p_idparametricasrenac) THEN
        p_error := true;
        p_message := 'El codigo ingresado ya existe';

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."PARAMETRICAS_RENAC" 
		SET 
			"idPadre" = p_idpadre,
			"idGrupo" = p_idgrupo,
			"codigo" = p_codigo,
			"descripcion" = p_descripcion,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idParametricasRenac" = p_idparametricasrenac;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_parametricas_renac_eliminar(
	IN p_idparametricasrenac integer, 
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	
	-- Inicializa como false
    p_error := false;
	
	-- Ejecutamos las validaciones
    
    -- Si intenta insertar un tipo de asiento existente
    IF NOT EXISTS(SELECT 1 FROM renac."PARAMETRICAS_RENAC" WHERE "idParametricasRenac" = p_idparametricasrenac) THEN
        p_error := true;
        p_message := 'El valor parametrico que intenta actualizar no existe';
    END IF;
	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
			UPDATE renac."PARAMETRICAS_RENAC" 
			SET 
				"activo" = false,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idParametricasRenac" = p_idparametricasrenac;

			p_message := 'Se elimino el registro';
			p_error := false;
    
    END IF;
	
end;
$procedure$
;













/***********************************************	logica de derivacion de informes    ************************************************************/










CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."fecha",
			A."descripcion",
			A."urlinformesustento",
			A."nombreinformesustento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN A."idEstadoDerivacion" IS NULL OR A."idEstadoDerivacion" = 0 OR E."codigo" = '10' THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			CASE
				WHEN A."idEstadoDerivacion" IS NULL OR A."idEstadoDerivacion" = 0 OR E."codigo" = '10' THEN false
				ELSE true
			END AS esderivado,
			B."iTipCircunscripcion"
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_derivar(
	IN p_usuarioorigen character varying,  
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_rutadocumentomemo character varying,
	IN p_nombredocumentomemo character varying,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;


		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];


		-- Ejecutamos las validaciones


		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- 2. Validacion si todos los informes tienen por lo menos una circunscripcion asociada

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				IF NOT EXISTS (
					SELECT 1
					FROM renac."ASIENTO_CIRCUNSCRIPCION" AS ac
					WHERE ac."idInformeRenac" = v_idinformerenac AND ac."activo" = true
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' no tiene ningún asiento asociado.';
					p_error := true;
					EXIT;
				END IF;
			END LOOP;

		END IF;	


		-- 3. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					LEFT JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE
					(ir."idEstadoDerivacion" IS NOT NULL AND pr."codigo" <> '10' and pr."idGrupo" = 1001) AND
					ir."idInformeRenac" = v_idinformerenac
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;	


		-- 4. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;

		
		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id de la derivacion destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '20'
			LIMIT 1;

			-- se inserta la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES(
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;



			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;



			--3. Guardamos el Proyecto Memo como documento asociado de la derivacion
			INSERT INTO renac."DOCUMENTO_DERIVACION" (
				"idDerivacionRenac",
				"rutaDocumento",
				"nombreDocumento",
				"activo",
				"fechaReg",
				"usuarioReg"
			)
			VALUES (
				v_idderivacionrenac,
				p_rutadocumentomemo,
				p_nombredocumentomemo,
				p_activo,
				CURRENT_TIMESTAMP,
				p_usuarioreg
			);



			--4. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '20' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Subsecretario SSIAT se realizó con éxito';
			p_error := false;
		
		END IF;	
		
	END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssiat_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
 LANGUAGE plpgsql
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."fecha",
			A."descripcion",
			A."urlinformesustento",
			A."nombreinformesustento",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN (E."codigo" = '20') THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoSsiat,
			CASE
				WHEN (E."codigo" <> '10' AND E."codigo" <> '20') THEN '-'
				ELSE '-'
			END AS EstadoAnotacion,
			B."iTipCircunscripcion"
        FROM
            			renac."INFORME_RENAC" 		A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" 	B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" 	C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" 	D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			INNER JOIN 	renac."PARAMETRICAS_RENAC" 	E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			E."idGrupo" = 1001 AND 
			E."codigo" <> '10'
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$
;



CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssiat_derivar(
	IN p_usuarioorigen character varying,  
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_idtipodocumento integer,
	IN p_rutadocumentomemo character varying,
	IN p_nombredocumentomemo character varying,
	IN p_numerodocumento character varying,
	IN p_fechadocumento timestamp,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" <> '20'
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '20'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '30'
			LIMIT 1;


			-- se inserta la informacion de la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;


			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;


			--3. Guardamos el Proyecto Memo como documento asociado de la derivacion
			INSERT INTO renac."DOCUMENTO_DERIVACION" (
				"idDerivacionRenac",
				"idTipoDocumentoRenac",
				"rutaDocumento",
				"nombreDocumento",
				"numeroDocumento",
				"fechaDocumento",
				"activo",
				"fechaReg",
				"usuarioReg"
			)
			VALUES (
				v_idderivacionrenac,
				p_idtipodocumento,
				p_rutadocumentomemo,
				p_nombredocumentomemo,
				p_numerodocumento,
				p_fechadocumento,
				p_activo,
				CURRENT_TIMESTAMP,
				p_usuarioreg
			);


			--4. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '30' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Subsecretario SSATDOT se realizó con éxito';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_informacion_ssiat_asientos(
	IN p_idinformerenac integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin

	OPEN p_cursor FOR
   		SELECT
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
            A."idAsientoCircunscripcion", 
			A."idInformeRenac", 
			A."idDispositivo",
			A."nombreCircunscripcion", 
			A."fechaAnotacion",
			B."idInformeRenac" AS "informerenac_idInformeRenac",
			B."numero" AS "informerenac_numero",
			D."vNumero" AS "norma_numero",
			D."dFecha" AS "norma_fecha",
			D."vArchivo" AS "norma_archivo",
			E."Descripcion" AS "tipodispositivo_descripcion"
		FROM
			renac."ASIENTO_CIRCUNSCRIPCION" A
			INNER JOIN renac."INFORME_RENAC" B ON (A."idInformeRenac" = B."idInformeRenac")
			INNER JOIN renlim."NORMA" D ON (A."idDispositivo" = D."iCodNorma")
			INNER JOIN renlim."PARTABLA" E ON D."iTipo" = E."IdTabla"
		WHERE
			A."idInformeRenac" = p_idinformerenac AND
			A."activo" = true
        ORDER BY
            A."fechaReg" DESC;
		
end;
$procedure$
;



CREATE OR REPLACE FUNCTION renac.fn_informacion_ssiat_documentos(p_idinformerenac int)
RETURNS TABLE (
	informeanotacion varchar,
	proyectomemo_espssiat varchar,
	proyectomemo_subssiat varchar,
	numero_partida varchar
) AS $$
BEGIN
	RETURN QUERY
		SELECT
			t1."urlinformesustento" AS informeanotacion,
			(
				SELECT t3."rutaDocumento"
				FROM renac."DERIVACION_RENAC" as t1
				INNER JOIN renac."INFORME_DERIVACION" as t2 on (t2."idDerivacionRenac" = t1."idDerivacionRenac")
				INNER JOIN renac."DOCUMENTO_DERIVACION" as t3 on (t3."idDerivacionRenac" = t1."idDerivacionRenac")
				WHERE
					t2."idInformeRenac" = p_idinformerenac AND
					t1."esRetorno" = false AND
					t1."usuarioOrigen" = 'E_SSIAT' AND
					t1."usuarioDestino" = 'S_SSIAT' AND
					t1."activo" = true AND
					t2."activo" = true AND
					t3."activo" = true
				ORDER BY
					t3."fechaReg" DESC
				LIMIT 1
			) AS proyectomemo_espssiat,
			(
				SELECT t3."rutaDocumento"
				FROM renac."DERIVACION_RENAC" as t1
				INNER JOIN renac."INFORME_DERIVACION" as t2 on (t2."idDerivacionRenac" = t1."idDerivacionRenac")
				INNER JOIN renac."DOCUMENTO_DERIVACION" as t3 on (t3."idDerivacionRenac" = t1."idDerivacionRenac")
				WHERE
					t2."idInformeRenac" = p_idinformerenac AND
					t1."esRetorno" = false AND
					t1."usuarioOrigen" = 'S_SSIAT' AND
					t1."usuarioDestino" = 'S_SSATDOT' AND
					t1."activo" = true AND
					t2."activo" = true AND
					t3."activo" = true
				ORDER BY
					t3."fechaReg" DESC
				LIMIT 1
			) AS proyectomemo_subssiat,
			t1."numero" AS numero_partida
		FROM renac."INFORME_RENAC" AS t1
		WHERE t1."idInformeRenac" = p_idinformerenac;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssiat_ajustes(
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
	IN p_observaciones character varying,
	IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_activo boolean,
	IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado a SSATDOT
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND pr."idGrupo" = 1001 
					AND (pr."codigo" <> '20' AND pr."codigo" <> '10')
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;

		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '20'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '10'
			LIMIT 1;

			-- insertar la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"observacion",
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_observaciones,
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;

			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;

			--3. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '10' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 4. Actualizamos los mensajes de retorno

			p_message := 'Se devolvieron los informes satisfactoriamente a SSIAT';
			p_error := false;
		
		END IF;	

	END;

$procedure$;







CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssatdot_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."fecha",
			A."descripcion",
			A."activo",
			A."fechaReg",
			A."fechaMod",
			A."usuarioReg",
			A."usuarioMod",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN E."codigo" = '30' THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			B."iTipCircunscripcion"
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			(E."codigo" <> '10' AND E."codigo" <> '20') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssatdot_derivar(
	IN p_idespecialista character varying,
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" <> '30'
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '30'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '40'
			LIMIT 1;


			-- se inserta la informacion de la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idEspecialistaSsatdot",
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				p_idespecialista,
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;


			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;

			-- 3. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '40' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 4. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Especialista SSATDOT se realizó con éxito';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssatdot_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",			
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN E."codigo" = '40' THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			(E."codigo" <> '10' AND E."codigo" <> '20' AND E."codigo" <> '30') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_verificar_informefavorable(
	IN p_listainformesrenac varchar,
	OUT p_error boolean,
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$

	DECLARE

	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
    v_informe_numero varchar;
    v_tiene_informe_favorable boolean := false;
    v_informes_con_opinion_favorable text[] := '{}';

	BEGIN
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_listainformesrenac, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_listainformesrenac está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		
			-- 1. Verifica los informes renac que ya tengan un informe de opinion favorable registrado
 			
			-- Itera a través de los IDs de informes
			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				 -- Obtiene el número de informe
				SELECT numero 
				INTO v_informe_numero
				FROM renac."INFORME_RENAC"
				WHERE "idInformeRenac" = v_idinformerenac;

				-- Verifica si el informe tiene informefavorablearchivo diferente de NULL
				SELECT informefavorablearchivo IS NOT NULL 
				INTO v_tiene_informe_favorable
				FROM renac."INFORME_RENAC"
				WHERE "idInformeRenac" = v_idinformerenac;

				-- Si tiene informefavorablearchivo, agrega el número de informe al arreglo
				IF v_tiene_informe_favorable THEN
					v_informes_con_opinion_favorable := array_append(v_informes_con_opinion_favorable, v_informe_numero);
				END IF;
				
			END LOOP;


			-- Construye el mensaje dependiendo de la cantidad de informes con opinión favorable
			IF array_length(v_informes_con_opinion_favorable, 1) > 1 THEN
				p_message := 'Los informes Renac número ' || array_to_string(v_informes_con_opinion_favorable, ', ') || ' ya tienen registrado un informe de opinión favorable. Al subir un nuevo informe de opinión favorable, este reemplazará los informes existentes.';
			ELSE
				IF array_length(v_informes_con_opinion_favorable, 1) = 1 THEN
					p_message := 'El informe Renac número ' || array_to_string(v_informes_con_opinion_favorable, ', ') || ' ya tiene registrado un informe de opinión favorable. Al subir un nuevo informe de opinión favorable, este reemplazará el informe existente.';
				ELSE
					p_message := '¿Está seguro que desea registrar el informe de opinion favorable?';
				END IF;
			END IF;			

			-- 2. Actualizamos los mensajes de retorno
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssatdot_informefavorable(
	IN p_informefavorablearchivo character varying,
	IN p_informefavorablenumero character varying,
	IN p_informefavorablefecha timestamp,
	IN p_listainformesrenac character varying,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE

	v_arr_idinformerenac integer[];

	BEGIN
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_listainformesrenac, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_listainformesrenac está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		
 			-- 1. Actualizamos los datos del informe de anotacion favorable sobre los informes renac

			IF p_listainformesrenac <> '' THEN

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET 
					"informefavorablearchivo" = p_informefavorablearchivo,
					"informefavorablenumero" = p_informefavorablenumero,
					"informefavorablefecha" = p_informefavorablefecha,
					"fechaMod" = CURRENT_TIMESTAMP,
					"usuarioMod" = p_usuarioreg
				WHERE 
					"idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_listainformesrenac, ','))::integer);

			END IF;
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'Se registraron los informes de opinión favorable satisfactoriamente';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_informe_renac_evaluacionfavorable(
    IN p_idinformerenac integer, 
	IN p_evaluacionfavorable boolean,
	IN p_usuariomod character varying, 
	OUT p_error boolean, 
	OUT p_message character varying
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    -- Inicializa como false
    p_error := false;

    -- Ejecutamos las validaciones
    
    -- Si intenta actualizar un registro no existente
    IF NOT EXISTS(SELECT 1 FROM renac."INFORME_RENAC" WHERE "idInformeRenac" = p_idinformerenac) THEN
        p_error := true;
        p_message := 'El tipo de asiento no existe';
    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."INFORME_RENAC" 
		SET 
			"evaluacionFavorable" = p_evaluacionfavorable,
			"usuarioMod" = p_usuariomod,
			"fechaMod" = CURRENT_TIMESTAMP
		WHERE 
			"idInformeRenac" = p_idinformerenac;
		
		p_message := 'Actualizacion exitosa';
    
    END IF;
 

END;
$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssatdot_derivar (
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_rutadocumentomemo character varying,
	IN p_nombredocumentomemo character varying,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying 
)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" <> '40'
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;


		-- 4. Validamos que los informes a derivar, tengan registrado su estado de evaluacion favorable

		IF NOT p_error THEN

		FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND ir."evaluacionFavorable" IS NULL
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' no tiene registrada su evaluacion favorable, debe actualizarlo para poder derivar el informe.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;



		-- 5. Validamos que todos los informes tengan registrado su Informe de opinion favorable

		IF NOT p_error THEN

		FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND ir."informefavorablearchivo" IS NULL
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' no tiene registrado su informe de opinión favorable, por favor regularizar la información antes de derivar.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '40'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '50'
			LIMIT 1;


			-- se inserta la informacion de la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;


			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;


			--3. Guardamos el Proyecto Memo como documento asociado de la derivacion
			INSERT INTO renac."DOCUMENTO_DERIVACION" (
				"idDerivacionRenac",
				"rutaDocumento",
				"nombreDocumento",
				"activo",
				"fechaReg",
				"usuarioReg"
			)
			VALUES (
				v_idderivacionrenac,
				p_rutadocumentomemo,
				p_nombredocumentomemo,
				p_activo,
				CURRENT_TIMESTAMP,
				p_usuarioreg
			);


			--4. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '50' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Subsecretario SSATDOT se realizó con éxito';
			p_error := false;
		
		END IF;
	
	END;

$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssatdot_derivacioninformes_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
			A."evaluacionFavorable",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN E."codigo" = '50' THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			CASE
				WHEN (E."codigo" = '50' and E."idGrupo" = 1001) THEN false ELSE true
			END AS esderivado
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			E."codigo" NOT IN ('10', '20', '30', '40') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssatdot_ajustes(
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
	IN p_observaciones character varying,
	IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_activo boolean,
	IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado 
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND pr."idGrupo" = 1001 
					AND pr."codigo" NOT IN ('10', '20', '30', '40') 
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;

		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '40'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '10'
			LIMIT 1;

			-- insertar la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"observacion",
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_observaciones,
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;

			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;

			--3. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente a SSIAT
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '10' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 4. Actualizamos los mensajes de retorno

			p_message := 'Se devolvieron los informes satisfactoriamente a SSIAT';
			p_error := false;
		
		END IF;	

	END;

$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssatdot_ajustes(
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
	IN p_observaciones character varying,
	IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_activo boolean,
	IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado 
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND pr."idGrupo" = 1001 
					AND pr."codigo" NOT IN ('10', '20', '30', '40', '50') 
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;

		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '50'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '40'
			LIMIT 1;

			-- insertar la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"observacion",
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_observaciones,
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;

			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;

			--3. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente a Especialista SSATDOT
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '40' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 4. Actualizamos los mensajes de retorno

			p_message := 'Se devolvieron los informes satisfactoriamente al especialista SSATDOT';
			p_error := false;
		
		END IF;	

	END;

$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_derivacion_insertar(
    IN p_idderivacionorigen integer,
	IN p_idderivaciondestino integer,
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
	IN p_derivacioninformes character varying,
	IN p_rutadocumento character varying,
	IN p_idtipodocumentorenac integer,
	IN p_nombredocumento character varying,
	IN p_fechadocumento timestamp without time zone,
	IN p_numerodocumento character varying,
	IN p_usuarioreg character varying
)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
	v_idderivacionrenac int;
	v_arr_idinformerenac int[];
	v_idinformerenac int;

	BEGIN

		-- 1. se inserta la informacion de la derivacion
		INSERT INTO renac."DERIVACION_RENAC" (
			"idDerivacionOrigen",
			"idDerivacionDestino",
			"fechaDerivacion", 
			"usuarioOrigen", 
			"usuarioDestino", 
			"esRetorno", 
			"activo", 
			"fechaReg", 
			"usuarioReg"
		)
		VALUES (
			p_idderivacionorigen,
			p_idderivaciondestino,
			CURRENT_TIMESTAMP, 
			p_usuarioorigen, 
			p_usuariodestino, 
			false, 
			true, 
			CURRENT_TIMESTAMP, 
			p_usuarioreg
		)
		RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;

		-- 2. Se inserta los informes en el detalle de la derivacion
		IF p_derivacioninformes <> '' THEN
			v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

			-- Insertar cada valor en la tabla INFORME_DERIVACION
			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
				INSERT INTO renac."INFORME_DERIVACION" 
				("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
				(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
			END LOOP;
		END IF;

		-- 3. Guardamos el Proyecto como documento asociado de la derivacion
		INSERT INTO renac."DOCUMENTO_DERIVACION" (
			"idDerivacionRenac",
			"idTipoDocumentoRenac",
			"rutaDocumento",
			"nombreDocumento",
			"numeroDocumento",
			"fechaDocumento",
			"activo",
			"fechaReg",
			"usuarioReg"
		)
		VALUES (
			v_idderivacionrenac,
			p_idtipodocumentorenac,
			p_rutadocumento,
			p_nombredocumento,
			p_numerodocumento,
			p_fechadocumento,
			true,
			CURRENT_TIMESTAMP,
			p_usuarioreg
		);

		-- 4. Actualizamos los estados de derivacion de los informes
		IF p_derivacioninformes <> '' THEN      

			UPDATE renac."INFORME_RENAC"
			SET "idEstadoDerivacion" = p_idderivaciondestino
			WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);
			
		END IF;
	END;

$procedure$;

 




CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssatdot_derivacioninformes (
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_idtipodocumentorenac integer,
    IN p_rutadocumento varchar,
    IN p_nombredocumento varchar,
	IN p_fechadocumento timestamp,
	IN p_numerodocumento varchar,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying 
)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino_espssiat_modificacion integer;
	v_idderivaciondestino_espssiat_anotacion integer;
	v_idderivaciondestino_responsable_archivo integer;	
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;
	v_departamental boolean := false;
	v_derivacioninformes_favorables character varying := '';
	v_derivacioninformes_no_favorables character varying := '';
    v_arr_informes_favorables  integer[];
	v_evaluacionFavorable boolean;
	v_codigoderivacion varchar;
	v_solicitudgore boolean;
	v_informes_con_solicitudgore character varying := '';
	v_informes_sin_solicitudgore character varying := '';

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" <> '50'
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

			-- Validamos si se trata de un caso de unicamente departamentos
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones = 0 THEN
				v_departamental := true;
			END IF;

		END IF;


		-- 4. Validamos que los informes a derivar, tengan registrado su estado de evaluacion favorable

		IF NOT p_error THEN

		FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND ir."evaluacionFavorable" IS NULL
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' no tiene registrada su evaluacion favorable, debe actualizarlo para poder derivar el informe.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;



		-- 5. Validamos que todos los informes tengan registrado su Informe de opinion favorable

		IF NOT p_error THEN

		FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND ir."informefavorablearchivo" IS NULL
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' no tiene registrado su informe de opinión favorable, por favor regularizar la información antes de derivar.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;



		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN

				
			-- 1. Determinamos cuales son los informes con Evaluacion favorable y los informes que no tienen Evaliacion favorable

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
                SELECT "evaluacionFavorable" 
                INTO v_evaluacionFavorable
                FROM renac."INFORME_RENAC"
                WHERE "idInformeRenac" = v_idinformerenac;

                IF v_evaluacionFavorable = true THEN
                    v_derivacioninformes_favorables := v_derivacioninformes_favorables || v_idinformerenac || ',';
                ELSE
                    IF v_evaluacionFavorable = false THEN
                        v_derivacioninformes_no_favorables := v_derivacioninformes_no_favorables || v_idinformerenac || ',';
                    END IF;
                END IF;
			END LOOP;

			-- Eliminar la última coma de las listas si es necesario
			IF length(v_derivacioninformes_favorables) > 0 THEN
				v_derivacioninformes_favorables := substring(v_derivacioninformes_favorables, 1, length(v_derivacioninformes_favorables) - 1);
			END IF;

			IF length(v_derivacioninformes_no_favorables) > 0 THEN
				v_derivacioninformes_no_favorables := substring(v_derivacioninformes_no_favorables, 1, length(v_derivacioninformes_no_favorables) - 1);
			END IF;



			-- 2. separamos de los informes favorables, que no son seccion departamental, aquellos que tienen solicitud de informacion GORE y los que no

            --Convertimos a Array la lista de informes favorables
		    v_arr_informes_favorables := STRING_TO_ARRAY(v_derivacioninformes_favorables, ',')::integer[];

            -- verificamos si existen informes favorables
            IF array_length(v_arr_informes_favorables, 1) IS NOT NULL THEN

				FOREACH v_idinformerenac IN ARRAY v_arr_informes_favorables LOOP
					SELECT "solicitudGore" 
					INTO v_solicitudgore
					FROM renac."INFORME_RENAC"
					WHERE "idInformeRenac" = v_idinformerenac;

					IF v_solicitudgore = true THEN
						v_informes_con_solicitudgore := v_informes_con_solicitudgore || v_idinformerenac || ',';
					ELSE
						v_informes_sin_solicitudgore := v_informes_sin_solicitudgore || v_idinformerenac || ',';
					END IF;
				END LOOP;

				-- Eliminar la última coma de las listas si es necesario
				IF length(v_informes_con_solicitudgore) > 0 THEN 
					v_informes_con_solicitudgore := substring(v_informes_con_solicitudgore, 1, length(v_informes_con_solicitudgore) - 1); END IF;

				IF length(v_informes_sin_solicitudgore) > 0 THEN 
					v_informes_sin_solicitudgore := substring(v_informes_sin_solicitudgore, 1, length(v_informes_sin_solicitudgore) - 1);  END IF;

			END IF;
		

		
			-- 3. Obtenemos el id del origen y los id de los posibles destinos, segun sea la condicion del informe renac
			

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac" INTO v_idderivacionorigen FROM renac."PARAMETRICAS_RENAC" AS t1 WHERE t1."activo" = true AND t1."idGrupo" = 1001 AND t1."codigo" = '50' LIMIT 1;

			-- (C1) obtenemos el id del destino para los informes con evaluaciones No favorables, que van al especialista SSIAT para "Modificar o solicitar archivo de informe de anotación" 
			SELECT T1."idParametricasRenac" INTO v_idderivaciondestino_espssiat_modificacion FROM renac."PARAMETRICAS_RENAC" AS t1 WHERE t1."activo" = true AND t1."idGrupo" = 1001 AND t1."codigo" = '60' LIMIT 1;

			-- (C2), (C3) obtenemos el id del destino para los informes que van al especialista SSIAT para "Generar formatos de anotación"
			SELECT T1."idParametricasRenac" INTO v_idderivaciondestino_espssiat_anotacion FROM renac."PARAMETRICAS_RENAC" AS t1 WHERE t1."activo" = true AND t1."idGrupo" = 1001 AND t1."codigo" = '70' LIMIT 1;

			-- (C4) obtenemos el id del destino para los informes que van al Responsable de archivo SSIAT para "Subir oficio de solicitud de información al GORE y evidencia de envio"
			SELECT T1."idParametricasRenac" INTO v_idderivaciondestino_responsable_archivo FROM renac."PARAMETRICAS_RENAC" AS t1 WHERE t1."activo" = true AND t1."idGrupo" = 1001 AND t1."codigo" = '80' LIMIT 1;




			-- 4. Se registran las derivaciones, segun sea el caso


			-- evaluamos si existen informes con resultado no favorable
			IF length(v_derivacioninformes_no_favorables) > 0 THEN

				/*	(C1) Se registra la derivacion de los informes renac no favorables */

                p_usuariodestino := 'E_SSIAT';

				CALL renac.usp_derivacion_insertar(
					v_idderivacionorigen,
					v_idderivaciondestino_espssiat_modificacion,
					p_usuarioorigen,
					p_usuariodestino,                    
					v_derivacioninformes_no_favorables,
                    p_rutadocumento,
					p_idtipodocumentorenac,					
					p_nombredocumento,
					p_fechadocumento,
					p_numerodocumento,
					p_usuarioreg
				);


			END IF;

			-- evaluamos si existen informes favorables
			IF length(v_derivacioninformes_favorables) > 0 THEN

				-- evaluamos si se trata de un registro departamental (seccion departamental)
				IF v_departamental = true THEN

					/* (C2) se registra la derivacion de los informes favorables departamentales */

                    p_usuariodestino := 'E_SSIAT';

					CALL renac.usp_derivacion_insertar(
						v_idderivacionorigen,
						v_idderivaciondestino_espssiat_anotacion,
						p_usuarioorigen,
                        p_usuariodestino,                    
                        v_derivacioninformes_favorables,
                        p_rutadocumento,
                        p_idtipodocumentorenac,					
                        p_nombredocumento,
                        p_fechadocumento,
                        p_numerodocumento,
                        p_usuarioreg
					);               

				-- caso contrario de no ser un registro departamenta (distrital y/o provincial)
				ELSE
					
					-- evaluamos si hay informes que tienen solicitud Gore
					IF length(v_informes_con_solicitudgore) > 0 THEN

						/* (C3) se registra la derivacion de los informes con solicitud Gore al Especialista SSIAT para Generar formatos de anotación */

                         p_usuariodestino := 'E_SSIAT';

						CALL renac.usp_derivacion_insertar(
							v_idderivacionorigen,
							v_idderivaciondestino_espssiat_anotacion,
							p_usuarioorigen,
                            p_usuariodestino,                    
                            v_informes_con_solicitudgore,
                            p_rutadocumento,
                            p_idtipodocumentorenac,					
                            p_nombredocumento,
                            p_fechadocumento,
                            p_numerodocumento,
                            p_usuarioreg
						);


					END IF;


					-- evaluamos si hay informes que no cuentan con solicitud Gore
					IF length(v_informes_sin_solicitudgore) > 0 THEN

						/* (C4) se registra la derivacion de los informes sin solicitud Gore al responsable de archivo SSIAT para Subir oficio de solicitud de informacion al Gore y evidencia de envio */

                        p_usuariodestino := 'R_ARCHIVO';

						CALL renac.usp_derivacion_insertar(
							v_idderivacionorigen,
							v_idderivaciondestino_responsable_archivo,
							p_usuarioorigen,
                            p_usuariodestino,                    
                            v_informes_sin_solicitudgore,
                            p_rutadocumento,
                            p_idtipodocumentorenac,					
                            p_nombredocumento,
                            p_fechadocumento,
                            p_numerodocumento,
                            p_usuarioreg
						);


					END IF;

				END IF;

			END IF;


 
			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación se realizó exitosamente';
			p_error := false;
		
		END IF;
	
	END;

$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_responsablearchivo_solicitudinformacion_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
            A."evaluacionFavorable",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN E."codigo" = '80' THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			CASE
				WHEN (E."codigo" = '80' and E."idGrupo" = 1001) THEN false ELSE true
			END AS esderivado
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			E."codigo" NOT IN ('10', '20', '30', '40', '50', '60', '70') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_responsablearchivo_solicitudinformacion_insertar (
	IN p_oficiosolicitudnumero character varying,
	IN p_oficiosolicitudfecha timestamp,
	IN p_oficiosolicitudarchivo character varying,
	IN p_evidenciasolicitudfecha timestamp,
	IN p_evidenciasolicitudarchivo character varying,
	IN p_listainformesrenac character varying,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE

	v_arr_idinformerenac integer[];

	BEGIN
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_listainformesrenac, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_listainformesrenac está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		
 			-- 1. Actualizamos los datos del informe de anotacion favorable sobre los informes renac

			IF p_listainformesrenac <> '' THEN

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET 
					"fechaSolicitudInformacion" = CURRENT_TIMESTAMP,
					"oficioSolicitudNumero" = p_oficiosolicitudnumero,
					"oficioSolicitudFecha" = p_oficiosolicitudfecha,
					"oficioSolicitudArchivo" = p_oficiosolicitudarchivo,
					"evidenciaSolicitudFecha" = p_evidenciasolicitudfecha,
					"evidenciaSolicitudArchivo" = p_evidenciasolicitudarchivo,
					"fechaMod" = CURRENT_TIMESTAMP,
					"usuarioMod" = p_usuarioreg
				WHERE 
					"idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_listainformesrenac, ','))::integer);

			END IF;
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'Se registraron los archivos de solicitud de información';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;

 




CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_registroformatos_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
            A."evaluacionFavorable",
			A."solicitudGore",
            A."constanciaAnotacionArchivo",
			A."respuestaGoreArchivo",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN (E."codigo" = '60' OR E."codigo" = '70' OR E."codigo" = '90') THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			CASE
				WHEN ((E."codigo" = '60' OR E."codigo" = '70' OR E."codigo" = '90') and E."idGrupo" = 1001) THEN false ELSE true
			END AS esderivado,
			CASE
                WHEN A."evidenciaSolicitudFecha" IS NULL THEN '-'
				WHEN A."solicitudGore" IS NOT NULL THEN '-'
                ELSE 
                CASE
                    WHEN DATE(A."evidenciaSolicitudFecha") = CURRENT_DATE THEN '0'
                ELSE  CAST(EXTRACT(DAY FROM AGE(CURRENT_DATE, A."evidenciaSolicitudFecha")) AS VARCHAR)
                END
            END AS "solicituddiastranscurridos"
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			E."codigo" NOT IN ('10', '20', '30', '40', '50', '80') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;







CREATE OR REPLACE PROCEDURE renac.usp_generar_correlativo_constancia_anotacion(
    IN p_idinformerenac integer
)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
    v_idcircunscripcion integer;
	tipo_circunscripcion text;
    correlativo text;
    correlativo_numerico integer;

	BEGIN

        -- Obtenemos el id de la circunscripcion del informe
        select ir."idCircunscripcion" 
        INTO v_idcircunscripcion
        from renac."INFORME_RENAC" as ir where ir."idInformeRenac" = p_idinformerenac;

        -- Obtener el tipo de circunscripción (Departamento, Provincia o Distrito)   

         SELECT CASE
            WHEN (cr."iCodDepCircunscripcion" = 0 or cr."iCodDepCircunscripcion" is null) THEN 'DEP'
            WHEN (cr."iCodProvCircunscripcion" = 0 or cr."iCodProvCircunscripcion" is null) and (cr."iCodDepCircunscripcion" <> 0 and cr."iCodDepCircunscripcion" is not null) THEN 'PRO'
            ELSE 'DIS' END 
        END INTO tipo_circunscripcion
        FROM renlim."CIRCUNSCRIPCION" as cr
        WHERE cr."iCodCircunscripcion" = v_idcircunscripcion;
        
        -- Verificar si la columna "vCodigoUnicoIdentificacion" ya tiene un valor
        SELECT "vCodigoUnicoIdentificacion" INTO correlativo
        FROM renlim."CIRCUNSCRIPCION"
        WHERE "iCodCircunscripcion" = v_idcircunscripcion;
        
        -- Si la columna no tiene un valor, generar el correlativo
        IF correlativo IS NULL THEN        
            
            IF tipo_circunscripcion = 'DEP' THEN

                -- Calcular el correlativo numérico según la cantidad de registros existentes
                select count(*)
                into correlativo_numerico
                from renlim."CIRCUNSCRIPCION" as cr 
                where ((cr."iCodDepCircunscripcion" = 0 or cr."iCodDepCircunscripcion" is null) and cr."bActivo" =  True and cr."vCodigoUnicoIdentificacion" IS NOT NULL);

                correlativo_numerico := correlativo_numerico + 1;

                -- Generar correlativo para Departamento
                correlativo := 'CIDE' || LPAD(correlativo_numerico::text, 2, '0');

            ELSIF tipo_circunscripcion = 'PRO' THEN

                -- Calcular el correlativo numérico según la cantidad de registros existentes
            select count(*)
            into correlativo_numerico
            from renlim."CIRCUNSCRIPCION" as cr 
            where ((cr."iCodProvCircunscripcion" = 0 or cr."iCodProvCircunscripcion" is null ) and (cr."iCodDepCircunscripcion" <> 0 and cr."iCodDepCircunscripcion" is not null))
            and cr."bActivo" =  True and cr."vCodigoUnicoIdentificacion" IS NOT NULL;
                
                correlativo_numerico := correlativo_numerico + 1;

                -- Generar correlativo para Provincia
                correlativo := 'CIPR' || LPAD(correlativo_numerico::text, 3, '0');
            ELSE

                -- Calcular el correlativo numérico según la cantidad de registros existentes
                select count(*)
                into correlativo_numerico
                from renlim."CIRCUNSCRIPCION" as cr 
                where (cr."iCodProvCircunscripcion" <> 0 and cr."iCodProvCircunscripcion"  is not null ) and (cr."iCodDepCircunscripcion" <> 0 and cr."iCodDepCircunscripcion" is not null)
                and cr."bActivo" =  True and cr."vCodigoUnicoIdentificacion" IS NOT NULL;
                
                correlativo_numerico := correlativo_numerico + 1;

                -- Generar correlativo para Distrito
                correlativo := 'CIDI' || LPAD(correlativo_numerico::text, 4, '0');
            END IF;
            
            -- Actualizar la columna "vCodigoUnicoIdentificacion" con el correlativo generado
            UPDATE renlim."CIRCUNSCRIPCION"
            SET "vCodigoUnicoIdentificacion" = correlativo
            WHERE "iCodCircunscripcion" = v_idcircunscripcion;
        ELSE
            -- Si la columna ya tiene un valor, no hacer nada
            RETURN;
        END IF;
		
	END;

$procedure$;

 

 


 


 
 
CREATE OR REPLACE PROCEDURE renac.usp_constancia_anotacion_renac(
	IN p_idinformerenac integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin

    CALL renac.usp_generar_correlativo_constancia_anotacion(p_idinformerenac);

	OPEN p_cursor FOR
    SELECT
        DATE(T."fechainforme") AS fecha_informe,
        T."derivacion_sub_ssatdot" AS der_sub_ssatdot,
        T."opinion_favorable" as der_esp_ssatdot,
        T."derivacion_sub_ssiat" AS der_sub_ssiat,
        T."informe_renac" AS informe_renac_registro,
        case when T."cantidad_asientos" > 1 then 'y sus respectivos asientos' else 'y su respectivo asiento' end as asientos_desc,
        CONCAT(' del ', T."tipo_circunscripcion", ' de ', T."nombrecircunscripcion") AS circ_desc ,
        CONCAT(' del ', T."tipo_circunscripcion", ' de ', T."nombrecircunscripcion",
        (select case when T.cantidad_asientos > 1 then ' y ' || fn_numero_a_palabra || ' ('|| T.cantidad_asientos ||') asientos' else ' ' || fn_numero_a_palabra || ' ('|| T.cantidad_asientos ||') asiento' end  from renac.fn_numero_a_palabra(T.cantidad_asientos))) as circ_asientos,    
        T."descripcion_gobierno" as circ_entidad,
        T."nombrecircunscripcion" as circ_nombre,
        'JHON JAMES BERAÚN CHACA' as analista_nombres,
        T."titulo_circunscripcion" as circ_titulo,        
        T."subtitulo_circunscripcion" as circ_subtitulo,
        T."circunscripcion_seccion" as circ_secc,
        T."codigo_unico_identificacion" as circ_cod
    FROM
        (SELECT 
            CURRENT_TIMESTAMP as "fechainforme",    
            CONCAT(sq1."tipodocumento", ' N° ', sq1."numdocumento", ' de fecha ', sq1."fechadocumento") as derivacion_sub_ssatdot,
            CONCAT('N° ', ir.informefavorablenumero, ' de fecha ', TO_CHAR( ir."informefavorablefecha" , 'DD/MM/YYYY')) as opinion_favorable,
            CONCAT(sq2."tipodocumento", ' N° ', sq2."numdocumento", ' de fecha ', sq2."fechadocumento") as derivacion_sub_ssiat,
            CONCAT('N° ', ir."numero", ' de fecha ', TO_CHAR(ir."fecha" , 'DD/MM/YYYY')) as informe_renac,    
            (SELECT COUNT(*) FROM renac."ASIENTO_CIRCUNSCRIPCION" as ac WHERE ir."idInformeRenac" = ac."idInformeRenac" and ir."activo" = true) as cantidad_asientos,
            pt."Descripcion" as tipo_circunscripcion,
            CASE
                WHEN cr."iCodDepCircunscripcion" IS NULL OR cr."iCodDepCircunscripcion" = 0 THEN initcap(CONCAT('Departamento de ', cr."vNomCircunscripcion"))
                WHEN cr."iCodProvCircunscripcion" IS NULL OR cr."iCodProvCircunscripcion" = 0 THEN initcap(CONCAT(cr."vNomCircunscripcion", ' perteneciente al departamento de ', cr_1."vNomCircunscripcion"))
                ELSE initcap(CONCAT(cr."vNomCircunscripcion", ' perteneciente a la provincia de ', cr_2."vNomCircunscripcion", ' - departamento de ', cr_1."vNomCircunscripcion"))
            END AS nombrecircunscripcion,
            CASE
                WHEN cr."iCodDepCircunscripcion" IS NULL OR cr."iCodDepCircunscripcion" = 0 THEN initcap(CONCAT('del departamento de ', cr."vNomCircunscripcion"))
                WHEN cr."iCodProvCircunscripcion" IS NULL OR cr."iCodProvCircunscripcion" = 0 THEN initcap(CONCAT('de la provincia de ', cr_2."vNomCircunscripcion"))
                ELSE initcap(CONCAT('del distrito de ', cr."vNomCircunscripcion"))
            END AS titulo_circunscripcion,
            CASE
                WHEN cr."iCodDepCircunscripcion" IS NULL OR cr."iCodDepCircunscripcion" = 0 THEN UPPER(CONCAT('DEPARTAMENTO DE ', cr."vNomCircunscripcion"))
                WHEN cr."iCodProvCircunscripcion" IS NULL OR cr."iCodProvCircunscripcion" = 0 THEN UPPER(CONCAT('PROVINCIA DE ', cr_2."vNomCircunscripcion"))
                ELSE UPPER(CONCAT('DISTRITO DE ', cr."vNomCircunscripcion"))
            END AS subtitulo_circunscripcion,            
            CASE
                WHEN cr."iCodDepCircunscripcion" IS NULL OR cr."iCodDepCircunscripcion" = 0 THEN 'DEPARTAMENTAL'
                WHEN cr."iCodProvCircunscripcion" IS NULL OR cr."iCodProvCircunscripcion" = 0 THEN 'PROVINCIAL'
                ELSE 'DISTRITAL'
            END AS circunscripcion_seccion,
            CASE
                WHEN (LOWER(pt."Descripcion") like '%distrito%' and LOWER(cr_1."vNomCircunscripcion") like '%lima%') THEN ' a la Municipalidad Metropolitana de Lima'
                ELSE ' al Gobierno Regional' END as descripcion_gobierno,
            CASE
                WHEN LOWER(pt."Descripcion") like '%distrito%' THEN 3
                WHEN LOWER(pt."Descripcion") like '%provincia%' THEN 2
                WHEN LOWER(pt."Descripcion") like '%departamento%' THEN 1 ELSE 0 END cod_seccion,
                cr."vCodigoUnicoIdentificacion" as codigo_unico_identificacion
            FROM
                renac."INFORME_RENAC" as ir
            INNER JOIN renlim."CIRCUNSCRIPCION" as cr ON ir."idCircunscripcion" = cr."iCodCircunscripcion"
            INNER JOIN renlim."PARTABLA" as pt on cr."iTipCircunscripcion" = pt."IdTabla"
            LEFT JOIN renlim."CIRCUNSCRIPCION" cr_1 ON cr."iCodDepCircunscripcion" = cr_1."iCodCircunscripcion"
            LEFT JOIN renlim."CIRCUNSCRIPCION" cr_2 ON cr."iCodProvCircunscripcion" = cr_2."iCodCircunscripcion"
            LEFT JOIN (
                SELECT 
                    t5."descripcion" as tipodocumento,
                    t4."numeroDocumento" as numdocumento,
                    TO_CHAR( t4."fechaDocumento" , 'DD/MM/YYYY') as fechadocumento
                FROM 
                    renac."DERIVACION_RENAC" as t1
                INNER JOIN renac."INFORME_DERIVACION" as t2 on t1."idDerivacionRenac" = t2."idDerivacionRenac"
                INNER JOIN renac."PARAMETRICAS_RENAC" as t3 on t1."idDerivacionOrigen" = t3."idParametricasRenac"
                INNER JOIN renac."DOCUMENTO_DERIVACION" as t4 on t1."idDerivacionRenac" = t4."idDerivacionRenac"
                INNER JOIN renac."TIPO_DOCUMENTO_RENAC" as t5 on t4."idTipoDocumentoRenac" = t5."idTipoDocumentoRenac"
                WHERE
                    t2."idInformeRenac" = p_idinformerenac and
                    t1."esRetorno" = false and t1."activo" = true and
                    t2."activo" = true and
                    t3."codigo" = '50' and t3."idGrupo" = 1001 and t3."activo" = true and
                    t4."activo" = true
                ORDER BY t1."fechaReg" DESC 
                LIMIT 1
            ) as sq1 ON ir."idInformeRenac" = p_idinformerenac
            LEFT JOIN (
                SELECT 
                    t6."descripcion" as tipodocumento,
                    t5."numeroDocumento" as numdocumento,
                    TO_CHAR( t5."fechaDocumento" , 'DD/MM/YYYY') as fechadocumento
                FROM 
                    renac."DERIVACION_RENAC" as t1
                INNER JOIN renac."INFORME_DERIVACION" as t2 on t1."idDerivacionRenac" = t2."idDerivacionRenac"
                LEFT JOIN renac."PARAMETRICAS_RENAC" as t3 on t1."idDerivacionOrigen" = t3."idParametricasRenac"
                INNER JOIN renac."PARAMETRICAS_RENAC" as t4 on t1."idDerivacionDestino" = t4."idParametricasRenac"
                INNER JOIN renac."DOCUMENTO_DERIVACION" as t5 on t1."idDerivacionRenac" = t5."idDerivacionRenac"
                INNER JOIN renac."TIPO_DOCUMENTO_RENAC" as t6 on t5."idTipoDocumentoRenac" = t6."idTipoDocumentoRenac"
                WHERE
                    t2."idInformeRenac" = p_idinformerenac and
                    t1."esRetorno" = false and t1."activo" = true and
                    t2."activo" = true and
                    t3."codigo" = '20' and t3."idGrupo" = 1001 and t3."activo" = true and
                    t4."codigo" = '30' and t4."idGrupo" = 1001 and t4."activo" = true and
                    t5."activo" = true
                ORDER BY t1."fechaReg" DESC 
                LIMIT 1
            ) as sq2 ON ir."idInformeRenac" = p_idinformerenac
        WHERE
        ir."idInformeRenac" = p_idinformerenac) AS T;
		
end;
$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_constancia_anotacion_renac_asientos(
	IN p_idinformerenac integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

	BEGIN

		OPEN p_cursor FOR
		SELECT     
			CONCAT('Ficha: ', (select fn_numero_a_palabra_enumerado from renac.fn_numero_a_palabra_enumerado(CAST(T."rownum" AS integer))), ' asiento de la partida registral del ', T."circ_titulo_1") as asiento_titulo,
			COALESCE(T.circ_titulo_2, '') as asiento_subtitulo,
			'DATOS DEL ASIENTO REGISTRAL: ' as asiento_datos_titulo,
    		COALESCE(T.asiento_numero, '') as asiento_numero,
			'DATOS DEL DISPOSITIVO LEGAL: ' as norma_titulo,
			COALESCE(T.norma_tipo, '') as norma_tipo,
			COALESCE(T.norma_numero, '') as norma_numero,
			COALESCE(T.norma_fecha, CURRENT_TIMESTAMP) as norma_fecha,
			'INFORMACIÓN BÁSICA DE LA CIRCUNSCRIPCIÓN: ' as circ_informacion_titulo,
			COALESCE(T.circ_nombre, '') as circ_nombre,
			COALESCE(T.circ_capital, '') as circ_capital,
			COALESCE(T.circ_departamento, '') as circ_departamento,
			COALESCE(T.circ_provincia, '') as circ_provincia,
			'INFORMACIÓN COMPLEMENTARIA: ' as info_complementaria_titulo,
			COALESCE(T.circ_infocomplementaria, '') as circ_infocomplementaria
		FROM (
			select
				ROW_NUMBER() OVER (ORDER BY ac."fechaReg") AS rownum,
				ac."numeroAsiento" as asiento_numero,
				tn."Descripcion" as norma_tipo,
				nr."vNumero" as norma_numero,
				nr."dFecha" as norma_fecha,
				ac."nombreCircunscripcion" as circ_nombre,
				ac."nombreCapital" as circ_capital,
				ac."nombreDepartamento" as circ_departamento,
				ac."nombreProvincia" as circ_provincia,
				ac."informacionComplementaria" as circ_infocomplementaria,
				CASE
					WHEN cr1."iCodDepCircunscripcion" IS NULL OR cr1."iCodDepCircunscripcion" = 0 THEN CONCAT('departamento de ', initcap(cr1."vNomCircunscripcion"))
					WHEN cr1."iCodProvCircunscripcion" IS NULL OR cr1."iCodProvCircunscripcion" = 0 THEN CONCAT('provincia de ', initcap(cr1."vNomCircunscripcion"))
					ELSE CONCAT('distrito de ', initcap(cr1."vNomCircunscripcion"))
				END AS circ_titulo_1,
				CASE
					WHEN cr1."iCodDepCircunscripcion" IS NULL OR cr1."iCodDepCircunscripcion" = 0 THEN CONCAT('DEPARTAMENTO ', upper(cr1."vNomCircunscripcion"))
					WHEN cr1."iCodProvCircunscripcion" IS NULL OR cr1."iCodProvCircunscripcion" = 0 THEN CONCAT('PROVINCIA ', upper(cr1."vNomCircunscripcion"))
					ELSE CONCAT('DISTRITO ', upper(cr1."vNomCircunscripcion"))
				END AS circ_titulo_2
			from 
				renac."ASIENTO_CIRCUNSCRIPCION" as ac
				inner join renac."INFORME_RENAC" as ir on ac."idInformeRenac" = ir."idInformeRenac"
				inner join renlim."NORMA" as nr on ac."idDispositivo" = nr."iCodNorma"
				inner join renlim."PARTABLA" tn on nr."iTipo" = tn."IdTabla"
				inner join renlim."CIRCUNSCRIPCION" cr1 on ir."idCircunscripcion" = cr1."iCodCircunscripcion"
				left join renlim."CIRCUNSCRIPCION" cr2 on cr1."iCodProvCircunscripcion" = cr2."iCodCircunscripcion"
				left join renlim."CIRCUNSCRIPCION" cr3 on cr2."iCodDepCircunscripcion" = cr3."iCodCircunscripcion"
			where
				ac."activo" = True and
				ac."idInformeRenac" = p_idinformerenac
		) AS T;
			
	END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_responsable_archivo_derivarsolicitud (
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying 
)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" <> '80'
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;


		-- 4. Validamos que los informes a derivar, tengan registrado Oficio de solicitud de información

		IF NOT p_error THEN

		FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE 
                        ir."idInformeRenac" = v_idinformerenac AND 
                        (ir."oficioSolicitudNumero" IS NULL OR ir."oficioSolicitudFecha" IS NULL OR ir."oficioSolicitudArchivo" IS NULL)
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' no tiene registrado su Oficio de solicitud de información, debe regularizarlo para poder derivar el informe.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;



		-- 5. Validamos que todos los informes tengan registrado su Evidencia de solicitud de información

		IF NOT p_error THEN

		FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac AND 
                        (ir."evidenciaSolicitudFecha" IS NULL OR ir."evidenciaSolicitudArchivo" IS NULL)
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe número ' || v_descinforme || ' no tiene registrado la Evidencia de solicitud de información, debe regularizarlo para poder derivar el informe.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '80'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '90'
			LIMIT 1;


			-- se inserta la informacion de la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;


			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;
		

			--3. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '90' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Especialista SSIAT se realizó con éxito';
			p_error := false;
		
		END IF;
	
	END;

$procedure$;






CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_registrarconstancia (
	IN  p_idinformerenac integer,
	IN  p_constanciaanotacionarchivo character varying,
    IN  p_usuariomod character varying,
	OUT p_error boolean,
	OUT p_message character varying 
)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_descinforme varchar;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;


		-- 1. Valida que llegue el id del informe renac

		IF p_idinformerenac IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar un informe';
		END IF;


		-- 2. Valida que el valor del archivo tenga valor

		IF NOT p_error THEN

			IF p_constanciaanotacionarchivo IS NULL THEN
				p_error := true;
				p_message := 'Debe seleccionar el archivo de anotacion';
			END IF;

		END IF;


		-- 3. Validamos que la circunscripcion del informe ya haya generado su contancia anotacion

		IF NOT p_error THEN

			IF NOT EXISTS (
					select 1 from
					renlim."CIRCUNSCRIPCION" as t1
					inner join renac."INFORME_RENAC" as t2 on t1."iCodCircunscripcion" = t2."idCircunscripcion"
					where t1."vCodigoUnicoIdentificacion" IS NOT NULL and t2."idInformeRenac" = p_idinformerenac
					LIMIT 1
				) THEN

				-- obtenemos los datos del informe que no cumple con la condicion
				SELECT ir."numero" FROM
				INTO v_descinforme
				renac."INFORME_RENAC" AS ir
				WHERE ir."idInformeRenac" = p_idinformerenac;

				p_error := true;
				p_message := 'Debe generar la constancia de anotación para el informe ' || v_descinforme || '.';
			END IF;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Actualizamos el valor del archivo de constancia de anotacion para el informe renac

			update renac."INFORME_RENAC"
			set 
				"constanciaAnotacionArchivo" = TRIM(BOTH FROM p_constanciaanotacionarchivo),
				"usuarioMod" = p_usuariomod
			where "idInformeRenac" = p_idinformerenac;
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Especialista SSIAT se realizó con éxito';
			p_error := false;
		
		END IF;
	
	END;

$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_respuestagore(
	IN p_respuestagorearchivo character varying,
	IN p_respuestagorenumero character varying,
	IN p_respuestagorefecha timestamp,
	IN p_listainformesrenac character varying,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE

	v_arr_idinformerenac integer[];

	BEGIN
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_listainformesrenac, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_listainformesrenac está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		
 			-- 1. Actualizamos los datos del informe de anotacion favorable sobre los informes renac

			IF p_listainformesrenac <> '' THEN

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET 
					"respuestaGoreNumero" = p_respuestagorenumero,
					"respuestaGoreFecha" = p_respuestagorefecha,
					"respuestaGoreArchivo" = CASE WHEN p_respuestagorearchivo IS NOT NULL THEN p_respuestagorearchivo ELSE "respuestaGoreArchivo" END,
					"solicitudGore" = true,
					"fechaMod" = CURRENT_TIMESTAMP,
					"usuarioMod" = p_usuarioreg
				WHERE 
					"idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_listainformesrenac, ','))::integer);

			END IF;
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'Se registró la respuesta GORE satisfactoriamente';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_retornomodificacion(
	IN p_usuarioorigen character varying,
	IN p_usuariodestino character varying,
	IN p_observaciones character varying,
	IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_activo boolean,
	IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

		-- Ejecutamos las validaciones

		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND pr."idGrupo" = 1001 
					AND (pr."codigo" <> '60' AND pr."codigo" <> '70' AND pr."codigo" <> '90')
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;

		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '90'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '10'
			LIMIT 1;

			-- insertar la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"observacion",
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_observaciones,
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;

			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;

			--3. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '10' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 4. Actualizamos los mensajes de retorno

			p_message := 'Se devolvieron los informes satisfactoriamente a SSIAT';
			p_error := false;
		
		END IF;	

	END;

$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_especialista_ssiat_derivar_anotacion(
	IN p_usuarioorigen character varying,  
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_rutadocumento character varying,
	IN p_nombredocumento character varying,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];


		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" not in('60', '70', '90')
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;



		-- 4. Validar que los informes tengan registradas la constancia de anotacion
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM  renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND   ir."constanciaAnotacionArchivo" is null
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' no tiene registrada la Constancia de Anotación.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;




		-- 5. Validar que los informes tengan registradas la Respuesta GORE
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM  renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND   (ir."solicitudGore" is null or ir."solicitudGore" = false)
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' no tiene respuesta GORE.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;



		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '90'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '95'
			LIMIT 1;


			-- se inserta la informacion de la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;


			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;


			--3. Guardamos el Proyecto Memo como documento asociado de la derivacion
			INSERT INTO renac."DOCUMENTO_DERIVACION" (
				"idDerivacionRenac",
				"rutaDocumento",
				"nombreDocumento",			
				"activo",
				"fechaReg",
				"usuarioReg"
			)
			VALUES (
				v_idderivacionrenac,
				p_rutadocumento,
				p_nombredocumento,			
				p_activo,
				CURRENT_TIMESTAMP,
				p_usuarioreg
			);


			--4. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '95' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Especialista SSIAT para la anotación se realizó con éxito';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssiat_anotacion_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",
            A."evaluacionFavorable",
			A."solicitudGore",
            A."constanciaAnotacionArchivo",
			A."respuestaGoreArchivo",
			A."constanciaAnotacionFirmadaArchivo",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN (E."codigo" = '95') THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			CASE
				WHEN (E."codigo" = '95' and E."idGrupo" = 1001) THEN false ELSE true
			END AS esderivado			
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			E."codigo" NOT IN ('10', '20', '30', '40', '50', '60', '70', '80', '90') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;


CREATE OR REPLACE PROCEDURE renac.usp_responsablearchivo_registroanotacion_insertar(
	IN p_oficioanotacionnumero character varying,
	IN p_oficioanotacionfecha timestamp,
	IN p_oficioanotacionarchivo character varying,
	IN p_evidenciaanotacionfecha timestamp,
	IN p_evidenciaanotacionarchivo character varying,
	IN p_listainformesrenac character varying,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE

	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_descinforme varchar;

	BEGIN
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_listainformesrenac, ',')::integer[];


		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_listainformesrenac está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- 2. Validamos que ninguno de los informes haya finalizado su registro de anotacion
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	ir."procesoAnotacionCerrado" = true
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue cerrado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		
 			-- 1. Actualizamos los datos del informe de anotacion favorable sobre los informes renac

			IF p_listainformesrenac <> '' THEN

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET 
					"oficioAnotacionNumero" = p_oficioanotacionnumero,
					"oficioAnotacionFecha" = p_oficioanotacionfecha,
					"oficioAnotacionArchivo" = p_oficioanotacionarchivo,
					"evidenciaAnotacionFecha" = p_evidenciaanotacionfecha,
					"evidenciaAnotacionArchivo" = p_evidenciaanotacionarchivo,
					"fechaMod" = CURRENT_TIMESTAMP,
					"usuarioMod" = p_usuarioreg
				WHERE 
					"idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_listainformesrenac, ','))::integer);

			END IF;
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'Se registraron los archivos anotación satisfactoriamente';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;




CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssiat_registrarconstancia (
	IN  p_idinformerenac integer,
	IN  p_constanciaanotacionfirmadafecha timestamp,
	IN  p_constanciaanotacionfirmadaarchivo character varying,
    IN  p_usuariomod character varying,
	OUT p_error boolean,
	OUT p_message character varying 
)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_descinforme varchar;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;


		-- 1. Valida que llegue el id del informe renac

		IF p_idinformerenac IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar un informe';
		END IF;

		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Actualizamos el valor del archivo de constancia de anotacion para el informe renac

			update renac."INFORME_RENAC"
			set 
				"constanciaAnotacionFirmadaArchivo" = CASE WHEN p_constanciaanotacionfirmadaarchivo IS NOT NULL THEN TRIM(BOTH FROM p_constanciaanotacionfirmadaarchivo) ELSE "constanciaAnotacionFirmadaArchivo" END,
				"constanciaAnotacionFirmadaFecha" = p_constanciaanotacionfirmadafecha,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			where 
				"idInformeRenac" = p_idinformerenac;
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'Se registró la anotación exitosamente.';
			p_error := false;
		
		END IF;
	
	END;

$procedure$;

 


CREATE OR REPLACE PROCEDURE renac.usp_subsecretario_ssiat_derivar_anotacion(
	IN p_usuarioorigen character varying,  
	IN p_usuariodestino character varying,
    IN p_esretorno boolean,
	IN p_derivacioninformes character varying,
	IN p_rutadocumento character varying,
	IN p_nombredocumento character varying,
	IN p_fechadocumento timestamp,
	IN p_numerodocumento varchar,
	IN p_activo boolean,
    IN p_usuarioreg character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE plpgsql
AS $procedure$

	DECLARE
	v_idderivacionrenac integer;
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_idestadoderivacion integer;
	v_descinforme varchar;
	v_idderivacionorigen integer;
	v_idderivaciondestino integer;
	v_idCircunscripcionDepartamento integer;
	v_contador_departamentos integer := 0;
    v_contador_otras_circunscripciones integer := 0;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];


		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_derivacioninformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;

		-- 2. Validamos que ninguno de los informes ya haya sido derivado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					INNER JOIN renac."PARAMETRICAS_RENAC" pr ON ir."idEstadoDerivacion" = pr."idParametricasRenac"
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	pr."idGrupo" = 1001 AND pr."codigo" not in('95')
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue derivado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que los informes renac que se esten derivando sean unicamente una lista de departamentos o exclusivamente distritos y provincias

		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP
				--obtenemos las id de las circunscripciones de tipo departamento en v_idCircunscripcionDepartamento
				select t2."iCodCircunscripcion"
				INTO v_idCircunscripcionDepartamento
				from renac."INFORME_RENAC" as t1
				inner join renlim."CIRCUNSCRIPCION" as t2 on t1."idCircunscripcion" = t2."iCodCircunscripcion"
				where  t2."iCodDepCircunscripcion" IS NULL OR t2."iCodDepCircunscripcion" = 0 
				and t1."idInformeRenac" = v_idinformerenac;

				IF (v_idCircunscripcionDepartamento IS NOT NULL) THEN
					v_contador_departamentos := v_contador_departamentos + 1;
				ELSE
					v_contador_otras_circunscripciones := v_contador_otras_circunscripciones + 1;
				END IF;
			END LOOP;

			-- Validar que todos los informes son departamentos o ninguno lo sea
			IF v_contador_departamentos > 0 AND v_contador_otras_circunscripciones > 0 THEN
				p_message := 'La lista de informes a derivar, debe contener únicamente circunscripciones de tipo departamento, y/o exclusivamente de tipo provincia y distrito.';
				p_error := true;			
			END IF;

		END IF;



		-- 4. Validar que los informes tengan registradas la constancia de anotacion firmada digitalmente
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM  renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac
					AND   ir."constanciaAnotacionFirmadaArchivo" is null
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' no tiene registrada la Constancia de Anotación firmada digitalmente.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;




		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. Se inserta la derivacion

			-- obtenemos el id del origen
			SELECT T1."idParametricasRenac"
			INTO v_idderivacionorigen
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '95'
			LIMIT 1;


			-- obtenemos el id del destino
			SELECT T1."idParametricasRenac"
			INTO v_idderivaciondestino
			FROM
				renac."PARAMETRICAS_RENAC" AS t1
			WHERE 
				t1."activo" = true AND
				t1."idGrupo" = 1001 AND
				t1."codigo" = '100'
			LIMIT 1;


			-- se inserta la informacion de la derivacion
			INSERT INTO renac."DERIVACION_RENAC" (
				"idDerivacionOrigen",
				"idDerivacionDestino",
				"fechaDerivacion", 
				"usuarioOrigen", 
				"usuarioDestino", 
				"esRetorno", 
				"activo", 
				"fechaReg", 
				"usuarioReg")
			VALUES (
				v_idderivacionorigen,
				v_idderivaciondestino,
				CURRENT_TIMESTAMP, 
				p_usuarioorigen, 
				p_usuariodestino, 
				p_esretorno, 
				p_activo, 
				CURRENT_TIMESTAMP, 
				p_usuarioreg)
				RETURNING "idDerivacionRenac" INTO v_idderivacionrenac;


			-- 2. Se inserta los informes en el detalle de la derivacion
			
			-- Validar si hay elementos en la lista
			IF p_derivacioninformes <> '' THEN
				-- Convertir la cadena en un array de enteros
				v_arr_idinformerenac := STRING_TO_ARRAY(p_derivacioninformes, ',')::integer[];

				-- Insertar cada valor en la tabla INFORME_DERIVACION
				FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac LOOP
					INSERT INTO renac."INFORME_DERIVACION" 
					("idDerivacionRenac", "idInformeRenac", "activo", "fechaReg", "usuarioReg") VALUES 
					(v_idderivacionrenac, v_idinformerenac, true, CURRENT_TIMESTAMP, p_usuarioreg);
				END LOOP;
			END IF;


			--3. Guardamos el Proyecto Memo como documento asociado de la derivacion
			INSERT INTO renac."DOCUMENTO_DERIVACION" (
				"idDerivacionRenac",
				"rutaDocumento",
				"nombreDocumento",
				"fechaDocumento",
				"numeroDocumento",
				"activo",
				"fechaReg",
				"usuarioReg"
			)
			VALUES (
				v_idderivacionrenac,
				p_rutadocumento,
				p_nombredocumento,
				p_fechadocumento,
				p_numerodocumento,
				p_activo,
				CURRENT_TIMESTAMP,
				p_usuarioreg
			);


			--4. Actualizamos los estados de derivacion de los informes

			IF p_derivacioninformes <> '' THEN

				--obtenemos el id del estado de derivacion correspondiente
				SELECT A."idParametricasRenac"
				INTO v_idestadoderivacion
				FROM renac."PARAMETRICAS_RENAC" AS A
				WHERE A."idGrupo" = 1001 AND A."codigo" = '100' AND A."activo" = true
				ORDER BY A."idParametricasRenac" DESC
				LIMIT 1;

				--actualizamos el estado de derivacion en los informes
				UPDATE renac."INFORME_RENAC"
				SET "idEstadoDerivacion" = v_idestadoderivacion
				WHERE "idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_derivacioninformes, ','))::integer);

			END IF;
			

			-- 5. Actualizamos los mensajes de retorno

			p_message := 'La derivación hacia el Responsable de Archivo para la anotación se realizó con éxito';
			p_error := false;
		
		END IF;	
	
	END;

$procedure$;





CREATE OR REPLACE PROCEDURE renac.usp_responsable_archivo_anotacion_paginado(
	IN p_filtro character varying,
	IN p_pagesize integer,
	IN p_pagenumber integer,
	OUT p_totalreg integer,
	OUT p_totpagina integer,
	OUT p_numpagina integer,
	OUT p_error boolean,
	OUT p_message character varying,
	OUT p_cursor refcursor)
LANGUAGE 'plpgsql'
AS $procedure$

DECLARE
    v_offset INTEGER;
BEGIN
    -- Inicializa las variables
    p_error := FALSE;
    p_totalReg := 0;
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);
    
    -- Validación de parámetros de paginación
    IF p_pageSize IS NULL OR p_pageNumber IS NULL OR p_pageSize = 0 THEN
        p_error := TRUE;
        p_message := 'Parametros de paginacion vacios';
        RETURN;
    END IF;

    -- Cálculo de la paginación
    v_offset := (p_pageNumber - 1) * p_pageSize;

    -- Realizar la consulta paginada
    OPEN p_cursor FOR
        SELECT
            COUNT(*) OVER () AS TotalReg,
			ROW_NUMBER() OVER (ORDER BY A."fechaReg" DESC) AS rownum,
          	A."idInformeRenac",
			A."idCircunscripcion",
			A."idEstadoDerivacion",
			A."numero",            
			A."solicitudGore",
            A."constanciaAnotacionArchivo",
			A."constanciaAnotacionFirmadaArchivo",
            A."informefavorablearchivo",
			A."respuestaGoreArchivo",
			A."procesoAnotacionCerrado",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN (A."procesoAnotacionCerrado" IS NULL OR "procesoAnotacionCerrado" = false) THEN 'Pendiente'
				ELSE 'Cerrado'
			END AS EstadoDerivacion,
			CASE
				WHEN (A."procesoAnotacionCerrado" IS NULL OR "procesoAnotacionCerrado" = false) THEN false ELSE true
			END AS esderivado			
        FROM
            			renac."INFORME_RENAC" A
			INNER JOIN 	renlim."CIRCUNSCRIPCION" B ON A."idCircunscripcion" = B."iCodCircunscripcion"
			LEFT JOIN  	renlim."CIRCUNSCRIPCION" C ON B."iCodDepCircunscripcion" = C."iCodCircunscripcion"
    		LEFT JOIN  	renlim."CIRCUNSCRIPCION" D ON B."iCodProvCircunscripcion" = D."iCodCircunscripcion"
			LEFT JOIN	renac."PARAMETRICAS_RENAC" E ON A."idEstadoDerivacion" = E."idParametricasRenac"
		WHERE
			A."activo" = true AND
			E."codigo" NOT IN ('10', '20', '30', '40', '50', '60', '70', '80', '90', '95') AND
			E."idGrupo" = 1001
        ORDER BY
            A."fechaReg" DESC
        OFFSET v_offset
        LIMIT p_pageSize;

    -- Setea los datos de paginación
    p_totPagina := COALESCE(p_pageSize, 0);
    p_numPagina := COALESCE(p_pageNumber, 0);

    -- Definir el mensaje
    IF p_totalReg > 0 THEN
        p_message := 'Consulta exitosa';
    ELSE
        p_message := 'Sin resultados';
    END IF;
END;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_responsable_archivo_cerraranotacion(
	IN p_listainformes character varying,
	IN p_usuariomod character varying,
	OUT p_error boolean,
	OUT p_message character varying)
LANGUAGE 'plpgsql'
AS $procedure$

	DECLARE
	v_arr_idinformerenac integer[];
	v_idinformerenac integer;
	v_descinforme varchar;

	BEGIN	
		
		-- Inicializa como false
		p_error := false;

		--Convertimos a Array la lista de informes
		v_arr_idinformerenac := STRING_TO_ARRAY(p_listainformes, ',')::integer[];


		-- 1. Validamos que la variable que obtiene la lista de informes tenga por lo menos un valor

		-- Verificar si p_listainformes está vacío o contiene al menos un valor
		IF array_length(v_arr_idinformerenac, 1) IS NULL THEN
			p_error := true;
			p_message := 'Debe seleccionar al menos un informe.';
		END IF;


		-- 2. Validamos que todos los informes tengan registro de anotacion
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac 
					AND (ir."oficioAnotacionArchivo" is null or ir."evidenciaAnotacionArchivo" is null)
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' no cuenta con registro de anotacion.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- 3. Validamos que ninguno de los informes anteriormente ya haya sido cerrado
		IF NOT p_error THEN

			FOREACH v_idinformerenac IN ARRAY v_arr_idinformerenac
			LOOP

				IF EXISTS (
					SELECT 1
					FROM renac."INFORME_RENAC" AS ir
					WHERE 	ir."idInformeRenac" = v_idinformerenac
					AND  	ir."procesoAnotacionCerrado" = true
					LIMIT 1
				) THEN

					-- obtenemos los datos del informe que no cumple con la condicion
					SELECT ir."numero" FROM
					INTO v_descinforme
					renac."INFORME_RENAC" AS ir
					WHERE ir."idInformeRenac" = v_idinformerenac;

					-- seteamos los mensajes de salida
					p_message := 'El informe numero ' || v_descinforme || ' ya fue cerrado.';
					p_error := true;
					EXIT;
				END IF;

			END LOOP;

		END IF;


		-- Si no ocurrió ningún error se realiza la operacion
		IF NOT p_error THEN
		

			-- 1. actualizamos el estado de informes finalizados
			UPDATE 
				renac."INFORME_RENAC"
			SET 
				"procesoAnotacionCerrado" = true,
				"usuarioMod" = p_usuariomod,
				"fechaMod" = CURRENT_TIMESTAMP
			WHERE 
				"idInformeRenac" IN (SELECT unnest(STRING_TO_ARRAY(p_listainformes, ','))::integer);
			

			-- 2. Actualizamos los mensajes de retorno

			p_message := 'Se cerraros los procesos de anotacion de manera satisfactoria.';
			p_error := false;
		
		END IF;	

	END;

$procedure$;

 


















































/*
	MODULO DE CONSULTA DE CIRCUNSCRIPCIONES
*/

CREATE OR REPLACE FUNCTION renac.fn_consultas_circunscripciones_totales()
RETURNS TABLE (
  total_partidas_anotadas INT,
  total_asientos_registrales INT
) AS $$
DECLARE
  total_pa INT;
  total_ar INT;
BEGIN

 	-- obtener el total de informes renac - Partidas Registrales Anotadas

	CAST(COUNT(*) AS INT) INTO total_pa
	from renac."INFORME_RENAC" as t1
	where
	t1."constanciaAnotacionFirmadaFecha" is not null
	and t1."activo" = true
	and t1."archivado" = false;


 	-- obtener el total de asientos  - Asientos Registrales Anotadas

	SELECT
	CAST(COUNT(*) AS INT) INTO total_ar
	FROM renac."INFORME_RENAC" AS t1
	INNER JOIN renac."ASIENTO_CIRCUNSCRIPCION" AS t2 ON t1."idInformeRenac" = t2."idInformeRenac"
	WHERE
	t1."constanciaAnotacionFirmadaFecha" is not null
	and t1."activo" = true 
	and t1."archivado" = false
	and t2."activo" = true;

  RETURN QUERY SELECT total_pa, total_ar;
END;
$$ LANGUAGE plpgsql;








CREATE OR REPLACE PROCEDURE renac.usp_consultas_circunscripciones_lista(
	IN p_nomcircunscripcion character varying,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		select
			A.rownum,
			A.numero ,
			A.tipoCircunscripcion,
			INITCAP(A.NombreCircunscripcion) as NombreCircunscripcion
		from (
				SELECT 
				ROW_NUMBER() OVER (ORDER BY t."fechaReg" DESC) AS rownum,
				TRIM(t."numero") numero,
				t4."Descripcion" as tipoCircunscripcion,
				CASE
					WHEN (t1."iCodDepCircunscripcion" IS NULL OR t1."iCodDepCircunscripcion" = 0) THEN t1."vNomCircunscripcion"
					WHEN (t1."iCodProvCircunscripcion" IS NULL OR t1."iCodProvCircunscripcion" = 0) THEN CONCAT_WS(' / ', t3."vNomCircunscripcion", t1."vNomCircunscripcion")
					ELSE CONCAT(t1."vNomCircunscripcion", ' ( ', t2."vNomCircunscripcion", ' / ', t3."vNomCircunscripcion", ' )')
				END AS NombreCircunscripcion
				FROM
					renac."INFORME_RENAC" as t
					INNER JOIN renlim."CIRCUNSCRIPCION" t1 ON t."idCircunscripcion" = t1."iCodCircunscripcion"
					LEFT JOIN renlim."CIRCUNSCRIPCION" t2 ON t1."iCodProvCircunscripcion" = t2."iCodCircunscripcion"
					LEFT JOIN renlim."CIRCUNSCRIPCION" t3 ON t1."iCodDepCircunscripcion" = t3."iCodCircunscripcion"
					INNER JOIN renlim."PARTABLA" t4 ON t1."iTipCircunscripcion" = t4."IdTabla"
				where 
					t."activo" = true
				and t."archivado" = false
				and "constanciaAnotacionFirmadaFecha" is not null
			) as A
		where
		LOWER(TRIM(COALESCE(A.NombreCircunscripcion, ''))) ILIKE '%' || LOWER(TRIM(p_nomcircunscripcion)) || '%';

end;
$procedure$;



CREATE OR REPLACE PROCEDURE renac.usp_consultas_asientos_lista(
	IN p_idinformerenac integer,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		select
		ROW_NUMBER() OVER (ORDER BY t1."fechaReg" DESC) AS rownum,
		t1."idAsientoCircunscripcion",
		t1."numeroAsiento",
		t3."Abreviado" as norma_tipo,
		t2."vNumero" as norma_numero,
		t2."dFecha" as norma_fecha,
		t2."vArchivo" as norma_archivo
		from
		renac."ASIENTO_CIRCUNSCRIPCION" as t1
		INNER JOIN renlim."NORMA" t2 ON (t1."idDispositivo" = t2."iCodNorma")
		INNER JOIN renlim."PARTABLA" t3 ON t2."iTipo" = t3."IdTabla"
		where 
		t1."activo" = true
		and t1."idInformeRenac" = p_idinformerenac
		order by t1."fechaReg" desc;

end;
$procedure$;

 
 
 
-- SELECT
--   t1."numero",
--   CASE
--     WHEN (c1."iCodDepCircunscripcion" <> 0 and c1."iCodProvCircunscripcion" <> 0) THEN c1."vNomCircunscripcion"
--     ELSE '-'
--   END AS Distrito,
--   CASE
--     WHEN (c1."iCodDepCircunscripcion" <> 0 and c1."iCodProvCircunscripcion" = 0) THEN c1."vNomCircunscripcion"
--     WHEN (c1."iCodDepCircunscripcion" <> 0 and c1."iCodProvCircunscripcion" <> 0) THEN c2."vNomCircunscripcion"
--     ELSE '--'
--   END AS Provincia,
--   CASE
--     WHEN (c1."iCodDepCircunscripcion" = 0) THEN c1."vNomCircunscripcion"
--     ELSE c3."vNomCircunscripcion"
--   END AS Departamento
-- FROM
--   renac."INFORME_RENAC" AS t1
-- INNER JOIN
--   renlim."CIRCUNSCRIPCION" AS c1 ON t1."idCircunscripcion" = c1."iCodCircunscripcion"
-- LEFT JOIN
--   renlim."CIRCUNSCRIPCION" c2 ON c1."iCodProvCircunscripcion" = c2."iCodCircunscripcion"
-- LEFT JOIN
--   renlim."CIRCUNSCRIPCION" c3 ON c1."iCodDepCircunscripcion" = c3."iCodCircunscripcion"
-- WHERE
--   t1."activo" = true;

 
 















CREATE OR REPLACE FUNCTION renac.fn_numero_a_palabra(num INT) RETURNS TEXT AS $$
DECLARE
    resultado TEXT;
BEGIN
    
    IF num >= 1 AND num <= 100 THEN
        CASE
            WHEN num <= 9 THEN
                resultado := CASE num
                    WHEN 1 THEN 'un'
                    WHEN 2 THEN 'dos'
                    WHEN 3 THEN 'tres'
                    WHEN 4 THEN 'cuatro'
                    WHEN 5 THEN 'cinco'
                    WHEN 6 THEN 'seis'
                    WHEN 7 THEN 'siete'
                    WHEN 8 THEN 'ocho'
                    WHEN 9 THEN 'nueve'
                END;
            WHEN num <= 19 THEN
                resultado := CASE num
                    WHEN 10 THEN 'diez'
                    WHEN 11 THEN 'once'
                    WHEN 12 THEN 'doce'
                    WHEN 13 THEN 'trece'
                    WHEN 14 THEN 'catorce'
                    WHEN 15 THEN 'quince'
                    ELSE 'dieci' || resultado
                END;
            WHEN num <= 99 THEN
                resultado := CASE num / 10
                    WHEN 2 THEN 'veinti' || resultado
                    WHEN 3 THEN 'treinta' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                    WHEN 4 THEN 'cuarenta' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                    WHEN 5 THEN 'cincuenta' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                    WHEN 6 THEN 'sesenta' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                    WHEN 7 THEN 'setenta' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                    WHEN 8 THEN 'ochenta' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                    WHEN 9 THEN 'noventa' || CASE num % 10
                        WHEN 0 THEN ''
                        ELSE ' y ' || resultado
                    END
                END;
            ELSE
                resultado := 'cien';
        END CASE;

    ELSE
        resultado:= '<<indeterminated>>';
    END IF;


    return resultado;    

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION renac.fn_numero_a_palabra_enumerado(num INT) RETURNS TEXT AS $$
DECLARE
    resultado TEXT;
BEGIN
    
    IF num >= 1 AND num <= 100 THEN
        CASE
            WHEN num <= 9 THEN
                resultado := CASE num
                    WHEN 1 THEN 'Primer'
                    WHEN 2 THEN 'Segundo'
                    WHEN 3 THEN 'Tercero'
                    WHEN 4 THEN 'Cuarto'
                    WHEN 5 THEN 'Quinto'
                    WHEN 6 THEN 'Sexto'
                    WHEN 7 THEN 'Séptimo'
                    WHEN 8 THEN 'Octavo'
                    WHEN 9 THEN 'Noveno'
                END;
            WHEN num <= 19 THEN
                resultado := CASE num
                    WHEN 10 THEN 'Décimo'
                    WHEN 11 THEN 'Onceavo'
                    WHEN 12 THEN 'Doceavo'
                    WHEN 13 THEN 'Treceavo'
                    WHEN 14 THEN 'Catorceavo'
                    WHEN 15 THEN 'Decimoquinto'
                    ELSE '-'
                END;
            ELSE
                resultado := '-';
        END CASE;

    ELSE
        resultado:= '-';
    END IF;


    return resultado;    

END;
$$ LANGUAGE plpgsql;


 


/*
	RENLIM
*/





CREATE OR REPLACE PROCEDURE renac.usp_circunscripcion_seleccionar(
	IN p_codcircunscripcion integer, 
	IN p_tipcircunscripcion integer,
	IN p_nomcircunscripcion character varying,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."iCodCircunscripcion",
			CASE
				WHEN A."iCodDepCircunscripcion" IS NULL OR A."iCodDepCircunscripcion" = 0 THEN A."vNomCircunscripcion"
				WHEN A."iCodProvCircunscripcion" IS NULL OR A."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', B."vNomCircunscripcion", A."vNomCircunscripcion")
				ELSE CONCAT(A."vNomCircunscripcion", ' ( ', C."vNomCircunscripcion", ' / ', B."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			A."vNomCircunscripcion",
			A."iTipCircunscripcion",
			A."iCodDepCircunscripcion",
			A."iCodProvCircunscripcion",
			A."bActivo",
			A."dFechaReg",
			A."dFechaMod",
			A."vUsuarioReg",
			A."vUsuarioMod"
		FROM
			renlim."CIRCUNSCRIPCION" A
			LEFT JOIN renlim."CIRCUNSCRIPCION" B ON A."iCodDepCircunscripcion" = B."iCodCircunscripcion"
    		LEFT JOIN renlim."CIRCUNSCRIPCION" C ON A."iCodProvCircunscripcion" = C."iCodCircunscripcion"
		WHERE
			(p_codcircunscripcion = 0 or A."iCodCircunscripcion" = p_codcircunscripcion) AND
			(p_tipcircunscripcion = 0 or A."iTipCircunscripcion" = p_tipcircunscripcion) AND
			(p_nomcircunscripcion IS NULL OR ( TRIM(COALESCE(A."vNomCircunscripcion", '')) ) ILIKE '%' || p_nomcircunscripcion || '%'  ) AND
			A."bActivo" = true;
		
end;
$procedure$
;
 
 
 
 CREATE OR REPLACE PROCEDURE renac.usp_tipo_circunscripcion_seleccionar(
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."IdTabla",
			A."Descripcion",
			A."Abreviado"
		FROM
			renlim."PARTABLA" A
		WHERE
			A."Grupo" = 11000 AND
			A."Orden" IN (1,2,3)
		ORDER BY
			A."Orden";
		
end;
$procedure$
;


CREATE OR REPLACE PROCEDURE renac.usp_tipo_dispositivo_seleccionar(
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."IdTabla",
			A."Descripcion",
			A."Abreviado"
		FROM
			renlim."PARTABLA" A
		WHERE
			A."Grupo" = 4000 AND
			A."Orden" <> 0
		ORDER BY
			A."Orden";
		
end;
$procedure$;


CREATE OR REPLACE PROCEDURE renac.usp_norma_seleccionar(
	IN p_codnorma integer, 
	IN p_tipo integer,
	IN p_numero character varying,
	IN p_fecha timestamp without time zone,
	OUT p_cursor refcursor
	)
 LANGUAGE plpgsql
AS $procedure$

begin
	OPEN p_cursor FOR
		SELECT
			A."iCodNorma",
			A."iTipo",
			A."vNumero",
			A."dFecha",
			A."vArchivo",
			A."bActivo",
			A."dFechaReg",
			A."dFechaMod",
			A."vUsuarioReg",
			A."vUsuarioMod",
			B."IdTabla",
			B."Descripcion",
			B."Abreviado"
		FROM
			renlim."NORMA" A
			INNER JOIN renlim."PARTABLA" B ON A."iTipo" = B."IdTabla"
		WHERE
			(p_codnorma = 0 OR A."iCodNorma" = p_codnorma) AND
			(p_tipo = 0 OR A."iTipo" = p_tipo) AND
			(p_numero IS NULL OR ( TRIM(COALESCE(A."vNumero", '')) ) ILIKE '%' || p_numero || '%'  ) AND
			(p_fecha IS NULL OR A."dFecha" = p_fecha) AND
			A."bActivo" = true;
		
end;
$procedure$
;



-- COMANDS

/*

	--DROP PROCEDURE IF EXISTS renac.usp_my_custom_transaction;


*/