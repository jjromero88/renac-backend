PGDMP          6                 {         	   RENLIM_DB    15.2    15.3    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    50130 	   RENLIM_DB    DATABASE     }   CREATE DATABASE "RENLIM_DB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Peru.1252';
    DROP DATABASE "RENLIM_DB";
                postgres    false                        2615    50131    renac    SCHEMA        CREATE SCHEMA renac;
    DROP SCHEMA renac;
                postgres    false                        2615    50132    renlim    SCHEMA        CREATE SCHEMA renlim;
    DROP SCHEMA renlim;
                postgres    false                       1255    50133 /   fn_asiento_circunscripcion_seleccionar(integer)    FUNCTION     `  CREATE FUNCTION renac.fn_asiento_circunscripcion_seleccionar(p_idasientocircunscripcion integer) RETURNS TABLE(idasientocircunscripcion integer, idinformerenac integer, idtipoasiento integer, iddispositivo integer, descripcion character varying, nombrecircunscripcion character varying, nombrecapital character varying, nombreprovincia character varying, nombredepartamento character varying, informacioncomplementaria character varying, fechaanotacion timestamp without time zone, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying, informerenac_idinformerenac integer, informerenac_idcircunscripcion integer, informerenac_numero character varying, informerenac_fecha date, informerenac_descripcion character varying, tipoasiento_idtipoasiento integer, tipoasiento_codigo integer, tipoasiento_descripcion character varying, norma_codnorma integer, norma_tipo integer, norma_numero character varying, norma_archivo character varying, norma_fecha date, tipodispositivo_descripcion character varying, detallesmodificacion text)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY
    SELECT
	A."idAsientoCircunscripcion", 
	A."idInformeRenac", 
	A."idTipoAsiento",
	A."idDispositivo",
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
$$;
 `   DROP FUNCTION renac.fn_asiento_circunscripcion_seleccionar(p_idasientocircunscripcion integer);
       renac          postgres    false    6            �            1259    50134    sec_asiento_modificacion    SEQUENCE     �   CREATE SEQUENCE renac.sec_asiento_modificacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renac.sec_asiento_modificacion;
       renac          postgres    false    6            �            1259    50135    ASIENTO_MODIFICACION    TABLE     �  CREATE TABLE renac."ASIENTO_MODIFICACION" (
    "idAsientoModificacion" integer DEFAULT nextval('renac.sec_asiento_modificacion'::regclass) NOT NULL,
    "idAsientoCircunscripcion" integer NOT NULL,
    "idTipoModificacionAsiento" integer NOT NULL,
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 )   DROP TABLE renac."ASIENTO_MODIFICACION";
       renac         heap    postgres    false    216    6                       1255    50141 ,   fn_asiento_modificacion_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_asiento_modificacion_seleccionar(p_idasientomodificacion integer) RETURNS SETOF renac."ASIENTO_MODIFICACION"
    LANGUAGE plpgsql
    AS $$
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
$$;
 Z   DROP FUNCTION renac.fn_asiento_modificacion_seleccionar(p_idasientomodificacion integer);
       renac          postgres    false    6    217            �            1259    50142 "   sec_circunscripcion_origen_destino    SEQUENCE     �   CREATE SEQUENCE renac.sec_circunscripcion_origen_destino
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE renac.sec_circunscripcion_origen_destino;
       renac          postgres    false    6            �            1259    50143    CIRCUNSCRIPCION_ORIGEN_DESTINO    TABLE     )  CREATE TABLE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" (
    "idCircunscripcionOrigenDestino" integer DEFAULT nextval('renac.sec_circunscripcion_origen_destino'::regclass) NOT NULL,
    "idAsientoCircunscripcion" integer NOT NULL,
    "nombreCircunscripcion" character varying(150),
    "origenDestino" character varying(150),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 3   DROP TABLE renac."CIRCUNSCRIPCION_ORIGEN_DESTINO";
       renac         heap    postgres    false    218    6                        1255    50149 6   fn_circunscripcion_origen_destino_seleccionar(integer)    FUNCTION     *  CREATE FUNCTION renac.fn_circunscripcion_origen_destino_seleccionar(p_idcircunscripcionorigendestino integer) RETURNS SETOF renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
    LANGUAGE plpgsql
    AS $$
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
$$;
 m   DROP FUNCTION renac.fn_circunscripcion_origen_destino_seleccionar(p_idcircunscripcionorigendestino integer);
       renac          postgres    false    6    219            !           1255    50150 (   fn_derivacion_renac_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_derivacion_renac_seleccionar(p_idderivacionrenac integer) RETURNS TABLE(idderivacionrenac integer, idderivacionorigen integer, idderivaciondestino integer, idespecialistassatdot character varying, fechaderivacion timestamp without time zone, usuarioorigen character varying, usuariodestino character varying, observacion character varying, esretorno boolean, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 R   DROP FUNCTION renac.fn_derivacion_renac_seleccionar(p_idderivacionrenac integer);
       renac          postgres    false    6            "           1255    50151 ,   fn_documento_derivacion_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_documento_derivacion_seleccionar(p_iddocumentoderivacion integer) RETURNS TABLE(iddocumentoderivacion integer, idderivacionrenac integer, idtipodocumentorenac integer, rutadocumento character varying, nombredocumento character varying, fechadocumento timestamp without time zone, numerodocumento character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 Z   DROP FUNCTION renac.fn_documento_derivacion_seleccionar(p_iddocumentoderivacion integer);
       renac          postgres    false    6            $           1255    50152 (   fn_informacion_ssiat_documentos(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_informacion_ssiat_documentos(p_idinformerenac integer) RETURNS TABLE(informeanotacion character varying, proyectomemo_espssiat character varying, proyectomemo_subssiat character varying, numero_partida character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 O   DROP FUNCTION renac.fn_informacion_ssiat_documentos(p_idinformerenac integer);
       renac          postgres    false    6            %           1255    50153 *   fn_informe_derivacion_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_informe_derivacion_seleccionar(p_idinformederivacion integer) RETURNS TABLE(idinformederivacion integer, idinformerenac integer, idderivacionrenac integer, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 V   DROP FUNCTION renac.fn_informe_derivacion_seleccionar(p_idinformederivacion integer);
       renac          postgres    false    6            &           1255    50154 %   fn_informe_renac_seleccionar(integer)    FUNCTION     �	  CREATE FUNCTION renac.fn_informe_renac_seleccionar(p_idinformerenac integer) RETURNS TABLE(idinformerenac integer, idcircunscripcion integer, idestadoderivacion integer, numero character varying, fecha date, descripcion character varying, urlinformesustento character varying, nombreinformesustento character varying, evaluacionfavorable boolean, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying, vnomcircunscripcion character varying, itipcircunscripcion integer, nombrecircunscripcion text, tipocircunscripcion_id integer, tipocircunscripcion_descripcion character varying, tipocircunscripcion_abreviatura character varying, esderivado boolean)
    LANGUAGE plpgsql
    AS $$
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
			END AS esderivado
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
$$;
 L   DROP FUNCTION renac.fn_informe_renac_seleccionar(p_idinformerenac integer);
       renac          postgres    false    6            '           1255    50155 *   fn_parametricas_renac_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_parametricas_renac_seleccionar(p_idparametricasrenac integer) RETURNS TABLE(idparametricasrenac integer, idpadre integer, idgrupo integer, codigo character varying, descripcion character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 V   DROP FUNCTION renac.fn_parametricas_renac_seleccionar(p_idparametricasrenac integer);
       renac          postgres    false    6            �            1259    50156    sec_tipo_asiento    SEQUENCE     x   CREATE SEQUENCE renac.sec_tipo_asiento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE renac.sec_tipo_asiento;
       renac          postgres    false    6            �            1259    50157    TIPO_ASIENTO    TABLE     �  CREATE TABLE renac."TIPO_ASIENTO" (
    "idTipoAsiento" integer DEFAULT nextval('renac.sec_tipo_asiento'::regclass) NOT NULL,
    descripcion character varying(250),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50),
    codigo integer
);
 !   DROP TABLE renac."TIPO_ASIENTO";
       renac         heap    postgres    false    220    6            (           1255    50163 $   fn_tipo_asiento_seleccionar(integer)    FUNCTION     }  CREATE FUNCTION renac.fn_tipo_asiento_seleccionar(p_idtipoasiento integer) RETURNS SETOF renac."TIPO_ASIENTO"
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		"idTipoAsiento",		
		"descripcion",
		"activo",
		"fechaReg",
		"fechaMod",
		"usuarioReg",
		"usuarioMod",
		"codigo"
    FROM renac."TIPO_ASIENTO"
    WHERE "idTipoAsiento" = p_idtipoasiento;
END;
$$;
 J   DROP FUNCTION renac.fn_tipo_asiento_seleccionar(p_idtipoasiento integer);
       renac          postgres    false    6    221            )           1255    50164 ,   fn_tipo_documento_renac_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_tipo_documento_renac_seleccionar(p_idtipodocumentorenac integer) RETURNS TABLE(idtipodocumentorenac integer, codigo integer, descripcion character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 Y   DROP FUNCTION renac.fn_tipo_documento_renac_seleccionar(p_idtipodocumentorenac integer);
       renac          postgres    false    6            �            1259    50165    sec_tipo_modificacion_asiento    SEQUENCE     �   CREATE SEQUENCE renac.sec_tipo_modificacion_asiento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE renac.sec_tipo_modificacion_asiento;
       renac          postgres    false    6            �            1259    50166    TIPO_MODIFICACION_ASIENTO    TABLE     �  CREATE TABLE renac."TIPO_MODIFICACION_ASIENTO" (
    "idTipoModificacionAsiento" integer DEFAULT nextval('renac.sec_tipo_modificacion_asiento'::regclass) NOT NULL,
    descripcion character varying(250),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 .   DROP TABLE renac."TIPO_MODIFICACION_ASIENTO";
       renac         heap    postgres    false    222    6            *           1255    50172 1   fn_tipo_modificacion_asiento_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_tipo_modificacion_asiento_seleccionar(p_idtipomodificacionasiento integer) RETURNS SETOF renac."TIPO_MODIFICACION_ASIENTO"
    LANGUAGE plpgsql
    AS $$
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
$$;
 c   DROP FUNCTION renac.fn_tipo_modificacion_asiento_seleccionar(p_idtipomodificacionasiento integer);
       renac          postgres    false    6    223            +           1255    50173 %  usp_asiento_circunscripcion_actualizar(integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_circunscripcion_actualizar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

    END IF;

    -- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN
       
		-- Realizar la actualización
	    UPDATE renac."ASIENTO_CIRCUNSCRIPCION" 
		SET 
			"idInformeRenac" = p_idinformerenac,
			"idTipoAsiento" = p_idtipoasiento,
			"idDispositivo" = p_iddispositivo,
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
$$;
 �  DROP PROCEDURE renac.usp_asiento_circunscripcion_actualizar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6                       1255    50175 @   usp_asiento_circunscripcion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_circunscripcion_eliminar(IN p_idasientocircunscripcion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_asiento_circunscripcion_eliminar(IN p_idasientocircunscripcion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6                       1255    50176 #  usp_asiento_circunscripcion_insertar(integer, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, boolean) 	   PROCEDURE       CREATE PROCEDURE renac.usp_asiento_circunscripcion_insertar(IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

    END IF;

	
	-- Si no ocurrió ningún error se realiza la actualización
    IF NOT p_error THEN        	

  	   
		-- Realizar la insercion del asiento
	    INSERT INTO renac."ASIENTO_CIRCUNSCRIPCION" 
			("idInformeRenac", 
			 "idTipoAsiento", 
			 "idDispositivo",
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
$$;
 �  DROP PROCEDURE renac.usp_asiento_circunscripcion_insertar(IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            ,           1255    50178 H   usp_asiento_circunscripcion_paginado(integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_circunscripcion_paginado(IN p_pagesize integer, IN p_pagenumber integer, IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 G  DROP PROCEDURE renac.usp_asiento_circunscripcion_paginado(IN p_pagesize integer, IN p_pagenumber integer, IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            -           1255    50179 9   usp_asiento_circunscripcion_seleccionar(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_circunscripcion_seleccionar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

begin
	OPEN p_cursor FOR
		SELECT
			A."idAsientoCircunscripcion", 
			A."idInformeRenac", 
			A."idTipoAsiento",
			A."idDispositivo",
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
$$;
 �   DROP PROCEDURE renac.usp_asiento_circunscripcion_seleccionar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            .           1255    50180 Q   usp_asiento_modificacion_actualizar(integer, integer, integer, character varying) 	   PROCEDURE       CREATE PROCEDURE renac.usp_asiento_modificacion_actualizar(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
   DROP PROCEDURE renac.usp_asiento_modificacion_actualizar(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            /           1255    50181 =   usp_asiento_modificacion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_modificacion_eliminar(IN p_idasientomodificacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_asiento_modificacion_eliminar(IN p_idasientomodificacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            0           1255    50182 O   usp_asiento_modificacion_insertar(integer, integer, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_modificacion_insertar(IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_asiento_modificacion_insertar(IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            2           1255    50183 N   usp_asiento_modificacion_paginado(integer, integer, integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_asiento_modificacion_paginado(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 s  DROP PROCEDURE renac.usp_asiento_modificacion_paginado(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            3           1255    50184 ?   usp_asiento_modificacion_seleccionar(integer, integer, integer) 	   PROCEDURE     <  CREATE PROCEDURE renac.usp_asiento_modificacion_seleccionar(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_asiento_modificacion_seleccionar(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, OUT p_cursor refcursor);
       renac          postgres    false    6            4           1255    50185 x   usp_circunscripcion_origen_destino_actualizar(integer, integer, character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_actualizar(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, IN p_nombrecircunscripcion character varying, IN p_origendestino character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 E  DROP PROCEDURE renac.usp_circunscripcion_origen_destino_actualizar(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, IN p_nombrecircunscripcion character varying, IN p_origendestino character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            5           1255    50186 G   usp_circunscripcion_origen_destino_eliminar(integer, character varying) 	   PROCEDURE     )  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_eliminar(IN p_idcircunscripcionorigendestino integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_circunscripcion_origen_destino_eliminar(IN p_idcircunscripcionorigendestino integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            6           1255    50187 v   usp_circunscripcion_origen_destino_insertar(integer, character varying, character varying, character varying, boolean) 	   PROCEDURE     @  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_insertar(IN p_idasientocircunscripcion integer, IN p_nombrecircunscripcion character varying, IN p_origendestino character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 +  DROP PROCEDURE renac.usp_circunscripcion_origen_destino_insertar(IN p_idasientocircunscripcion integer, IN p_nombrecircunscripcion character varying, IN p_origendestino character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            8           1255    50188 O   usp_circunscripcion_origen_destino_paginado(integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_paginado(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 ^  DROP PROCEDURE renac.usp_circunscripcion_origen_destino_paginado(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            9           1255    50189 @   usp_circunscripcion_origen_destino_seleccionar(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_seleccionar(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_circunscripcion_origen_destino_seleccionar(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, OUT p_cursor refcursor);
       renac          postgres    false    6            :           1255    50190 D   usp_circunscripcion_seleccionar(integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_circunscripcion_seleccionar(IN p_codcircunscripcion integer, IN p_tipcircunscripcion integer, IN p_nomcircunscripcion character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_circunscripcion_seleccionar(IN p_codcircunscripcion integer, IN p_tipcircunscripcion integer, IN p_nomcircunscripcion character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            ;           1255    50191 �   usp_derivacion_renac_actualizar(integer, integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_actualizar(IN p_idderivacionrenac integer, IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_idespecialistassatdot character varying, IN p_fechaderivacion timestamp without time zone, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observacion character varying, IN p_esretorno boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �  DROP PROCEDURE renac.usp_derivacion_renac_actualizar(IN p_idderivacionrenac integer, IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_idespecialistassatdot character varying, IN p_fechaderivacion timestamp without time zone, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observacion character varying, IN p_esretorno boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            <           1255    50192 9   usp_derivacion_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_eliminar(IN p_idderivacionrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_derivacion_renac_eliminar(IN p_idderivacionrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            =           1255    50193 �   usp_derivacion_renac_insertar(integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_insertar(IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_idespecialistassatdot character varying, IN p_fechaderivacion timestamp without time zone, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observacion character varying, IN p_esretorno boolean, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �  DROP PROCEDURE renac.usp_derivacion_renac_insertar(IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_idespecialistassatdot character varying, IN p_fechaderivacion timestamp without time zone, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observacion character varying, IN p_esretorno boolean, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            >           1255    50194 B   usp_derivacion_renac_paginado(character varying, integer, integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_derivacion_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_derivacion_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            ?           1255    50195 )   usp_derivacion_renac_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_seleccionar(IN p_idderivacionrenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 o   DROP PROCEDURE renac.usp_derivacion_renac_seleccionar(IN p_idderivacionrenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            @           1255    50196 �   usp_documento_derivacion_actualizar(integer, integer, integer, character varying, character varying, timestamp without time zone, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_actualizar(IN p_iddocumentoderivacion integer, IN p_idderivacionrenac integer, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �  DROP PROCEDURE renac.usp_documento_derivacion_actualizar(IN p_iddocumentoderivacion integer, IN p_idderivacionrenac integer, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            A           1255    50197 =   usp_documento_derivacion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_eliminar(IN p_iddocumentoderivacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_documento_derivacion_eliminar(IN p_iddocumentoderivacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            B           1255    50198 �   usp_documento_derivacion_insertar(integer, integer, character varying, character varying, timestamp without time zone, character varying, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_insertar(IN p_idderivacionrenac integer, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �  DROP PROCEDURE renac.usp_documento_derivacion_insertar(IN p_idderivacionrenac integer, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            D           1255    50199 F   usp_documento_derivacion_paginado(character varying, integer, integer) 	   PROCEDURE     
  CREATE PROCEDURE renac.usp_documento_derivacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_documento_derivacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            E           1255    50200 -   usp_documento_derivacion_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_seleccionar(IN p_iddocumentoderivacion integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 w   DROP PROCEDURE renac.usp_documento_derivacion_seleccionar(IN p_iddocumentoderivacion integer, OUT p_cursor refcursor);
       renac          postgres    false    6            h           1255    50629 �   usp_especialista_ssatdot_informefavorable(character varying, character varying, timestamp without time zone, character varying, character varying) 	   PROCEDURE     (  CREATE PROCEDURE renac.usp_especialista_ssatdot_informefavorable(IN p_informefavorablearchivo character varying, IN p_informefavorablenumero character varying, IN p_informefavorablefecha timestamp without time zone, IN p_listainformesrenac character varying, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
					"informeFavorableArchivo" = p_informefavorablearchivo,
					"informeFavorableNumero" = p_informefavorablenumero,
					"informeFavorableFecha" = p_informefavorablefecha,
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

$$;
 [  DROP PROCEDURE renac.usp_especialista_ssatdot_informefavorable(IN p_informefavorablearchivo character varying, IN p_informefavorablenumero character varying, IN p_informefavorablefecha timestamp without time zone, IN p_listainformesrenac character varying, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            g           1255    50620 F   usp_especialista_ssatdot_paginado(character varying, integer, integer) 	   PROCEDURE     
  CREATE PROCEDURE renac.usp_especialista_ssatdot_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_especialista_ssatdot_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6                       1255    50201 �   usp_especialista_ssiat_derivar(character varying, character varying, boolean, character varying, character varying, character varying, boolean, character varying) 	   PROCEDURE     l  CREATE PROCEDURE renac.usp_especialista_ssiat_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �  DROP PROCEDURE renac.usp_especialista_ssiat_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            F           1255    50203 D   usp_especialista_ssiat_paginado(character varying, integer, integer) 	   PROCEDURE     V  CREATE PROCEDURE renac.usp_especialista_ssiat_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_especialista_ssiat_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            G           1255    50204 '   usp_informacion_ssiat_asientos(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informacion_ssiat_asientos(IN p_idinformerenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 j   DROP PROCEDURE renac.usp_informacion_ssiat_asientos(IN p_idinformerenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            H           1255    50205 O   usp_informe_derivacion_actualizar(integer, integer, integer, character varying) 	   PROCEDURE     l  CREATE PROCEDURE renac.usp_informe_derivacion_actualizar(IN p_idinformederivacion integer, IN p_idinformerenac integer, IN p_idderivacionrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP PROCEDURE renac.usp_informe_derivacion_actualizar(IN p_idinformederivacion integer, IN p_idinformerenac integer, IN p_idderivacionrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            1           1255    50206 ;   usp_informe_derivacion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_derivacion_eliminar(IN p_idinformederivacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_informe_derivacion_eliminar(IN p_idinformederivacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            7           1255    50207 M   usp_informe_derivacion_insertar(integer, integer, character varying, boolean) 	   PROCEDURE     A  CREATE PROCEDURE renac.usp_informe_derivacion_insertar(IN p_idinformerenac integer, IN p_idderivacionrenac integer, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_informe_derivacion_insertar(IN p_idinformerenac integer, IN p_idderivacionrenac integer, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            C           1255    50208 D   usp_informe_derivacion_paginado(character varying, integer, integer) 	   PROCEDURE     o  CREATE PROCEDURE renac.usp_informe_derivacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_informe_derivacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6                       1255    50209 +   usp_informe_derivacion_seleccionar(integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_informe_derivacion_seleccionar(IN p_idinformederivacion integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 s   DROP PROCEDURE renac.usp_informe_derivacion_seleccionar(IN p_idinformederivacion integer, OUT p_cursor refcursor);
       renac          postgres    false    6            I           1255    50210 �   usp_informe_renac_actualizar(integer, integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_renac_actualizar(IN p_idinformerenac integer, IN p_idestadoderivacion integer, IN p_idcircunscripcion integer, IN p_numero character varying, IN p_fecha timestamp without time zone, IN p_descripcion character varying, IN p_urlinformesustento character varying, IN p_nombreinformesustento character varying, IN p_evaluacionfavorable boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �  DROP PROCEDURE renac.usp_informe_renac_actualizar(IN p_idinformerenac integer, IN p_idestadoderivacion integer, IN p_idcircunscripcion integer, IN p_numero character varying, IN p_fecha timestamp without time zone, IN p_descripcion character varying, IN p_urlinformesustento character varying, IN p_nombreinformesustento character varying, IN p_evaluacionfavorable boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            J           1255    50211 6   usp_informe_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_renac_eliminar(IN p_idinformerenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_informe_renac_eliminar(IN p_idinformerenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            i           1255    50630 J   usp_informe_renac_evaluacionfavorable(integer, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_renac_evaluacionfavorable(IN p_idinformerenac integer, IN p_evaluacionfavorable boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP PROCEDURE renac.usp_informe_renac_evaluacionfavorable(IN p_idinformerenac integer, IN p_evaluacionfavorable boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            K           1255    50212 �   usp_informe_renac_insertar(integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying, boolean) 	   PROCEDURE        CREATE PROCEDURE renac.usp_informe_renac_insertar(IN p_idcircunscripcion integer, IN p_idestadoderivacion integer, IN p_numero character varying, IN p_fecha timestamp without time zone, IN p_descripcion character varying, IN p_urlinformesustento character varying, IN p_nombreinformesustento character varying, IN p_evaluacionfavorable boolean, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �  DROP PROCEDURE renac.usp_informe_renac_insertar(IN p_idcircunscripcion integer, IN p_idestadoderivacion integer, IN p_numero character varying, IN p_fecha timestamp without time zone, IN p_descripcion character varying, IN p_urlinformesustento character varying, IN p_nombreinformesustento character varying, IN p_evaluacionfavorable boolean, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            L           1255    50213 ?   usp_informe_renac_paginado(character varying, integer, integer) 	   PROCEDURE     h
  CREATE PROCEDURE renac.usp_informe_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_informe_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            M           1255    50214 &   usp_informe_renac_seleccionar(integer) 	   PROCEDURE     e  CREATE PROCEDURE renac.usp_informe_renac_seleccionar(IN p_idinformerenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 i   DROP PROCEDURE renac.usp_informe_renac_seleccionar(IN p_idinformerenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            N           1255    50215 W   usp_norma_seleccionar(integer, integer, character varying, timestamp without time zone) 	   PROCEDURE     M  CREATE PROCEDURE renac.usp_norma_seleccionar(IN p_codnorma integer, IN p_tipo integer, IN p_numero character varying, IN p_fecha timestamp without time zone, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_norma_seleccionar(IN p_codnorma integer, IN p_tipo integer, IN p_numero character varying, IN p_fecha timestamp without time zone, OUT p_cursor refcursor);
       renac          postgres    false    6            O           1255    50216 u   usp_parametricas_renac_actualizar(integer, integer, integer, character varying, character varying, character varying) 	   PROCEDURE     	  CREATE PROCEDURE renac.usp_parametricas_renac_actualizar(IN p_idparametricasrenac integer, IN p_idpadre integer, IN p_idgrupo integer, IN p_codigo character varying, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 "  DROP PROCEDURE renac.usp_parametricas_renac_actualizar(IN p_idparametricasrenac integer, IN p_idpadre integer, IN p_idgrupo integer, IN p_codigo character varying, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            P           1255    50217 ;   usp_parametricas_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_parametricas_renac_eliminar(IN p_idparametricasrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_parametricas_renac_eliminar(IN p_idparametricasrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            Q           1255    50218 s   usp_parametricas_renac_insertar(integer, integer, character varying, character varying, character varying, boolean) 	   PROCEDURE     0  CREATE PROCEDURE renac.usp_parametricas_renac_insertar(IN p_idpadre integer, IN p_idgrupo integer, IN p_codigo character varying, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_parametricas_renac_insertar(IN p_idpadre integer, IN p_idgrupo integer, IN p_codigo character varying, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            R           1255    50219 D   usp_parametricas_renac_paginado(character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_parametricas_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_parametricas_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            S           1255    50220 +   usp_parametricas_renac_seleccionar(integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_parametricas_renac_seleccionar(IN p_idparametricasrenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 s   DROP PROCEDURE renac.usp_parametricas_renac_seleccionar(IN p_idparametricasrenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6                       1255    50624 �   usp_subsecretario_ssatdot_derivar(character varying, character varying, character varying, boolean, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_subsecretario_ssatdot_derivar(IN p_idespecialista character varying, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

$$;
 ]  DROP PROCEDURE renac.usp_subsecretario_ssatdot_derivar(IN p_idespecialista character varying, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            f           1255    50221 G   usp_subsecretario_ssatdot_paginado(character varying, integer, integer) 	   PROCEDURE     �
  CREATE PROCEDURE renac.usp_subsecretario_ssatdot_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
			(E."codigo" <> '10' AND E."codigo" <> '20')AND
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
$$;
    DROP PROCEDURE renac.usp_subsecretario_ssatdot_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            U           1255    50222 �   usp_subsecretario_ssiat_ajustes(character varying, character varying, character varying, boolean, character varying, boolean, character varying) 	   PROCEDURE     V  CREATE PROCEDURE renac.usp_subsecretario_ssiat_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

$$;
 Z  DROP PROCEDURE renac.usp_subsecretario_ssiat_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            #           1255    50626 �   usp_subsecretario_ssiat_derivar(character varying, character varying, boolean, character varying, integer, character varying, character varying, character varying, timestamp without time zone, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_subsecretario_ssiat_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_idtipodocumento integer, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_numerodocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

$$;
   DROP PROCEDURE renac.usp_subsecretario_ssiat_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_idtipodocumento integer, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_numerodocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            V           1255    50226 E   usp_subsecretario_ssiat_paginado(character varying, integer, integer) 	   PROCEDURE     -  CREATE PROCEDURE renac.usp_subsecretario_ssiat_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_subsecretario_ssiat_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            W           1255    50227 S   usp_tipo_asiento_actualizar(integer, integer, character varying, character varying) 	   PROCEDURE     F  CREATE PROCEDURE renac.usp_tipo_asiento_actualizar(IN p_idtipoasiento integer, IN p_codigo integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP PROCEDURE renac.usp_tipo_asiento_actualizar(IN p_idtipoasiento integer, IN p_codigo integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            X           1255    50228 5   usp_tipo_asiento_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_asiento_eliminar(IN p_idtipoasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_asiento_eliminar(IN p_idtipoasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            T           1255    50229 Q   usp_tipo_asiento_insertar(integer, character varying, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_asiento_insertar(IN p_codigo integer, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_asiento_insertar(IN p_codigo integer, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            Z           1255    50230 >   usp_tipo_asiento_paginado(character varying, integer, integer) 	   PROCEDURE     j  CREATE PROCEDURE renac.usp_tipo_asiento_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_tipo_asiento_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6                       1255    50231 %   usp_tipo_asiento_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_asiento_seleccionar(IN p_idtipoasiento integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 g   DROP PROCEDURE renac.usp_tipo_asiento_seleccionar(IN p_idtipoasiento integer, OUT p_cursor refcursor);
       renac          postgres    false    6            [           1255    50232 &   usp_tipo_circunscripcion_seleccionar() 	   PROCEDURE     G  CREATE PROCEDURE renac.usp_tipo_circunscripcion_seleccionar(OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 S   DROP PROCEDURE renac.usp_tipo_circunscripcion_seleccionar(OUT p_cursor refcursor);
       renac          postgres    false    6            \           1255    50233 "   usp_tipo_dispositivo_seleccionar() 	   PROCEDURE     <  CREATE PROCEDURE renac.usp_tipo_dispositivo_seleccionar(OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 O   DROP PROCEDURE renac.usp_tipo_dispositivo_seleccionar(OUT p_cursor refcursor);
       renac          postgres    false    6            ]           1255    50234 [   usp_tipo_documento_renac_actualizar(integer, integer, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_documento_renac_actualizar(IN p_idtipodocumentorenac integer, IN p_codigo integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP PROCEDURE renac.usp_tipo_documento_renac_actualizar(IN p_idtipodocumentorenac integer, IN p_codigo integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            ^           1255    50235 =   usp_tipo_documento_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_documento_renac_eliminar(IN p_idtipodocumentorenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_documento_renac_eliminar(IN p_idtipodocumentorenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            _           1255    50236 Y   usp_tipo_documento_renac_insertar(integer, character varying, character varying, boolean) 	   PROCEDURE       CREATE PROCEDURE renac.usp_tipo_documento_renac_insertar(IN p_codigo integer, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_documento_renac_insertar(IN p_codigo integer, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            `           1255    50237 F   usp_tipo_documento_renac_paginado(character varying, integer, integer) 	   PROCEDURE     t  CREATE PROCEDURE renac.usp_tipo_documento_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_tipo_documento_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            a           1255    50238 -   usp_tipo_documento_renac_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_documento_renac_seleccionar(IN p_idtipodocumentorenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 v   DROP PROCEDURE renac.usp_tipo_documento_renac_seleccionar(IN p_idtipodocumentorenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            b           1255    50239 W   usp_tipo_modificacion_asiento_actualizar(integer, character varying, character varying) 	   PROCEDURE     v  CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_actualizar(IN p_idtipomodificacionasiento integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP PROCEDURE renac.usp_tipo_modificacion_asiento_actualizar(IN p_idtipomodificacionasiento integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            c           1255    50240 B   usp_tipo_modificacion_asiento_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_eliminar(IN p_idtipomodificacionasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_modificacion_asiento_eliminar(IN p_idtipomodificacionasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            d           1255    50241 U   usp_tipo_modificacion_asiento_insertar(character varying, character varying, boolean) 	   PROCEDURE       CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_insertar(IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_modificacion_asiento_insertar(IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            e           1255    50242 8   usp_tipo_modificacion_asiento_paginado(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_paginado(IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
   DROP PROCEDURE renac.usp_tipo_modificacion_asiento_paginado(IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            Y           1255    50243 2   usp_tipo_modificacion_asiento_seleccionar(integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_seleccionar(IN p_idtipomodificacionasiento integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_tipo_modificacion_asiento_seleccionar(IN p_idtipomodificacionasiento integer, OUT p_cursor refcursor);
       renac          postgres    false    6            �            1259    50244    v_informeanotacion    TABLE     Z   CREATE TABLE public.v_informeanotacion (
    urlinformesustento character varying(850)
);
 &   DROP TABLE public.v_informeanotacion;
       public         heap    postgres    false            �            1259    50249    v_proyectomemosubssiat    TABLE     [   CREATE TABLE public.v_proyectomemosubssiat (
    "rutaDocumento" character varying(250)
);
 *   DROP TABLE public.v_proyectomemosubssiat;
       public         heap    postgres    false            �            1259    50252    sec_asiento_circunscripcion    SEQUENCE     �   CREATE SEQUENCE renac.sec_asiento_circunscripcion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE renac.sec_asiento_circunscripcion;
       renac          postgres    false    6            �            1259    50253    ASIENTO_CIRCUNSCRIPCION    TABLE     H  CREATE TABLE renac."ASIENTO_CIRCUNSCRIPCION" (
    "idAsientoCircunscripcion" integer DEFAULT nextval('renac.sec_asiento_circunscripcion'::regclass) NOT NULL,
    "idInformeRenac" integer NOT NULL,
    "idTipoAsiento" integer NOT NULL,
    "idDispositivo" integer NOT NULL,
    descripcion character varying(250),
    "nombreCircunscripcion" character varying(200),
    "nombreCapital" character varying(200),
    "nombreProvincia" character varying(200),
    "nombreDepartamento" character varying(200),
    "informacionComplementaria" character varying(250),
    "fechaAnotacion" timestamp without time zone,
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 ,   DROP TABLE renac."ASIENTO_CIRCUNSCRIPCION";
       renac         heap    postgres    false    226    6            �            1259    50261    sec_derivacion_renac    SEQUENCE     |   CREATE SEQUENCE renac.sec_derivacion_renac
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE renac.sec_derivacion_renac;
       renac          postgres    false    6            �            1259    50262    DERIVACION_RENAC    TABLE     �  CREATE TABLE renac."DERIVACION_RENAC" (
    "idDerivacionRenac" integer DEFAULT nextval('renac.sec_derivacion_renac'::regclass) NOT NULL,
    "fechaDerivacion" timestamp without time zone,
    "usuarioOrigen" character varying(50),
    "usuarioDestino" character varying(50),
    observacion character varying(350),
    "esRetorno" boolean DEFAULT false,
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50),
    "idDerivacionOrigen" integer,
    "idDerivacionDestino" integer,
    "idEspecialistaSsatdot" character varying(20)
);
 %   DROP TABLE renac."DERIVACION_RENAC";
       renac         heap    postgres    false    228    6            �            1259    50271    sec_documento_derivacion    SEQUENCE     �   CREATE SEQUENCE renac.sec_documento_derivacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renac.sec_documento_derivacion;
       renac          postgres    false    6            �            1259    50272    DOCUMENTO_DERIVACION    TABLE     �  CREATE TABLE renac."DOCUMENTO_DERIVACION" (
    "idDocumentoDerivacion" integer DEFAULT nextval('renac.sec_documento_derivacion'::regclass) NOT NULL,
    "idDerivacionRenac" integer NOT NULL,
    "idTipoDocumentoRenac" integer,
    "rutaDocumento" character varying(250),
    "nombreDocumento" character varying(250),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50),
    "fechaDocumento" timestamp without time zone,
    "numeroDocumento" character varying(30)
);
 )   DROP TABLE renac."DOCUMENTO_DERIVACION";
       renac         heap    postgres    false    230    6            �            1259    50280    sec_informe_derivacion    SEQUENCE     ~   CREATE SEQUENCE renac.sec_informe_derivacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE renac.sec_informe_derivacion;
       renac          postgres    false    6            �            1259    50281    INFORME_DERIVACION    TABLE     �  CREATE TABLE renac."INFORME_DERIVACION" (
    "idInformeDerivacion" integer DEFAULT nextval('renac.sec_informe_derivacion'::regclass) NOT NULL,
    "idInformeRenac" integer NOT NULL,
    "idDerivacionRenac" integer NOT NULL,
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 '   DROP TABLE renac."INFORME_DERIVACION";
       renac         heap    postgres    false    232    6            �            1259    50287    sec_informe_renac    SEQUENCE     y   CREATE SEQUENCE renac.sec_informe_renac
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE renac.sec_informe_renac;
       renac          postgres    false    6            �            1259    50288    INFORME_RENAC    TABLE     .  CREATE TABLE renac."INFORME_RENAC" (
    "idInformeRenac" integer DEFAULT nextval('renac.sec_informe_renac'::regclass) NOT NULL,
    "idCircunscripcion" integer NOT NULL,
    numero character varying(100),
    fecha date,
    descripcion character varying(250),
    urlinformesustento character varying(850),
    nombreinformesustento character varying(250),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50),
    "idEstadoDerivacion" integer,
    "evaluacionFavorable" boolean,
    informefavorablearchivo character varying(250),
    informefavorablenumero character varying(50),
    informefavorablefecha timestamp without time zone
);
 "   DROP TABLE renac."INFORME_RENAC";
       renac         heap    postgres    false    234    6            �            1259    50296    sec_parametricas_renac    SEQUENCE     ~   CREATE SEQUENCE renac.sec_parametricas_renac
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE renac.sec_parametricas_renac;
       renac          postgres    false    6            �            1259    50297    PARAMETRICAS_RENAC    TABLE     �  CREATE TABLE renac."PARAMETRICAS_RENAC" (
    "idParametricasRenac" integer DEFAULT nextval('renac.sec_parametricas_renac'::regclass) NOT NULL,
    "idPadre" integer,
    "idGrupo" integer,
    codigo character varying(5),
    descripcion character varying(80),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 '   DROP TABLE renac."PARAMETRICAS_RENAC";
       renac         heap    postgres    false    236    6            �            1259    50303    sec_tipo_documento_renac    SEQUENCE     �   CREATE SEQUENCE renac.sec_tipo_documento_renac
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renac.sec_tipo_documento_renac;
       renac          postgres    false    6            �            1259    50304    TIPO_DOCUMENTO_RENAC    TABLE     �  CREATE TABLE renac."TIPO_DOCUMENTO_RENAC" (
    "idTipoDocumentoRenac" integer DEFAULT nextval('renac.sec_tipo_documento_renac'::regclass) NOT NULL,
    codigo integer,
    descripcion character varying(250),
    activo boolean DEFAULT true,
    "fechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "fechaMod" timestamp without time zone,
    "usuarioReg" character varying(50),
    "usuarioMod" character varying(50)
);
 )   DROP TABLE renac."TIPO_DOCUMENTO_RENAC";
       renac         heap    postgres    false    238    6            �            1259    50310    sec_acuerdo_anotacion    SEQUENCE     ~   CREATE SEQUENCE renlim.sec_acuerdo_anotacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE renlim.sec_acuerdo_anotacion;
       renlim          admin    false    7            �           0    0    SEQUENCE sec_acuerdo_anotacion    ACL     B   GRANT ALL ON SEQUENCE renlim.sec_acuerdo_anotacion TO usr_renlim;
          renlim          admin    false    240            �            1259    50311    ACUERDO_ANOTACION    TABLE     ;  CREATE TABLE renlim."ACUERDO_ANOTACION" (
    "iCodAcuerdoAnotacion" integer DEFAULT nextval('renlim.sec_acuerdo_anotacion'::regclass) NOT NULL,
    "iCodAnotacion" integer,
    "vNumDocumento" character varying(100),
    "vDesDocumento" character varying(200),
    "vArchDocumento" character varying(500),
    "dFechaDocumento" date,
    "dFechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying(50),
    "bActivo" boolean DEFAULT true,
    "vUsuarioMod" character varying(50)
);
 '   DROP TABLE renlim."ACUERDO_ANOTACION";
       renlim         heap    admin    false    240    7            �           0    0    TABLE "ACUERDO_ANOTACION"    ACL     =   GRANT ALL ON TABLE renlim."ACUERDO_ANOTACION" TO usr_renlim;
          renlim          admin    false    241            �            1259    50319    sec_anotacion    SEQUENCE     v   CREATE SEQUENCE renlim.sec_anotacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE renlim.sec_anotacion;
       renlim          admin    false    7            �           0    0    SEQUENCE sec_anotacion    ACL     :   GRANT ALL ON SEQUENCE renlim.sec_anotacion TO usr_renlim;
          renlim          admin    false    242            �            1259    50320 	   ANOTACION    TABLE     �  CREATE TABLE renlim."ANOTACION" (
    "iCodAnotacion" integer DEFAULT nextval('renlim.sec_anotacion'::regclass) NOT NULL,
    "vNomAnotacion" character varying(200),
    "vFuenteCartografica" character varying(2500),
    "vRepreCartografica" character varying(200),
    "vCartografiaBase" character varying(200),
    "vArchivoShape" character varying(200),
    "bTrifinio" boolean,
    "tMemDescriptiva" text,
    "dFechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "dFechaFinalizado" date,
    "bAprobado" boolean,
    "iCodSolicitud" integer,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean DEFAULT true,
    "iCodTipAnotacion" integer,
    "iCodLibro" integer,
    "iCodSeccion" integer,
    "iEstado" integer DEFAULT 1001,
    "vUsuarioMod" character varying(100),
    "iTipSustento" integer,
    "iCodNorma" integer,
    "bPublicado" boolean DEFAULT false,
    "iCodDocAcuerdo" integer
);
    DROP TABLE renlim."ANOTACION";
       renlim         heap    admin    false    242    7            �           0    0 !   COLUMN "ANOTACION"."iTipSustento"    COMMENT     e   COMMENT ON COLUMN renlim."ANOTACION"."iTipSustento" IS 'Sustento por ley, acta o informe dirimente';
          renlim          admin    false    243            �           0    0    TABLE "ANOTACION"    ACL     5   GRANT ALL ON TABLE renlim."ANOTACION" TO usr_renlim;
          renlim          admin    false    243            �            1259    50330    sec_asiento_limite    SEQUENCE     {   CREATE SEQUENCE renlim.sec_asiento_limite
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE renlim.sec_asiento_limite;
       renlim          admin    false    7            �           0    0    SEQUENCE sec_asiento_limite    ACL     ?   GRANT ALL ON SEQUENCE renlim.sec_asiento_limite TO usr_renlim;
          renlim          admin    false    244            �            1259    50331    ASIENTO_LIMITE    TABLE     �  CREATE TABLE renlim."ASIENTO_LIMITE" (
    "iCodAnotacion" integer NOT NULL,
    "iCodLimite" integer NOT NULL,
    "iNumAsiento" integer,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean,
    "iCodAsiento" integer DEFAULT nextval('renlim.sec_asiento_limite'::regclass) NOT NULL,
    "vUsuarioMod" character varying(100),
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone,
    "bAprobado" boolean,
    "bPublicado" boolean
);
 $   DROP TABLE renlim."ASIENTO_LIMITE";
       renlim         heap    admin    false    244    7            �           0    0    TABLE "ASIENTO_LIMITE"    ACL     :   GRANT ALL ON TABLE renlim."ASIENTO_LIMITE" TO usr_renlim;
          renlim          admin    false    245            �            1259    50335    CIRCUNSCRIPCION    TABLE     �  CREATE TABLE renlim."CIRCUNSCRIPCION" (
    "iCodCircunscripcion" integer NOT NULL,
    "vNomCircunscripcion" character varying(200),
    "iTipCircunscripcion" integer,
    "iCodDepCircunscripcion" integer,
    "iCodProvCircunscripcion" integer,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean,
    "vUsuarioMod" character varying(100),
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone
);
 %   DROP TABLE renlim."CIRCUNSCRIPCION";
       renlim         heap    admin    false    7            �           0    0    TABLE "CIRCUNSCRIPCION"    ACL     ;   GRANT ALL ON TABLE renlim."CIRCUNSCRIPCION" TO usr_renlim;
          renlim          admin    false    246            �            1259    50338    sec_documento_anotacion    SEQUENCE     �   CREATE SEQUENCE renlim.sec_documento_anotacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renlim.sec_documento_anotacion;
       renlim          admin    false    7            �           0    0     SEQUENCE sec_documento_anotacion    ACL     D   GRANT ALL ON SEQUENCE renlim.sec_documento_anotacion TO usr_renlim;
          renlim          admin    false    247            �            1259    50339    DOCUMENTO_ANOTACION    TABLE     ]  CREATE TABLE renlim."DOCUMENTO_ANOTACION" (
    "iCodDocAnotacion" integer DEFAULT nextval('renlim.sec_documento_anotacion'::regclass) NOT NULL,
    "iCodAnotacion" integer,
    "vNumDocumento" character varying(100),
    "vDesDocumento" character varying(200),
    "vArchDocumento" character varying(500),
    "dFechaDocumento" date,
    "iCodTipDocumento" integer,
    "dFechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean DEFAULT true,
    "vUsuarioMod" character varying(100)
);
 )   DROP TABLE renlim."DOCUMENTO_ANOTACION";
       renlim         heap    admin    false    247    7            �           0    0    TABLE "DOCUMENTO_ANOTACION"    ACL     ?   GRANT ALL ON TABLE renlim."DOCUMENTO_ANOTACION" TO usr_renlim;
          renlim          admin    false    248            �            1259    50347    sec_documento_aasiento_limite    SEQUENCE     �   CREATE SEQUENCE renlim.sec_documento_aasiento_limite
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE renlim.sec_documento_aasiento_limite;
       renlim          admin    false    7            �           0    0 &   SEQUENCE sec_documento_aasiento_limite    ACL     J   GRANT ALL ON SEQUENCE renlim.sec_documento_aasiento_limite TO usr_renlim;
          renlim          admin    false    249            �            1259    50348    DOCUMENTO_ASIENTO_LIMITE    TABLE     j  CREATE TABLE renlim."DOCUMENTO_ASIENTO_LIMITE" (
    "iCodDocAsientoLimite" integer DEFAULT nextval('renlim.sec_documento_aasiento_limite'::regclass) NOT NULL,
    "iCodAsiento" integer,
    "vNumDocumento" character varying(100),
    "vDesDocumento" character varying(200),
    "vArchDocumento" character varying(500),
    "dFechaDocumento" date,
    "iCodTipDocumento" integer,
    "dFechaReg" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean DEFAULT true,
    "vUsuarioMod" character varying(100)
);
 .   DROP TABLE renlim."DOCUMENTO_ASIENTO_LIMITE";
       renlim         heap    admin    false    249    7            �           0    0     TABLE "DOCUMENTO_ASIENTO_LIMITE"    ACL     D   GRANT ALL ON TABLE renlim."DOCUMENTO_ASIENTO_LIMITE" TO usr_renlim;
          renlim          admin    false    250            �            1259    50356    sec_documento_solicitud    SEQUENCE     �   CREATE SEQUENCE renlim.sec_documento_solicitud
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renlim.sec_documento_solicitud;
       renlim          admin    false    7            �           0    0     SEQUENCE sec_documento_solicitud    ACL     D   GRANT ALL ON SEQUENCE renlim.sec_documento_solicitud TO usr_renlim;
          renlim          admin    false    251            �            1259    50357    DOCUMENTO_SOLICITUD    TABLE     4  CREATE TABLE renlim."DOCUMENTO_SOLICITUD" (
    "iCodDocSolicitud" integer DEFAULT nextval('renlim.sec_documento_solicitud'::regclass) NOT NULL,
    "iCodTipDocumento" integer,
    "vNumDocumento" character varying(100),
    "vDesDocumento" character varying(200),
    "vArchDocumento" character varying(500),
    "dFechaDocumento" date,
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying(50),
    "bActivo" boolean,
    "iCodSolicitud" integer,
    "vUsuarioMod" character varying(50)
);
 )   DROP TABLE renlim."DOCUMENTO_SOLICITUD";
       renlim         heap    admin    false    251    7            �           0    0    TABLE "DOCUMENTO_SOLICITUD"    ACL     ?   GRANT ALL ON TABLE renlim."DOCUMENTO_SOLICITUD" TO usr_renlim;
          renlim          admin    false    252            �            1259    50363    LIMITE    TABLE     �  CREATE TABLE renlim."LIMITE" (
    "iCodLimite" integer NOT NULL,
    "vNumPartida" character varying(150),
    "iCodSuscripcionA" integer,
    "iCodSuscripcionB" integer,
    "iCodLibro" integer,
    "iCodSeccion" integer,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean,
    "vUsuarioMod" character varying(100),
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone
);
    DROP TABLE renlim."LIMITE";
       renlim         heap    admin    false    7            �           0    0    TABLE "LIMITE"    ACL     2   GRANT ALL ON TABLE renlim."LIMITE" TO usr_renlim;
          renlim          admin    false    253            �            1259    50366    sec_memoria    SEQUENCE     t   CREATE SEQUENCE renlim.sec_memoria
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE renlim.sec_memoria;
       renlim          admin    false    7            �           0    0    SEQUENCE sec_memoria    ACL     8   GRANT ALL ON SEQUENCE renlim.sec_memoria TO usr_renlim;
          renlim          admin    false    254            �            1259    50367    MEMORIA    TABLE     �  CREATE TABLE renlim."MEMORIA" (
    "iCodMemoria" integer DEFAULT nextval('renlim.sec_memoria'::regclass) NOT NULL,
    "iCodAnotacion" integer,
    "iCodTipo" integer,
    "dFechaReg" time without time zone,
    "dFechaMod" time without time zone,
    "vUsuarioReg" character varying(100),
    "vUsuarioMod" character varying(100),
    "bActivo" boolean,
    "vDescripcion" character varying(100)
);
    DROP TABLE renlim."MEMORIA";
       renlim         heap    admin    false    254    7            �           0    0    TABLE "MEMORIA"    ACL     3   GRANT ALL ON TABLE renlim."MEMORIA" TO usr_renlim;
          renlim          admin    false    255                        1259    50371    sec_memoria_descriptiva    SEQUENCE     �   CREATE SEQUENCE renlim.sec_memoria_descriptiva
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renlim.sec_memoria_descriptiva;
       renlim          admin    false    7            �           0    0     SEQUENCE sec_memoria_descriptiva    ACL     D   GRANT ALL ON SEQUENCE renlim.sec_memoria_descriptiva TO usr_renlim;
          renlim          admin    false    256                       1259    50372    MEMORIA_DESCRIPTIVA    TABLE     �  CREATE TABLE renlim."MEMORIA_DESCRIPTIVA" (
    "iCodMemDescriptiva" integer DEFAULT nextval('renlim.sec_memoria_descriptiva'::regclass) NOT NULL,
    "iCodAnotacion" integer,
    "vDesMemDescriptiva" character varying,
    "dFechaReg" time without time zone,
    "dFechaMod" time without time zone,
    "vUsuarioReg" character varying(100),
    "vUsuarioMod" character varying(100),
    "bActivo" boolean
);
 )   DROP TABLE renlim."MEMORIA_DESCRIPTIVA";
       renlim         heap    admin    false    256    7            �           0    0    TABLE "MEMORIA_DESCRIPTIVA"    ACL     ?   GRANT ALL ON TABLE renlim."MEMORIA_DESCRIPTIVA" TO usr_renlim;
          renlim          admin    false    257                       1259    50378    sec_memoria_normalizada    SEQUENCE     �   CREATE SEQUENCE renlim.sec_memoria_normalizada
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE renlim.sec_memoria_normalizada;
       renlim          admin    false    7            �           0    0     SEQUENCE sec_memoria_normalizada    ACL     D   GRANT ALL ON SEQUENCE renlim.sec_memoria_normalizada TO usr_renlim;
          renlim          admin    false    258                       1259    50379    MEMORIA_NORMALIZADA    TABLE     �  CREATE TABLE renlim."MEMORIA_NORMALIZADA" (
    "iCodMemNormalizada" integer DEFAULT nextval('renlim.sec_memoria_normalizada'::regclass) NOT NULL,
    "iCodAnotacion" integer,
    "iCodTipElemento" integer,
    "vDesMemNormalizada" character varying,
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying(100),
    "bActivo" boolean,
    "vUsuarioMod" character varying(100),
    "iCodMemoria" integer
);
 )   DROP TABLE renlim."MEMORIA_NORMALIZADA";
       renlim         heap    admin    false    258    7            �           0    0    TABLE "MEMORIA_NORMALIZADA"    ACL     ?   GRANT ALL ON TABLE renlim."MEMORIA_NORMALIZADA" TO usr_renlim;
          renlim          admin    false    259                       1259    50385    sec_movimiento_anotacion    SEQUENCE     �   CREATE SEQUENCE renlim.sec_movimiento_anotacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE renlim.sec_movimiento_anotacion;
       renlim          admin    false    7            �           0    0 !   SEQUENCE sec_movimiento_anotacion    ACL     E   GRANT ALL ON SEQUENCE renlim.sec_movimiento_anotacion TO usr_renlim;
          renlim          admin    false    260                       1259    50386    MOVIMIENTO_ANOTACION    TABLE     4  CREATE TABLE renlim."MOVIMIENTO_ANOTACION" (
    "iCodMovAnotacion" integer DEFAULT nextval('renlim.sec_movimiento_anotacion'::regclass) NOT NULL,
    "iCodAnotacion" integer,
    "iEstadoMov" integer,
    "vDesMovAnotacion" character varying(200),
    "dFechaMov" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "vUsuarioReg" character varying(100),
    "iCodRolUsuarioReg" integer,
    "vUsuarioDerivar" character varying(100),
    "iCodRolUsuarioDerivar" integer,
    "dFechaAccion" timestamp without time zone,
    "bActivo" boolean DEFAULT true
);
 *   DROP TABLE renlim."MOVIMIENTO_ANOTACION";
       renlim         heap    admin    false    260    7            �           0    0    TABLE "MOVIMIENTO_ANOTACION"    ACL     @   GRANT ALL ON TABLE renlim."MOVIMIENTO_ANOTACION" TO usr_renlim;
          renlim          admin    false    261                       1259    50392    sec_movimiento_solicitud    SEQUENCE     �   CREATE SEQUENCE renlim.sec_movimiento_solicitud
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE renlim.sec_movimiento_solicitud;
       renlim          admin    false    7            �           0    0 !   SEQUENCE sec_movimiento_solicitud    ACL     E   GRANT ALL ON SEQUENCE renlim.sec_movimiento_solicitud TO usr_renlim;
          renlim          admin    false    262                       1259    50393    MOVIMIENTO_SOLICITUD    TABLE     '  CREATE TABLE renlim."MOVIMIENTO_SOLICITUD" (
    "iCodMovSolicitud" integer DEFAULT nextval('renlim.sec_movimiento_solicitud'::regclass) NOT NULL,
    "iCodSolicitud" integer,
    "vDesMovSolicitud" character varying(200),
    "dFechaMov" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "vUsuarioReg" character varying(100),
    "iCodRolUsuarioReg" integer,
    "vUsuarioDerivar" character varying(100),
    "iCodRolUsuarioDerivar" integer,
    "iEstadoMov" integer,
    "dFechaAccion" timestamp without time zone,
    "bActivo" boolean
);
 *   DROP TABLE renlim."MOVIMIENTO_SOLICITUD";
       renlim         heap    admin    false    262    7            �           0    0    TABLE "MOVIMIENTO_SOLICITUD"    ACL     @   GRANT ALL ON TABLE renlim."MOVIMIENTO_SOLICITUD" TO usr_renlim;
          renlim          admin    false    263                       1259    50398 	   sec_norma    SEQUENCE     r   CREATE SEQUENCE renlim.sec_norma
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE renlim.sec_norma;
       renlim          admin    false    7            �           0    0    SEQUENCE sec_norma    ACL     6   GRANT ALL ON SEQUENCE renlim.sec_norma TO usr_renlim;
          renlim          admin    false    264            	           1259    50399    NORMA    TABLE     �  CREATE TABLE renlim."NORMA" (
    "iCodNorma" integer DEFAULT nextval('renlim.sec_norma'::regclass) NOT NULL,
    "vNumero" character varying(100),
    "dFecha" date,
    "vArchivo" character varying(300),
    "vUsuarioReg" character varying(100),
    "vUsuarioMod" character varying(100),
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone,
    "iTipo" integer,
    "bActivo" boolean DEFAULT true NOT NULL
);
    DROP TABLE renlim."NORMA";
       renlim         heap    admin    false    264    7            �           0    0    TABLE "NORMA"    COMMENT        COMMENT ON TABLE renlim."NORMA" IS 'Tabla Maestra que contiene los tipos de norma como:
Ley
Ley Regional
Decreto Ley
Decreto';
          renlim          admin    false    265            �           0    0    TABLE "NORMA"    ACL     1   GRANT ALL ON TABLE renlim."NORMA" TO usr_renlim;
          renlim          admin    false    265            
           1259    50406    PARTABLA    TABLE     �  CREATE TABLE renlim."PARTABLA" (
    "IdTabla" integer,
    "Descripcion" character varying,
    "Abreviado" character varying,
    "Valor1" character varying,
    "Valor2" character varying,
    "Valor3" character varying,
    "Indicador1" character varying,
    "Indicador2" character varying,
    "Indicador3" character varying,
    "Orden" integer,
    "Grupo" integer,
    "Estado" integer,
    "SeMuestra" integer,
    "GrupoSuperior" integer
);
    DROP TABLE renlim."PARTABLA";
       renlim         heap    admin    false    7            �           0    0    TABLE "PARTABLA"    ACL     4   GRANT ALL ON TABLE renlim."PARTABLA" TO usr_renlim;
          renlim          admin    false    266                       1259    50411    sec_solicitud    SEQUENCE     v   CREATE SEQUENCE renlim.sec_solicitud
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE renlim.sec_solicitud;
       renlim          admin    false    7            �           0    0    SEQUENCE sec_solicitud    ACL     :   GRANT ALL ON SEQUENCE renlim.sec_solicitud TO usr_renlim;
          renlim          admin    false    267                       1259    50412 	   SOLICITUD    TABLE     �  CREATE TABLE renlim."SOLICITUD" (
    "iCodSolicitud" integer DEFAULT nextval('renlim.sec_solicitud'::regclass) NOT NULL,
    "dFechaRecepcion" date,
    "vNumSGD" character varying(20),
    "vDesSolicitud" character varying(100),
    "bFavorable" boolean,
    "dFechaFinalizado" date,
    "iCodTipProceso" integer,
    "dFechaReg" timestamp without time zone,
    "dFechaMod" timestamp without time zone,
    "vUsuarioReg" character varying,
    "bActivo" boolean,
    "iEstado" integer DEFAULT 1001,
    "vUsuarioMod" character varying,
    "vInforme" character varying(200),
    "vInformeFirmado" character varying(200),
    "vNumInformeFirmado" character varying(100),
    "dFechaInformeFirmado" date
);
    DROP TABLE renlim."SOLICITUD";
       renlim         heap    admin    false    267    7            �           0    0    COLUMN "SOLICITUD"."vInforme"    COMMENT     l   COMMENT ON COLUMN renlim."SOLICITUD"."vInforme" IS 'Proyecto de Informe, asociado a la columna bFavorable';
          renlim          admin    false    268            �           0    0    TABLE "SOLICITUD"    ACL     5   GRANT ALL ON TABLE renlim."SOLICITUD" TO usr_renlim;
          renlim          admin    false    268            f          0    50244    v_informeanotacion 
   TABLE DATA           @   COPY public.v_informeanotacion (urlinformesustento) FROM stdin;
    public          postgres    false    224   ,�      g          0    50249    v_proyectomemosubssiat 
   TABLE DATA           A   COPY public.v_proyectomemosubssiat ("rutaDocumento") FROM stdin;
    public          postgres    false    225   ��      i          0    50253    ASIENTO_CIRCUNSCRIPCION 
   TABLE DATA           M  COPY renac."ASIENTO_CIRCUNSCRIPCION" ("idAsientoCircunscripcion", "idInformeRenac", "idTipoAsiento", "idDispositivo", descripcion, "nombreCircunscripcion", "nombreCapital", "nombreProvincia", "nombreDepartamento", "informacionComplementaria", "fechaAnotacion", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    227   ��      _          0    50135    ASIENTO_MODIFICACION 
   TABLE DATA           �   COPY renac."ASIENTO_MODIFICACION" ("idAsientoModificacion", "idAsientoCircunscripcion", "idTipoModificacionAsiento", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    217   @�      a          0    50143    CIRCUNSCRIPCION_ORIGEN_DESTINO 
   TABLE DATA           �   COPY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" ("idCircunscripcionOrigenDestino", "idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    219   �      k          0    50262    DERIVACION_RENAC 
   TABLE DATA             COPY renac."DERIVACION_RENAC" ("idDerivacionRenac", "fechaDerivacion", "usuarioOrigen", "usuarioDestino", observacion, "esRetorno", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "idDerivacionOrigen", "idDerivacionDestino", "idEspecialistaSsatdot") FROM stdin;
    renac          postgres    false    229   n�      m          0    50272    DOCUMENTO_DERIVACION 
   TABLE DATA           �   COPY renac."DOCUMENTO_DERIVACION" ("idDocumentoDerivacion", "idDerivacionRenac", "idTipoDocumentoRenac", "rutaDocumento", "nombreDocumento", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "fechaDocumento", "numeroDocumento") FROM stdin;
    renac          postgres    false    231   ��      o          0    50281    INFORME_DERIVACION 
   TABLE DATA           �   COPY renac."INFORME_DERIVACION" ("idInformeDerivacion", "idInformeRenac", "idDerivacionRenac", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    233   ��      q          0    50288    INFORME_RENAC 
   TABLE DATA           G  COPY renac."INFORME_RENAC" ("idInformeRenac", "idCircunscripcion", numero, fecha, descripcion, urlinformesustento, nombreinformesustento, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "idEstadoDerivacion", "evaluacionFavorable", informefavorablearchivo, informefavorablenumero, informefavorablefecha) FROM stdin;
    renac          postgres    false    235   ��      s          0    50297    PARAMETRICAS_RENAC 
   TABLE DATA           �   COPY renac."PARAMETRICAS_RENAC" ("idParametricasRenac", "idPadre", "idGrupo", codigo, descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    237   ��      c          0    50157    TIPO_ASIENTO 
   TABLE DATA           �   COPY renac."TIPO_ASIENTO" ("idTipoAsiento", descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", codigo) FROM stdin;
    renac          postgres    false    221   ��      u          0    50304    TIPO_DOCUMENTO_RENAC 
   TABLE DATA           �   COPY renac."TIPO_DOCUMENTO_RENAC" ("idTipoDocumentoRenac", codigo, descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    239   ��      e          0    50166    TIPO_MODIFICACION_ASIENTO 
   TABLE DATA           �   COPY renac."TIPO_MODIFICACION_ASIENTO" ("idTipoModificacionAsiento", descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    223   �      w          0    50311    ACUERDO_ANOTACION 
   TABLE DATA           �   COPY renlim."ACUERDO_ANOTACION" ("iCodAcuerdoAnotacion", "iCodAnotacion", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod") FROM stdin;
    renlim          admin    false    241    �      y          0    50320 	   ANOTACION 
   TABLE DATA           �  COPY renlim."ANOTACION" ("iCodAnotacion", "vNomAnotacion", "vFuenteCartografica", "vRepreCartografica", "vCartografiaBase", "vArchivoShape", "bTrifinio", "tMemDescriptiva", "dFechaReg", "dFechaFinalizado", "bAprobado", "iCodSolicitud", "dFechaMod", "vUsuarioReg", "bActivo", "iCodTipAnotacion", "iCodLibro", "iCodSeccion", "iEstado", "vUsuarioMod", "iTipSustento", "iCodNorma", "bPublicado", "iCodDocAcuerdo") FROM stdin;
    renlim          admin    false    243   ��      {          0    50331    ASIENTO_LIMITE 
   TABLE DATA           �   COPY renlim."ASIENTO_LIMITE" ("iCodAnotacion", "iCodLimite", "iNumAsiento", "vUsuarioReg", "bActivo", "iCodAsiento", "vUsuarioMod", "dFechaReg", "dFechaMod", "bAprobado", "bPublicado") FROM stdin;
    renlim          admin    false    245   ��      |          0    50335    CIRCUNSCRIPCION 
   TABLE DATA           �   COPY renlim."CIRCUNSCRIPCION" ("iCodCircunscripcion", "vNomCircunscripcion", "iTipCircunscripcion", "iCodDepCircunscripcion", "iCodProvCircunscripcion", "vUsuarioReg", "bActivo", "vUsuarioMod", "dFechaReg", "dFechaMod") FROM stdin;
    renlim          admin    false    246   �      ~          0    50339    DOCUMENTO_ANOTACION 
   TABLE DATA           �   COPY renlim."DOCUMENTO_ANOTACION" ("iCodDocAnotacion", "iCodAnotacion", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "iCodTipDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod") FROM stdin;
    renlim          admin    false    248   E      �          0    50348    DOCUMENTO_ASIENTO_LIMITE 
   TABLE DATA           �   COPY renlim."DOCUMENTO_ASIENTO_LIMITE" ("iCodDocAsientoLimite", "iCodAsiento", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "iCodTipDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod") FROM stdin;
    renlim          admin    false    250   ~J      �          0    50357    DOCUMENTO_SOLICITUD 
   TABLE DATA           �   COPY renlim."DOCUMENTO_SOLICITUD" ("iCodDocSolicitud", "iCodTipDocumento", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "iCodSolicitud", "vUsuarioMod") FROM stdin;
    renlim          admin    false    252   �K      �          0    50363    LIMITE 
   TABLE DATA           �   COPY renlim."LIMITE" ("iCodLimite", "vNumPartida", "iCodSuscripcionA", "iCodSuscripcionB", "iCodLibro", "iCodSeccion", "vUsuarioReg", "bActivo", "vUsuarioMod", "dFechaReg", "dFechaMod") FROM stdin;
    renlim          admin    false    253   fV      �          0    50367    MEMORIA 
   TABLE DATA           �   COPY renlim."MEMORIA" ("iCodMemoria", "iCodAnotacion", "iCodTipo", "dFechaReg", "dFechaMod", "vUsuarioReg", "vUsuarioMod", "bActivo", "vDescripcion") FROM stdin;
    renlim          admin    false    255   G      �          0    50372    MEMORIA_DESCRIPTIVA 
   TABLE DATA           �   COPY renlim."MEMORIA_DESCRIPTIVA" ("iCodMemDescriptiva", "iCodAnotacion", "vDesMemDescriptiva", "dFechaReg", "dFechaMod", "vUsuarioReg", "vUsuarioMod", "bActivo") FROM stdin;
    renlim          admin    false    257   R      �          0    50379    MEMORIA_NORMALIZADA 
   TABLE DATA           �   COPY renlim."MEMORIA_NORMALIZADA" ("iCodMemNormalizada", "iCodAnotacion", "iCodTipElemento", "vDesMemNormalizada", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod", "iCodMemoria") FROM stdin;
    renlim          admin    false    259   �      �          0    50386    MOVIMIENTO_ANOTACION 
   TABLE DATA           �   COPY renlim."MOVIMIENTO_ANOTACION" ("iCodMovAnotacion", "iCodAnotacion", "iEstadoMov", "vDesMovAnotacion", "dFechaMov", "vUsuarioReg", "iCodRolUsuarioReg", "vUsuarioDerivar", "iCodRolUsuarioDerivar", "dFechaAccion", "bActivo") FROM stdin;
    renlim          admin    false    261   7      �          0    50393    MOVIMIENTO_SOLICITUD 
   TABLE DATA           �   COPY renlim."MOVIMIENTO_SOLICITUD" ("iCodMovSolicitud", "iCodSolicitud", "vDesMovSolicitud", "dFechaMov", "vUsuarioReg", "iCodRolUsuarioReg", "vUsuarioDerivar", "iCodRolUsuarioDerivar", "iEstadoMov", "dFechaAccion", "bActivo") FROM stdin;
    renlim          admin    false    263   G      �          0    50399    NORMA 
   TABLE DATA           �   COPY renlim."NORMA" ("iCodNorma", "vNumero", "dFecha", "vArchivo", "vUsuarioReg", "vUsuarioMod", "dFechaReg", "dFechaMod", "iTipo", "bActivo") FROM stdin;
    renlim          admin    false    265   �       �          0    50406    PARTABLA 
   TABLE DATA           �   COPY renlim."PARTABLA" ("IdTabla", "Descripcion", "Abreviado", "Valor1", "Valor2", "Valor3", "Indicador1", "Indicador2", "Indicador3", "Orden", "Grupo", "Estado", "SeMuestra", "GrupoSuperior") FROM stdin;
    renlim          admin    false    266   �"      �          0    50412 	   SOLICITUD 
   TABLE DATA           4  COPY renlim."SOLICITUD" ("iCodSolicitud", "dFechaRecepcion", "vNumSGD", "vDesSolicitud", "bFavorable", "dFechaFinalizado", "iCodTipProceso", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "iEstado", "vUsuarioMod", "vInforme", "vInformeFirmado", "vNumInformeFirmado", "dFechaInformeFirmado") FROM stdin;
    renlim          admin    false    268   %(      �           0    0    sec_asiento_circunscripcion    SEQUENCE SET     I   SELECT pg_catalog.setval('renac.sec_asiento_circunscripcion', 32, true);
          renac          postgres    false    226            �           0    0    sec_asiento_modificacion    SEQUENCE SET     F   SELECT pg_catalog.setval('renac.sec_asiento_modificacion', 61, true);
          renac          postgres    false    216            �           0    0 "   sec_circunscripcion_origen_destino    SEQUENCE SET     P   SELECT pg_catalog.setval('renac.sec_circunscripcion_origen_destino', 68, true);
          renac          postgres    false    218            �           0    0    sec_derivacion_renac    SEQUENCE SET     B   SELECT pg_catalog.setval('renac.sec_derivacion_renac', 32, true);
          renac          postgres    false    228            �           0    0    sec_documento_derivacion    SEQUENCE SET     F   SELECT pg_catalog.setval('renac.sec_documento_derivacion', 25, true);
          renac          postgres    false    230            �           0    0    sec_informe_derivacion    SEQUENCE SET     D   SELECT pg_catalog.setval('renac.sec_informe_derivacion', 49, true);
          renac          postgres    false    232            �           0    0    sec_informe_renac    SEQUENCE SET     ?   SELECT pg_catalog.setval('renac.sec_informe_renac', 27, true);
          renac          postgres    false    234            �           0    0    sec_parametricas_renac    SEQUENCE SET     D   SELECT pg_catalog.setval('renac.sec_parametricas_renac', 13, true);
          renac          postgres    false    236            �           0    0    sec_tipo_asiento    SEQUENCE SET     =   SELECT pg_catalog.setval('renac.sec_tipo_asiento', 7, true);
          renac          postgres    false    220            �           0    0    sec_tipo_documento_renac    SEQUENCE SET     E   SELECT pg_catalog.setval('renac.sec_tipo_documento_renac', 3, true);
          renac          postgres    false    238            �           0    0    sec_tipo_modificacion_asiento    SEQUENCE SET     J   SELECT pg_catalog.setval('renac.sec_tipo_modificacion_asiento', 7, true);
          renac          postgres    false    222            �           0    0    sec_acuerdo_anotacion    SEQUENCE SET     D   SELECT pg_catalog.setval('renlim.sec_acuerdo_anotacion', 1, false);
          renlim          admin    false    240            �           0    0    sec_anotacion    SEQUENCE SET     <   SELECT pg_catalog.setval('renlim.sec_anotacion', 1, false);
          renlim          admin    false    242            �           0    0    sec_asiento_limite    SEQUENCE SET     A   SELECT pg_catalog.setval('renlim.sec_asiento_limite', 1, false);
          renlim          admin    false    244            �           0    0    sec_documento_aasiento_limite    SEQUENCE SET     L   SELECT pg_catalog.setval('renlim.sec_documento_aasiento_limite', 1, false);
          renlim          admin    false    249            �           0    0    sec_documento_anotacion    SEQUENCE SET     F   SELECT pg_catalog.setval('renlim.sec_documento_anotacion', 1, false);
          renlim          admin    false    247            �           0    0    sec_documento_solicitud    SEQUENCE SET     F   SELECT pg_catalog.setval('renlim.sec_documento_solicitud', 1, false);
          renlim          admin    false    251            �           0    0    sec_memoria    SEQUENCE SET     :   SELECT pg_catalog.setval('renlim.sec_memoria', 1, false);
          renlim          admin    false    254            �           0    0    sec_memoria_descriptiva    SEQUENCE SET     F   SELECT pg_catalog.setval('renlim.sec_memoria_descriptiva', 1, false);
          renlim          admin    false    256            �           0    0    sec_memoria_normalizada    SEQUENCE SET     F   SELECT pg_catalog.setval('renlim.sec_memoria_normalizada', 1, false);
          renlim          admin    false    258            �           0    0    sec_movimiento_anotacion    SEQUENCE SET     G   SELECT pg_catalog.setval('renlim.sec_movimiento_anotacion', 1, false);
          renlim          admin    false    260            �           0    0    sec_movimiento_solicitud    SEQUENCE SET     G   SELECT pg_catalog.setval('renlim.sec_movimiento_solicitud', 1, false);
          renlim          admin    false    262            �           0    0 	   sec_norma    SEQUENCE SET     8   SELECT pg_catalog.setval('renlim.sec_norma', 1, false);
          renlim          admin    false    264            �           0    0    sec_solicitud    SEQUENCE SET     <   SELECT pg_catalog.setval('renlim.sec_solicitud', 1, false);
          renlim          admin    false    267            �           2606    50420 2   ASIENTO_CIRCUNSCRIPCION PK_ASIENTO_CIRCUNSCRIPCION 
   CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION"
    ADD CONSTRAINT "PK_ASIENTO_CIRCUNSCRIPCION" PRIMARY KEY ("idAsientoCircunscripcion");
 _   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION" DROP CONSTRAINT "PK_ASIENTO_CIRCUNSCRIPCION";
       renac            postgres    false    227                       2606    50422 ,   ASIENTO_MODIFICACION PK_ASIENTO_MODIFICACION 
   CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION"
    ADD CONSTRAINT "PK_ASIENTO_MODIFICACION" PRIMARY KEY ("idAsientoModificacion");
 Y   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION" DROP CONSTRAINT "PK_ASIENTO_MODIFICACION";
       renac            postgres    false    217            �           2606    50424 @   CIRCUNSCRIPCION_ORIGEN_DESTINO PK_CIRCUNSCRIPCION_ORIGEN_DESTINO 
   CONSTRAINT     �   ALTER TABLE ONLY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
    ADD CONSTRAINT "PK_CIRCUNSCRIPCION_ORIGEN_DESTINO" PRIMARY KEY ("idCircunscripcionOrigenDestino");
 m   ALTER TABLE ONLY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" DROP CONSTRAINT "PK_CIRCUNSCRIPCION_ORIGEN_DESTINO";
       renac            postgres    false    219            �           2606    50426 $   DERIVACION_RENAC PK_DERIVACION_RENAC 
   CONSTRAINT     v   ALTER TABLE ONLY renac."DERIVACION_RENAC"
    ADD CONSTRAINT "PK_DERIVACION_RENAC" PRIMARY KEY ("idDerivacionRenac");
 Q   ALTER TABLE ONLY renac."DERIVACION_RENAC" DROP CONSTRAINT "PK_DERIVACION_RENAC";
       renac            postgres    false    229            �           2606    50428 ,   DOCUMENTO_DERIVACION PK_DOCUMENTO_DERIVACION 
   CONSTRAINT     �   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION"
    ADD CONSTRAINT "PK_DOCUMENTO_DERIVACION" PRIMARY KEY ("idDocumentoDerivacion");
 Y   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION" DROP CONSTRAINT "PK_DOCUMENTO_DERIVACION";
       renac            postgres    false    231            �           2606    50430 (   INFORME_DERIVACION PK_INFORME_DERIVACION 
   CONSTRAINT     |   ALTER TABLE ONLY renac."INFORME_DERIVACION"
    ADD CONSTRAINT "PK_INFORME_DERIVACION" PRIMARY KEY ("idInformeDerivacion");
 U   ALTER TABLE ONLY renac."INFORME_DERIVACION" DROP CONSTRAINT "PK_INFORME_DERIVACION";
       renac            postgres    false    233            �           2606    50432    INFORME_RENAC PK_INFORME_RENAC 
   CONSTRAINT     m   ALTER TABLE ONLY renac."INFORME_RENAC"
    ADD CONSTRAINT "PK_INFORME_RENAC" PRIMARY KEY ("idInformeRenac");
 K   ALTER TABLE ONLY renac."INFORME_RENAC" DROP CONSTRAINT "PK_INFORME_RENAC";
       renac            postgres    false    235            �           2606    50434 (   PARAMETRICAS_RENAC PK_PARAMETRICAS_RENAC 
   CONSTRAINT     |   ALTER TABLE ONLY renac."PARAMETRICAS_RENAC"
    ADD CONSTRAINT "PK_PARAMETRICAS_RENAC" PRIMARY KEY ("idParametricasRenac");
 U   ALTER TABLE ONLY renac."PARAMETRICAS_RENAC" DROP CONSTRAINT "PK_PARAMETRICAS_RENAC";
       renac            postgres    false    237            �           2606    50436    TIPO_ASIENTO PK_TIPO_ASIENTO 
   CONSTRAINT     j   ALTER TABLE ONLY renac."TIPO_ASIENTO"
    ADD CONSTRAINT "PK_TIPO_ASIENTO" PRIMARY KEY ("idTipoAsiento");
 I   ALTER TABLE ONLY renac."TIPO_ASIENTO" DROP CONSTRAINT "PK_TIPO_ASIENTO";
       renac            postgres    false    221            �           2606    50438 ,   TIPO_DOCUMENTO_RENAC PK_TIPO_DOCUMENTO_RENAC 
   CONSTRAINT     �   ALTER TABLE ONLY renac."TIPO_DOCUMENTO_RENAC"
    ADD CONSTRAINT "PK_TIPO_DOCUMENTO_RENAC" PRIMARY KEY ("idTipoDocumentoRenac");
 Y   ALTER TABLE ONLY renac."TIPO_DOCUMENTO_RENAC" DROP CONSTRAINT "PK_TIPO_DOCUMENTO_RENAC";
       renac            postgres    false    239            �           2606    50440 6   TIPO_MODIFICACION_ASIENTO PK_TIPO_MODIFICACION_ASIENTO 
   CONSTRAINT     �   ALTER TABLE ONLY renac."TIPO_MODIFICACION_ASIENTO"
    ADD CONSTRAINT "PK_TIPO_MODIFICACION_ASIENTO" PRIMARY KEY ("idTipoModificacionAsiento");
 c   ALTER TABLE ONLY renac."TIPO_MODIFICACION_ASIENTO" DROP CONSTRAINT "PK_TIPO_MODIFICACION_ASIENTO";
       renac            postgres    false    223            �           2606    50442 "   ASIENTO_LIMITE ASIENTO_LIMITE_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY renlim."ASIENTO_LIMITE"
    ADD CONSTRAINT "ASIENTO_LIMITE_pkey" PRIMARY KEY ("iCodAsiento");
 P   ALTER TABLE ONLY renlim."ASIENTO_LIMITE" DROP CONSTRAINT "ASIENTO_LIMITE_pkey";
       renlim            admin    false    245            �           2606    50444 &   ACUERDO_ANOTACION PK_ACUERDO_ANOTACION 
   CONSTRAINT     |   ALTER TABLE ONLY renlim."ACUERDO_ANOTACION"
    ADD CONSTRAINT "PK_ACUERDO_ANOTACION" PRIMARY KEY ("iCodAcuerdoAnotacion");
 T   ALTER TABLE ONLY renlim."ACUERDO_ANOTACION" DROP CONSTRAINT "PK_ACUERDO_ANOTACION";
       renlim            admin    false    241            �           2606    50446    ANOTACION PK_ANOTACION 
   CONSTRAINT     e   ALTER TABLE ONLY renlim."ANOTACION"
    ADD CONSTRAINT "PK_ANOTACION" PRIMARY KEY ("iCodAnotacion");
 D   ALTER TABLE ONLY renlim."ANOTACION" DROP CONSTRAINT "PK_ANOTACION";
       renlim            admin    false    243            �           2606    50448 "   CIRCUNSCRIPCION PK_CIRCUNSCRIPCION 
   CONSTRAINT     w   ALTER TABLE ONLY renlim."CIRCUNSCRIPCION"
    ADD CONSTRAINT "PK_CIRCUNSCRIPCION" PRIMARY KEY ("iCodCircunscripcion");
 P   ALTER TABLE ONLY renlim."CIRCUNSCRIPCION" DROP CONSTRAINT "PK_CIRCUNSCRIPCION";
       renlim            admin    false    246            �           2606    50450 *   DOCUMENTO_ANOTACION PK_DOCUMENTO_ANOTACION 
   CONSTRAINT     |   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION"
    ADD CONSTRAINT "PK_DOCUMENTO_ANOTACION" PRIMARY KEY ("iCodDocAnotacion");
 X   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION" DROP CONSTRAINT "PK_DOCUMENTO_ANOTACION";
       renlim            admin    false    248            �           2606    50452 4   DOCUMENTO_ASIENTO_LIMITE PK_DOCUMENTO_ASIENTO_LIMITE 
   CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE"
    ADD CONSTRAINT "PK_DOCUMENTO_ASIENTO_LIMITE" PRIMARY KEY ("iCodDocAsientoLimite");
 b   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE" DROP CONSTRAINT "PK_DOCUMENTO_ASIENTO_LIMITE";
       renlim            admin    false    250            �           2606    50454 *   DOCUMENTO_SOLICITUD PK_DOCUMENTO_SOLICITUD 
   CONSTRAINT     |   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD"
    ADD CONSTRAINT "PK_DOCUMENTO_SOLICITUD" PRIMARY KEY ("iCodDocSolicitud");
 X   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD" DROP CONSTRAINT "PK_DOCUMENTO_SOLICITUD";
       renlim            admin    false    252            �           2606    50456    LIMITE PK_LIMITE 
   CONSTRAINT     \   ALTER TABLE ONLY renlim."LIMITE"
    ADD CONSTRAINT "PK_LIMITE" PRIMARY KEY ("iCodLimite");
 >   ALTER TABLE ONLY renlim."LIMITE" DROP CONSTRAINT "PK_LIMITE";
       renlim            admin    false    253            �           2606    50458    MEMORIA PK_MEMORIA 
   CONSTRAINT     _   ALTER TABLE ONLY renlim."MEMORIA"
    ADD CONSTRAINT "PK_MEMORIA" PRIMARY KEY ("iCodMemoria");
 @   ALTER TABLE ONLY renlim."MEMORIA" DROP CONSTRAINT "PK_MEMORIA";
       renlim            admin    false    255            �           2606    50460 *   MEMORIA_DESCRIPTIVA PK_MEMORIA_DESCRIPTIVA 
   CONSTRAINT     ~   ALTER TABLE ONLY renlim."MEMORIA_DESCRIPTIVA"
    ADD CONSTRAINT "PK_MEMORIA_DESCRIPTIVA" PRIMARY KEY ("iCodMemDescriptiva");
 X   ALTER TABLE ONLY renlim."MEMORIA_DESCRIPTIVA" DROP CONSTRAINT "PK_MEMORIA_DESCRIPTIVA";
       renlim            admin    false    257            �           2606    50462 *   MEMORIA_NORMALIZADA PK_MEMORIA_NORMALIZADA 
   CONSTRAINT     ~   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA"
    ADD CONSTRAINT "PK_MEMORIA_NORMALIZADA" PRIMARY KEY ("iCodMemNormalizada");
 X   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA" DROP CONSTRAINT "PK_MEMORIA_NORMALIZADA";
       renlim            admin    false    259            �           2606    50464 ,   MOVIMIENTO_SOLICITUD PK_MOVIMIENTO_SOLICITUD 
   CONSTRAINT     ~   ALTER TABLE ONLY renlim."MOVIMIENTO_SOLICITUD"
    ADD CONSTRAINT "PK_MOVIMIENTO_SOLICITUD" PRIMARY KEY ("iCodMovSolicitud");
 Z   ALTER TABLE ONLY renlim."MOVIMIENTO_SOLICITUD" DROP CONSTRAINT "PK_MOVIMIENTO_SOLICITUD";
       renlim            admin    false    263            �           2606    50466 -   MOVIMIENTO_ANOTACION PK_OBSERVACION_ANOTACION 
   CONSTRAINT        ALTER TABLE ONLY renlim."MOVIMIENTO_ANOTACION"
    ADD CONSTRAINT "PK_OBSERVACION_ANOTACION" PRIMARY KEY ("iCodMovAnotacion");
 [   ALTER TABLE ONLY renlim."MOVIMIENTO_ANOTACION" DROP CONSTRAINT "PK_OBSERVACION_ANOTACION";
       renlim            admin    false    261            �           2606    50468    SOLICITUD SOLICITUD_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY renlim."SOLICITUD"
    ADD CONSTRAINT "SOLICITUD_pkey" PRIMARY KEY ("iCodSolicitud");
 F   ALTER TABLE ONLY renlim."SOLICITUD" DROP CONSTRAINT "SOLICITUD_pkey";
       renlim            admin    false    268            �           2606    50470    NORMA TIPO_NORMA_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY renlim."NORMA"
    ADD CONSTRAINT "TIPO_NORMA_pkey" PRIMARY KEY ("iCodNorma");
 C   ALTER TABLE ONLY renlim."NORMA" DROP CONSTRAINT "TIPO_NORMA_pkey";
       renlim            admin    false    265            �           1259    50471    PK_ASIENTO_LIMITE    INDEX        CREATE UNIQUE INDEX "PK_ASIENTO_LIMITE" ON renlim."ASIENTO_LIMITE" USING btree ("iCodAnotacion", "iCodLimite", "iNumAsiento");
 '   DROP INDEX renlim."PK_ASIENTO_LIMITE";
       renlim            admin    false    245    245    245            �           1259    50472    fki_FK_TIPO_NORMA    INDEX     R   CREATE INDEX "fki_FK_TIPO_NORMA" ON renlim."ANOTACION" USING btree ("iCodNorma");
 '   DROP INDEX renlim."fki_FK_TIPO_NORMA";
       renlim            admin    false    243            �           1259    50473    partabla_idtabla_idx    INDEX     W   CREATE UNIQUE INDEX partabla_idtabla_idx ON renlim."PARTABLA" USING btree ("IdTabla");
 (   DROP INDEX renlim.partabla_idtabla_idx;
       renlim            admin    false    266            �           2606    50474 /   ASIENTO_MODIFICACION FK_ASIENTO_CIRCUNSCRIPCION    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION"
    ADD CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION" FOREIGN KEY ("idAsientoCircunscripcion") REFERENCES renac."ASIENTO_CIRCUNSCRIPCION"("idAsientoCircunscripcion");
 \   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION" DROP CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION";
       renac          postgres    false    3463    227    217            �           2606    50479 9   CIRCUNSCRIPCION_ORIGEN_DESTINO FK_ASIENTO_CIRCUNSCRIPCION    FK CONSTRAINT     �   ALTER TABLE ONLY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
    ADD CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION" FOREIGN KEY ("idAsientoCircunscripcion") REFERENCES renac."ASIENTO_CIRCUNSCRIPCION"("idAsientoCircunscripcion");
 f   ALTER TABLE ONLY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" DROP CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION";
       renac          postgres    false    219    227    3463            �           2606    50484 &   INFORME_DERIVACION FK_DERIVACION_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."INFORME_DERIVACION"
    ADD CONSTRAINT "FK_DERIVACION_RENAC" FOREIGN KEY ("idDerivacionRenac") REFERENCES renac."DERIVACION_RENAC"("idDerivacionRenac");
 S   ALTER TABLE ONLY renac."INFORME_DERIVACION" DROP CONSTRAINT "FK_DERIVACION_RENAC";
       renac          postgres    false    229    3465    233            �           2606    50489 (   DOCUMENTO_DERIVACION FK_DERIVACION_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION"
    ADD CONSTRAINT "FK_DERIVACION_RENAC" FOREIGN KEY ("idDerivacionRenac") REFERENCES renac."DERIVACION_RENAC"("idDerivacionRenac");
 U   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION" DROP CONSTRAINT "FK_DERIVACION_RENAC";
       renac          postgres    false    3465    231    229            �           2606    50494 "   INFORME_RENAC FK_ESTADO_DERIVACION    FK CONSTRAINT     �   ALTER TABLE ONLY renac."INFORME_RENAC"
    ADD CONSTRAINT "FK_ESTADO_DERIVACION" FOREIGN KEY ("idEstadoDerivacion") REFERENCES renac."PARAMETRICAS_RENAC"("idParametricasRenac");
 O   ALTER TABLE ONLY renac."INFORME_RENAC" DROP CONSTRAINT "FK_ESTADO_DERIVACION";
       renac          postgres    false    237    235    3473            �           2606    50499 (   ASIENTO_CIRCUNSCRIPCION FK_INFORME_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION"
    ADD CONSTRAINT "FK_INFORME_RENAC" FOREIGN KEY ("idInformeRenac") REFERENCES renac."INFORME_RENAC"("idInformeRenac");
 U   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION" DROP CONSTRAINT "FK_INFORME_RENAC";
       renac          postgres    false    235    3471    227            �           2606    50504 #   INFORME_DERIVACION FK_INFORME_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."INFORME_DERIVACION"
    ADD CONSTRAINT "FK_INFORME_RENAC" FOREIGN KEY ("idInformeRenac") REFERENCES renac."INFORME_RENAC"("idInformeRenac");
 P   ALTER TABLE ONLY renac."INFORME_DERIVACION" DROP CONSTRAINT "FK_INFORME_RENAC";
       renac          postgres    false    3471    233    235            �           2606    50509 '   ASIENTO_CIRCUNSCRIPCION FK_TIPO_ASIENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION"
    ADD CONSTRAINT "FK_TIPO_ASIENTO" FOREIGN KEY ("idTipoAsiento") REFERENCES renac."TIPO_ASIENTO"("idTipoAsiento");
 T   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION" DROP CONSTRAINT "FK_TIPO_ASIENTO";
       renac          postgres    false    227    3459    221            �           2606    50514 ,   DOCUMENTO_DERIVACION FK_TIPO_DOCUMENTO_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION"
    ADD CONSTRAINT "FK_TIPO_DOCUMENTO_RENAC" FOREIGN KEY ("idTipoDocumentoRenac") REFERENCES renac."TIPO_DOCUMENTO_RENAC"("idTipoDocumentoRenac");
 Y   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION" DROP CONSTRAINT "FK_TIPO_DOCUMENTO_RENAC";
       renac          postgres    false    3475    231    239            �           2606    50519 1   ASIENTO_MODIFICACION FK_TIPO_MODIFICACION_ASIENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION"
    ADD CONSTRAINT "FK_TIPO_MODIFICACION_ASIENTO" FOREIGN KEY ("idTipoModificacionAsiento") REFERENCES renac."TIPO_MODIFICACION_ASIENTO"("idTipoModificacionAsiento");
 ^   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION" DROP CONSTRAINT "FK_TIPO_MODIFICACION_ASIENTO";
       renac          postgres    false    3461    217    223            �           2606    50524 &   ACUERDO_ANOTACION FK_ACUERDO_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ACUERDO_ANOTACION"
    ADD CONSTRAINT "FK_ACUERDO_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 T   ALTER TABLE ONLY renlim."ACUERDO_ANOTACION" DROP CONSTRAINT "FK_ACUERDO_ANOTACION";
       renlim          admin    false    3479    241    243            �           2606    50529     ANOTACION FK_ANOTACION_SOLICITUD    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ANOTACION"
    ADD CONSTRAINT "FK_ANOTACION_SOLICITUD" FOREIGN KEY ("iCodSolicitud") REFERENCES renlim."SOLICITUD"("iCodSolicitud");
 N   ALTER TABLE ONLY renlim."ANOTACION" DROP CONSTRAINT "FK_ANOTACION_SOLICITUD";
       renlim          admin    false    243    3508    268            �           2606    50534 *   ASIENTO_LIMITE FK_ASIENTO_LIMITE_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_ASIENTO_LIMITE_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 X   ALTER TABLE ONLY renlim."ASIENTO_LIMITE" DROP CONSTRAINT "FK_ASIENTO_LIMITE_ANOTACION";
       renlim          admin    false    3479    245    243            �           2606    50539 '   ASIENTO_LIMITE FK_ASIENTO_LIMITE_LIMITE    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_ASIENTO_LIMITE_LIMITE" FOREIGN KEY ("iCodLimite") REFERENCES renlim."LIMITE"("iCodLimite");
 U   ALTER TABLE ONLY renlim."ASIENTO_LIMITE" DROP CONSTRAINT "FK_ASIENTO_LIMITE_LIMITE";
       renlim          admin    false    3493    245    253            �           2606    50544 4   DOCUMENTO_ASIENTO_LIMITE FK_DOCUMENTO_ASIENTO_LIMITE    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE" FOREIGN KEY ("iCodAsiento") REFERENCES renlim."ASIENTO_LIMITE"("iCodAsiento");
 b   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE" DROP CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE";
       renlim          admin    false    250    245    3482            �           2606    50549 C   DOCUMENTO_ASIENTO_LIMITE FK_DOCUMENTO_ASIENTO_LIMITE_TIPO_DOCUMENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE_TIPO_DOCUMENTO" FOREIGN KEY ("iCodTipDocumento") REFERENCES renlim."PARTABLA"("IdTabla");
 q   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE" DROP CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE_TIPO_DOCUMENTO";
       renlim          admin    false    3506    266    250            �           2606    50554 4   DOCUMENTO_SOLICITUD FK_DOCUMENTO_SOLICITUD_SOLICITUD    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD"
    ADD CONSTRAINT "FK_DOCUMENTO_SOLICITUD_SOLICITUD" FOREIGN KEY ("iCodSolicitud") REFERENCES renlim."SOLICITUD"("iCodSolicitud");
 b   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD" DROP CONSTRAINT "FK_DOCUMENTO_SOLICITUD_SOLICITUD";
       renlim          admin    false    268    3508    252            �           2606    50559 9   DOCUMENTO_SOLICITUD FK_DOCUMENTO_SOLICITUD_TIPO_DOCUMENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD"
    ADD CONSTRAINT "FK_DOCUMENTO_SOLICITUD_TIPO_DOCUMENTO" FOREIGN KEY ("iCodTipDocumento") REFERENCES renlim."PARTABLA"("IdTabla");
 g   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD" DROP CONSTRAINT "FK_DOCUMENTO_SOLICITUD_TIPO_DOCUMENTO";
       renlim          admin    false    3506    252    266            �           2606    50564 .   DOCUMENTO_ANOTACION FK_DOC_ANOTACION_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION"
    ADD CONSTRAINT "FK_DOC_ANOTACION_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 \   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION" DROP CONSTRAINT "FK_DOC_ANOTACION_ANOTACION";
       renlim          admin    false    248    3479    243            �           2606    50569 3   DOCUMENTO_ANOTACION FK_DOC_ANOTACION_TIPO_DOCUMENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION"
    ADD CONSTRAINT "FK_DOC_ANOTACION_TIPO_DOCUMENTO" FOREIGN KEY ("iCodTipDocumento") REFERENCES renlim."PARTABLA"("IdTabla");
 a   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION" DROP CONSTRAINT "FK_DOC_ANOTACION_TIPO_DOCUMENTO";
       renlim          admin    false    248    3506    266            �           2606    50574 !   LIMITE FK_LIMITE_CIRCUSCRIPCION_A    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."LIMITE"
    ADD CONSTRAINT "FK_LIMITE_CIRCUSCRIPCION_A" FOREIGN KEY ("iCodSuscripcionA") REFERENCES renlim."CIRCUNSCRIPCION"("iCodCircunscripcion");
 O   ALTER TABLE ONLY renlim."LIMITE" DROP CONSTRAINT "FK_LIMITE_CIRCUSCRIPCION_A";
       renlim          admin    false    253    246    3485            �           2606    50579    MEMORIA FK_MEMORIA_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA"
    ADD CONSTRAINT "FK_MEMORIA_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 J   ALTER TABLE ONLY renlim."MEMORIA" DROP CONSTRAINT "FK_MEMORIA_ANOTACION";
       renlim          admin    false    243    3479    255            �           2606    50584 *   MEMORIA_NORMALIZADA FK_MEMORIA_NORMALIZADA    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA"
    ADD CONSTRAINT "FK_MEMORIA_NORMALIZADA" FOREIGN KEY ("iCodMemoria") REFERENCES renlim."MEMORIA"("iCodMemoria");
 X   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA" DROP CONSTRAINT "FK_MEMORIA_NORMALIZADA";
       renlim          admin    false    3495    255    259            �           2606    50589 0   MEMORIA_DESCRIPTIVA FK_MEM_DESCRIPTIVA_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA_DESCRIPTIVA"
    ADD CONSTRAINT "FK_MEM_DESCRIPTIVA_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 ^   ALTER TABLE ONLY renlim."MEMORIA_DESCRIPTIVA" DROP CONSTRAINT "FK_MEM_DESCRIPTIVA_ANOTACION";
       renlim          admin    false    3479    257    243            �           2606    50594 0   MEMORIA_NORMALIZADA FK_MEM_NORMALIZADA_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA"
    ADD CONSTRAINT "FK_MEM_NORMALIZADA_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 ^   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA" DROP CONSTRAINT "FK_MEM_NORMALIZADA_ANOTACION";
       renlim          admin    false    259    243    3479            �           2606    50599 /   MOVIMIENTO_ANOTACION FK_MOV_ANOTACION_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MOVIMIENTO_ANOTACION"
    ADD CONSTRAINT "FK_MOV_ANOTACION_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 ]   ALTER TABLE ONLY renlim."MOVIMIENTO_ANOTACION" DROP CONSTRAINT "FK_MOV_ANOTACION_ANOTACION";
       renlim          admin    false    3479    243    261            �           2606    50604 /   MOVIMIENTO_SOLICITUD FK_MOV_SOLICITUD_SOLICITUD    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MOVIMIENTO_SOLICITUD"
    ADD CONSTRAINT "FK_MOV_SOLICITUD_SOLICITUD" FOREIGN KEY ("iCodSolicitud") REFERENCES renlim."SOLICITUD"("iCodSolicitud");
 ]   ALTER TABLE ONLY renlim."MOVIMIENTO_SOLICITUD" DROP CONSTRAINT "FK_MOV_SOLICITUD_SOLICITUD";
       renlim          admin    false    3508    263    268            f   J   x�s�O.�M�+�/�ϼ����TǼ������<������kp��cH���������������^AJW� a,�      g   U   x�s�O.�M�+�/���Ҥ���ԒĢ���`O��h@Q~ejrI�ojn~L����?X*��������������H� %�+F��� %t      i   E  x��R�R�0��_��Fwg=�h((�L#��$V�V(�zd�y���I���j�%Ā��Gxh6a_�&���O����:uq�M
�x )�r$��ץ�J��	�9��t�J�@�*��@�z`�߅.|�M�
��ИV�I�|���Ɠ��	u9�*�����ϡ���g��2Z�3�:��حg'1[=�4I�L��SM�����w�?�+�N"),��+ �H�{�n�bbm�R=�3G����^)�$�#�T�@� Zw�~�z��5�u�s�]
��MQ��f2��Ɋ5�334��Rw���Ή+O�%*e���(�kQ��      _   �   x�����0��=E��������A=XJ�S����@=��oA6��aUzQp���w�y�DY{xeT
C���+��bi�>�(�����w��Q������{�'�W能0����"^l��[��uA�a��G|��S�#��!���M�"���ˌ9��%��K
��      a   Y  x���Mn�0FדS�X���'޵]UZ�-�R���	=
�jBb���|�gT�â���?@h�$�D�	R��S�C+�$f�s��hy�|��1 ]�a��|,�7!����C�Y_��2}�3�M����I�!F<�3<W�rW�K����^B���:}���0}�S�O�z�J�#+rV(�SL��H�e�.l|STè�#r��4�ϼ��*ĦD��ٞ���ZJ����X�d�r�i&̇[Jk)k�J����(]���q/��������C�*ꏱdڑ�ۃ��( {h׷n��1�Vhb6j��H�����<�ܝ:s���Hs�h������A�I�|����      k     x���Mn� ��p
_ ���ϳ�T�Ucg�����W!j��(-22���<���Z��M'�F�˛d��W�s��Ӣ��������_�B��*�A��8&�Byb�������2S*_��u����'�â��[�Gv%r��\_��Bf-��$��~]����/y�^���b&���]���6�*�=�����5��v&U�(@�Ǎv ;b�&���oeR!*#�⑑Y�:�]jĵ4���j��W��-`��3zC�����J�q3Z��CЁ      m   E  x����J�0������|iҜM7���P2k���c��{��~lׁ��#yr���D��A��|�)>���ZT�"_�>�U�J���ss��+���.�Ŧ̲�b�آbpH��m��ۻ�
k�\N�M�&��fL� �M��ю&P$#ꑻ��/�"qض���L_/ݿVE�+��n]�Ï �A�#���@�s�d�wx��������YXP)���+��~�=o�H����(GO0�J��9<ӓ	���X��z�F��Q���~��>�{�c|�!t�f7�:t�I�8������6�'q��mEs���%�EZ�o�_AD      o   �   x�����1г��4>`0E�����km��z�����(�Y?yR<�9�j�Xy�
��^�
�?�����V*��5�l;4(�U�ݭ����k�hNxaH�Z��S#uܤ�h[s�]��f)�"m_P�F�k}0�J*�{�[��B���T!E�ci>�q����o������$KX�6��|��~�;g�      q   )  x����J�@�ϛ��l����{+F�B�X��"�MD��;Ә&�C�e�1;�,?b�!�p��H?ެ�v�Z>�{%FC���n����u>�u����*O����,����V�r��{xZ���RH��3��'���~�@N�'!826��9�;#�,G���7�~���#̴|��!		l�E�/� �����=����/�ڞ!	�亯G��{)��{{��}���9�fR��}LB8z��C6���$TD֌�e�":U ثH���dʑ��T��rI�� ��Xr��Y��Y�}{���      s   �   x��б
�0���y�(�nB;ti�:��h@�$��o�urQ�����;	�"�5�0��ڛ8�.J[7��H�H����"/�L�Br��:�E. ��LF[5��Ѻ�W�1#V�G�?]0ڛYy�N)lS�^�����7'۝t��#�L��T7����]�1�M	!_td�      c   �   x�u�Kn�0D��)|�R$%m�nO���8��")Z���U�E��������\�i���խ�"�!�!b�TJ$l����ŭ��;~�O�!�� ��8^���i��*dϰOn��Vw�3� ���$���I�&W�@���������ͥ��f����%َ A�u�«ߦ;H����f��]���(,B��w���#)n�$���$I�=A��S��� ��[�      u   x   x�e�;�0��SpV������D��q�W)B�y�XJ=����Th��6�<�,�Cv�d1����A�V�mP����y"7M�H�&���=��5�c?�Z�]�.�1I�ݍ�W$�      e   �   x���Mj� ���^ ���'N�]��.gc�B&�s���)eRH�Ѝ��}O��N}�E�|�FF��]��!���������n	[��5Ȯo�R{�ȉ���ӽK�QRȋ�d��d��-��I��ϊ�"	K��=��?��n��}j�1�u\|�����U����Rc��)#�F����U��W[A`$�7lNk��q�>k��������J(E�"�WJ$+�)>�����/LC��      w   z  x����nA�s��@]Kos��8r �,'_z)�@���Ocb,�������bRhYi�@l��i����qX����i�_�Z��_�p:�Y]�p8�b�y<���>E�`�i��+�d,$���\�s����F �H؆��=s�ر6V��N��;ujq�|A�9m�a�8��+8k�B�l@&E�VG!T���Vnqd;1�y�V'�:t���vz����Mr��X�G¹�a]s)(���[ �mnm�;g���i��Ԑ��d��&�j�*U �R��C	3Q��tQh�
�%�^�g�6�۷ �зc���ރ�@!7��$�E��if.If[9��0h�k$�D�3��x�Yk>C>���o�v��\<O�b��X��      y   #  x��X�n��}f�bs�3{��7F��Q K���`Hm�(Prpҿ�hѷ>6?�=�,K�e�m*�n�����-�|<���ɘ���9r�ۧ|<�?���K��p�X6��eK>�������)[2�e�����^43R��ړ*��fޅE���_Rry;o�Y�~���#������FN��\��	���\��<#y�5��ѣ��o�N��my{f�v�v�1��˕o=�;�i���R3����Y`jQU6�Ϯ����\��8��OA 2�O�� �jc���e\� Fa�ޟ�,c�8�x��1���7��+��ƗW�e�O����2���(O>\���eT����rW8*�6��Z�;�z!�sL���g}V*5F����owl����]��e����.��{puI@gRdʥ�	��Q��LA���Q��}>!q�O�۹�2?O�\2c�)���3;���ssU���]2�0�)��uV2�b3J�:�K*��(x������UX�d�Y�`���FR���2�����2?��ם��;����5�-4���h��0�ؤ��7~���\5KG�esOz�\�"��
Pa�o*FyiD)*�U�v&d?�"fP�8���YwY���L&]j�d��N�*���uz���v��'�������d�_\�O>��O��������P�����z�����J�J/d�g )S����W�L���AVxY�јd��L�Y�}��#����Q�&}���4��~k��6�����TMɍ��X���xbC�a�ߒg�c�?��C��x�?��?��~���C���e�8V�chFk��7?J=����ؙQ��m�������y���qf�l��!�z���`ͻ��n��b�f�#�@�#�ۮ����>N�2�\P����QFp{�F �T���c����x2��P�ޟ"*�-�X�\��"O���×��{�\�z�R����j��Ri$Т֒�P:VI�P���~$LE��	�H*�-%_1��4G�b�f�kD5�6��:m�0+���;m;O(yr����������{�?����=�Ӧ�9���M�~���a�g-y��?�Ӱ��y;E/fhr�(q>Wn������w3����`�Y�_0��\!����g�.� ���#�#yq�ܔrk@�÷�F�@��i��&�'���A�%�Ɖa�(��}�KGG����k�,U����d}C���j���U+-
����:	~���|�������Fy׻�>��a��Gu�Gb>C�y�5�ѣPa�����1d�$��^*x"Ј0�.U륷�0�FUs��i���
wÓ�.�Lq���6���`��$_/BB�<j#2������8@��-�H��"RS���.BA����K$.蒗��r� ��Q�i�H9�Q����p�@~�j��3Z�6��N ��r��ۉU&�[t�A�bK�A�Z��]�6�D���c�њօ؂����5j5k�b�Py��Y�W�x�4�]]T�y��ִ�5����ҳ�f�]��R+��q�3v;� �Eh��0[*����M����������=J�s��BQ��Z�Bz�НJqS`��Bb�����n�8Y�*�
��@�n���^Vu�$:���>�|��ׅgԾ�d�X�1�a�������4���-����^����"�Up�Ji&��y�.����7F"@3�X���_� �\����;/�i��Y=	D�o�K�q����k!�(tL8����)��̽�ܱIU_�G�WB�g8?�̘D�f�bl���e	�8��+/۞ӏ�*��ri��r$�B�:h�U������uՓ�HA[`^��K�.Hpz2*�����C�ꨍF���9�e�����IA�w�EJR�9#��^��V'~��ث�An jxi�dC��A�v�����qG�	�V�g�#��A�-�yV����U��O\�)��F����-�ceg��6l��D]���Zq(vbX�9�M4ư	����&�m��ś�)^�h�P<�S�Ky��~M_�z�o7��      {     x�}�I��@D��)|78��;%�"A� N����ۃl�@�ƫR�"R����2������yx��XE1VY�j�Z*:�<;L���aY�A�5��@0�	�n5�?Ɵ_����<�;]qA'�c:��Q�֧i�=JiL%�#_�r����yaa]�WBe�%\pAz����Os��`���=R���Jh�ty�:�e[X��y�����@�GohM�� .�� >�*�����`	'�	,���/�[7U�?_��O������3u�EI��E�4$1�̞�
�����s^�w%y��~�r�GKq��q��'84�Mj��0��}N����qU}c��72�-��@m�=��D�]@P{&$M9"�v�/��D�mtV|�����F���S	3���Q���.´�����ؽ�\%ƦT�Y�n���J�:�+�s���W��y��w9�)"|��Y�z����1,'<%�IP�P�>�74r�S�W����u+ꉓ���_J*M����}�}��n�l�@�      |      x��}Ir$���9�W}�22�odD�h�_Ҵm@РLK���ݑ$���f��T��^� ����x��岜.�t�-�Ǣ�<�JUd]������0�4�Z�o��f���<��(Oy�?���������j�_��P�r��~7ۮӠJ����z����}�O����L����Ꮶ�Vʬ�c�tL��q{=�0����:��Y_ҐZ5���9qE���/'3��W�1���:���uu<�<S��ޖ�q���P9���kﰺ��[&R�^=�zp�M	g�s�J��y7���i�^�ū�f�g=%.�VW�r���f]�^�a���8��y�s"L�4ofз�
&P���N[P�)POp��`�R�B�Ӌ^�œ�Y1�����Q=��0�����.��:ú�`� �d"6����.-c� �~�k�]Q���\�V0�k�jtK�ǫ3�þ�ĝ�9��#>"�j0�8
S��R�9?���G�E����s�ā���Z򼀥�-�m78��lk0URŨ�>6}��{����z>���bލN�^��9|�H�0���:��.�� �9B��w1���#�c�@��I��U�9��}�l7`,`�%_�����+�2(x�j�yq雕\�k��pk��pN��/KP��I��u����ļ�-J�g��1�-�a�ѫ�n�[�J��l��W�O y��k�+��8M�}I��FS�4���'��S6�67W��ԕ��V�kX[�y����ٟ߁pd�u�
��>��������l:Mw���>kP4i[���]���W2���@��F��5��L���b�K��a�sF�0$jpq�EO�^R�CKu8@I�Ɠ��u���mH�f=�2l&%Wo�❗�+����d�p��`�����x�<�դ�۾���t��t>6�����~Zͻ�>e��������������
jj�{��:�ޖ䝡�y�v��6�
~��΍��6�����+��DsK^_����	���O�`a�zαpU�"Y�E"��f3,`����\�)QE�Y�>ƛ�M�<k��z;�����o�ʯ�8`ģQ:/����ua��uy��0���9-l���0���9s�fտ�%��o�� (|�dőWJO�r���]��4��c*d~�~��P%JG��C~��7 oh��	]6h�iIWay���r��'Td�~�/���̠R漢T
�˺�@.��s�8����N,�cJ4Ss0�}��޼��O����V���=實{�T�y�(@���x˹	�2u��`�a� ����l]^���	���T,wE21(+z��.�	W��U�V�\�İS^��6d�G�{I-ܖd���<Sh��[�����P���U��r��S?`��U�f�;��a�E�zd��
~A⭮J�	��̔[^�	s�tf/�rJ�'��ke��C�����l��n��s�+�Z��R�Kg;��0��=�KK0e3����W���,����e�.0:�l�%�
̔%��g]W�����9	�ՠ����R��׀NI�qu�0�7�Y�1neQ���8�9��
�e/�^C*���h8[(1O�D�{oi��9�#콕��i�?&�g�P�<}���Ը��ú)}ò�D��<�=\WԱ�N_�D%�s/rӃǰ��]�ⴙ������U��5�y�����7p\ӕ�
#��^�T]���(��.O�5�h�-���lϜ��P��'qf��z*-���D%�e�/U ��_���e5/:���߮�z�I�1��+N]IVذD�W3a�TxX�_QM5��aā}S�������Եj?��Pe4,���O�^KO��%R%��YlLھ�z��I����S����|��c����c���؍�ސ�����s��8�P���[���ƥf����zPދ��-7��w��xq�,�tl	 ����uH\P�e����8MN��hME�SC�v��٩�.���޻��gܖ���*��a���*A�s�n�}T؟s�+�dg�X+w]��L�e��X�H�I�Co`�ԥL�z��O)�����J2{9�X5�=x/-�{��thSƥ-��Q��WVtpG�9�"����pq�zB��5n73�InْZ5��m˱a��y�(%��p�p��:����/Wd`,�#��:(���#��V�$9&3�g���_��7�L����[`{��	���lԯ[�`���SQ4��z�@-0SEѪu��i�EG�x�1nkFQ��S���V����e��U/e��h�>\�P����B���/�Fe�=��m ���fY��2�wGq�>=�qc�g<OˉL� ���Fa"��I��+���KB���>/^� O���P�s��7�⚚Xaۓ�}tz?QU���*�&�q��ۭ%[��o���1c�>~�U/�~��W}�.��$^�
��B�����t2g�
NϺL�V5���ޅ�i@l�@�3�����@�?�"ߢ��#�+�`��<�;֙��{�
>ܔ']�k�`�sY��%tk�7�.�`՘�	_6X�t௨����~}w%�ǵqE�n�FkX��}��byh�N~&����{!k[�2L�u��� r�/H�Yϲ��6b�]���x���ɖ��(kbl�h���o��X�Q���ꦊ�8o������
E�)��`�F��Μ
�R[�7W�5��]�C��:���iô������Z�8���%W��]Mw.1F�YP��':op�1o�2W�[�_0��D��D��KЊ�~]@����a�[�z���:��xI���'�n�֊�����6k����p`!4-���Qv�t/��,��E�,����}���R
�g�&}�~����+��o�}�����$QЪ�)2猹���%��FX)���oq�
���?Q��o���Ģ�d�[\`Ž6�@�0=3v�OgO�Z3�fI�r(���!	ϼ�j��px�+����JR�aa�y�F��]fg�/Q�ej�2+�!���5	�\I�y��~����/�h��wMa��L�r*�_f��i$M"%�E�^!��߮Ug=m���{ҵ�C���
Zvǭ.��$�S#
0�y����%�E�q^��6��)ۛ�,ܮn9�$HY��^��~$o���`�%1USi�<��=b��eސa��n��0㺼�І"1gVg�W7e+C�m����#R��"SGT'�ULE��<��W�|/��(�^4{=�Z���W��� ��ZO}O�J����[=�n������}ȩ�3��[,�v*�G���>��g�xJY��e�c����xI][����*����n���c�m��K���Q"AѺz̬�;WFK� ؍��8\�g�/�uq���g�l0��T7��Ć5��Z�Ob1�ԥv�6� ����
���MaE�����ORl����He�Dw�)�
k�#4ع*�zZ�(
s��X{�c�w��t����i(�l���Kj|�W�u��"��"cf��~>n�uY���1�����f� ��b�߱=���h�5��<�nɛ-�T~}�.��t�U�B��"�<Զ�b
�!c=���؆0���	h���1��(H$d3��M��+�a���ǚ�,)5J=]q�WV�M��,��DN����}Ѧ|j�Q��U�w����Ƶ�ϙ�%:<-���}�>ٳ�{=Omz�AaOƠG����\�'M����"~G.P�Y%��Sxw���� �4��;�h�l<pd�mNX�Ռso�kh}>yQ�D�VϠH�s���-D�k\�]R��3�n�9���j�fJ��iQNA�6¯�cu�Qhre\9�D�GTw�U�]�(�"Y����H�F+>3� �S��|R#)1go�g�U_��Ӟ���Bjc����+O�[��o
�;Uzq@pl�X\fGv�zY*��(�d��g_�[�A�W"�� �,�*��NY�(�ӗ_s/'�u����0��>�Z���ਉ�H�O�u_<�B�����(��^Rg�-�jn�PX�h�ír�W�s�tI��ʰo�2���$ Xe����\a��Ԡ�:�k^a���
����LQE��3�>�=Qv��P�    �5���#�6�.k��`�^7.��S�)��z|P�T<�C$�r�y=:�+�h�cv-G�-S�讂�z=F�X��^>R!�T~28P��T��ѱ���S+���A�6ۘ��-���8n����t�v̸��xOJU�q%�X����I����|��
$:�������g�6R�,H�$w�YQR�5]L�x��7E����0Λ[�#��VE�'�*������5�%��
2���{�Nl$�G �}tXxԴ��\!*se��v��lU%ܯ.���G�*�*_@�]��	Uߍ:Q �;����G0���+���U6�
�����h3��{�*H���ͅE���4�$RJ����i��z����0�Wa \Va�_�ͭ���G]���s"UT�F[�Y�0��	��T<������ڋ���2����IԼ�l�2,�5)�T݀KDi����)q=�l�#U7������B�:j\�����\�T$̳�����gU�,7���^U��eM�7Uh�Ӛ�}RO��μ�%u*0�&�nv��y���y���5<)�0VO��'��Il
��44#JR��V��H�t�'1�g�+���F�,���e��r�J�*$Op_��}�0��!R��Ht��%^SQ�=L�pO��h����\?�Ez�
��JAK!���R���֖*��Z��*��x��d롎���V���-��Fa���wd@����%��y���r�D۹�A�R� ��Ε���};�����2'���#�W��q'+u^��x=�}��E��s=/^c��G�@W*$�rS-5�r�QG���G��NE�U��I0\e�2
+Z�Ǆ���h�6׳�r�T6V�"5q:Po{����	��3��-ð�O��1/���J���X�`x�f��*�ݥ�QM��_<	�!5��-ȖK^A�3}dX�'K�&���N�|�:Cj<�%9������m�{Zv���G��Y��è1��|�����X3�z\�2o 2�a�/�9���� ��Ь��ᶚQ&��[g�2�Ia=
M�c���'ݫ��?��<Sz:�L����ĥ幚Fs��Iz}k$S8���Ѓؚ����<���*�6B��j:��� �m5���5��A �Bž�`��j���bM��%I?JM=��eY�]B�YHb}���5$�9u�Ɋ7��i3��� j�_}�������~�`Y�|]T�<�iSI �\�(�(���jBR�߰��z�܇{b���SG8�E8�{�|fTQ��.�*�2�	'$����P���b��9���V��a���~K2�uY�~HG$)5�Aɛ��h�d���_��������6�&Oz���f��Gr�Kh�h/�_��|�-�#�~�c��e���������]0��z����[��z߽�ʖT`�����R�U�S �l�WUY�8������~xG�9纲lf3nFHT2SW8c����N�LBH�M0�[B!<:��󲺕=���UQ��0�W2�a�H*$E?Ӑ^�Ț��������Wk2�n�F��vx���{]�zo�V�s����fwJXcj4|�\Q�y�)Z}z��Y��Ӡ�_Cqm�q����=��6�sϽ)�R�]� *?Y���.���N�]��˺S7��X��[�E�zN�� I��I��e�p#�`��G��)\�Rl�]��ԽY��|2���Y|�Lj����)\�5�G���Z;~�t:Ï�kK�l4g�Gn�=}�Ȋ�Y;}I�k��e�렣B泷��:��m���k�o��D��>�W��oF�{4|Ukh��qzK:T���.��qd�q�+f���ۋ;
�
�v\����|tvVH8ۈ�0w87��FS��2Dl�\u��ßv{���Z���=5��u����;Qc�6�ٱ�3�i/$
걡򯑇�xqm�VŬ.v�&��P��?�O���ᩦ�>�B�or+*e� ��)������h���qX.���Ţ�K��Tsu������h,�d�B*�gl���XݶĴx:W�D����S��F����ęr�`.�\oh&�7�}�v��#m�F��f[n��O�� ,<2l#��8"�5����lk�͒��Kcg�b=ݴ���+_����C���u$ϒ��+�����]���Gpɀ��f3C�4��A~���t��f|�{5h��۸>�f�jag�^Y�0���À2�H�ےǎ�t��[��`�,���U�q
T���W!:��)��&�`��VP�p��&������*������S�ϧ	�M�8�����՛_OH�W�h�y\g7l%[Q��q4��þ�]{�x,�6=�qn�]� K]�(�Í��񦄉��w�Q?]w��h�HdL�ƛ-![fy'����po�]U��x��(��Wב"�4N.��5�Vmh̟C� ���Ln��gu4wQU��!x�_�PQs�\𺁆A%��崬��H�n�UW,"�����J8��Ħ���SB��T��>����j���[��j����@�>ِ8^g3s��@��9�Ņ��B�EO8���NM,!O���0a��RT�<}��oD���6��t���{�����T���z�B�C�����J~^ÏǵD�$Wp��ZRX�C_��64�!��!,��0*~�:\qjpb=���hh�x��YR�hh��3�Xͣ�2��}�q�+��-�2,b��E�&�1��W� wф���l<*qAv��ǲ%áz̈*_V��s#��v����q�^����Yg�rz�W6�/�E�U�kӶ6r7ckSZEH�v�m=���j_��mܽ��,
��o�&W�;Y�3����ĵ��R�ˊ���>6��L��J��l���њp�ߚ�P��0�aЍ+����;�j�[j �kQ�)1[�P��P$i�m(�z��b`�1��=-úD��l�<h.���"]�̑sP+��;�UT���UP��üG5�ܫ��vP"�Vӓ�FT�]-���&b�Cv���Y�7����r Z���o=*c;ke���|j[�ĝi�pZIR���#f���j��r!�q2V��{Hn�ftM��۬A�����[֪m�!V���f�W�B]'!��i3�~d�q�5"���1������(��[�T���j*��	^��jC���h��*�z1�*G��(��/���4��<���U���1�����$��`������3k8��D�+��$�y�cZ,Y�$�֏���~�G�(@�>]���U�C�nk���X6|�G2(,&�b�P�coqtt�UtԾV�Jf��E$<����n���m<Y:���p%��	,�xR� C�B��]J'f\�YF���[�?K=���3.+��ً���A���ً�m�Vxs͖
�V�r�Q0���c��İQ[�m<?�?����*�,�E1}�����M���la5���|V3Q ����C�$<b-fTH��L��U�����˲�D�{�=��E����4���E{��ʫܣG�+5�:x��G8�S����=�DP<�B��j�(�EP�G������}2&/�z���Wd%�Jn�[����E3���/&PͰ���\��Wt7L�"i��_5M�
K������"Ah**���0�}��P.�(�с"�R��9�/��Bu��ۺ��nѮM���W�,/󸅥�+�f6����7B�f��.˻�R�
�~n:t���ٖj{=�=$��y[)�!��[$�bj_=�	�X1�m1h�F�y��U1ԭz��W��888�p1w�s�4�X7��]ڂƥ���8�Qg[�����^��ZXv��܏0rǆ*��wT��7����zH� i;���o�V���]3 7`�����{�P2�V]����+W���׫�&w�K��)�t�Vik�Ea��"�hk�i��V�6�c�(�x�7�A��F��ߞ��WϨ���!5�������[4��-�=Z�^߬�a���M*za�.�5��|��S�!�����)�9s�
�y���WcS?��nU�eXc�-8��{y�D���/�NHvJ�'}٘zH-�ޑ�ID���J�vO��W�p������iԮ���[�    �=��i	mh���3�4�w9��a�u\��%x	W̜��J?d)�������.Lp0ͺ.�d��IO�S����"��{t��{�Laf��ޙ"S��uIyyW��a�	{A8 j�z=�Wk�K�^ χ��AN�۸"W���&^J����V�c{I�84�$�N����	;x�ч�VwE����M�bK�-t<��lpWUfT�U�s�c�+d�M,��̴�e�oW۔_�z�I��d�u���j��MR%�;�"�E}Vܗ�l�_O$ܕ���g7�&���^!1�G�&)v�*2� eV�qq��]O;�$�-�D�D�G��l�]Ц�#R |��R\�Pa����CCB���7�"af�/��+2����	6��𹗐����k��!ՙ:ko ��\��s[��d"�����O���;���VoZ�Cԫ��b]תo�:;\Q#{N����P��tq���������xj�#,�v3a7;y�"_]����ONS�K �A�l��v��Y ��hr�ґ��㠷�srUN�e�z�p
������x����˝�"\2h��T�7q�������t�qL]M�졗}��lt�OG˲�j�(&���-=8��8����7Y[rHq�s4���$��?��h�2W���Y�9q�3R���g�@�uNcO \�t��}���(M��}������C�޼.���hB8�P��d\�_&��(��&JyW)����B��O���!U���9o�l����c�e��@K�2�*�aG�g�gX�ea�R�&
�G��y�́,y�2�B�DuP}^c�П�X����+dd:�	I����
-_.���[ Z��H�o�i�=�e]��qƛ6�q��X��A��	Q��IXǆ4u�!y��,W�����[��F*�v�w��)�2�Ȭ��N���؞L(��~�I�v���?un?@P���F��gh�.�L�:��LS��1-�>�1�g5�4�"'�ϳ�9�i�?�<�$,��W�0�X� ���J�s���=_a����e]n�������ȝ�������I�i��
��������6�-�&n�c7�5��]P���vD�'܋�sZ��6���B�~�pgH��=�\�U�����U�6�$oD2�����s���V��NT���7=<� ����ku����>8{�a���E��W���4gYء�s�E����X����O�h$u:x_�0�~��l�ԭR!?*M�l�c"k��?j��5$��`�^��'k���C��fjﮋ�B��]�����aP� �W|ӹJ��J?Ԯ�}�k.k�s�&�a���gq��(.���w�%�f�lW��t�e:�je�k�زE#(��"?��� �^���(D���8z�zc�S��r��Q5����a���q�H���U��7��G��{s�8���3u�tr����d&�*��g���a��z�����2�l((s;$D�j��:%�WTP(�z��oJE��'
_EvWU5���43�n��E�T�<y��42�G�T�ɷ^�J�5����zkbZ�o0���Ώ�Ƣ٪^i���ksR���Y|����n���b \��I�5��$���K�@���+*ҝm�~�z�-�t����]�R���U�k����W��>m��2�yIَ�d��}����P]k�k��Hg��� �e���m��3Q#0��:KvN.�u��ƕ�t���n��%��X�,���S���)|���<A��4�-�$�\n�D&�	X ��rqx��D��UZ}��6[q����q�lAT�Ѧ�a��� ���`M�G�ŐN��}�-��g�F֦��4��9$ �[���{l<~P�I=0%
x��R{D���y�����j�۸�ɯ� �o[T�T�[x����ȁ�󏬷��G����	(�³,hw�� ψ���������9�!����6�'�
9N��g�k�C��!����Di�%�9� �n�9أ&�]�y�Xy9�u Z�`����T��L�9��&����n��H��P僭)yM�g�s����P�����ӓg���]3�s����:	
^���ȝ�!���謗:-�8|V��{8���[�8�I!�+�.��E�Ox>�e�_�Y�B�R���Q8���j��]1 j�k8�B����H%��D_3�o����/1��4)wK���̀!�{UUn�C�"��(�/����yf������l��+����羚c������_ͪ��K��w�������Rg���Y���Ͷ«������������;}�w�U�p�5��!{+~�[�[B���a9�e��7�^����!��^W;9"�3�-���\�ՄΧ��ʎ�8aڟ��G ����%	���r���o9�����ɞΔ����zD�[��k��{�����)��A~`�Rd�?���`�lӦ����K�*<�ڞ�]����5VY���UQ��p��k�'��
�ɋ��,6&k�d�PK�h[�#��?TK�S���4�K�?���VT�>�/љ���&�H��C�H|���h�ഊ�
#S��D�8�3:\����G��;��&W@y��a�-.ME�ǃV���%�DE1��9���geL컉_Y�{�ɄI[p��"��0��Gk�NdH6�N���"�)�m��4Y���bҰD ������d���hB��_ ��G V������BA�+�7�=+���"�H�?���6C�d����kXdj
��T�{�$�ؑS15ѕ�i�ߏ�%U���\���ܲ���-�q�#�i�7��	Bܯ�g��_��<^V�"+���_<kSb ���yR����̓�01(�c�7��,��>��M=9p;�pM���[�wD
E47�7�E
U����s¡�S���!��?����s���Tb�(�fE��� �T!��m�wə�܎^=�-�J�7�8z���85��Sr��RU�ŸQoQ�$�$/2���m�V!iE��
��(�#�zXN�~;�Lh���=�{T�"@�#�=�8��c-f�����ozz�gt�,i�������()3�	�������+f���ð�,pw��+�*���)�xY���O�h��-�Yh�C����'$����k��.����M�������l2I6��MgE<�#�t9&	C7��êx�H�)�B�bD�8�W�\N�W=�ƒ�a +�bb=�sj e��U�N��{��涝v�^��
sW&�(�'�[ �s�y�9p�+O�E�Z�{UVӁst��N�*)�z�el��)�g�����>�#��y[5V�����4mk�`Ȗ�Iλ;_[��)��x�y���):b��R�+��ϰ���Y�b/J&��.D�=���0僵M��] [�v�c�T��X�֠�����oJ����8�"�K,���� }v���HݓĊ�W~=���[d����ˎ}5����-��i�����M�P�>(W��Я�%��N �����6�N�_����JI�|"���1��p �0XӢ�SQ]j2#��.�j��^e1��1���D3�S�wG�l3S�ͮĘp<��/TX�@]x�a�7��Ղm@��?�c�j��0�c$�HF�9��bH��4V���B��5��f��N��0�"f߈>�w�R�ryO�����/�
*{�,�/^�C�}�PlQ�[���=�4.��^X�'w�[��^�?���W�O�&�A��B���wa�y��"۫��ԉ�e�I��t�\y�����${r(��Ϙ��h��*w�ybl�����3���og{VD��ɫ?�J
�=-���%� ���(ܜcM��R��U�^�"'�?���{�D/^�g�|0��M�R# T��ρa��Պ�cO��S�5Bfd*�J?�N] \^p�f$��H�e����#3�'��"{�RşR��)}�#3O
�k� W��*X��{E�b��NYRQT���s_�������J)�QgЍ��c�%ߋ�U�ut���Uu���5��    ~�!)3;�<Z[�<*"C�z��E���)�O�.{�.|�2��W���d�Z�?a4��e?��V��×A��ɗ p|FD���6<�~�6�<ү��X=������e�V)�vT��e�=΢*!�a�k�V�u��P�6���(G��(�V��?����v����`����Sc���4?�5�ao�YCaJm@,�����;�B0��u����H�zÙB�'VU�C?=/������\
p)P���*��a˴��^WP�����O	F����O������X�w' �v.lvJ�M��D^�`���8�����p�Y]7��h1�
��*?g"�����������5��(��ZM,@��ק�P�5
������t38G3,�f�|K�ģW�V�¤�4�(���a�� C-�_R��G��'j).|��~�>���t�ꟳ4���\��<!�ۂ�"���*,��:�M��QЈ-]�~��c@.�����t�-+u;���jg���(P�X�1�����[Qe��`Nv������ca&j~zpl�E�h�gO5��0K%G��?M����:��t��Yo+�S��Z��˱��n)'?9��"89u)
�-&�e��`�T�)��,k� �����T׽��|Pe�)KGfޓ��J���lRzp>^�)̏J� p��I׳ؒ}^��vP��5ϒ�X+!�`�̬g�󲹳ˬ������^��ǜ�:��i�༎��2�=)�1�E,�� ���̠�[M}^K��R~y�r \C��������Z��^���v�`v'"?�}Lp���W��`BW�}Y�p���[��H'�����1�'��Q��kk��g�#X����^T�p��c�<�H���p{�6�(��%vTK���R�2����n�B:\�|~���P�X�%aV֋�Ӛ:�`?.�^ò'�fa_}+��Ė �ŵEғ9�s|�عe�eYQ�X�,��������K�z�%5��-�W�s�B,��&���d�Y@�'v]lѬ;�����V�U����������f���l}YǗ�7D+��T�8��v��ڸA�������M	�ɟ�JK,��X+����O�IG��m7���$�R(�Xt�����Zю��c��?3kӯ��v�4d�~��;lb���C��!:��P��������%���.�}��Ҷ����+;�'U��G��j�S�o�Q����8�ξ\4�"u�	�ykM��է><��b �O����m_1��z�RE��ճ�`��˦P�Z��i=r�g,{]/nDS��5��_,"S�M
I�<ڥ_�'�}������׆��b[O���[x_�Wˣ�[͖vdK6{0pɮ����߿P�7�+����ʲd�R�W��@�[P�X놹?�"��[���P?������=Hj���F����Z
\�R0ޟ����/%��6���}L?����t��e_q�d��M�S���.ͻ�q(�G�)Е6���WrK����|Ls>"��Ǫ�[=%0���^�9PhBQEe�.�p]�Mv�'9�����,��N�ϰ�`�n�ꗆ�Br=8����˾@�3l�z&l��	�۲���Y��X'ݜ*���>a�jKk��x!v�'��½"�,Xv�G#�۾�4Y|{��Ǜg_˶Ze��@ٲ�,W4q��1k�p}q)�콬���#�R2{�ʰ���f�	�����U��f(���l��]���*k��z���Ⴚ�+��hUܨG��p!���pwyf_�@��[>�łi�7>TAǇ �-�yim��&��0#~���2��Z�{��Q���\��=�nٺ*o�L%CpJ�37ʜ�*�ՆU��+!�|�H�-�A�Y��nM����3�\B�����^#��G*QYݦ��!�)U��	Woz���l	-j�<��|Y�*��q�ǈ��6��� bv����ˊM��[���E��襮���`�@P{������I�^	±:�qr�Z��0mw��{��:Ve���A�=Dv�Y�1�Ҷz �1��� �`�����x�)w����f����c}��#߲B��mxV¾>U��X��*	��X��T[vg����=`F>�U��x_�O0�a3r��]5do=���z�U�*fɃ����}�d[�ҵH9�����h�G�p�"k22��{c�����'T#Q�=d|��fV`ݼ?�[��/s�
�>^���b�u�������q�Ɲ�&��u��.@
�Ŧ?�V�`�ԛ5MK2R��4oĺ)Wz����r:^���Ua}��lFqw�����u�E�85�ua��L���!�
�B�9�R���q�������&r�7}y=�I�k_S?!�%G��2�Dɫ�
��]c�*6}뜼?�Z���g�f�!��",��^�\/y�X�s;��e5��G�-�v�N�[�OLT.���hx(Խ�\\�{���F�ʠ:jJ���mv9~ϰHB��Q>pn��4�o0h/��7�v;�.jC����O��يN�>_���Ŗ�MZqQ�����e�*�(����<��{z��띐~�8Ϗ��٣[��&�仢&��E翙��E�D2>Z�_�Ȍ*��/�u���o�q��Ǟ/�x�O �� �\�X}?����R�X�E}=�g�A�D�M���=���~�3���~ �=~���ht��,�M�~��Kq�'P"k����!�Y�
�e��wY�HB�G���8�̇�\Ӣ�:���x��6�`����3�P�Ԕ��T���oS����Z+h����ǸE�|,���	� ���1�{�/K���&٧�s"cX��|@�Z��#���u�!�Y���z�{�5
	h���-��ՙ�`'�S���Ww�T{X�y�DW�diw��J�!����d�b^�WW�m��~D��,lXs3�;�;+�\��8�k��H��7��zK_e�(�x�zd ui��_�pN<Q��2W�on�Tvbe����>��#��zdJ�� �������C4m�zr�w�u���-5��=aš���F����2o�#yw�Z�.N�)*L�Y��q����)�����'�/QZ��ʧ���C;ޥ�����s��
�K�Ԕ�&��&�K��}�_��ouՓW>���:{��T��Z�ڎ���k�fRCiu]ĸȨ�����1�W��V����¾oL}]n0��k��vA�+j����0����8�A�@�?�ǟ��ln��^u>Z��Cs׷d��d!c�p��|;�����R׬溄��/��7�$��U`u�5Yg�[ؗ[d!�Y��<��>l�鎟P?H�:�bnɯGӓ�v��al���ɜ�G��;?E�������*>r
��h�'�>�ò���J�A�n��B���Vg�Œ��t�}[,�n�W�n��Ty�X��w�DӔ���2��mWv�����j&7S.�7���8�����jt"	�D��'�O�6��+�pe��r7����6~�_�>�����LWl�o�p�3XnQ�Ɇt~������|�N���oG%a+��E�oQP�oe�����z�Q����>�ě��ʒ�N��7PÊ-]�����,>R�ߌ�(pS��ږ�[�/j�nׯ�qb����c�ԫ_�fE��+=Q�#z�ӻ�ȲdOc�e���:nv��>�﩯Hv�z�?�7��
��w�̔���vA����ϲ������e_1	sK��|����b���#QfK��E�S�իl���I�UGc�t/�*���c��tq�� �=�ʑ������M2FL��$�a	�T�T��T�*�0M�]����-�~Pq�n���ڥ&k�i>ejk�<nf��×-Y��U�⋨MO�rf>Qխ[���܆����-a� ���Ӊ�)�dtHF)�7D�}9���2�Jw�a0��Rvt������vp���G`#�1���T�N�ێ��/�Ѷh�{X��hi8�,Z�����!�Ip#T�c�
J�p�DĪwg0�-�����J��yG��+b<���a�v�&��j��lY���D��sT4�G�:#K�;��,|� �?�    ��!\n��V����`-W�Vo
J>܎5v��'U��yu�-5�yW�ъ��0���]k��c�����q�z^��~����:���_ڣb�I�:�j'�U{P�b���l�qK� �^G��g�`I���M�B�R�Ѩ����]1I��c����-�`$#��IM'5h���Y/}&H!4`$���F�d��D� 0$�N��'��̚
�����n.c��
u��W�u��	�p���T�~�_aD�V�G�y��-��g<1�<mS!�9Q�>�F���N�v�k�}�:Eq+���5�%9qW��#KC���96f�Y�($�>�Ga1��h� ���
�0��6�����B�馺��Ļ��L�Zm�Mꝭ�O&ɀ�G�� 	�*؆$�9�ss/����$��=�qK� "&Z��m��1��ٗ�)��F���D�1�j���M��ߩ�u}qp{����)%�587!ΰCV�)@b[}MK��?���꛶���^"8��z��j\�P�9�n�
*�}<��j�B��D���8�b�r�l[�-�hu�pY>�i170/�R��]��[$h�ײ�լݺ{nl��"��zE���V}��	y�â�'�ݲX��!�
�ޱ�#D}
P.��Eb+m�����-�X�T�}jH�;�#�K|���f��W���9r\���C���s�b�ܘy���L�!a.؆�d�γ���� )j�h��F����L섨���s,*�y�J����js��,�珸>��r ���c6��c�pN�x�ƅp��8�K���q�)�e��e���X/�ٯSߩ���7�FC��2�;�S���~'89�xtm� �=Of~p�o[�9���܃�)����ܖP!Q�͡+,=���QC����e{�IF��=�R�֟Ϟ��{�n�N�m��Ն�q����m�)�¿� nȦ��:�u�R��)��p�%1������=�^�Ow�׊1�Htٗ)�¡��k�����1��G,�0�^�/ᰛk[0<�����1�z�"1���2���%�-�z��1ɔ�C�!��>	�WF�ХHX�}=/a��P�b��1��Y��jXS�8,���~���pa\��-:r'/b,=��f�B��G�Q�DK �j3�D�H�z3�qJ��@��w��!�����~:�� ��l�Ȳ�#���N����Kk���)��c���7��i�����9��*$���%z��Hh� ���-V�Z���S%J��U��8���O!�K�`�F��=��0a&l���zd`[EU�f�l#����+ڪ}��؜/v���#�V�1�;anI����|8�x58*)�.J�ƪ�q�-su��u)��X�g��$�-������R���Z�S���x	��2ލ�- �@�o�*b<�N�7x��[[w�mK^�O" �7 �ܗ)�4�~k������'�%��B}<��*K�}��:����|M��B�:z<�B,l�\��+|~ĖJ+O�7cZ�ECc"����^������l-w�>	��St}�Z��?MB�D�η��U�vʃ�`��=�!n��I>%k뼁�W��{���R��k�"���c'7�)Y��:�wn:,� d+E*��"B jC��W<�G{'�/4FD7P��|�`D�����#�d��Qkr�=�\G<��_���&��?�%4�A�ĬxD
��{�^�X4��[���`X�n���KeW��Wl�_��4y`��/O/�\C��g�[�Vi��of���yU�s���+=`�_l�p=�.˂�G��천xa#	�~�.+�ו|%�Q>+٢�h:��������,����*���Z*�ǁhSP)�8M&|��X�	F�n��.��R��"�����K�	�Z�pX�=�W�04"�$�;�q�a��Lb�J��u��DY�j
X_?Ǜ'�.� '��$#���������i
L�R�@p;��l����drj����%D��+�k��`�yURL�w��@(�O�s$0w,��~fl�Fb�B�×�d�7��(�S|����&VD|����>��+g�{E}��Ň*3/�DcS���G�Q����M�ϑ���S* -�d�:|�X�c0T2P�3<�Y~-r��l�T6��t���'D�Ȝn��t���*�G���K!7��l�Z�Z�/^���� ��L�ME�(��t9V��g|�B��'�A6CJW�(��B�{0Ž]�m֊������r�w�H]�q���1n ��(��_a� ��cK�ہ-<��7�?�)�_Z��ˑ��p:��ӄ�87P�����o,���9���k*�D���Oh�޴;�[D�4Q�)��l�cW��fl�{_N8S��'��W��M�F��%t�c�j��8b��v��[����:Xr�C�؎H�?��5�g��~�j��	pNE�S��Xb��ߑ
�o�T�G7�*���:~ [���5/�l{���!r�w=]�G4���٨��պ!cӉ.G84�۪�����d������ ��r:��>ҷ�Ͽ[,-D�T�1lDB���M#*"�"��d#�+��["=J|\�j���9�Q��j�\N8�(�ʾ�-�4'�#���r$��G�Uߖ�C牡��)R���rY�}Pw���H��qJ���Ga��B�Q��J�|��&�Rz;���{���y��]aX(�����+>ǿ���O���A���L)��_��%��`���l�q�Q�FC����S�l���4�y�O�*��T��K��q�[�����ډ��A0M��!q1m0�^�!��?Zo��q�����Gq�/i��X�3�0� ��R$�(���_\T+
i�1qAX��XP"R�(w��%A��GF�ݵT��S�qr$1�~V��Q(�Eٚ4��o�� W�}�޸4��,����4�Z�mr/��8�c�b��Ϟ6���y�}��GK��?�<NNU���b�b���_�i(�W�)�)�]p�T�����X�F�`�^]��ݶÃ�CB����~!��%M4�g�'b�����W� �����!����+��Q���y�4�3FGS:3�� �n2�|�ċ���kb��TJe��Qz\)A���٤@1��	����	���k����	��PD�a ]�4$�7��xH@K0eapd�6$�,q�\����4,��r�vM��iB/(��1�TI�hZ�gт�x<�Į�E�pLVҰ*u�a�R���0K��p�����uy7�:~���H���!M�i`;T
R��������{u�h�ဢvE����,�IrO�"�H�]�A�ֽ��#�"��>�1$n��敨���'�yb0�G��9	�}���c�権u\��d�!�Pw�.�i�T���r`�������>D�R���P����u(�"���BsqV�+�w�:H E���M��,���F�rpZ����3��3�0U��[�~�sx�&�}8�RH�<%A,��0'j��W�<�Y��g�O���GRnYs�S�e?>\5!A�U��%@�۝L����"�5�x�K�x�nԬ�ت}=ތ�� g̚(E�Z4Lއc��i�O0I���i��8~�<��
5G���hK��F4��3u�1V��(4껩" 
t쉫�@ǟ��>�����aJC�4v��A�D~౦NN�Gs2Y{Y5Jagxz�L �y�pHž��8%O�K�ak��'o�Q�4��Ŵ��6]�Eө���+e�bN�؃�ٌ{�G,���y8�d�_1�a�O�@����b���e�GPG����$����q�)���2��.�ͩ��e�b�e��;�=gQҩ�����D8�GDKO7;(@|�!q�*��	�q
�yTR:��b��T�Q�ap��S��Ź��g= ��r0Au���p�=m=UF����}F<�1�pX�� ���Ӌ㕋P���5�Xp����ф���R�9�(#~1�(6�.n�������vTuN� $v|���c%��V�p
�`�ŋՋ��Q�b��ZK�ix`�C���;�ԏ��ષD��Vdwb�"�^!���I08���J��� �  �\�-��x:�M_�D0��WI@J��ֹ�jMqT�լ�&��W;�_�ijw���	|��� A;Ƶn�}1_ߖ��CT�n#��	L�K�3�ǖ�+/��Oi!��&@�J�n�U	 �_�.�}&H_�PZ��L�9�O2�'�"�.�*d�J[C�d�dhU�&s��q�e8UY����au@�F"e�S�*�YIׁu���,�����o�^��{12�"��d0�cs�*�U�A�^W�ѐ���㎑���:aWEE��yM���{nǟ���`o'3iY �j6��|���x!��Z���D�墧�p|
 ���&$�����א�]��27��Κ[<$���x�0�^����g�
�7����j�K�(!@�R�Q׮ l�g����ب�W�1���6.�Q�j�2NJ�g ����`���?32�%��s�T_h�R����������r$l�      ~   h  x���KO�X��ͯ�\S���˻ &�@����/K�&!�0R���q7$����2�?W�9��l��3Ll���w�����ǧ������������{z��������S�_��Ya�l�&6�$��C��R��mZ���#6BĿέ�Z;2���#�0�������	�'̼f�~�x��hV�Ww���.�����%ή/�ݟ��P�{oM�>-�M�)�dc���"޽p�w�!���ީ�ۗdT7�=��7�H�D�� |"���ݞ_������Ǉ��R��	��P���)��,v��r��w�)����n!
��e֝������RV��bb��h�b��Ʉ2�q1��cuUJ�oDF�1��`�H:8�J�SJP����Ň,U0��6�A����|j�'�ư�]�0J�II�;�)��[�΢�#���O��h2��dr*ݔҔ�$pM�Ha��zj��~�$'�d���I���b���Os����Ms�q�$��$�E�49��R�Ðt?a�M/	�m�5)��b�UZ���ϧ��ŝZ����b8�R|���˛�����))7�Sh�F�:A~�)�e�Q�i����Ajxk�N-�sm1פɥ�Ka� k�:�
7a_�����b���%WO����i�͔ܽ	�J��lFa��L���|JiDk%`~�����ayu��������P	t\)�R!�(��Q(�@�l��>�J�[��R��_�#�}RѰ���	���K�s�]M���L��c}��u�N��"�9��Dk{݃�<{�9���drD� e��# B���-'y�;C�4Oฆa]:��6�|x���=�i��-�}������k?��_���g�����AK�~j�V�d�O4�>Z˭� �_
�b�sv�dͺ2'#
-�Cpۗtew8��������{Tw.�3<�!葢N��!�e@ms0@��nR}�}��66��K��hn+򣥁]Z�ޞ�#!�@v=����5/	���d=���b8�NSwخt��+����I�Y<��d��͊��`��/��n���"�i"ޅ�Q*�|SN�z�����,�[����	�L^`����!.f���Vb���N�K0�J�B:khmt�P~�9)t�Aj�u	�vܧ���i������0x�x��y�����g����SoXT��l6�nI���v�@?Ĥ�ޒ�"-���)K�$$�r4X��&�X 7�������j�y�$�8N�-({,�kX s��$���a5�|ɾ�.X4��d*%�w�ɛP�eX�Q>b���E*֓��������6r9�𪁰y�R�25;O����JyN{<���;������=��c��r���L���Z�Q��Ez�����ۚ�}롕3;,���f�y899�h#�N      �     x��нj1�9�}],K���Rҭ���Y�_�!M!���.C��l��~��Vxu�͵=�S���/��us9����t��u�lL`�XH�jCp��R�c�]���wN��	��ԁe���|�y���m�����uzw�=�AM�"6��\k��&�ڴ�17
���+hVſ*���lY��*�[5:��Z��I���6"dQ%k%J
������٢�?��(E�G��=pV��
��>3J���͊ǌT{Rta1�C�u�/7��      �   �
  x����rG���S�������;�Z6 ���7�� #`�����iF�FMx��#}��y���g����i���m���������w��o?},��Y�[���pa%9jr�*yg7����?��]�(M�����F�Fxr�{��_ߞ��������ͫ���>�vF:�o�����g��@�����5�����hE9w�RU�JU���T�)��2V�J��#�s�'M����������A�g��=����w�/�>�����߫�I[AY�Q�QP!��u�ɧzLiR���k8,RҠܽJ�zwuu���>�:{���7o^�o��ĉ�d�D�����*����I���hs�I�c���IdsT_�����5��HѺ����zT9KR���؝>F�Gh���L���e4�cびH5Y�Jn��M���<�C�4�������I�,��16�m�=���i�yy���ˋ��9�����e�)�Q)��hM��ԙ҆P�0q��?3c�-�9���2q{��݋7������&�����JE���T��(��B.��ObBlď�Z���_<�h�y��bN�b�XUL�05,�}V���tQ��b7���NS� ��ǀ�EJ?�X���5P]��b*�FI4����)e���z���?��Ǎ���؏q���H�q,-+��E2J�W	�ޫqR���Da��k��n6���*�u��VǴbJ�*�ޕ�֓�6�@G�� �oL�O^�c*�R=��Y�Q���+�\ �-��|Q��u=��1=�Q[$qو�/2�}�VI���� �"�3�.me|�Q�k&
�Dv,m6�'G&�m��������.n.n�\v��V+����@*P|�%I�Ǝw�mmZcy�3[,�֢��X�!=1k��#Xf_.b�����!k8%���R�Dxl�(p�TL,��f�J�S�=�;'�1��vb!e��͜�r`�R>����û���_]�R��o�:9L�X�2��2bZ�A"w LG�d6�:��� �;����U�_�����4��u^����1T��z 9,�CHL������8�۝��q�71C��G�����k��ט��jgX�0�9	�ncG��Kp~���#'�.c/9N�0ӣ|�zV=á(��� ����u��x�;��s��.[�`���8�Z�;f\cA4M�r2Gp��r�nX&�wn�0��5X�'۱B]E�$뮢�h�@M��9R=�@`ٻ�Ca`	o�OX���u�����/��6c�-V�E_�D��Yd-褹�'���u����I0�����ᢹ\Xcj��+�U���CA�{�8S\:^������#�>���lci��� ��yW�C@���U�g����p�͠��q�Ū�oЇ��w�\:zH�ǼR��Y<���e�=����K;{���~����v����>K���/n����T>�~n_�Jk��(�o��mx�*};� n�r�f����Z@ ��N����R��U.bԒ5��?��k�"����2[Gpl��<���`�?gg��F�5~�2p Se����6֞-a��gu�^!w n7(C<q���!�Hxх��u�j�ʐ�`Pc�9�~���8t���07��:Is��nøE�w��{�A��z��%��y���U���"�aGu�۲
�SG��G��C�ۍ�Γ��U�#���g�\8�ޓ������XX+Cr�>���Ɯ�Xa5�M:j���j����F'(+�֢1�?4� ��c�V_�;�*�H:�&9�J����j٤N����C�5�K��J�"��=���|xJ��4��e�mVE�\�zp
����L��r�&����G����`��܇���\fW��\H���>= � �&�?L�h����1�y�e���I����I�;C��ۓW1��E$o���#2���"9sј[��6��3�Ȃ�k�OqI*.���CRW�`�!*N�KC�9�%��:y�4:����B�`GV]|xm�E[��袒�F��Ř�/������n��e	Kf,��?��:�����1�+b B+���)�h��
��-�fi�\����'�B�L��"��5�$�	�S���s�E`W��-�Er3�����TMQ��S����ڑ�d�Fq�Ai:���CT'�&,�*8�E{�.//׀��)��UC4A�����Ɉ�7�<�`Cg�b��\4�)Z�G�D{_��2�0:Ryd`r����`��W�g8�@#��(�衍�M"픾��qϬW�*�=��#����I�_P�m�9{����φa�� \-�P����@��
�rP�T�j)8�6>t�kpў:Iٚ!3��C[/ޕLv-���>t6��2h|$��0�!��[Rѹ�*�	(7�ל�']���+��� ���H5�c��6���SE��aכ����q\��q��P.XYJ�<+���G�ꚯ�h}T�Z?6PV�Z��LNj#�߃�{0<�m�As���Y�3��s8뜗�US���aaCjVU4{䞸�?���k��ơ_N{������g�R�ZA��G�Ҽ��{����fGƜ���*��i2v�^;����dF�}���|i��W�<u��2GL� �d�Z.dcw��1)}O�a���S�[��&�UQ<�%biKu�ڌ�+�g*�t��U����v��������|��{.���z\���b�	#rQ��t��76ԓ`2�����l���ٳg���      �      x���M�.9s�ǯW��(���	�`��g^��3�|��7�
��{� ��dF2�~��oO�ϓ~�m�����'���<��_�����ǿ������������)�����������G.iԺ���e�2`c~+����c=��*`U3|��k����3X����;� l'yӜ�M}{s��u�b���`�h�9@1��h	4}�?�w4H��kj��`A*�����	�
����RX��g4����f�LH�E3V*$�(�����BZx6c�.��E����BSf}��r~Yo�.p!��g����{l�;\��E3f
r}�wכ�B���p!��X���'�xZ�By^��߭���@3fZ�Bɇ�V<S�B)���w�������J{ь����߽�;O\(�����.�y�s���{\(��e���.����gU�P�Y~�n.�����w�p��w��w���f�.���c���fp�:8z83�u�����z������B{�����6����d���B�!��5��
h�'op���[~_��~����b���#���/\H����L�Z�@�B<�	Z�Џ�m��4�������h	����@�-=���w��1�VA+���w4��O�M�k4�w��B�$g7��B�U�&\��d+�hp!�'3�ۀ�D��c�m����_π.�X�i������;\ȓ5u��B~���;��E��y�f���}�����߱}��.����w�	����L4�P�k�\(���'�pa��XS.��e�w�p���r~�'\�ao�D����\�����ׄ5�myh.�s35��B�q��G.��B7��B]�w3���>g����hp��>d}�\h�
w)>���6�n\h�������Q�w��+����}wp��O���A��߅����v�J8pb��X�]fz`�x�J���{��81��8H1�mz}w&�{��pS?�{��`Ō-��p�b�ݵ��V̘�p�`Ō���da�z��. ���ޕu�`�b�;:g��bRw�`��/�3YX�����/+��J�
��9'���p8YpJ�;\N+��W��|;���MՅ����p�y '���wY��Fη3H�p靬W`Ej/���8����p�"��4�dV�	�cwV(�r����X*�� V(��8���`E�#39K+�L.wV(��b=�oWaE,�#�RaE	C��;���ߙ�+Jf),8XQbe��w8XQ�;��ٺTa��u���|�1c�dVD+�����.�`E�5��l���c��P�h�s�`E䋎�9p��i��Z8X��;:geaE��/�V4�B����`��mge-8X�:�΁C��07R>3�+�k����[}\8X�c�����`E$܂��a(���w8X��;Y#�E�N}��u�`��������|��p��i�w���B�N�p;�u�`��b��ƶ���"��+"�l8X��C4X���"*�+"��+"ۙ+"׮�|�C�N���Ȣ�E�N�V���{'����HC1<
bv�t`Č�X��\�ˊ���;#rG��Oz'k�1�v�d噬�>Q�s$+[2ᐴsd+��i�H�7#�C���excT����L�W��fDP��9�c����p�"2���gQ�s���᠐�sdd�pьS�v��G.����#��� VD�"�*���B.,8XY��\8XGٳߝ{F�Α�8�΁�qB9��;+2�v��l�C�+�����+"h�cc7�ж���V-8XQc`Ӆ�q����+�He��3���VD:p���+"�9�u�`ED;����ٌ��#<9����� �d8��g�����-�|���lF����o����ر#�b�����gt�sG���9��o������������R-V����jg���p���Ѷs��.u�a
�v�UÅ����Y���m4wt�b����@��g�Z�����Ѷ�Az\8Xq���w8X��X+R�����8��<�;Y#�F��1�3YVD*5~Xp�"r��*жs�>#=k����}�zX����<�5<
�v��癬+"�y���,�v���g,�v^띬��жK�߅���m�D�,�Â+����W�+"�j�5���6��d���w�� .V!����h�%j4�d��]"xV� �v����]8X��c(�H�;+��]R�];���`E~�΂�Q�vFg�wh�%*��5�m��?��LVD���9����<p�sG�.y�fl�QжKt�
�ȸL�ѶK��
�Ȃ����Ig���`E������폌�]�[O��|���Ѯ'�KZp���GI�p4n0d��-vη3��v�>6g���жK4�9�5<
�v��3g��@�.�.&]��+Z{�����yF?�d��v�Յ�]��!-8X��;Yc�@�.=��+z|�i¡m�>���m����v��]��+�	��a(h�%��������hDzV�Y
X��éQ6�ѶK� ����`ѕԨs�h�%�vE[R��m��5�D�����m�h��?-8X���Q3[жK4)��̂�3�]8X-"�-�+�Wu���`�*��(L/h�e��VD��cザ]� ��vY�]����m�'��p���m�F��cw��pZ�8�Ձm�F�}J-��V6�ZZp�5���[���]��u�жk4��s������9ς�e��̂�ѷ��K��]#x:��~&+h�5��h�j���<�d��wh�5b�8�Zp�"��8����ʂ�]�{���]#x�Ӆ�<����m��?ʁ���v�ݡm�h�fl�j���-�Ձm���E�\VD��6\8X�p&k�<h�5V!r3�v�k݅��L"7c���ȐE^�Y
��zV!����b~��ǂ�+΢�3��p��,�<C�+"�u0��Q
�v�ԙ���жko/�1Y���������]#)F�m��AENЂ��N��A2��-���8X)���v��m�x\'�ׂ��Ҋ�QlXжk<w2.�g8��)�ȧ:�ۦ������O���_�^��P2��S�B:���*`�}o,����G��d�o���G�-���m�X����ko��5�j�I�������g�͠�&*,J���#�Q�Y�����k]�߆����a���w0�����w(�jB�a�{Ps�}��/�m0L��eؾ�9l�=�30�G{��n��P�W ��i<� ����Ƙ�Ȱ�����h?�a�{�ԧ�Xˉ����sfg�X��u�XX�.!�QZF6��������C���ڇ��&Ư@%,֘�����=FfLra��)4�����!)��W{�6�� t�ҝ�a����3��)*��-'P�wɿ�ך��V�iz��J�jÛ-(��Xue.���)+��Vv�@}`��A}��s	�>�1�:��쬛�����k�;��ng�i���8`�y� �$����Z�
Lв���例U��~��%�]��ۇW�K	�W3����M��	Zk����x����$��m��]�����|���}2�_ڭ�.0�aW7c�Px��6�f������rY�?c�{L��Z�����Vc������$���>̵�gi�J!F?,����x�(L�;�ߧ��9���u_X�*�a����^�ȱ���+��?��-
���2,l?|��+�Jl��V���O���vl��)θ�|�T7�(
��ʽ�s�N��U���&�{a��k������1�X����il�3�1�����H��R������'k,�t��Z+����P�W���Tא�_P#l+5��O�V�˙�{5<��q:�*��[�n	�"�/Flذ�V��'cV��#ӛ$V���n�3w�a�:�*C��ͻa�i�����pXڒm6�_��am���ad�������B�UW�b8�D�UG٬e�(�����a�y���1W�hħ��{E�U���5    Ml��c�N���$�Z&����%U�4�ȫ.2
+C�U�}�2�I���8i�1T^5T���G�U;�����xsh��#9"�:��yV�\�x��]����I�"
��^B����W@[~�7�ĩ�;`����v�؍0�W�:DogT�}��t�+�n4�Sz/�A�U�H��ʱ!��D����b�wT�<!�8ۥef������E�x�\�9��`���Y�r͒�y�a���īA)�7���!񪓁�b����>� �8�]��Cj����u�6xdxk�]]�v����2�����j(��*/��0�=X�n��)�4�]]D�����iW�е�y9`X�Z�D4��[4�]����6�]���߲�	X�Qy� �V��M�!�Jl��� yC��M�M%g������t����K�{~Ͱ0T]�pV�����nǓN<�v��o*7��aW�}��X���aWWL�L��0���k���=|�w0�_��􊀵�h�%2���h����:�eT�7�]]x�g��sDCݍ�W��cQwu�l,�f�wu�����xu���p&
Ԯ>z�K�«�U�����x�y��f��[�����7ZpI�3�ن������v��|~��ؽ�Y����;m)��E�Ս�p?��Y�����>���h��G�W-_�ʫ��ɸ�����n�����G<x���7�b%��;k��G��r@��Qzu_#�E6bF��2��Zb�ꆥ�$�ؖP{Cj�ӻ�0Y�^ݱ���P	�W7,z�9{%Z��W蚆a(��_!�ˁ����7h�L�_9�~����M�T�p�Wҹ��H��*pBO�!����XL�s��;X�]Of�'ro�n�%�w�
� od�u<�2,�We�;:�F��ثJ�3.l�~��Z�7Z�oe1�W�z�1�֫�0~�Ih���m�.�ҫZ�H�:�ҫTJ�S2��5��zހ���ګR�c���0�M�!uπ�����Ȱ��*E�WUeCa���K�Um�c�oh��iҸ�G�UM��J�Im���vHG^o�X~���M!Z�JW�Z�8��W�&:�Ϳ�a��{�ó�X���ͲX������ס�,�W�ŵt^��Sa�qc���J$���XI�^��E�(�_W�c��Jb�{�����ܡ�J�N]�Y�S�^��z��1َ�[C���}���R~uı�2X�X��K���J^�&f�>悔�0um-1lG�mq�R�!�aG��x��&7�W<�C���+]N#m+:��t�x��;z�T9m�ӨW�(�R�9^���J��t�Nh����Ϫ5M8�od��ݎ�+)-#}����7����+%M{�a�H�-Jֻ�gv$_	_W�3�WʗSo�~� Qd�3����+�*�2bJF���ۢ��ܜ}�/��ʦ��+-���^G�����Ѓ:�op\ωY�
�S�v$_	0څ��NG�f"�h�&��dY[ �o��d��fH�R&�Ø�|���1��~5&��|/�?j
��� �JX.Ư�|<�w0�_�+rtF��dvĞ����I��<�W)㰉dxE_%�O�bTBvD_e�ÿfg�ؿ4�.��YL�_I�00�@��|�G�#��Dh�J�ʑ�D�U>UP��{�����WP}+���*������*z�3I?��Fz� �𣞾{��W9K�a�(��X��v/'-��D���Y�a8�"z���;�zӑ{��+1C�.�{[,k���0�u��d����K!,n�W8Y��Q|����q��J��E%�^%��_�υګ�٪�E�U~+�-�;Xl��ګ��,N��*'�e4�Jow��1:}t�^�4.�R�y�B����m(����c���0��l�W9�3G�!�*瓢A��H�^e}���X#����b#o�ث4�܎��H�J�J:_��e}1ggC�U^E�h%�Qz�W�6�$�_�oǋ�:�r*�'j}/t^%B"�f@a���<~#�*u����ݗ��%Cd屮�6���G�U���ᨑy�!Ph�|0�^U�o0�0{��P�6'�(��d���W����=l_�Rٿ�0h�Jh)(l��@a��N�2ց��C��z;�܁��C}��hu7wu�Q�8����"��i�l�]⮎�)z�:�U�]�7�/�w8�_�g�}W'^��l�vyW'ޤzpkdP��m$#70�wuޕ�0�"�n�{�b�c�ؿ��K���G����6>Pwum����~:܄�k�3�]�	uKɱ���յ'Y���U�ӱ�]�����1���]��nY����:�gy2����_gG1H���C�Y��xu8�^Ď�"��x�4�v�爹ζ�(���Y����Z�B�U�k�P
���-���:��ҫ >X`��e�������ҫ�{U���*�V}�t<Z��b2\+B���m��"��0�B"�*�����ԫ`-�ck��`=����� �}��3�7st0���^�Xb�# �*�����@�U�q�iX,��"�J��S4_�����	�W����!wz@�����F�q��j{�u���8��ng4��D�b8� T_m��b�����b�Ӎ�W�6�,�����9���W�(|r6D�]�u��1���'�2 �o�Z�7Q�p���+*�-�`'��Z��RƮ�,��_Κ*LP�%�3U��g�Z2jY2���51Q����� Ɖm���a����D�j�P�`}>Mъ�P����7Z�ل��1X#T��x\�`��<;C��<#�G�R�[��P�G��z�7M0�n`t���B�c�)��_���Mx��+�^��M!
+_�c�an��'Wk�4�����!1��h�SB�l[C�����c�u%_�6�+�q8���}���l`N*�X/��57��gz�e�j"O=s��+�� z���՟Z�Y�;шgj��Ld�z��I��P<���b�	�xF?��N�⩪�MN�M����jd�4!�r���#C+�y�X@+��TYL�O��Ԅ�(�
m"O��mѢ�{�v"O���xX� ����Ev����Z�p��7�^<��k�F�{"Ϻ#��D��x*y����P��������)Q|�U��d�jo`�
�x�v��8�y2��{8?ь�~����L4�9��m��Q��Xǳ�f�~-�ni~6�O���fho�x��H�Ϻ~��	c/�&�љ`"OUuD��A�Q���&��縖��������a��������:+
�����72�v���W�	�Ÿ��g0��b���#O��ӭ����u/���f�Oc�:cAэ�aNj�-(���5SgK@<��T*gd�/���W�px�x��rF�p��WzK޲5���Do�j.(���F�Uc����Ǫ�D=�X��D+p��ű6����ح��W\�R�l�H�+�,��+|�	;�ZUg�0A=i��p���2SEH����M�2_���#�w�������fM.���dM&�F�a�56���l�������k��u�hǕ�	U���R���5�1���W���&��c ��K�w)����v����*��;�)y]KK�1x��(��װ'Z��Ò
����-Y-�4G��%�x�6D�iD���K��� '�x�zv���tX�,0H��/F9[<z��	R#��$8ǿe�؜��Kv�0:)N����GeT�M��%M�̨a��ɑ�0c���K�k�;9�DJ^+2<�ܦ����nZZ�R��h��|58��Y���p`�32��x����;��A�p��Ւ���c�9�*��W�٢c�ZWI޿:=����$�_�w���ד/ع5k�� ֎�]�Ց7X�uǺ:��ɋg���QA��	t:��Ƞ���X��m=P@�T���P	�}{�8>�a������/�\_�Y˄�g]��#3�����="\�o���٣hR���W�� 3�,a�jOT;v����@׎S7�qW��$n�����@���j��p@:�K9����^�9���p@��f�K��(�2؁c�S    hO,fX�g0(�R�YV��@��ɲ���P�m�]��%À���o���`�z��xPXP�{;@���EDT�\*�?�vZ����7���ޫ`�=2MRV�������ʂ퇳�uog)��q����*���\����*��{P�����&[!�P���y���c�41�y|�70�W�~�cW�b��N#]�*PU�-?�U!���Q=TH�j�xQϱ�	��κPm,h�K���0��`p@/@�K���e�C�Au�sk�`��"�n$����!A�+'՘��Y,�:q����8k� ��:��]�8Ŷ��t��j�LM߻9�K9m���q�n����q\�8E��s�s�+o�v��aW"�`��<�wX�F�GoA!�^�֢g	 ��J��	tB�e�k@�dG�2��b,�	�O@��=��]�QN��0@%-yq��۾����3��8�Z�jZ-�ن��
�h���Q`Bݛ�Ê�-�p`ǹc��p`ǹ�gu��	T !_�,�ʻD�ך�@ʼ�D�fMH��
x��aN������FA�Z��+�,��X��`O�Wւ{KVg��ͪz���,H�bJ5	n��^�`��yF���C��3�s��<��q8jzb�3�(���קg�������о���8��n�+W�SK��W�Μ����7����B�x۟I�1hR�A����E���E*�W\�r��Ӎʁ�֏��:�1��Ǳ��晥�����#��޷�.r��(��x�,�n���w�iT�D!ǅk�a������ڡ��㢩nb��E<�I���-�ꙥ�{��8Ǔ>ݤ?�qރ$����z�Y���!��d�F�'�M.Z;�QD'-^���把��\�٫
����n\�pС\�iz:����y>�w8��.i�;_M9�U[����u���Mkt���upg/"�Џ���/j>H���s-16ϟ 0�Z��ZYhQ�<�]�9���,�!3��\w]љsT������D�gܹx�%��{xp"Z_4s�Fo��A:ⶆ���������x�R<�":箾���,�s�)�<�Cu��JOu}'�s���s��Y��4�i$���뢵�Yg�E}Vw���U^L�����J�{�@��J�E�7�H�YR��Fbm������YVl��YG1t�<zL4�bl4H���8�(�y>��,ƢE�Yߕ�&+����ޢ������x++��7�A����"r7�F���[���(��J�˫�Ц�^=9�k9)�i)�2�f`j���Z��D�#A�2��B�.*�Q��g,���١@���:p9F�����<�W��<�	���Q��.-Jzbp�x=#J0/��pF�|�`^�������ڟh��2� ��F�d]t�L_�C�9�y��ǝ�Z�\�_�B]/�<�wߣ����p�^�l]�s�0ǆn]J���s~B�.�G���N\��^�rL�8;,�uѩ�,�H��K���.�s�eE��F�~C�ͳQ/�<3���Ǹ�u�m^_�<���o����w.*w��Nmֺ�J�Mj�ƷK(�E�'��h�`��%t���x)�I)$����ֲ8џ34V��=g�P�K���e���z��	j�w	A[��]N��A����3��@��u��,�C�.�dó����a�����$�}��Q�}��.�c�fl��{1L4��/6��E�.��5���%�j�x�F�HN�3�k�)�t�����D�<��&��"����S5�P�˹��qLI(���X[�h�%^�����-q��|��<��vQ/��i8���]Te�;/^샸]�nUsWu�>���z����ᦒ��0�*p�]\�����v��������)W���4�\��.޼�����q߻���k�L�p��]�e03�F�i�n�1fd˳�[hP#�h�Vt[����[�K��3�sܔ��Lh�5��E�J�P F���ʨ�z�hO՟/�(�Jw�6xL�q�ܵ���4n��z^�#�Qt�E��@�Vg��_a)F�&!t�8�M�]����n����C4x��,;��4�p�d���V��V��F�����U�"מ�4�)T�2���[����b2�k���e*�U�)���h�"R�d�@�}bzƣ)!t�S ���5���憅��]����3Db�U8��CԺh^8^��*��d/I��]gXI�?Ę141����ˋE�qİ��85[a�uѺ�9*��lE����lw}����qTՐ�+��f�y��TB��%7/���0b���`���Z]�F��*x�ҝ�gz(�m�j,F��$�'���<�y�x�'��<�[��w5��{�g0]�Xн۳����j�P�[V���4:��]ˋ�_/j}<���U��xP#5�S�w�tv5�������������i���+��_�b/�75�>�g�WL^H��p�c����� h�AFFo����错dT�xXᷓ�ʨ�q	^/f��9����Ow�/����c��9껯Yp��ֳN8���r?�I��*���GpM��ˈ���T����H�k����3*x�<]ǜQ�[,��,sQ���,׳X��=Ұ�7�2V���� G{7J��-#����#���Ҍ���tH�q��*㸛�����~��!��X�������{��9U�9�E^$�f���/��)eP��kq_��Eޡ��Eo=Av�Ûj��0��P�ۈ�om���h�w��9�����c-��m\�s����c3w�Z3rx���俬�5��?Q����#�vVÚ.옕��L2jx��յƇޢ0�X��;"�7�@=��X��.zx[�墺;�x;���Z3�x[�����c��U�z��#�%v����Cok�O��w�ѕ݌���!���Odo����߽�ً��)��U��Ż��!�9��x���p��3�x��V�"�����.w��{�oT��H���M���x���m��8%����Pj�|?k�E���R�����y�[����0��lC<�Ś-�+o��fʨ㽔�ͯ�>�K}%^v��+zy�#*y�S'e�8?��U�w�X��{M�����x�l��b@��h������(2�u-��=��),0�r�ȭ�	��7�k��t��)Ҳ�D(�=�݌Z��{d�Nv��x�C�U�ԝ�A��Gr.
��5��Ǔ.�o1��^P�#�N�fF �{����Z1�xWRs{�������|E��t"���}o�=ڛX+�>ޣNh'ε��>އZL�oW�V�^�[J�	l��}�N���Q��V-�g�h�}DaFw�)��b�Dsϐ!Ƙ/���q���\q�W���?/3��[UOn��2=����r��5Y��]itM0'1�/�=S�F���Gp�ktc/�Y
�fU\(qε�ڂ*�U�.��~
�x߾O�-��]��{<X8k���,޷��+��ô���i[L�����O�blM|l�V����,(�z�X���ho�>��^V��U݅]��7�pF�>���V�8W�
b�����:1|(w�G�(��#S)��V��G��&wl�A
R�P.����xH�c��hggf�����J�س�R4�ޮ���=H]�ꖿC�O@�
*���[�i�
>JzS ������u�<(�(嚝�ޑ��ƭ᦬�����;F �_�0���_�}۹JRпG}��-�ᐿ��K̕E��E-8X��Ÿ�i�P�u��o)􈘮1ZC��[�/g.�hw`�������:���P,l�sň�qJ\�e��^Řq��ɣ$oժ��y�E�V�.���"x��3Ykeѻ���h��Y1��:��YhpB7J��s�	�wtaN�g{k/t|��xs�A�Qr�����wG�'��X���=��D%ur2x�[�؀ˎZP���cY|BfDS�(��l�{D(=��x�{�U᳒?�X�v�P�;�Aie����[��k-��v�||��!vG��]\�XP�UQ��js���n���b3��U    �[���=N����r@	�9J�w
4���F�����N7���u~��#�*�Q�R�;
.����QExӹ�]����"ܼs���sϒ�o��A����x0C%/�?�.Ԉ��0�g2
:�
~����k�����(/�>��A�nXektݳ���Vן�Э�J�}���L-�S}��Zȹ�Uйu�8>��ː���5];A�|7w��"��a�xt�Ҟ��Pt��ޥ�� �>��T�	�+"��m���"r�{�8`xp�b��9:�[�g�,�S�Q���9E�������=�S�Q��Q�{���i��<TE�;����&���e�R@�xb@Oe���qϡ�v�gE�;���+N�Eឪv]�S����d�������A�rE�� �IVn=W���h<`�A�FBxs��nb�	CU��S��ת��S-:��f+����b�1Y��QCRb�6��������G���y{.��͞-�����|E���۰��#�/wC�^�W��w��"��n/�c��鐷唎[�G�^)
����P���1T�+���K�����ZN��:A,���gӉFI�zɡ�x�b�M�� �WܹRU_v��U��U� ��"o��un;W��u-{Wt�2T�텑�[������و��<�7ݕE�V@�w<A�^Qϛw'C�^��%��sP(�k��bE+E^��r��]sJ�*��қj���c����'@q.tW��7բhιIWѷ�
HV���@�R���<������9 }{�%�k� Aբ˟X�]{��z:��(�k����N�������0�qJ*��R]52'��ڳ��N��"k��Ec�d�Ft��<E[��מv�Y3�{��H,4�#+.�ѳW�C�x[6z����f��-��9�@�^J�ɳ{�@�^#��;]I*����EN�������q3M��9O�1]�"(k|0c��-С�@�;�8/�Y�	I{(	�NUKE�^������
�����4��"g�(��=��г�
�i�O-�ZOsx�B=�w(���@���0��AW���D+�C�^j��o �V�j�.[ي�����R��\E�>�B��[N����t�~�.�Q�����:�{�w��V��������Xz�s�j��k��������8��ꕳ7�|MŲ�^|�j~�v��$�m�i�J����c���4"b��c�i1�4�!�'3~o��3<vW��Z(���,Bd,�bD{`D^g�2��9c�>\�
d�t��(�Ur�#��!t�L�Ya@K0"^P|\������ �^�e_ݥ��~OllM^�U8�6ֺZ�Bx~8����e��2�-�?�jk�[������E�JT�>�E���E{�ȢK��/���b�]O�0�^��Zx��zB1h�jD�2%�j4u�I��S`��gy�1�u���+cǊQ�S�2�V F�e�4Њ?���$�ם3w+0�����`FT�u�`�
�G&[�r�
��s�g����
�
T��*�PU�.G:��VaŘgp�{��Bͪ�c�i[��9ҧ��J�(p��ր�s��7���+�U�;��ܭ��V�D���0hPbR�e�>+�X��,��g�+���C�'����k�A	-
�2�#VǙXS��'.���m[x�I]��u����K첎Ү��� ��6��oo��3��p�{/��q%|oq���pgY��a=>Ԯ½�V�9��շ�?�{l�;ە�7��-\8���G1���'y�D�IN%�/Y�b�i�`�q:�'�Q^W�Tʀj?�	'ˁ�����ki�#�A['c���#;>��xPB����+nkF�~\���(�G����Y��xF�u�N*�w�	#"5ۧK�	'J����d'�(�,��'NHQ�q쏣n�	+�8P��LX��^O�b����#�f�vB�}���c�}Nx����������܋ә�-��v�g��P�i�7��Ԟ�)���O�����.����@��};�����F�����O�=���Z�0�����s�w3��x��,F3����������IO�L(9���p���C^j��l5���;ŕ�3>n�Y��A��$�QG�N#���[VX1"NI�g���0�i2�Q���9�'>J�o�Tץ8�E��=Ov㞎­Vp�N�hG�NQ6ۚ�[tn�1�A!q'�二u��ȝ�j�7���[��zӅ�Gm�s���i�!�u��5���{*���p�=����|�[���8G����C�=�	Ǝ­��g�u⊎"|��e(���"L�׃kAkx�9���8�C�Α��>n��G�����A��4v����哑���b1�����A���\n\���wn�X�V�ݡo�gawλ8�;�85�Yo�A���U5i�ĝ��y����"rK��/g��;z�E(���#s�h6+�yˁ����LcF��n�,�	7r��]�taG/:m<ؑ��-<ر-E�"��TG��{+�NrG�>WU�9א:J�n��g�RDI�<R�)��ӱ�������96�Э���%"�'/�mѹ���Z_Jl�y�kyd�\��z�"wV��u�#rg=��,; ��F��]
t�d%f��;��v�̵������Q�܁t�Κ*�P=n�@��m8oC�֠׬t:wn����`E�½[k�ԝ{�Mִb�n	�gi��R�G�	�����*a��ʧ�u�m�k��75�<�Ѻst�쮻C��c�ar�dѺ��sx�ǩQ��z<��m5�h�Ѭ_)<+S�ԭ�O��IE!t��2�o��y]��3<X���'-m��
��fr] B��VtZv��] � ��vG莶��ηC�փ��&i��K���e:	�nE�"���A�ֳ�'`�ׁ��㙋1��:�����Dv&�K{�3�R���g uk�Qw,˅����3�56x��	+r3��̭�Z50�P*�j�s����[/�ʁZ/��n��W-�R�[���֞�����	�g�N���𢎋H�z\5,��Z��V-�� �[O�F���s t�Pʚ���z	�F�¢s�uP�H��i���z���l����]��)��l r��yr��+�v��\�C�֋��r����DC�[x�"�l4�X6���h��hVg��ʭ73kt�u���z��dܭe��P8V�ƭ'.Ֆ}9��[OR�e��(Q�[R*�6�*����)Ņi�q[�Q�7�Vq[�Q�̡ڶ��n����T�D��hۥߍ?e'�2���:�Z:�	u[/QN�� Dd��Ha��D�2��Q��.cJq��Ve�DEd�²f����c�������yء,���f<ϓXh��{��������tޣ,��:V�s�km�,��f������J&cQ���_~�����zX0�XˈQ�����N�cG�֣�qw(ʆ<8�Gv�Xktp"*�=9-��v����-Z Y[��Zh�bq��VN�q�f��h��5�]������su(�zg�:kp�z�-I�7�*xz�p��	z�*Z�˜ h�!��c'ox<��n3I[�υ�`���g�*N���������ə+��^�#=��I[���R$+}�����OX�-���	Ƭ�B�x�	�݉���k<��j���=�ީ�#���E���z\,w�i2�����ZO{�@�V�x��������~��A�}����
�P�����u�B���bq>nb���Q!�ܸ��z�K��rn�Tm��u?�eưb/��ͬP Y[��J���k8�F��OT�hBp�2�ʢj�I����Q�kXIs���]�� ����g��V���@֮qu!�A-�v���S ����V�<�<���L�Lӛ��z�jD��S0�/������.�G�Aq:�Ot��J�4�ډ���n���v"mד�m��H�*���`�>��W�'0���Z:��&¶�;:sE�V�����8����=�:����g�n��'�v��T�j��Vq���KyxC&��U���5*p���̘D+��C��)Z������wB�f����w�d�    �a[o�ܠ��P���QN󐉶��rN(`Yڶ�QqZX�'�{Nv.�M�m=�P�惾��rY�5���]�=����­�m���w�h�z�&�/@���6����^f��<��-�k)oQ�[t��?֧렍�鼭�[����u.GNDn=�2�x�3�K���D��l��[<3Kk}=d��T촖@���%2�x�΀�zL)\���s�H��%����sS����'J����>�!u빌�z��B%jCam�	�[�eD�m5Ѻ��@�̜-Z�y�8F[LC��3�����E?�z*j�����E�V3��\fD.n�{_jl�V�Ku^C��ݍ(/���3��`��-�y��|�WF�n�>fd�ꭦ�g1��A��ㆮu<C�V��㤬��OI�ݢ��0�(�-i�q�2;h�1��
4o�h/O�-�����` Yv��6���'G����-*�r����\,K�SA�Vp�L�f��˵D�W��I��}"z�gv�)�@�V��*��Mb���*��:\�xCӹ�5Ѽ��D�w+RA�n�y�@�l���a��Ңy�K�<r�V܃歾�Y�7�*�䭶��#[Gyou-��</1�⭞��N�� ��z�{���Z�2�鍑��aX�-VD��ݣ9�t
z�����|'jw���tx����Yo�97"v+ϣZ����h�j21����8
Ww�Q����~ιK�к{:1{J��.�n��-�ɱ�X�����ÊZ�:�&���w�[=wUP����+�-�eORd��s>^��깛νp��[MwϮX��L��4�\(�ꑫ]�:�-��~����-,�n��U�(�ۡt��m:�vw�P�����h=<�Q�O�	�ŀ���9�SK���NW����]��jjɀi}8H�|j<��t�~�ش�ҁ�5�;[h�����X��Э�q���Ydn�O�i�9���[�N�N�0*�z��ai/�^��jR����`�>4���/$n������B�V��&����=�����[��p0B�_����ՉQ��S�B���+��0�ʞ,�m��K�iV��{��6���­V���3�[�O���[��y��Y\�m���E��@���Kn*k�o�`yN��@�����C�V�?x��-�mu��[�N�~!m�]�� ֲB	�-�/~�.i[��"��b�m�֋��gs��j�wl�ӡj��9;Yh�a͈��� i���[�?�v���\g�n��~j�cbH�ꄗt���c���l.�lV(��-��\���h�ٜ�������T�z�B�V�f ��E�Vo������B�Q�R$b'�]兠=�9��]R h�����9Y(���ב��{M��Sqn,�l����Y	�l��R�sZ11R�:~�~ڝ�J��GDs�F�VϯW7�l'Z��~�1������Y+"�l��P�E�:s)��2b���Q��	+b+u���NXa#۹; %[����~�������<E![�09 /$F�V�*� ^���VS�yF���NS
�gh0b�)bk�@�Vg��M�ɡb�^��in����U��x��[���f[��D�q�c�Y�2O斈���Fw�q�[=�N�âB����de:���G������e�����d��{Bq��ƃQ�ע��w�e��ū��&��{JF����c�όwq�NR(;Y�k-`ŹIj�Z�N�� %?(�#^S����f�-R<S]�w4�l�6���n8��'X��p�q~P���D�Ĝ+�X'z� 4X�k��`}:x�Z���t�b)������ڭ�\�B�4t&3} J��_H��F����h�Occ����lƾ���]����-��k�ո����u�т7����t//ԭ"�;�iz���W�]v5�fD=`��v˘�F\؎����G�V�	]3�Q[�%b�q� Go4`������kE���3j��!k�Ll��r����qL�hPCo��^ ���.%����3��㰗dm�=��U[m��gd�����еՉ@v��x����X��k�{��2�`Eׅz<¶:D�hi[�bi��R~ж�9 b3�E�V� �;'i��m���5��E��E};'U��`�^�{s�1��<aJs}
���ǆ��m]��C���}[߯�wh��1r�x�BQ�ᅡp��[7��>�ɢ4x�։̰�[7˯��f5z&�ejt�����ܺ>��������R�b��>	�8�[��%sb���xQ#*�n[G��Tn]�67[dn]�C�"tnݵ=?C�x�b̈˼�E��}ay�a�ܺ.|�>�J@��oj��Ѕ�WX_ND=�ލwY�̭���U���[�{�,+F�����,�"s�
m���5[H�}G w|�bEHV\KF���RY�w�B�����Y2b�n���o����BWAu��zкu4Xьw�7\���fF�ݺ	�K�I%�\n\`��n�f\�V	�u���ێ�!v��8<�� ��ə��[W�4�i�Dl48�Bccp	�[��D��O��b��ը�5�DY������Ij� �	�[w��9�p'!t�ʛf9Nݺ���T���F����fB�n�����B	��<�u���)йu�,�H��8rB���X����J�.[>�/v0v2gqѺu9��̨�פ����*����	�{ES���R����.���nݣ�Rx�E����v��t��A��L(ݺ�m��H6�t�
��Y�n�U�J�8�لέ�*I����B��ċtF��F����|�o+�@+��lV��̭+�͑@"����j�GZ7�xc��"�q����}v�hܺ%��x=n�A���rR��LoB�֭�XY稝P�u�A�9���N(ܺ7�Gj����y��t
��'nO�x?6'�m���-Խ�9ˊ�����lv2P	y{��������;ϲF%t�X/p[�,�j�[�wY�m���mZ)���-G"J�S����z�	i[��9:#Y�@�V���ޘ;���ˉ���Y��mp뀗��C������,h�U�6J��wr�����z>F/���/^�^��� o���'W�.*|���&�.�ޭe(�Z�
�E���?Y�]��8��F�:*T�"K��ӻ�Sth�OjX�V�x;��bE�V�/$�C��(�1���	������5:HQZ8w��u8�c���c�i�	m{�)N=@P�^?lcN�����C�'j�fg-�Jܫ5�;[X���{���F��7��<��������M�2^$;��.\g-�	-��]��u���"����Nk��w܍��6�P+�|Ο��;�Ƿ;v2!�޽��3�Kl8X�w�<s[��b�Y����]�ԗ�-N8�{�ivT޴��j���roa��ѪF�|��ӂ{KS�c�Nh�.'ad��	�T�Pѹ����N9R�j�o�����{_Nl���1����DtG��d��)��S�(��-?�b{�Iq"?PB��j�����o�¦���'��I!^^�����&g��c���f��۬Y��vQ�B�w�W�.*\��c㨝��]T� ºk����S�	c��W�.).���m�յ���y��aƕ���F�?�%����E���U���w�����]�a��U�j����V�ewx�"�R]CN�"��M�S���H뮅�S2�PFk��.�
h�x^�Qzr����\����"�s����9�%�b��h��E�-�n���2�����-9C�rO�V �3�(�a�
�(5���b�Q�%��%��@�=��Y^�����Q�Rx�<U�Sk���U�=8V��Z�c'Vԛ��NR�@��Cw�#����IaR����'@v<@�M��<f> WH��сs��
)�کJ�F.���T����R�q�ɚ+�Л2�(P!E?��D��|��Xq�z��=�����'����'��;�<N�yeF���%�:�b��H�ʩ�>�ܿ�(�ʁj!<�"l+i���f���e���O�l8���%_����Q�6!P���)    ��QT�U[��lO�����.e�^/:.5wOD�������M��
eF\Ư��l�h�Tۙ�����/W���Ưo�ܝ�ui[��9�-�!m�ܸ@���m��x��3e�m��ց;<�q:���n�hVSlǂ��hl���\�ʨ�qr��=΅��������}[Q��'��m�y����1�Ǐr=�\Q�%�C��"o+��H�:2�n+�ի�͹�Q�׆�$G@��ۊk���98H�R��f�c(��
D1ka!E�cx�ǃ�S�u~G�V4z\�s�)#q+SQ�$Z��Q�7nE����ta�J+v�7�k����EX��!r+���ʻ��и?���2<Dn���k1РE�?qwnŎ�7Ղĭ�1�,R4�-��c�A�N��س�jw�wk)

w�/'������D=\��L������Lu=S�

���Zc�� k��+
�I��X��E�R�'�YP�s<��tw]ѷ���LR oGj���%��Z^�VA�Vdq��!vd�z�^A�VdQ���(h�2Qu:�i[���,h�W�_�
ڶB�8�4��|A��杣Ւs:.hۚ�m���h�ڽcL�������2d����GdS�	��t�0o�7\�C��n��Ҷv[UGZqqAَ��#	�8��i[�c�Þl.�8�YY�mm�gs(��]ҟ���t�BuU�/Z)�qwݩE)(���dt�i_е���JH9҃�V����C�֜yAז��x�,�v�^�3>�뙼MU;z$��S,������/IN;���-���'�㙐��)�f~<tmy�v�c�dѵK���I1�m�9'/QYP��K�1/e\жe��?9�@ۖrV�b�"�c�� F\%Qn�;�"p�j����[�u|f0�­u�Ƿ8{
��%^ʴΟ����g�v>��TQjZ
�&:�g(���M)�8:m4
궀���p
�
ڶ`O��t�BUU����ed>�����z!Sy�^��m��c��戴]"u7M���l��b)�c �v��Q���D\�:;�c(��e=�O�X;-�vQ��l���uN�mX+)�aul�N�wA�.��1zx�b��\�"l_��xû���7�y8��mW5�Ϊ�rm�>9ܱiyh�5��u^O*h�5)�� ͩ�,H�5j!��rXp�v]���(���x���*H�u���u�TP�k>aJvnktm�����N)OA��U(!���Wd�Z�p׹�8v���*h�0�N�qA֮�z�
a��x5I�g�H��p�ϡEE�Vg>�v8�+�v��x�R�6/�v�x,��xi[�3G�o�QE��V7N�F/��X�����+��q�e��'m�\Zx��e��I���]�uO�#UѶ�>��ur�m;�Aȝ��T/V���HԎ�3d����8r�N�SQ�k�!Yg��qͮ@���	nh�"�3:k)�Ũ��{G��'
��/���NfO�;:��:�@E��P^lQ����a'�Q+
wUQJ��KF�Vϐ�!=8�!!��T$Q�۔ޢqk�a%�)C��8�8���ݴ[� �[4�&�ᥬ�e��ݼ-Z q7�Q�h-
w�½"�04����tR�,��]��+1@k'�I�s����-] ݀��hrvqrZ�Vd�&u�.���-:s����Зkq]ղ=��Mb#"p�d�n=�Y�t�d��V�pS����ǳ���w�#�W��V�u��5�����Ncof��C�n۠s4K�h����ۦư\Bw;��`����G=��!t7Ff� �nu���9�EE�nY���MZ(��BJ�\Jw�C�q����%,�Z
d��8���E�nڵ#�f��[�w7��>����kf']��[W�;����z+�덑��{DK\�P �^��P�h����bte�[$@�����ݢwPT�X ���r{[A�zs���;�SŪ�"v��3Y͢+r�j,�v��-C�}�;@�n��/���m�-�@��L�B��6ׯo�u�����Ԃ�T{p�"�)�h��d���h�������癋k)��D�8Xbr�J��@P-�C�V���u'LF����0�F�n�����E��ϛ��E��������kq��4���m5<SF�VI�D��6��Z|O����{���n�ŻG���F+�=�*ҰWZ�vS ��k��]�q��S��ϙ���:�p�3��rwϕ���o�л{�^��������yӅy�㞢)^�Odl�ͩ�j(޽H�&m�w/o��D�[�i���s/Ż��%^�!x�)���
4�nU��Q�w|zw��V���@��ĦUN�#V��EYp�Bٲ�Xp�B7d'V�ؐ�{��^�Ґ����Su��ݕ�Q�։Zw�j\3ܭ��G�J8ːQ�{�6����n��}<�T�sU��vw�i7/�Sg�к��&�u3`lh�}�p��Io5�n���Z�����A�P��љ�qC���jJ,#A��ەės�����X�>!tw=],��4�n��]�5����B����V!�
r��-߄��u�2�z��{��L��l�ܺv��X�z;�*���{<w���{�[���\�oh��Q��n�vH�c��'P��e.�WU����p�Og���B1�:��L_�­�$����[�ل;�l�[�����+��7�M��<�5��F��B���bl�B�U���f�a�m��6a�&�m���Zo6�mE�wp�7A�z�O��a?���=�>��q{�"H��hb�=j,l:N�m���ɰrHۣ�7���DSz���؆�=��n���vz'�qVi{��O�������,����#�����#���P��Q[�hZV/jB��7Zw�����r2I���Ԉ��uTG�}�u���1��G8SE�{E�C��t(�#N�v�
E{�ox?�C	���h�41�!�gè�c*7dg��>�w�l&�X�9u밎�=V�J�l��WG��F�y1�9ӡd���{���p��4t����Ju'2�T�uy�T��:�|:q�ׁĜ� n�¦��%��թ�ô����������s�o*��t{�ζc�e�"���Rt�l]���m-EGƞqI�F�d��	��)'�4Р�>^�������=�s(Q��A��/��(تB���';��%�XF���>P%�c���*�ݝ*ώ�=�ÿ�aw�W1I�}���=k�I1`�A
�卝���`��'sr{�7v�>�P�x�x�C��M�z8<N�{�UO�����ۛ*���fT�n.�P)k������D=�M���=��9�8���=���ʉ���E���ሓ	{F�����@Þ#nS�j�V��=w(�ڧ0b�P��Ok'CŞz���]2��� �9�p�B��m�͠��=��O��Yd�,�.y.
{n���ӟ��b�;U�<ηCŞ빣s�{.�ͥ2�\9�E��sE]gw{Fs���kQ{�9��c)��3�8n�9�mwt���+��N���-��7-){��"�Jx�-{)�����dh�k�Ύ���;b��6]���1{�7#���W�N[�׎:r�J�:�d��H<�5[����8uE9{��[�T��@�^��0�9�p�b;��_X��j*u<�7<x�	<Cq�H�+�V�XV��9Zq��*;q<
���>!>�(�ֲ�	�e��,9h��+�sFKg+͋���s�;ӟ�i�zc��0�hګƉv�����{hq����P�WTf�������ڇ����-���7F�^�;�g,�(]{)q�G,�C�^j;ݛ,�����:�	Y36��E\X,����l�vγ�p�b;�X��\��H�K�-��ѝw{:���'ܞV�e{E���"�K/z=	��v�P�Lv�Z���K!2X)K����8�F����#n/eݞ��ܨ�k(s����
�����Nk������&w�dH�Km\��o#m/��,h�	��;�QlVi{I8�m�:���5B=��N6��|b-�cu��q����,N��5�u N�g�m���f3��k;�k��    N1P��:��ެ���b�W~�:
����/�4X�K�i����+w�fD1���=)2kt�u��oDa���޸����$)Fh�U�Z�Y�ɸ�vի�qpw�(�J�m�%:���v}tj�������mW��p}s"/��]i{�M�N�n\q{�_	�(Q#É�p�s,%É=L};/xR�ac�ގ+�d2�쑡�:�t;�^���p� V��-wW̰B��w�� �������D�(�B~��X �d�AY�-�B�G���*�BBE	Y���
��9\�t� F��\�M�i�0
�����9/Ў-j�(���uB�T�ͬ����[!F{p��nVaƟ�]r��'ƛ���i:*�PF+��\�EW���ҶB��w�F,��/z9q@wZߎ
-ԦE�K,Z!EW��s*��֠��_��]����]�'"�S݈�A	M�L����Ę��(V��Gu]@�����ϣE����y1T����Z	X1�]	/���b�e��Ƴ^����>�X�=�X��j���w@Ǖ�kR2@׫-�w�퍖�(������z̥���s�ŀ���i_�6�+no��9��kJ��rZ-E0a���lo��f>3����S�NN;�1�Dj�	ӟH�W\���I�)���K��H!#Q�Fsi!E���g��58a��R�3��N��1�E�72��bB��릥��PV��둅�Vv��X��J�(�p���	'J	+n�]�1�D9�1oǞPb�RC�r81ᄺ��K�mA	-�J��-(Qӭ�v�ʱ�D-�T�Y݂z.�x�ǚ.��:/��p����1+n_�"�<V�0�{.X���ឪ��d,h�^�a�N��`�.��2���-��c��A��@5/Q,g,�|��u�^$;Xт���y�+��L!��/�V�1�;[X�"#	���=X��9{���| E�!�VÀ�q���*g!�O|�Ԝ��L�"R<�B��Q&�v�E1��D�N7	`�i;�v��Ճ��ϱ�Z\h�O'ֶH����okq+��)��i�Mۋ�'�v��I&5�������i�f/w�$ۧX��D�NR��5ze��;�f����(�I)|9)/;;��Ӧmx�kH��<g�p��TH�i|gӰ&5�`V���Q4{A�D��qe��T���;ې�1�2p{�}� r��M� B4�./��V�Ʋc$�]��^�q罵��иs$���,�Ɲ�V�x��-���z͐�sd�N�
Z�'=/�0Ѹ����$�np�b��o�:�9M$�l��\�Ɲ��1\��}�_�vV��ʝ�ͳ=Z�%bGe�:ˉН�W�~�Y��\�]��!t������E�>RC4�q��H�ze&�|szkN�nu��6G^��9� 5��6�i=�M�t��x�ڋ5��Ӛ�`L��ܮ��|<Zwn3ֶ[n �;G]dl��� Fo���!#u�>XZ���D�����S���D�&�'��fU�'3tD���F+��B��'1f~ױeo]++L����2�$�T\/�9�@���p
�������wxN۾���ɞw�cA���y�
�w�,ӛ �z({"zG���Od����Ӝ�{���wy�/��3�w�n�[F�.�g�γ'�<�5���DY^v���]N�����J{�έĉ�]�Q�O�[xpCI�?,χ �x%<�:�pP#�%w���%�%%����.�<���j(Gp��c���%�������%�,/��}z�Dg�:�D /y��k1
�5����T��ө�[ड़�̺I�^q�]Z8>o��ҟ����D�i	j����]jfx��w��P��q����g>������$o�Ѕ�����I�c������Z��B��~�����U6NS����K@�-�"���8����B]�Jj��$�}��4�����i��	���a��#.x��~����P���]7jfD�bE�N�p!���?�%�M!���bw�N��B /qO����B/�p5�'��5�'�a94��UNxk9*4p1V�Ҝr.Qs�'u���T�py� ^���v��(�*���qֳ�	����x=ˋ��ǣr�J�/D�/{/���J�K�����ՙ$x��c��e���ng��$k�H�Ui��b=����;y��^��:���w�Q�>�r744pU�K7�
xUiټ@�q)+��M�f�w�B�֣Hi�{�ҷs��!���a&&�����
V䅇�>�P��Q�%���ǹ�����P��f��
'���-�?A��z����Jl�PvZA �wU��<�@�������`D��5Y�T.d��@��x��w=����xp��;<+@���uv�9ջ�'9mi���	e����'"z��>���[דÄ���1����Sdf}:$��;�)���B�q[�� yW�[���м��[�g�,���]g�z����S�h~��B��n[���XjV��`���]�H�Zv��]���κ"v�h5���2� ���,R�u7F��]����Z��:p���rw(�ZOU;��n�O��d�~��`z'dn�8�ZӬ�1*�"�����r�sw��g����5Z+����^qX���w!s+�W]�;<h���*r���z�y�lZ�E㎞J���)���0cS,�Jiϧ�nv�A�n��c�E�q��>L�6��-╥�=x�_e�A�w��>��C���(��h�B%�R����1�������Eӈ�9xhܭ�bZ2w+���8�n4x�z�'/��ÿo<x��Ƃ�ݔ���g����ָd���E��xbC3��EK��h�"��"*���}����í�!oG��ˬ�@�nQ�Vg��m�l�Ƿ���D\������Dп]PV�z�e���n8X����YV���3ࠅ
!�[�m�<�}ƌ��/d�
�,8�S�i[���X;�v�e�lRa���w���gyеی�{͞+��'+Vp�����v��
#���4ׄQ��t���W��3���)�j��C�ݹB��N��[W4m%��Q�U4�h�s�eĈ����i�S��A�5b�u�+B�9���ѵ�n�B�]a���Ca+�S.���抮ݟ�:M֢kGÓ��Y;�e�߮�׎ѹx�~��E�H�q�3�[�f��2�'�+�3ҋ�A���꺮�{N q;n[^1��� ow���gԑ�m;��(��q;z4�������_;������ǎ�������z~ }��K���-�v?�>6܈(�$��q�hc�@H�=�딝ɢp��9�5=�m�BO�^_`�A/Eu�ћv���(^ɍ-�{�d����0#R����{Ir%W�4<�]L`O`������MAj\�a�֠(%YuL������K�.R�o�4v����4���P�;y^�utƱ��)i�xח��w�Y|�E�汋���օ[�4f�K��1�2�I���x*IP��|
Оsx�??��N3�1�������]��͐�#���-j?)e�p�^��գ/�v�4����d��z�8 Q�����)���=_��<�P�-7-z�v�o��/It�z7��'T��i׻:�#��;��VnK��������cS��|�����tlܤ�,H?%3xȈ?%��W���[��yq��4��#)�v�~�{�w2n|��|��ʝ�p_;ߴk�$��Ɋ��~��HJzj�Y�p�9"�W�M��]��?�rbS�q��k�W���[�V��JS���M�Ɲ���m�^�7�7W���sg{��5�a)�5�_��DT�[Ю���a����M\y�k�!��K鵉t����/�Zg�k�"����k�t��ܟ�W����������v��M����0[M�|�ӾW�R�d�����S��w����|��lܙ��n��ɞ'��U�3�i|���r�We����wN��J@���A���JK�����؎rۦa㎣ok���<�1_6�����
�_�7"�K��w��}�hR��ٸ�o-+B6nv��29i��qs��8��2:~㤅L���)�X,���qo���[��&    ��q����NZ(�g��O��g"6n���(��Q�qGD<;u�����1D�E���o�+ן���Jy���{S�y�h7!��ϫ�K�����i��CE�����Q_�h��(/�!1�e�n��/�[�b�7-���������g��,A�g|�~���.%^j6��7?i�?nq^~���ٛ�}����p��{�S� f�>z�h�u���ُ��q����P�ϻ,���ʟ���{˽�u�����J9�����{��|W�0�q�T�a����P���ڸ��J�qN��A`񕙢}ޙ���i�fk��V���Dm�;w"V�بڸ�ٻĢ�-�}��W�<��1��1��������K����&�-�m���Th�,�m����6���Ҕ�G����k�n�>f3�e����J��4�o��#r��o��<��> }[S�����WY/�n��[z�������@��:p��\�O-�������<�޸SU�[L*]�y�FU�X ����3_���	��F�JI�H߸���?E	�	���;K�?E
���8�1_�޳������Y�Q�}	��o�0�ߏ+�m4pܹ���ګ����;��Y�k�qk�7J���q7>?i�8���[2�<������F9�k�p�a����8���D��+�%A7Xy�����A�ܿߞ���ǻ���>�8�հ�'�)*i$��n����s�;OO�2d$��=0���Fǽ&��'�+γ�9������~{�ӂ\i��Gj�����Q�q�w-B	;��8��-����������]�!>9���ދ��������E�]�ñ���3aSA7z86��o��0j�}_IW�����{�x��0��א�h��;R�MY-qlҾq��:�m��~�6ʟqlc��w�HӘnr��U)����M�wo���}�D�}s汍�W���c�#")?;����ޟV�F��x�{vRgql���1�y�"of/6a���RV6zu#�c���k���c�{�߃��?i)�N9�����SñAxY�O�Y�G<$�EK
����&Mc��蔗O28���ﬔsڍ
�ݲ�?�4�A�_�RDp�o�{[�~u������[�;���c�>�l���$���8�C	[���5�vF����7O9�m$�� =֞�x�p�H+;��s=v�������s�Su��?���s�3X��I
������������I���y�}j⼟��z��w��6�>?����z���ߟ4���(|�j�;������	����O��?�0�}��O��ఏ}�^_��ʇ}�[n���=��c��wwSm�e8.��Z��<p�^��q��lq����:g��d\r��]Ɓo��ne�Lc�ѿ'���U�ę������0�'PIV��6b�l�@�e�]�]w��!|1�������/6����^Yx���(�����Pa����=�<V1�u�Ǖ��|����7U��w`7��o����^���T�p���{8���,�9��RN�����v(l�5�ʻ�6�-��~	�'��#��>G\�?�N�Ӏg%���i��Q�K�Qw�U7�MkN�W5 �6�p�}��V~�Ϲ[`W��\��?�N\����oG���̝���e@ڊ�ʝ��u{�(�y�yl�Q@�۔#�n�b~�L}� ��O��c8����8�onL���[�<�1?�������;����½�f��1�w;)-5g�����ʝxܝm�f��8��*�[�҇Ng�_��_��	�����NH��c3�����F!�u���F���(��M�{P�Ղq����<%�`ǃ�G��q|�P�<�u@�	�Gٟރu���~^���:���ԟ�y`_��RF�|����҇�`8�ۡ)�dz�
,Lk�'M61N�(���5]�!�N��Fv�n�7�+��y���7k�\ʡSOF0K��L`BӔ��� �5��6�R�'3�)���b
���)ϯÉO@��X�|��Ǳ	���8u��-8�w�b�l��Qە}i�����)
��|�ƅ��4�ﵷi��~V���hpH[��O��}�y�-�H�v�г�|;q��Ɓhu�s*{w\^�}��]3��?i^r^|pS�mʩdN�ƕNo�Rũ۸��;N�O'n�J�߳�����'}I!m�:'lC��´_�����U6�r�6.sڸ�B\(tm\F�_��ґ(����f�\�#}�!k�;j�sS���dm{�f�W�|A��u:��l���Aֶw$��m�H?/���-ܴJ|!�k�ʕ�<m�ѵq�ʶ�{�Ra׮���P�P#a���}�q����Rߧ(�cn��_�8&ٷQ�t)�S�q���J�4p�׻��8�i�o�i\�q�>n*#m��m{'���&Q��*p�Y���}P�qF�o}a�a��F ߧ'T�m�P�������|����T�h�6N	�$���A��9�q��w��qR�o��Ph�8+�Ry�7Nm��(H�Kи�]�|B��PP��]���'<J7�m�<�Swк�]�<�]��۟(����w�[��V�R���Mpo����|�籠�8�7>�{K��G�~q��[���mu�͔���G���͆��m緽�*�c'�e�4�q�{�|\%��������h�<�q�oW啞�s�א���q&��ϡ�>�7N�}o����I�;�:�u�S���Y�8.��v��{Do��}ޓ�l�]����FI�~�~o���c���K��k����ʟ������)oTo/���U�g��ܿH�-��8�}�wJ/UDo�j��01�ʕ�y�d��9��y�=����>�7��
<���pڼM^��4�e�wr9N���R���;Ԕ���;>�[�ޜA �	�۾_%��n�)]�Dp7�P�����������|ޣ���߉\�߂Y� w�T�Ø�؛J�2�e!���� ���S^��8���p���A�i��T��%��8�J�tD��'�P�~Pf�V�,8NL���l Dp�5��P���
l8�?ʋ1	�>})O��V�7�Vn��o����&�U��S��>����o��w�R^H��7J}z�qA�Ѯ
�7 ����b������tڠ{Cq��u� ����>���a���u��to�+
����7�]�Ә.�{u)g����3�]zŤx�
7��z���X�;q���"�A�*�7�ߠx�8Oi�����מ��>םR�4��"ݏ9�ݠl��.3�9��o��щ��.=m)��!#�KW�y�y����_���'��J@�<|��,�2������*����B�I�Ƒx���8��.�r�6I�80m鉱
l܅yW6�Ib7�
��L9>��W(�8��8���l�G�v�0T|_ۥq,b>ڽ����o{R�q\�w�B9P��n��^��c�&{߻��ޓ�nZ���:�Y̔�+eA�~��8mU��.����o���кq<`K/'Tn|�{�(oaI���2|1�q�{����I���7J}z,�}��<i���q���+E��&�k���1�s�k�`�I������yI�Ƈd�S^Rh�ߣ����8��ĻfK�H���si�y�;�`��� y:��B������ǔ�eI����8�����U��eڼ���3E��ƍ�@���3I��g l,������@�n���:I��G��8兀�������g���߶�K:����@8/������O@�˷X�q�b> a��	MҶ����'�(ޖ,����어m|
z�?���!����H�����UN�I�6>�`Z($]����Kô����O��R|$a0�@�~u,;O�h�3���g����^��l�X{��)�?֞y9�R>�s�W����T{�5���R~�=�~{8�,��jlR����`�`�RÕ!�������&��y������MJךHO�a��IόU���Ճ��*<��#�Y�㔏;�*�U��3�/��#��ߙ�<V��;/�O��*U���ތ"�    ".�%��D8�)/x�*�-d|Mі
È�<�Kc3��o���]3�hf�<��,��E@:u�E\f����Y��8%��,�����y�����?�x�:����c�O)�<f��S�0�Yd�͓������r\��g��y��o.�и=¿�9�>�Af�� s��{�����=HÒ�p��<HÊ����a�a���a����=H��o��vz�a�X�AG*�8(�H�B��0p�j����T@-pP��
��
8R�X�AG*�8(�H�b��Z,ࢀ��Y�EW+`����V�f\���.
�Z�\p�6�(�j�o���s��l��a�a8���N�~���{�����|w���lqػX�j��o�ۄ���N�~�q��N�~�s>���������;��a�a8���w�?����s������ c���`, �]���,���z�����V���wj��
p���Z��9�W+�Y���, g~���,��|�j8���A���\W+ X��:�jį��ǃ4�8lރ4�9�>�A2]Z��� +��{��5���=H��a������=(�rq���i�6�x��� ��i�)!x��� \�i�Ux��� \�i���x��� �H�i�� xP��i x����w�i��x��� ���i��x��� \Y�i��)x��� �>�i�ާx��� l|�eX� �#�0��A����a, [��A��Y�a, ;+�A��{�a, ���A�p?e<H�X�� �
8, '��A��	�pX .�4��bJ<H�X@�S'��9	7���� c���0�3Z��T.<(�.��qx��� ܷ
�0���� c8��0��� c8��0�( �.�	�x����D�pY .oƃ0�H�R���;�P@I�b���0�+%� c���a, W
�A�p�%�a, �ă4����T@/�����, ۷�A�p�5<H�X �껭�Y �E���Y �ǽ��Y ���@�0᫙pӄ/L�j&�4���	7M��f�M�0᫙pӄ/L�j&�4���	7M��f�M��*̈́�&|a�W3�	_���L�i�&|5n���	_̈́�&�K�ރ2�&|a�W3�	_���L�i�&|5n���	_̈́�&|a�W3�	_���L�i�&|5n���	_̈́�&|a�W3�	_���L�i�&|5���qosB̈́;xf��9{K+ xf��9{�	w�̸�s�4���q��i&��sC���L��熮�ݤV@��Ѕ�V5�๡g�j&��sC�Z�L��l��p'�xK3�N���f,`� ̈́;Y�F�	w���4�dh&��6
�L��l��p�(@3�.`(@3�.`(@3�.`���a, ��/̈́�X �k_�	w� \Ծ4�b��}i&��pA��L���j���p7���K3�n�+ٗf��, ��/̈́�Y �a_�	w� \þ4�f��}i&��p��L�������p7���K3�n�Kחf�}X �[_�	�a�j}i&܇
�L���K3�>, ��/̈́���@�	�a��}i&܇����p��ޗf�}X .z_�	��u¸�}i&��	�r�p�]'��ݗf��w�p� ̈́��:a��di&��	����p�]'��їf��w�0�p_�	��u¸�}i&��	'
�L��]'�(@3�X@� ̈́��u4>�	
�L��]'\(@3��w�p� ̈́��u4>�	
�L��]'\(@3��w�p� ̈́��u4>�	7
�L��Lx��c����0���V�M
N�k����ڤ���6�9�>�M:�ԟ�&]N:�#M���z{Vk��o.�Y�(.r\��r�*�%0�27.s\ ��s�:��/�B7.t\���t�Jǥ/�R7.�w�tm����T�\��mW�;����j��Mm�;W;mj�ݹ�q`S[��ՎÚ�jw�v��V�s�㐦�ڝ�4���\�8�����j��Lm�W���j�v�)Q[���>��ڃ�}
rm�W���j��)ȵ�\�S�k�=��[�k��ڧ �V{r���t�jO�v�mH[���>��ړ�}

m�'W{`clmW{����(�v�!����j�^��jO�vlͩ���jǍ���^\��}T[���>��ڋ�}
Jm�W���j/��)(��^\�SPj���ڧ��V{q�OA����j��R[��Վ�@k���ڧ��V{s�OA����j��J[���>��ڛ�}
*m�7W�T�jo�����Q\�SPi���ڧ��V{s�OA�����^���6��7��V��j�m���~�ڧ��V��j��Z[퇫}
jm���)���~�ڧ��V��j��Z[퇫}
jm�_��)���~�ڧ������>m�_��)�h��r�OAG[헫}
:�j�\�S��V��j�����/W�t��~�ڧ�#����ڧ�#�����/�S���j�m��~W;�b �����q�i���Վ�H��.�v��BZ�wq���%�j����S�V�]\��%���7W;n詭���wW��-wꆡ.m�SQ��-����{.m�SR7�\ڒ���>�{ik�������==uc���z�����K[�4�����6������%��Ǫں��n���������^�ꆬj�zI����ꥭnت�������y�uO]��U�W/yu�W5_���m�6��,�{�(�	륰nl(��%�n{w0�fq�c;AY/�uc7AMY/�uc3A�Y/�uc/A�Y/�uc+AZ/�wޚ�^J��F��^R��>���^Z��6��^b��.���^j��&��^r�����^z����^������^�����^�������^������^����^�����^���ށ��^���A��{���΁��^���Ɓ�^��ƾ���^��ƶ��^��Ʈ���^��Ʀ��^��ƞ���^��Ɩ��^�Ǝ���^
�Ɔ��^��~���^��v��^"��n���^*��f��^2��^���^:��V��^B��N���^J��F��^R��>���^Z��6��^b��.���^j��&��^r�����^z����^������^�����^�������^������^����^�����^���ހ��^���ր�^���΀��^���ƀ�^��ƾ���^��~����=qv�;�i�:�ߍ�uO���>qں���w�8m�h��K���)���$N[�$�����{���"N��H���u�J��f�ʺ�E��o/@e�Ǣ�����cj��	PY��(��m���X����T�},Z�~� *�>�v�] �u�Z��&�ں'����ڬߺ����,㬷��6�9�m���
�z;�h���޶ڬ⬷�6�9�]��:���ٮͺ��nX-͢����O[��Z�����,�{��'ym,z�a�?�kc�k��I^�^k��O��X�ZÞ��Ƣ�����6�ְ�䵱赆�$��E�5��'ym,z��zX�kc�k�J^�^k�Xm��k��J^�^k�&V��X�Z�E���Ƣ�����6��pY�䵱赆�b%��E�5\+ym,z�a�?�kc�k{�I^�^k��O��X�Z���Ƣ�6���6�ְ��䵱赆��$��E�5��'ym,z�as?�kc�k{�I^�^k��O��X�Z��~��Ƣ�6���6�ְ��䵱��A[��Zî~��Ƣ�6���6�ְ��䵱赆-�$��E�5��'ym,z�aC?�kc�k��I^�^k��O��X�Z�n~��Ƣ�6�6�ְ��䵱赆��$��E�5��'ym,z�a#?�kc�k��I^�^k��O��X�Z�.~��Ƣ�6�6�ְ��䵱赆-�$��E�5��'ym,z�a?�kc�k��I^�^kؾO��X�Z��}��Ƣ�66��&&��6��&&��6��&&��6��&&��6��&&��6��&&��6���=i�^k�I^�^k�I^�^k�I^�^k�I^�^k�I    ^�^k�I^�^k�I^�^k�I^�^k�I^�^k�I^�^k��I�~�kmb2�k7��&&Ӽv�kmb2�k7��&&Ӽv�kmb2�k7��&&Ӽv�kmb2�k7��&&Ӽv�kmb2�k7��&&Ӽv�k�b�?m��k}a�?m��k}��k^��>��5���Z�>Ś�nz�OL�y�������nz�OL�y�������nz�OL�y�������nz�OL�y�����֖ں������nz�OL�y�������nz�OL�y�������nz����k^��>1�浛^��k^��>1�浛^��k^��n��U[��Z��\��M����5���Z��\��M����5���Z��\��M����5���Z��\��M�u�d�y���:�2ּv�k{k^���63��=�ֱ��浛^���X��M�u�g�y���:64ּv�k;k^�鵎-�5���Z��\��M����5���Z��\��M����5���Z�⭭{z�OL�y�������nz�OL�y�������nz�OL�y�������nz�OL�y�������nz�OL�y�������nz�'����=��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7���m��=��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��7,��=��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7��'&׼v�k}br�k7����#�{��������'&׼��>1��F����5�5z�OL�y��k}br�k�^��k^k�Z��\�Z��������'&׼��~q�*m��kc�Uں�����м��1�44�5zmLL�y��kw�ռ��11��F���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z�����ٴuO���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z��η�Oh^k�����	�k�^;��>�y��k�����v*���F����'4�5z��o�м��11��F���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z�������6&�м��11��F���8�uO���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z�������6pZ�k�^�	��F�܅V�Z��nC�y��k#pZm��k7�ռ�赁;�j^k����h5�5zm�^����6p3Z�k�^Sh^k�ژ�B�Z�������6&�м��11��F�����uO���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z�������6&�м��11��F���)4�5zmLL�y��k�p�qm��kcb
�k�^Sh^k�ژ�B�Z�������6&�м��11��F���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z�������6&�м��11��F���)4�5zmLL�y��kcb
�k�^Sh^k�ژ�B�Z�������6&�м��11��N���)4�uzmLL�y��kcb
�k�^Sh^��ژ�B�Z������:�6&�м��11��N���)4�uzmLL�y��kcb
�k�^�Sj^��ڜ���:�6矦�N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzm�H�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ��91��N�͉)5�uzmNL�y��ksbJ�k�^�Sj^��ڜ�R�Z���Ĕ��:�6'�Լ6�91��A�͉)5�zmNL�ym�ksbJ�k�^�Sj^�ڜ�R�ڠ��Ĕ���6'�Լ6�91��A�͉)5�zmNL�ym�kkb*�k�^[��K�ڠ����Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T����&�Ҽ6�51��A����4�zmML�ym�kkb*�k�^[Si^�ښ�J�ڠ���T��&��&�Ҽ6�51��I����4�MzmML�ym�kkb*�k�^[Si^��ښ�J�ڤ���T��&��&�Ҽ6�51��I����4�Mz��[�{m�q�����=��5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�MzmOL�ym�k{bj�k�^�Sk^��ڞ�Z�ڤ���Ԛ�&��'�ּ6�=1��I�퉩5�-zmOL�ym�k{bj�k�^�Sk^[�ڞ�Z�ڢ���Ԛ���'�ּ��=1��E�퉩5�-zmOL�ym�k{bj�k�^�Sk^[��31�k�^{���k�^{��k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�    Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k����ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:����LLG�ڢמ��h^[��31�k�^{&��ym�k��t4�-z환��E�=�Ѽ��gb:��6��LLG�ڦמ��h^���31�k�^{&��ym�k��t4�mz환��M�=�Ѽ��gb:��6��LLG�ڦמ��h^���31�k�^;0D�e��?W�ڦ����W�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;��j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘��M���ռ��wb���6��NLW�ڦ�މ�j^���;1]�k�^{'��ym�k��t5�mz흘�浇^{'��y���މ�j^{�wb���z흘�浇^{'��y���މ�j^{�wb���z흘�浇^{'��y���މ�j^{�wb��מ����y�0��y�0�0��iXp�ރ4,9,>�AV��� k��{����{��];������̹�� cht{�l���1�Q����X�F��ch|{�l���1�Q���X�F��ch�{�l��q`(@C��,�P����Y�� �q�� C��g�4�=�h�{�
�(�80�Y�q`(@��,�P���'X�� �sO� G��`�4�=�h�{�8
�H�p���	�(@C�,�Q���'X�� �uO� G��d�4�=�h�{�
�h�$���I(@�ݓ, P���'Y@� �wO��@��d�4�=�h�{�$
Ј�H��)�(@C�S, Q����X@� �yO��D��b�4�=�h�{�$
Ш�4H�Y�iP(@���,�P����Y@� �{O��B���f�4�=�
h�{�
���4(���iP(@C�sX@� M}�a�4�=�4
����(@��sX@� M~�a�4�=�4
����(@��sX@� M�a�4�=�4
���\pP��粀�4>���,� ̀�eh|.8(@S�sY�A��
��\pP��w���4	��\�Q�],� ͂�bh|�(@��X�E��.
�<�.pQ��w���4��\����,� ̈́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�f&�a�[3�K�0᭙�	o���L�҄7Lxk&|i�&�5�4�ޚ	_���	ö́/MxÄ�d¹h�&�%�E�0�-�p.���	oɄsф7LxK&��&�a�[2�\4�ޒ	�	o��L8MxÄ�d¹h�&�%�E�0�-�p.���	oɄsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&<�X L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�d¹h�6Ʉsф&l�	�	L�$�E6��I&��&l0a�L8M�`�&�p.����M2�\4a�	�f&l0a�Lxӄ&l�	o����M3�M6��i&�i�6̈́7M�`¦��	L�4�4a�	�f&l0a�Lxӄ&l�	o����M3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o� �  �Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&�i�v̈́7M�a®��	;L�5�4a�	�f&�0a�Lxӄ&�	o��Ä]3�Mv��k&l4a�	�f�Fv��k&l4a�	�f�Fv��k&l4a�	�f�Fv��k&l4a�	�f�Fv��k&l4a�	�f�Fv��k&l4a�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&l4�	�f�F�ph&�4�	�f�N�ph&�4�	�f�N�ph&�4�	�f�N�ph&�4�	�f�N�ph&�4�	�f�N�ph&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&�4�	�f�NN�pj&4�	�f�AN�pj&4�	�f�AN�pj&4�	�f�AN�pj&4�	�f�AN�pj&4�	�f�AN�pj&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&4�	�f�A.�pi&�4�	�f�I.�pi&�4�	�f�I.�pi&�4�	�f�I.�pi&�4�	�f�I.�pi&�4�	�f�I.�pi&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�I���Wa�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&�4�	�f�In�pk&\4�	�f�En�pk&\4�	�f�En�pk&\4�	�f�En�pk&\4�	�f�En�pk&\4�	�f�En�pk&\4�	�f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	M����f�E>0ᣙpфL�h&\4�>�	�τ���{��5���=H����=H�.���=(�~&<s���a����=HÌ���=H��7l>��iXp���iXr�}ރ4�$
?�]�(@�|vY@� ���e���g�X@� ��Y/�(@�|��������}��      �   �   x����j�0���S�	�-Y����.k��^ۡ�,z��OnY�m	;d�����QL��{0!�޷>�$�̡3�q����l�}ٽ6�Ƥ�pG [�Ns�"�v�@n19���ڝ�	��3رp�x�G}r��H湼<�n_����UnƩ�iB�����P<��K���|��}����|L�8�����`	��v��q6�`]L�"��H��.2"ʪ����/\��!q�q�D&$Z|%ԯDH"q_��.�Z�6��X      �   5  x�}S]o�0}&��>nRe�o.�S ��V���z-���Jۿ�o��5ͪ�J��5��9��$b1���Z�� ��(śHJu"��:2˪��bZ���k����ܖ�G$��S�	E�����\A^X���l��2 E+�zm�Em�HɅTPc3�⪰E��7?mmyU��[�Z�7�qm��T�3W�*+sen�;|�1unn����Jg�N����J���D3��䄫X�c|�ͬrSo�5��̱9�����!�_-���4DDL�����~[��}3�OS��"��&��0�e�ZQ�
��w�o�H/�����+�B5��i�
�D����~��Ǿ���%�͸̔ �1��!�g��$G��IT�(A�
ş$�3�	W�X�j��HC�SN�%�Iq6��Mtm�N��o��׬�wл���`�><<#t7�E;xt����ܣ�O��?8�:h�C�C�����{��	w�'��yz�fJg}�40���GIq
p(_j��r�ΏzMg���؃���ox�G&���B~�q��u���,���]      �   �  x���ߋ�@���W�c�eg�G6yۋ�6Ec�y�½���Ƣ^���;ɝ9�DD���~gv6��ZPI�A>� �D7�/������D�(x�?�fyph>�p�_w ���i��{$a��d��]KA*VZDRY�H��:�J�q�c��A�<Iq��0�D��R:�3�V�����Ha�N I�bS�9-� �a�!�͊q���$��|3�]Z�y�y�0/2N���s�&�{��/�-���I6�� K<��/>O��tϒ+k%$)+�y�s�6:n�v��D�<:�P8m����'�����c$3�cx+��MUz)�Zk���y��&��3&��8�uü�)��&&�PRJ�~��C��XX�R�2,���w$"�ƅ4P1�ޙ�� �й+�9<���^-V%T�˶��7�ØL���M�h`���,
�����[�����@IKC��px�P�6���n/1��2��`�[tbe]��9�-#�Q�P���=�e.�=��)�Tt��'��oe�/1ŏR����x�9>���UU�k�j�r�J���G��6�S��'��#���row�.aQ�v�M	�ʶ�k�?_,��@���h y�Lx�|���rh���yQ����P���Ւ?�5�m�/�CE�=��h��Z�<      �      x���Mj�0F��)|���5;5.�!u��e���S91��
i1ߛ��4�B  �n�š����B�>Ǡ �'?�U#H�^µI�����K%
�5��)���1)�d�d���YZ4��(��V��З�C�k�Ne�ai��c�Q rNa�+�s����}���aW�s�ʴ5P�ꄑ՘l�#K���m%T������4�i8[���F�Lx�\M��g�;���Eq5'����^l��b�/0�n?AAs������tU      �   .  x����n"A�ϝ��H���k���E�dɉ�L�l���5�&@oA !�H���\�ݠ�X,
����*�&ǉ�!'�RTg�Iᬅ�#j��n�Oh�g���'�f_T7�<�����y5��N��鬼��{4�ޜϫ�>XC�Q��@�,&��q�%���Q?�u�B"11R��4H��՜s�o�@�� ���}r'��>�,�Y!A0^"�X�� �� ns��ݬ���	��.�E���FN�A���Ƙ �q]�d7��[�X���X��F��围��3$�=��ͨR��Ԧu��]�(F�$�b��/�%tɒ!��Z5.v��4 v ��P/�z��/��F���u":
�[����尣���5�N-�"� �Ib0�䵛�q5���5[������W���Mu��-�'��l"�xe!�u����	63�@�O���k!jE��w��g�jv6=k۸`e���e��@��KDƺHv�<���� }䭭�Hjl>��a_%YG	ܭ�]�?x��Oն|-a�BAg�h���m�n!Y��a�
�W6���_����w{_�	R�I &�`����A��P=�ju�	�Y�^+����t����kY.�>WO���������Nm����&Z	��C5���IGc9�=����'^��N(�\_��{���t��΋�\�p�3_���v�^������U�����e��z�Z~>����+���g�D�s�`�;4���u���J�� �W��A�f�q;p�З��:��_�@ZQ����0� صL�iE5�[��a��osrr�K1�      �   H  x���InAE��S�QĘC�Z���� @���#���FM#S�EJ���Ǐ"Y�E�B)` ������4>��������Y�)g�j��F�j�0[�,���_�\����#3�/�&܌6�b�����|�"]�Ы��(^��v*}��A�dHe&���-9C����û�����_ޜ30_c�H7�kt�|�`�������N|�A��X��R�a
�BY�榣�#��W��Ç��7���E��ٮ�6�qM���#��HDO���ʋ=<-�Q�O���mR��-��e��!>��(v�}��,�ҹMq�lz��1q��:�E%:B����Vi����S�o6�5��9BZ��b�dB�����D={��A�@�FPJ�#����$l׌�N&�N���=�KQ���6���P"��|g:[����Փ�mʛ�5v� �b��_�v9��ޣL�APC���JCZ�0�������g`]E%������Rj�I;$A�[h'H=&qDO��H��1�CZ%�&9G�ǁ=�+���3�؄Ѓ#�4�sL��<b�Q�90`݇ycZc����q����	�wJ      �   8  x��X�n�6]3_!யkR�K#N� i$��nd�7a��%m�����	������NXR琜�%�ө�)�to�����O��/RL���ĺ8��~��0�`�K[s���f�w]T6z���Lu܋�z'u��ɤx�	`�����c$eP��iݻ�~�n�"�p� �X<V��?#��v���^��RgNW����������`���h�f�YW���3���ؑ�QW���Qڤ_��[���EʘPF	Ky�]e���4ǝ�x3�
�&^�7��%8O;�QNE�)�����E-�&�S��e�-��RXC���a�����+����	�w(�DA- �"�~B2kQݓs�~���E�ס1O�؛�־E�sd��K�6�ֿ�f�d΄�ua��+O	qf�;a��x�Ϗ��T0�t�=#˞�Y�[��.���eo�d��	�h���^t���=��/0L�'gO��a`��O�Jl�Y7 ���c�2�{����r��"��}�)g��p�NN�
Nl6�l]
ӏn;c�������旛s�!R\��2s���eN�F�kH��>�v�����_�~�\���aD(!�V�z_�2�/�H��}�XH���h��M!qm�sI\H�����H����_|�#�(AD�X�kx٧��Ia��Ѯar:H�L�>;��z�g��,��0�_�L�C1/�6���*�z,�N@)T�-���Q��
�	T�f��>��Mv��p������������I
��Q�3�����no�~�W���3կ��$څ��N���R�U�D��V�׏�/ ����<�:-7��tP�5��bB)Ń��~XCQ����Z{v�`�����ڤ�-�[���K*����E����&f�V^HI��/T���	ζ�O�3(pj~�9�Z��Χ\�f�� e���Q+��EnL�����:1u=ʾ9�͘�y���+a��WaU��o�[�&k"�.a���
?:�*������=fNsꂸ�e7_P�%T<d���{,�I	�$EK�7�h�'���Y�,_�:�x�X�'�C������;��Zہ��_A�V�|��ΎP#ՙ����ݳc�VX����_/���q`��жXϟ�mL��PzTpE�6���H	.9��
-�kyW��+�Hⴲ@��˸���bu<.nCp`�A�r��V��#�Q%�_�@�gg�E��Nkr�e��
}Qڬ�7���펹B��������?��?�1֐1^ӌ�ү�٣o~[\�6��4ɐ�%���Cߤ����H�!_7����gm}`m���an�s<��,�a�&�əo�����Jǀ�������      �      x��XYn�H��O�Ϟ�dgd��?�l�\�%�-���In(5TbAKO�9�s��t]�#I�&%�e{�$���xK��ȸb\F �F�f�(�]�U����/�m�	ǋ�G��)��9<>+d<U6�<A�A����R��Zp�n�I���z��ч�K7���yvs5�}�Λb��Zm���W��Y�6?;�P��by	��Z��iS0y�]�dY�ײ}8��CŊ�#��.���c�'}Q�Ѧ}XH���=�6�9� �V�����(-���v���W��.����#������T�L��ŉ�l�M�q�^W�V>$s������
�<E�(-]��}F)�γ�C�`���猪������K8�8.�M�]�/ͦ�_�x��V��bU,�����W��a��u��Ų��O��D�!�\���%�
H��W�寻��_�Oo�S*m�����o����FM�l��*�r�hNCU�pk�}S����QѦ̢�s�y6�K��|ّd����!`���l�������|�v@��u�Z�a��4f�.�2����Y1�h�է���Iv?�.����v������2�5!�pɼ(�%P�Ko���)�}�rQ�X�&�����)�+�����[��߈��?�[�:l_�ݾTI�$VZ)ƺ�$��q��Z��"��#�)_AR�Ub��j$�h'��o���#ȯk,��@�������jr58�/gw�����Q��6�m�#���,A�]�:1����I�Н����A�SDV)&�,m�Q`�r����,Ǣ�8#�W�,"g��VȀF����yrK��Nn��}6?��߀�!|��p��.�>=[E��JǥA�9��)�`I@�:k�Ot� ]�)��
ŝ>Z��I�t���hԏQ�k�5�+i�)������c��u^טWֿT(�Z�In�P�,�(�JU�WE'�=���r��s�Dі��Y��<Rl�R5S"Q�pR��Ղ�GЌ��P�-��gKr�����r�k
��"��(�^��|R�'�� ����C6�W����x-.���TH�1�hI���sʈ1��R�q����=\���֭�ᘂI����xI�J��p$ݧY1�KC��>��0��l�M�f� {���1�S@�%�R��"�5�C�p�)0�2$�Qͫm)�q&��SJR-)YnKU��;����{���c'��=4�{�7�Z��i�+��1CR� 
��+�]�ʆv?!��u���/v��&�܇����]�$7A��pJ���v�HQ[;2;�sP�r�l�R]�xO��O~Eb)�q�����"������ů����ǟ>}z�m,ui�4�()�<�(�Y$�r�k��]S�u��>� rJZk���R��l�G���Q�A��F���8�DZЅ>�d�S�ɪ:@��dQ	
G2̝yM?��n�����~�I��%N�F��%S���}γ�t���|o[�j�:&Η���Զ�%Ɂ�pO�G����Q"��V~�]���+�|n�� ���5!�/O�6���I���S�"�()��OΘ��q��+���IA�	'�����b��t!�03HG.^kj���n�ڍo/n/('���a��j>{yc�9o���l���4�͖ݧ_�jy��:�-4݇� t3��(��x����������5��`���
�t��г�ٞƽ�w"c�5�j��������9Zq�i�!��^��4/��Ⱦ1Y�y�*FSxɽ�u�l�܎s�49XW1�=�ȕy���\^y�-��[��6�-�m��~K����p��     