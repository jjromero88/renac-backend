PGDMP     2    	                {         	   RENLIM_DB    15.2    15.3 +   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
                postgres    false            s           1255    66014 /   fn_asiento_circunscripcion_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_asiento_circunscripcion_seleccionar(p_idasientocircunscripcion integer) RETURNS TABLE(idasientocircunscripcion integer, idinformerenac integer, idtipoasiento integer, iddispositivo integer, numeroasiento character varying, descripcion character varying, nombrecircunscripcion character varying, nombrecapital character varying, nombreprovincia character varying, nombredepartamento character varying, informacioncomplementaria character varying, fechaanotacion timestamp without time zone, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying, informerenac_idinformerenac integer, informerenac_idcircunscripcion integer, informerenac_numero character varying, informerenac_fecha date, informerenac_descripcion character varying, tipoasiento_idtipoasiento integer, tipoasiento_codigo integer, tipoasiento_descripcion character varying, norma_codnorma integer, norma_tipo integer, norma_numero character varying, norma_archivo character varying, norma_fecha date, tipodispositivo_descripcion character varying, detallesmodificacion text)
    LANGUAGE plpgsql
    AS $$

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
       renac         heap    postgres    false    216    6                       1255    50141 ,   fn_asiento_modificacion_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_asiento_modificacion_seleccionar(p_idasientomodificacion integer) RETURNS SETOF renac."ASIENTO_MODIFICACION"
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
       renac          postgres    false    217    6            �            1259    50142 "   sec_circunscripcion_origen_destino    SEQUENCE     �   CREATE SEQUENCE renac.sec_circunscripcion_origen_destino
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
       renac         heap    postgres    false    218    6                       1255    50149 6   fn_circunscripcion_origen_destino_seleccionar(integer)    FUNCTION     *  CREATE FUNCTION renac.fn_circunscripcion_origen_destino_seleccionar(p_idcircunscripcionorigendestino integer) RETURNS SETOF renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
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
       renac          postgres    false    219    6                        1255    50150 (   fn_derivacion_renac_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_derivacion_renac_seleccionar(p_idderivacionrenac integer) RETURNS TABLE(idderivacionrenac integer, idderivacionorigen integer, idderivaciondestino integer, idespecialistassatdot character varying, fechaderivacion timestamp without time zone, usuarioorigen character varying, usuariodestino character varying, observacion character varying, esretorno boolean, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
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
       renac          postgres    false    6            !           1255    50151 ,   fn_documento_derivacion_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_documento_derivacion_seleccionar(p_iddocumentoderivacion integer) RETURNS TABLE(iddocumentoderivacion integer, idderivacionrenac integer, idtipodocumentorenac integer, rutadocumento character varying, nombredocumento character varying, fechadocumento timestamp without time zone, numerodocumento character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
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
       renac          postgres    false    6            q           1255    57868 %   fn_informe_renac_seleccionar(integer)    FUNCTION     L  CREATE FUNCTION renac.fn_informe_renac_seleccionar(p_idinformerenac integer) RETURNS TABLE(idinformerenac integer, idcircunscripcion integer, idestadoderivacion integer, numero character varying, fecha date, descripcion character varying, urlinformesustento character varying, nombreinformesustento character varying, evaluacionfavorable boolean, fechasolicitudinformacion timestamp without time zone, oficiosolicitudnumero character varying, oficiosolicitudfecha timestamp without time zone, oficiosolicitudarchivo character varying, evidenciasolicitudfecha timestamp without time zone, evidenciasolicitudarchivo character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying, vnomcircunscripcion character varying, itipcircunscripcion integer, nombrecircunscripcion text, tipocircunscripcion_id integer, tipocircunscripcion_descripcion character varying, tipocircunscripcion_abreviatura character varying, esderivado boolean, solicituddiastranscurridos integer)
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
			A."fechaSolicitudInformacion",
			A."oficioSolicitudNumero",
			A."oficioSolicitudFecha",
			A."oficioSolicitudArchivo",
			A."evidenciaSolicitudFecha",
			A."evidenciaSolicitudArchivo",
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
                WHEN A."evidenciaSolicitudFecha" IS NULL THEN 0
                ELSE 
                CASE
                    WHEN DATE(A."evidenciaSolicitudFecha") = CURRENT_DATE THEN 0
                ELSE CAST(DATE_PART('day', CURRENT_DATE) - DATE_PART('day', A."evidenciaSolicitudFecha") AS INT)
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
$$;
 L   DROP FUNCTION renac.fn_informe_renac_seleccionar(p_idinformerenac integer);
       renac          postgres    false    6            #           1255    66030    fn_numero_a_palabra(bigint)    FUNCTION     +
  CREATE FUNCTION renac.fn_numero_a_palabra(num bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;
 5   DROP FUNCTION renac.fn_numero_a_palabra(num bigint);
       renac          postgres    false    6            x           1255    66072 &   fn_numero_a_palabra_enumerado(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_numero_a_palabra_enumerado(num integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;
 @   DROP FUNCTION renac.fn_numero_a_palabra_enumerado(num integer);
       renac          postgres    false    6            &           1255    50155 *   fn_parametricas_renac_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_parametricas_renac_seleccionar(p_idparametricasrenac integer) RETURNS TABLE(idparametricasrenac integer, idpadre integer, idgrupo integer, codigo character varying, descripcion character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
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
       renac         heap    postgres    false    220    6            '           1255    50163 $   fn_tipo_asiento_seleccionar(integer)    FUNCTION     }  CREATE FUNCTION renac.fn_tipo_asiento_seleccionar(p_idtipoasiento integer) RETURNS SETOF renac."TIPO_ASIENTO"
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
       renac          postgres    false    6    221            (           1255    50164 ,   fn_tipo_documento_renac_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_tipo_documento_renac_seleccionar(p_idtipodocumentorenac integer) RETURNS TABLE(idtipodocumentorenac integer, codigo integer, descripcion character varying, activo boolean, fechareg timestamp without time zone, fechamod timestamp without time zone, usuarioreg character varying, usuariomod character varying)
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
       renac         heap    postgres    false    222    6            )           1255    50172 1   fn_tipo_modificacion_asiento_seleccionar(integer)    FUNCTION     �  CREATE FUNCTION renac.fn_tipo_modificacion_asiento_seleccionar(p_idtipomodificacionasiento integer) RETURNS SETOF renac."TIPO_MODIFICACION_ASIENTO"
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
       renac          postgres    false    223    6            n           1255    66019 8  usp_asiento_circunscripcion_actualizar(integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying) 	   PROCEDURE     �   CREATE PROCEDURE renac.usp_asiento_circunscripcion_actualizar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_numeroasiento character varying, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
$$;
 �  DROP PROCEDURE renac.usp_asiento_circunscripcion_actualizar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_numeroasiento character varying, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6                       1255    50175 @   usp_asiento_circunscripcion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_circunscripcion_eliminar(IN p_idasientocircunscripcion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            m           1255    66017 6  usp_asiento_circunscripcion_insertar(integer, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, boolean) 	   PROCEDURE     $  CREATE PROCEDURE renac.usp_asiento_circunscripcion_insertar(IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_numeroasiento character varying, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
$$;
 �  DROP PROCEDURE renac.usp_asiento_circunscripcion_insertar(IN p_idinformerenac integer, IN p_idtipoasiento integer, IN p_iddispositivo integer, IN p_numeroasiento character varying, IN p_descripcion character varying, IN p_nombrecircunscripcion character varying, IN p_nombrecapital character varying, IN p_nombreprovincia character varying, IN p_nombredepartamento character varying, IN p_informacioncomplementaria character varying, IN p_fechaanotacion timestamp without time zone, IN p_detallesmodificacion character varying, IN p_circunscripcionorigenes character varying, IN p_circunscripciondestinos character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            u           1255    66016 H   usp_asiento_circunscripcion_paginado(integer, integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_asiento_circunscripcion_paginado(IN p_pagesize integer, IN p_pagenumber integer, IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
$$;
 G  DROP PROCEDURE renac.usp_asiento_circunscripcion_paginado(IN p_pagesize integer, IN p_pagenumber integer, IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            t           1255    66015 9   usp_asiento_circunscripcion_seleccionar(integer, integer) 	   PROCEDURE     5  CREATE PROCEDURE renac.usp_asiento_circunscripcion_seleccionar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
$$;
 �   DROP PROCEDURE renac.usp_asiento_circunscripcion_seleccionar(IN p_idasientocircunscripcion integer, IN p_idinformerenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            +           1255    50180 Q   usp_asiento_modificacion_actualizar(integer, integer, integer, character varying) 	   PROCEDURE       CREATE PROCEDURE renac.usp_asiento_modificacion_actualizar(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            ,           1255    50181 =   usp_asiento_modificacion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_modificacion_eliminar(IN p_idasientomodificacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            -           1255    50182 O   usp_asiento_modificacion_insertar(integer, integer, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_asiento_modificacion_insertar(IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            /           1255    50183 N   usp_asiento_modificacion_paginado(integer, integer, integer, integer, integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_asiento_modificacion_paginado(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            0           1255    50184 ?   usp_asiento_modificacion_seleccionar(integer, integer, integer) 	   PROCEDURE     <  CREATE PROCEDURE renac.usp_asiento_modificacion_seleccionar(IN p_idasientomodificacion integer, IN p_idasientocircunscripcion integer, IN p_idtipomodificacionasiento integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            1           1255    50185 x   usp_circunscripcion_origen_destino_actualizar(integer, integer, character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_actualizar(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, IN p_nombrecircunscripcion character varying, IN p_origendestino character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            2           1255    50186 G   usp_circunscripcion_origen_destino_eliminar(integer, character varying) 	   PROCEDURE     )  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_eliminar(IN p_idcircunscripcionorigendestino integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            3           1255    50187 v   usp_circunscripcion_origen_destino_insertar(integer, character varying, character varying, character varying, boolean) 	   PROCEDURE     @  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_insertar(IN p_idasientocircunscripcion integer, IN p_nombrecircunscripcion character varying, IN p_origendestino character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            5           1255    50188 O   usp_circunscripcion_origen_destino_paginado(integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_paginado(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            6           1255    50189 @   usp_circunscripcion_origen_destino_seleccionar(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_circunscripcion_origen_destino_seleccionar(IN p_idcircunscripcionorigendestino integer, IN p_idasientocircunscripcion integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            7           1255    50190 D   usp_circunscripcion_seleccionar(integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_circunscripcion_seleccionar(IN p_codcircunscripcion integer, IN p_tipcircunscripcion integer, IN p_nomcircunscripcion character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            v           1255    66059 '   usp_constancia_anotacion_renac(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_constancia_anotacion_renac(IN p_idinformerenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

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
                WHEN (LOWER(pt."Descripcion") like '%distrito%' and LOWER(cr_1."vNomCircunscripcion") like '%lima%') THEN 'Municipalidad Metropolitana de Lima'
                ELSE 'Gobierno Regional' END as descripcion_gobierno,
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
$$;
 j   DROP PROCEDURE renac.usp_constancia_anotacion_renac(IN p_idinformerenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            y           1255    66073 0   usp_constancia_anotacion_renac_asientos(integer) 	   PROCEDURE     B
  CREATE PROCEDURE renac.usp_constancia_anotacion_renac_asientos(IN p_idinformerenac integer, OUT p_cursor refcursor)
    LANGUAGE plpgsql
    AS $$

	BEGIN

		OPEN p_cursor FOR
		SELECT     
			CONCAT('Ficha: ', (select fn_numero_a_palabra_enumerado from renac.fn_numero_a_palabra_enumerado(CAST(T."rownum" AS integer))), ' asiento de la partida registral del ', T."circ_titulo_1") as asiento_titulo,
			T.circ_titulo_2 as asiento_subtitulo,
			T.asiento_numero,
			T.norma_tipo,
			T.norma_numero,
			T.norma_fecha,
			T.circ_nombre,
			T.circ_capital,
			T.circ_departamento,
			T.circ_provincia,
			T.circ_infocomplementaria
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
$$;
 s   DROP PROCEDURE renac.usp_constancia_anotacion_renac_asientos(IN p_idinformerenac integer, OUT p_cursor refcursor);
       renac          postgres    false    6            l           1255    57856 �   usp_derivacion_insertar(integer, integer, character varying, character varying, character varying, character varying, integer, character varying, timestamp without time zone, character varying, character varying) 	   PROCEDURE     �	  CREATE PROCEDURE renac.usp_derivacion_insertar(IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_derivacioninformes character varying, IN p_rutadocumento character varying, IN p_idtipodocumentorenac integer, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuarioreg character varying)
    LANGUAGE plpgsql
    AS $$

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

$$;
 �  DROP PROCEDURE renac.usp_derivacion_insertar(IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_derivacioninformes character varying, IN p_rutadocumento character varying, IN p_idtipodocumentorenac integer, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuarioreg character varying);
       renac          postgres    false    6            8           1255    50191 �   usp_derivacion_renac_actualizar(integer, integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_actualizar(IN p_idderivacionrenac integer, IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_idespecialistassatdot character varying, IN p_fechaderivacion timestamp without time zone, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observacion character varying, IN p_esretorno boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            9           1255    50192 9   usp_derivacion_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_eliminar(IN p_idderivacionrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            :           1255    50193 �   usp_derivacion_renac_insertar(integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_insertar(IN p_idderivacionorigen integer, IN p_idderivaciondestino integer, IN p_idespecialistassatdot character varying, IN p_fechaderivacion timestamp without time zone, IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observacion character varying, IN p_esretorno boolean, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            ;           1255    50194 B   usp_derivacion_renac_paginado(character varying, integer, integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_derivacion_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            <           1255    50195 )   usp_derivacion_renac_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_derivacion_renac_seleccionar(IN p_idderivacionrenac integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            =           1255    50196 �   usp_documento_derivacion_actualizar(integer, integer, integer, character varying, character varying, timestamp without time zone, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_actualizar(IN p_iddocumentoderivacion integer, IN p_idderivacionrenac integer, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            >           1255    50197 =   usp_documento_derivacion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_eliminar(IN p_iddocumentoderivacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            ?           1255    50198 �   usp_documento_derivacion_insertar(integer, integer, character varying, character varying, timestamp without time zone, character varying, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_insertar(IN p_idderivacionrenac integer, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            A           1255    50199 F   usp_documento_derivacion_paginado(character varying, integer, integer) 	   PROCEDURE     
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
       renac          postgres    false    6            B           1255    50200 -   usp_documento_derivacion_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_documento_derivacion_seleccionar(IN p_iddocumentoderivacion integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            e           1255    50634 �   usp_especialista_ssatdot_ajustes(character varying, character varying, character varying, boolean, character varying, boolean, character varying) 	   PROCEDURE     U  CREATE PROCEDURE renac.usp_especialista_ssatdot_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
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

$$;
 [  DROP PROCEDURE renac.usp_especialista_ssatdot_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            *           1255    50631 �   usp_especialista_ssatdot_derivar(character varying, character varying, boolean, character varying, character varying, character varying, boolean, character varying) 	   PROCEDURE     4   CREATE PROCEDURE renac.usp_especialista_ssatdot_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
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

$$;
 �  DROP PROCEDURE renac.usp_especialista_ssatdot_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
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

$$;
 [  DROP PROCEDURE renac.usp_especialista_ssatdot_informefavorable(IN p_informefavorablearchivo character varying, IN p_informefavorablenumero character varying, IN p_informefavorablefecha timestamp without time zone, IN p_listainformesrenac character varying, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            d           1255    50620 F   usp_especialista_ssatdot_paginado(character varying, integer, integer) 	   PROCEDURE     
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
       renac          postgres    false    6            C           1255    50203 D   usp_especialista_ssiat_paginado(character varying, integer, integer) 	   PROCEDURE     V  CREATE PROCEDURE renac.usp_especialista_ssiat_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            r           1255    57870 U   usp_especialista_ssiat_registroformatos_paginado(character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_especialista_ssiat_registroformatos_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
            A."evaluacionFavorable",
			A."solicitudGore",
			CASE
				WHEN B."iCodDepCircunscripcion" IS NULL OR B."iCodDepCircunscripcion" = 0 THEN B."vNomCircunscripcion"
				WHEN B."iCodProvCircunscripcion" IS NULL OR B."iCodProvCircunscripcion" = 0 THEN CONCAT_WS(' / ', C."vNomCircunscripcion", B."vNomCircunscripcion")
				ELSE CONCAT(B."vNomCircunscripcion", ' ( ', D."vNomCircunscripcion", ' / ', C."vNomCircunscripcion", ' )')
			END AS NombreCircunscripcion,
			CASE
				WHEN (E."codigo" = '60' OR E."codigo" = '70') THEN 'Sin Derivar'
				ELSE 'Derivado'
			END AS EstadoDerivacion,
			CASE
				WHEN ((E."codigo" = '60' OR E."codigo" = '70') and E."idGrupo" = 1001) THEN false ELSE true
			END AS esderivado,
			CASE
                WHEN A."evidenciaSolicitudFecha" IS NULL THEN 0
                ELSE 
                CASE
                    WHEN DATE(A."evidenciaSolicitudFecha") = CURRENT_DATE THEN 0
                ELSE CAST(DATE_PART('day', CURRENT_DATE) - DATE_PART('day', A."evidenciaSolicitudFecha") AS INT)
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
$$;
 .  DROP PROCEDURE renac.usp_especialista_ssiat_registroformatos_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            w           1255    66067 5   usp_generar_correlativo_constancia_anotacion(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_generar_correlativo_constancia_anotacion(IN p_idinformerenac integer)
    LANGUAGE plpgsql
    AS $$

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

$$;
 `   DROP PROCEDURE renac.usp_generar_correlativo_constancia_anotacion(IN p_idinformerenac integer);
       renac          postgres    false    6            D           1255    50204 '   usp_informacion_ssiat_asientos(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informacion_ssiat_asientos(IN p_idinformerenac integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            E           1255    50205 O   usp_informe_derivacion_actualizar(integer, integer, integer, character varying) 	   PROCEDURE     l  CREATE PROCEDURE renac.usp_informe_derivacion_actualizar(IN p_idinformederivacion integer, IN p_idinformerenac integer, IN p_idderivacionrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            .           1255    50206 ;   usp_informe_derivacion_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_derivacion_eliminar(IN p_idinformederivacion integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            4           1255    50207 M   usp_informe_derivacion_insertar(integer, integer, character varying, boolean) 	   PROCEDURE     A  CREATE PROCEDURE renac.usp_informe_derivacion_insertar(IN p_idinformerenac integer, IN p_idderivacionrenac integer, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            @           1255    50208 D   usp_informe_derivacion_paginado(character varying, integer, integer) 	   PROCEDURE     o  CREATE PROCEDURE renac.usp_informe_derivacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6                       1255    50209 +   usp_informe_derivacion_seleccionar(integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_informe_derivacion_seleccionar(IN p_idinformederivacion integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            F           1255    50210 �   usp_informe_renac_actualizar(integer, integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_renac_actualizar(IN p_idinformerenac integer, IN p_idestadoderivacion integer, IN p_idcircunscripcion integer, IN p_numero character varying, IN p_fecha timestamp without time zone, IN p_descripcion character varying, IN p_urlinformesustento character varying, IN p_nombreinformesustento character varying, IN p_evaluacionfavorable boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            G           1255    50211 6   usp_informe_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_renac_eliminar(IN p_idinformerenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            g           1255    50630 J   usp_informe_renac_evaluacionfavorable(integer, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_informe_renac_evaluacionfavorable(IN p_idinformerenac integer, IN p_evaluacionfavorable boolean, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            H           1255    50212 �   usp_informe_renac_insertar(integer, integer, character varying, timestamp without time zone, character varying, character varying, character varying, boolean, character varying, boolean) 	   PROCEDURE        CREATE PROCEDURE renac.usp_informe_renac_insertar(IN p_idcircunscripcion integer, IN p_idestadoderivacion integer, IN p_numero character varying, IN p_fecha timestamp without time zone, IN p_descripcion character varying, IN p_urlinformesustento character varying, IN p_nombreinformesustento character varying, IN p_evaluacionfavorable boolean, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            I           1255    50213 ?   usp_informe_renac_paginado(character varying, integer, integer) 	   PROCEDURE     h
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
       renac          postgres    false    6            J           1255    50214 &   usp_informe_renac_seleccionar(integer) 	   PROCEDURE     e  CREATE PROCEDURE renac.usp_informe_renac_seleccionar(IN p_idinformerenac integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            i           1255    50640 ?   usp_informe_renac_verificar_informefavorable(character varying) 	   PROCEDURE     (  CREATE PROCEDURE renac.usp_informe_renac_verificar_informefavorable(IN p_listainformesrenac character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

$$;
 �   DROP PROCEDURE renac.usp_informe_renac_verificar_informefavorable(IN p_listainformesrenac character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            K           1255    50215 W   usp_norma_seleccionar(integer, integer, character varying, timestamp without time zone) 	   PROCEDURE     M  CREATE PROCEDURE renac.usp_norma_seleccionar(IN p_codnorma integer, IN p_tipo integer, IN p_numero character varying, IN p_fecha timestamp without time zone, OUT p_cursor refcursor)
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
       renac          postgres    false    6            L           1255    50216 u   usp_parametricas_renac_actualizar(integer, integer, integer, character varying, character varying, character varying) 	   PROCEDURE     	  CREATE PROCEDURE renac.usp_parametricas_renac_actualizar(IN p_idparametricasrenac integer, IN p_idpadre integer, IN p_idgrupo integer, IN p_codigo character varying, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            M           1255    50217 ;   usp_parametricas_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_parametricas_renac_eliminar(IN p_idparametricasrenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            N           1255    50218 s   usp_parametricas_renac_insertar(integer, integer, character varying, character varying, character varying, boolean) 	   PROCEDURE     0  CREATE PROCEDURE renac.usp_parametricas_renac_insertar(IN p_idpadre integer, IN p_idgrupo integer, IN p_codigo character varying, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            O           1255    50219 D   usp_parametricas_renac_paginado(character varying, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_parametricas_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            P           1255    50220 +   usp_parametricas_renac_seleccionar(integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_parametricas_renac_seleccionar(IN p_idparametricasrenac integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            k           1255    57862 �   usp_responsablearchivo_solicitudinformacion_insertar(character varying, timestamp without time zone, character varying, timestamp without time zone, character varying, character varying, character varying) 	   PROCEDURE     v  CREATE PROCEDURE renac.usp_responsablearchivo_solicitudinformacion_insertar(IN p_oficiosolicitudnumero character varying, IN p_oficiosolicitudfecha timestamp without time zone, IN p_oficiosolicitudarchivo character varying, IN p_evidenciasolicitudfecha timestamp without time zone, IN p_evidenciasolicitudarchivo character varying, IN p_listainformesrenac character varying, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
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

$$;
 �  DROP PROCEDURE renac.usp_responsablearchivo_solicitudinformacion_insertar(IN p_oficiosolicitudnumero character varying, IN p_oficiosolicitudfecha timestamp without time zone, IN p_oficiosolicitudarchivo character varying, IN p_evidenciasolicitudfecha timestamp without time zone, IN p_evidenciasolicitudarchivo character varying, IN p_listainformesrenac character varying, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            p           1255    57861 Y   usp_responsablearchivo_solicitudinformacion_paginado(character varying, integer, integer) 	   PROCEDURE     �
  CREATE PROCEDURE renac.usp_responsablearchivo_solicitudinformacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
$$;
 2  DROP PROCEDURE renac.usp_responsablearchivo_solicitudinformacion_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
       renac          postgres    false    6            f           1255    50636 �   usp_subsecretario_ssatdot_ajustes(character varying, character varying, character varying, boolean, character varying, boolean, character varying) 	   PROCEDURE     {  CREATE PROCEDURE renac.usp_subsecretario_ssatdot_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
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

$$;
 \  DROP PROCEDURE renac.usp_subsecretario_ssatdot_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            o           1255    57835 �   usp_subsecretario_ssatdot_derivacioninformes(character varying, character varying, boolean, character varying, integer, character varying, character varying, timestamp without time zone, character varying, boolean, character varying) 	   PROCEDURE     �7  CREATE PROCEDURE renac.usp_subsecretario_ssatdot_derivacioninformes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
    LANGUAGE plpgsql
    AS $$

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

			-- obtenemos el id del destino para los informes con evaluaciones No favorables, que van al especialista SSIAT para "Modificar o solicitar archivo de informe de anotación"
			SELECT T1."idParametricasRenac" INTO v_idderivaciondestino_espssiat_modificacion FROM renac."PARAMETRICAS_RENAC" AS t1 WHERE t1."activo" = true AND t1."idGrupo" = 1001 AND t1."codigo" = '60' LIMIT 1;

			-- obtenemos el id del destino para los informes que van al especialista SSIAT para "Generar formatos de anotación"
			SELECT T1."idParametricasRenac" INTO v_idderivaciondestino_espssiat_anotacion FROM renac."PARAMETRICAS_RENAC" AS t1 WHERE t1."activo" = true AND t1."idGrupo" = 1001 AND t1."codigo" = '70' LIMIT 1;

			-- obtenemos el id del destino para los informes que van al Responsable de archivo SSIAT para "Subir oficio de solicitud de información al GORE y evidencia de envio"
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

$$;
   DROP PROCEDURE renac.usp_subsecretario_ssatdot_derivacioninformes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_idtipodocumentorenac integer, IN p_rutadocumento character varying, IN p_nombredocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_numerodocumento character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying);
       renac          postgres    false    6            j           1255    50633 Z   usp_subsecretario_ssatdot_derivacioninformes_paginado(character varying, integer, integer) 	   PROCEDURE     �
  CREATE PROCEDURE renac.usp_subsecretario_ssatdot_derivacioninformes_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
$$;
 3  DROP PROCEDURE renac.usp_subsecretario_ssatdot_derivacioninformes_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor);
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
       renac          postgres    false    6            c           1255    50221 G   usp_subsecretario_ssatdot_paginado(character varying, integer, integer) 	   PROCEDURE     �
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
       renac          postgres    false    6            R           1255    50222 �   usp_subsecretario_ssiat_ajustes(character varying, character varying, character varying, boolean, character varying, boolean, character varying) 	   PROCEDURE     V  CREATE PROCEDURE renac.usp_subsecretario_ssiat_ajustes(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_observaciones character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            "           1255    50626 �   usp_subsecretario_ssiat_derivar(character varying, character varying, boolean, character varying, integer, character varying, character varying, character varying, timestamp without time zone, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_subsecretario_ssiat_derivar(IN p_usuarioorigen character varying, IN p_usuariodestino character varying, IN p_esretorno boolean, IN p_derivacioninformes character varying, IN p_idtipodocumento integer, IN p_rutadocumentomemo character varying, IN p_nombredocumentomemo character varying, IN p_numerodocumento character varying, IN p_fechadocumento timestamp without time zone, IN p_activo boolean, IN p_usuarioreg character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            S           1255    50226 E   usp_subsecretario_ssiat_paginado(character varying, integer, integer) 	   PROCEDURE     -  CREATE PROCEDURE renac.usp_subsecretario_ssiat_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            T           1255    50227 S   usp_tipo_asiento_actualizar(integer, integer, character varying, character varying) 	   PROCEDURE     F  CREATE PROCEDURE renac.usp_tipo_asiento_actualizar(IN p_idtipoasiento integer, IN p_codigo integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            U           1255    50228 5   usp_tipo_asiento_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_asiento_eliminar(IN p_idtipoasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            Q           1255    50229 Q   usp_tipo_asiento_insertar(integer, character varying, character varying, boolean) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_asiento_insertar(IN p_codigo integer, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            W           1255    50230 >   usp_tipo_asiento_paginado(character varying, integer, integer) 	   PROCEDURE     j  CREATE PROCEDURE renac.usp_tipo_asiento_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            X           1255    50232 &   usp_tipo_circunscripcion_seleccionar() 	   PROCEDURE     G  CREATE PROCEDURE renac.usp_tipo_circunscripcion_seleccionar(OUT p_cursor refcursor)
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
       renac          postgres    false    6            Y           1255    50233 "   usp_tipo_dispositivo_seleccionar() 	   PROCEDURE     <  CREATE PROCEDURE renac.usp_tipo_dispositivo_seleccionar(OUT p_cursor refcursor)
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
       renac          postgres    false    6            Z           1255    50234 [   usp_tipo_documento_renac_actualizar(integer, integer, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_documento_renac_actualizar(IN p_idtipodocumentorenac integer, IN p_codigo integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            [           1255    50235 =   usp_tipo_documento_renac_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_documento_renac_eliminar(IN p_idtipodocumentorenac integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            \           1255    50236 Y   usp_tipo_documento_renac_insertar(integer, character varying, character varying, boolean) 	   PROCEDURE       CREATE PROCEDURE renac.usp_tipo_documento_renac_insertar(IN p_codigo integer, IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            ]           1255    50237 F   usp_tipo_documento_renac_paginado(character varying, integer, integer) 	   PROCEDURE     t  CREATE PROCEDURE renac.usp_tipo_documento_renac_paginado(IN p_filtro character varying, IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            ^           1255    50238 -   usp_tipo_documento_renac_seleccionar(integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_documento_renac_seleccionar(IN p_idtipodocumentorenac integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6            _           1255    50239 W   usp_tipo_modificacion_asiento_actualizar(integer, character varying, character varying) 	   PROCEDURE     v  CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_actualizar(IN p_idtipomodificacionasiento integer, IN p_descripcion character varying, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            `           1255    50240 B   usp_tipo_modificacion_asiento_eliminar(integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_eliminar(IN p_idtipomodificacionasiento integer, IN p_usuariomod character varying, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            a           1255    50241 U   usp_tipo_modificacion_asiento_insertar(character varying, character varying, boolean) 	   PROCEDURE       CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_insertar(IN p_descripcion character varying, IN p_usuarioreg character varying, IN p_activo boolean, OUT p_error boolean, OUT p_message character varying)
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
       renac          postgres    false    6            b           1255    50242 8   usp_tipo_modificacion_asiento_paginado(integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_paginado(IN p_pagesize integer, IN p_pagenumber integer, OUT p_totalreg integer, OUT p_totpagina integer, OUT p_numpagina integer, OUT p_error boolean, OUT p_message character varying, OUT p_cursor refcursor)
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
       renac          postgres    false    6            V           1255    50243 2   usp_tipo_modificacion_asiento_seleccionar(integer) 	   PROCEDURE       CREATE PROCEDURE renac.usp_tipo_modificacion_asiento_seleccionar(IN p_idtipomodificacionasiento integer, OUT p_cursor refcursor)
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
       renac          postgres    false    6                       1259    66045    correlativo_numerico    TABLE     ?   CREATE TABLE public.correlativo_numerico (
    count bigint
);
 (   DROP TABLE public.correlativo_numerico;
       public         heap    postgres    false            �            1259    50244    v_informeanotacion    TABLE     Z   CREATE TABLE public.v_informeanotacion (
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
       renac          postgres    false    6            �            1259    50253    ASIENTO_CIRCUNSCRIPCION    TABLE     s  CREATE TABLE renac."ASIENTO_CIRCUNSCRIPCION" (
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
    "usuarioMod" character varying(50),
    "numeroAsiento" character varying(10)
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
       renac          postgres    false    6            �            1259    50288    INFORME_RENAC    TABLE     �  CREATE TABLE renac."INFORME_RENAC" (
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
    informefavorablefecha timestamp without time zone,
    "solicitudGore" boolean DEFAULT false,
    "fechaSolicitudInformacion" timestamp without time zone,
    "oficioSolicitudNumero" character varying(20),
    "oficioSolicitudFecha" timestamp without time zone,
    "oficioSolicitudArchivo" character varying(250),
    "evidenciaSolicitudFecha" timestamp without time zone,
    "evidenciaSolicitudArchivo" character varying(250)
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
    "dFechaMod" timestamp without time zone,
    "vCodigoUnicoIdentificacion" character varying(20)
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
          renlim          admin    false    268            �          0    66045    correlativo_numerico 
   TABLE DATA           5   COPY public.correlativo_numerico (count) FROM stdin;
    public          postgres    false    269   �      z          0    50244    v_informeanotacion 
   TABLE DATA           @   COPY public.v_informeanotacion (urlinformesustento) FROM stdin;
    public          postgres    false    224   �      {          0    50249    v_proyectomemosubssiat 
   TABLE DATA           A   COPY public.v_proyectomemosubssiat ("rutaDocumento") FROM stdin;
    public          postgres    false    225   G      }          0    50253    ASIENTO_CIRCUNSCRIPCION 
   TABLE DATA           ^  COPY renac."ASIENTO_CIRCUNSCRIPCION" ("idAsientoCircunscripcion", "idInformeRenac", "idTipoAsiento", "idDispositivo", descripcion, "nombreCircunscripcion", "nombreCapital", "nombreProvincia", "nombreDepartamento", "informacionComplementaria", "fechaAnotacion", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "numeroAsiento") FROM stdin;
    renac          postgres    false    227   �      s          0    50135    ASIENTO_MODIFICACION 
   TABLE DATA           �   COPY renac."ASIENTO_MODIFICACION" ("idAsientoModificacion", "idAsientoCircunscripcion", "idTipoModificacionAsiento", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    217   2      u          0    50143    CIRCUNSCRIPCION_ORIGEN_DESTINO 
   TABLE DATA           �   COPY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" ("idCircunscripcionOrigenDestino", "idAsientoCircunscripcion", "nombreCircunscripcion", "origenDestino", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    219   �                0    50262    DERIVACION_RENAC 
   TABLE DATA             COPY renac."DERIVACION_RENAC" ("idDerivacionRenac", "fechaDerivacion", "usuarioOrigen", "usuarioDestino", observacion, "esRetorno", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "idDerivacionOrigen", "idDerivacionDestino", "idEspecialistaSsatdot") FROM stdin;
    renac          postgres    false    229   �      �          0    50272    DOCUMENTO_DERIVACION 
   TABLE DATA           �   COPY renac."DOCUMENTO_DERIVACION" ("idDocumentoDerivacion", "idDerivacionRenac", "idTipoDocumentoRenac", "rutaDocumento", "nombreDocumento", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "fechaDocumento", "numeroDocumento") FROM stdin;
    renac          postgres    false    231   �      �          0    50281    INFORME_DERIVACION 
   TABLE DATA           �   COPY renac."INFORME_DERIVACION" ("idInformeDerivacion", "idInformeRenac", "idDerivacionRenac", activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    233   /      �          0    50288    INFORME_RENAC 
   TABLE DATA           �  COPY renac."INFORME_RENAC" ("idInformeRenac", "idCircunscripcion", numero, fecha, descripcion, urlinformesustento, nombreinformesustento, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", "idEstadoDerivacion", "evaluacionFavorable", informefavorablearchivo, informefavorablenumero, informefavorablefecha, "solicitudGore", "fechaSolicitudInformacion", "oficioSolicitudNumero", "oficioSolicitudFecha", "oficioSolicitudArchivo", "evidenciaSolicitudFecha", "evidenciaSolicitudArchivo") FROM stdin;
    renac          postgres    false    235   H      �          0    50297    PARAMETRICAS_RENAC 
   TABLE DATA           �   COPY renac."PARAMETRICAS_RENAC" ("idParametricasRenac", "idPadre", "idGrupo", codigo, descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    237   /      w          0    50157    TIPO_ASIENTO 
   TABLE DATA           �   COPY renac."TIPO_ASIENTO" ("idTipoAsiento", descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod", codigo) FROM stdin;
    renac          postgres    false    221          �          0    50304    TIPO_DOCUMENTO_RENAC 
   TABLE DATA           �   COPY renac."TIPO_DOCUMENTO_RENAC" ("idTipoDocumentoRenac", codigo, descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    239   !      y          0    50166    TIPO_MODIFICACION_ASIENTO 
   TABLE DATA           �   COPY renac."TIPO_MODIFICACION_ASIENTO" ("idTipoModificacionAsiento", descripcion, activo, "fechaReg", "fechaMod", "usuarioReg", "usuarioMod") FROM stdin;
    renac          postgres    false    223   �!      �          0    50311    ACUERDO_ANOTACION 
   TABLE DATA           �   COPY renlim."ACUERDO_ANOTACION" ("iCodAcuerdoAnotacion", "iCodAnotacion", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod") FROM stdin;
    renlim          admin    false    241   �"      �          0    50320 	   ANOTACION 
   TABLE DATA           �  COPY renlim."ANOTACION" ("iCodAnotacion", "vNomAnotacion", "vFuenteCartografica", "vRepreCartografica", "vCartografiaBase", "vArchivoShape", "bTrifinio", "tMemDescriptiva", "dFechaReg", "dFechaFinalizado", "bAprobado", "iCodSolicitud", "dFechaMod", "vUsuarioReg", "bActivo", "iCodTipAnotacion", "iCodLibro", "iCodSeccion", "iEstado", "vUsuarioMod", "iTipSustento", "iCodNorma", "bPublicado", "iCodDocAcuerdo") FROM stdin;
    renlim          admin    false    243    $      �          0    50331    ASIENTO_LIMITE 
   TABLE DATA           �   COPY renlim."ASIENTO_LIMITE" ("iCodAnotacion", "iCodLimite", "iNumAsiento", "vUsuarioReg", "bActivo", "iCodAsiento", "vUsuarioMod", "dFechaReg", "dFechaMod", "bAprobado", "bPublicado") FROM stdin;
    renlim          admin    false    245   S,      �          0    50335    CIRCUNSCRIPCION 
   TABLE DATA             COPY renlim."CIRCUNSCRIPCION" ("iCodCircunscripcion", "vNomCircunscripcion", "iTipCircunscripcion", "iCodDepCircunscripcion", "iCodProvCircunscripcion", "vUsuarioReg", "bActivo", "vUsuarioMod", "dFechaReg", "dFechaMod", "vCodigoUnicoIdentificacion") FROM stdin;
    renlim          admin    false    246   x.      �          0    50339    DOCUMENTO_ANOTACION 
   TABLE DATA           �   COPY renlim."DOCUMENTO_ANOTACION" ("iCodDocAnotacion", "iCodAnotacion", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "iCodTipDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod") FROM stdin;
    renlim          admin    false    248   �      �          0    50348    DOCUMENTO_ASIENTO_LIMITE 
   TABLE DATA           �   COPY renlim."DOCUMENTO_ASIENTO_LIMITE" ("iCodDocAsientoLimite", "iCodAsiento", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "iCodTipDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod") FROM stdin;
    renlim          admin    false    250   c�      �          0    50357    DOCUMENTO_SOLICITUD 
   TABLE DATA           �   COPY renlim."DOCUMENTO_SOLICITUD" ("iCodDocSolicitud", "iCodTipDocumento", "vNumDocumento", "vDesDocumento", "vArchDocumento", "dFechaDocumento", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "iCodSolicitud", "vUsuarioMod") FROM stdin;
    renlim          admin    false    252   y�      �          0    50363    LIMITE 
   TABLE DATA           �   COPY renlim."LIMITE" ("iCodLimite", "vNumPartida", "iCodSuscripcionA", "iCodSuscripcionB", "iCodLibro", "iCodSeccion", "vUsuarioReg", "bActivo", "vUsuarioMod", "dFechaReg", "dFechaMod") FROM stdin;
    renlim          admin    false    253   K�      �          0    50367    MEMORIA 
   TABLE DATA           �   COPY renlim."MEMORIA" ("iCodMemoria", "iCodAnotacion", "iCodTipo", "dFechaReg", "dFechaMod", "vUsuarioReg", "vUsuarioMod", "bActivo", "vDescripcion") FROM stdin;
    renlim          admin    false    255   ,R      �          0    50372    MEMORIA_DESCRIPTIVA 
   TABLE DATA           �   COPY renlim."MEMORIA_DESCRIPTIVA" ("iCodMemDescriptiva", "iCodAnotacion", "vDesMemDescriptiva", "dFechaReg", "dFechaMod", "vUsuarioReg", "vUsuarioMod", "bActivo") FROM stdin;
    renlim          admin    false    257   7S      �          0    50379    MEMORIA_NORMALIZADA 
   TABLE DATA           �   COPY renlim."MEMORIA_NORMALIZADA" ("iCodMemNormalizada", "iCodAnotacion", "iCodTipElemento", "vDesMemNormalizada", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "vUsuarioMod", "iCodMemoria") FROM stdin;
    renlim          admin    false    259   |U      �          0    50386    MOVIMIENTO_ANOTACION 
   TABLE DATA           �   COPY renlim."MOVIMIENTO_ANOTACION" ("iCodMovAnotacion", "iCodAnotacion", "iEstadoMov", "vDesMovAnotacion", "dFechaMov", "vUsuarioReg", "iCodRolUsuarioReg", "vUsuarioDerivar", "iCodRolUsuarioDerivar", "dFechaAccion", "bActivo") FROM stdin;
    renlim          admin    false    261   X      �          0    50393    MOVIMIENTO_SOLICITUD 
   TABLE DATA           �   COPY renlim."MOVIMIENTO_SOLICITUD" ("iCodMovSolicitud", "iCodSolicitud", "vDesMovSolicitud", "dFechaMov", "vUsuarioReg", "iCodRolUsuarioReg", "vUsuarioDerivar", "iCodRolUsuarioDerivar", "iEstadoMov", "dFechaAccion", "bActivo") FROM stdin;
    renlim          admin    false    263   ,Y      �          0    50399    NORMA 
   TABLE DATA           �   COPY renlim."NORMA" ("iCodNorma", "vNumero", "dFecha", "vArchivo", "vUsuarioReg", "vUsuarioMod", "dFechaReg", "dFechaMod", "iTipo", "bActivo") FROM stdin;
    renlim          admin    false    265   j\      �          0    50406    PARTABLA 
   TABLE DATA           �   COPY renlim."PARTABLA" ("IdTabla", "Descripcion", "Abreviado", "Valor1", "Valor2", "Valor3", "Indicador1", "Indicador2", "Indicador3", "Orden", "Grupo", "Estado", "SeMuestra", "GrupoSuperior") FROM stdin;
    renlim          admin    false    266   �^      �          0    50412 	   SOLICITUD 
   TABLE DATA           4  COPY renlim."SOLICITUD" ("iCodSolicitud", "dFechaRecepcion", "vNumSGD", "vDesSolicitud", "bFavorable", "dFechaFinalizado", "iCodTipProceso", "dFechaReg", "dFechaMod", "vUsuarioReg", "bActivo", "iEstado", "vUsuarioMod", "vInforme", "vInformeFirmado", "vNumInformeFirmado", "dFechaInformeFirmado") FROM stdin;
    renlim          admin    false    268   
d      �           0    0    sec_asiento_circunscripcion    SEQUENCE SET     I   SELECT pg_catalog.setval('renac.sec_asiento_circunscripcion', 36, true);
          renac          postgres    false    226            �           0    0    sec_asiento_modificacion    SEQUENCE SET     F   SELECT pg_catalog.setval('renac.sec_asiento_modificacion', 74, true);
          renac          postgres    false    216            �           0    0 "   sec_circunscripcion_origen_destino    SEQUENCE SET     P   SELECT pg_catalog.setval('renac.sec_circunscripcion_origen_destino', 77, true);
          renac          postgres    false    218            �           0    0    sec_derivacion_renac    SEQUENCE SET     B   SELECT pg_catalog.setval('renac.sec_derivacion_renac', 56, true);
          renac          postgres    false    228            �           0    0    sec_documento_derivacion    SEQUENCE SET     F   SELECT pg_catalog.setval('renac.sec_documento_derivacion', 43, true);
          renac          postgres    false    230            �           0    0    sec_informe_derivacion    SEQUENCE SET     D   SELECT pg_catalog.setval('renac.sec_informe_derivacion', 74, true);
          renac          postgres    false    232            �           0    0    sec_informe_renac    SEQUENCE SET     ?   SELECT pg_catalog.setval('renac.sec_informe_renac', 31, true);
          renac          postgres    false    234            �           0    0    sec_parametricas_renac    SEQUENCE SET     D   SELECT pg_catalog.setval('renac.sec_parametricas_renac', 16, true);
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
       renac            postgres    false    227            �           2606    50422 ,   ASIENTO_MODIFICACION PK_ASIENTO_MODIFICACION 
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
       renac          postgres    false    3483    227    217            �           2606    50479 9   CIRCUNSCRIPCION_ORIGEN_DESTINO FK_ASIENTO_CIRCUNSCRIPCION    FK CONSTRAINT     �   ALTER TABLE ONLY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO"
    ADD CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION" FOREIGN KEY ("idAsientoCircunscripcion") REFERENCES renac."ASIENTO_CIRCUNSCRIPCION"("idAsientoCircunscripcion");
 f   ALTER TABLE ONLY renac."CIRCUNSCRIPCION_ORIGEN_DESTINO" DROP CONSTRAINT "FK_ASIENTO_CIRCUNSCRIPCION";
       renac          postgres    false    3483    219    227            �           2606    50484 &   INFORME_DERIVACION FK_DERIVACION_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."INFORME_DERIVACION"
    ADD CONSTRAINT "FK_DERIVACION_RENAC" FOREIGN KEY ("idDerivacionRenac") REFERENCES renac."DERIVACION_RENAC"("idDerivacionRenac");
 S   ALTER TABLE ONLY renac."INFORME_DERIVACION" DROP CONSTRAINT "FK_DERIVACION_RENAC";
       renac          postgres    false    229    233    3485            �           2606    50489 (   DOCUMENTO_DERIVACION FK_DERIVACION_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION"
    ADD CONSTRAINT "FK_DERIVACION_RENAC" FOREIGN KEY ("idDerivacionRenac") REFERENCES renac."DERIVACION_RENAC"("idDerivacionRenac");
 U   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION" DROP CONSTRAINT "FK_DERIVACION_RENAC";
       renac          postgres    false    3485    231    229            �           2606    50494 "   INFORME_RENAC FK_ESTADO_DERIVACION    FK CONSTRAINT     �   ALTER TABLE ONLY renac."INFORME_RENAC"
    ADD CONSTRAINT "FK_ESTADO_DERIVACION" FOREIGN KEY ("idEstadoDerivacion") REFERENCES renac."PARAMETRICAS_RENAC"("idParametricasRenac");
 O   ALTER TABLE ONLY renac."INFORME_RENAC" DROP CONSTRAINT "FK_ESTADO_DERIVACION";
       renac          postgres    false    237    235    3493            �           2606    50499 (   ASIENTO_CIRCUNSCRIPCION FK_INFORME_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION"
    ADD CONSTRAINT "FK_INFORME_RENAC" FOREIGN KEY ("idInformeRenac") REFERENCES renac."INFORME_RENAC"("idInformeRenac");
 U   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION" DROP CONSTRAINT "FK_INFORME_RENAC";
       renac          postgres    false    227    3491    235            �           2606    50504 #   INFORME_DERIVACION FK_INFORME_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."INFORME_DERIVACION"
    ADD CONSTRAINT "FK_INFORME_RENAC" FOREIGN KEY ("idInformeRenac") REFERENCES renac."INFORME_RENAC"("idInformeRenac");
 P   ALTER TABLE ONLY renac."INFORME_DERIVACION" DROP CONSTRAINT "FK_INFORME_RENAC";
       renac          postgres    false    233    3491    235            �           2606    50509 '   ASIENTO_CIRCUNSCRIPCION FK_TIPO_ASIENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION"
    ADD CONSTRAINT "FK_TIPO_ASIENTO" FOREIGN KEY ("idTipoAsiento") REFERENCES renac."TIPO_ASIENTO"("idTipoAsiento");
 T   ALTER TABLE ONLY renac."ASIENTO_CIRCUNSCRIPCION" DROP CONSTRAINT "FK_TIPO_ASIENTO";
       renac          postgres    false    221    3479    227            �           2606    50514 ,   DOCUMENTO_DERIVACION FK_TIPO_DOCUMENTO_RENAC    FK CONSTRAINT     �   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION"
    ADD CONSTRAINT "FK_TIPO_DOCUMENTO_RENAC" FOREIGN KEY ("idTipoDocumentoRenac") REFERENCES renac."TIPO_DOCUMENTO_RENAC"("idTipoDocumentoRenac");
 Y   ALTER TABLE ONLY renac."DOCUMENTO_DERIVACION" DROP CONSTRAINT "FK_TIPO_DOCUMENTO_RENAC";
       renac          postgres    false    239    231    3495            �           2606    50519 1   ASIENTO_MODIFICACION FK_TIPO_MODIFICACION_ASIENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION"
    ADD CONSTRAINT "FK_TIPO_MODIFICACION_ASIENTO" FOREIGN KEY ("idTipoModificacionAsiento") REFERENCES renac."TIPO_MODIFICACION_ASIENTO"("idTipoModificacionAsiento");
 ^   ALTER TABLE ONLY renac."ASIENTO_MODIFICACION" DROP CONSTRAINT "FK_TIPO_MODIFICACION_ASIENTO";
       renac          postgres    false    3481    217    223            �           2606    50524 &   ACUERDO_ANOTACION FK_ACUERDO_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ACUERDO_ANOTACION"
    ADD CONSTRAINT "FK_ACUERDO_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 T   ALTER TABLE ONLY renlim."ACUERDO_ANOTACION" DROP CONSTRAINT "FK_ACUERDO_ANOTACION";
       renlim          admin    false    3499    243    241            �           2606    50529     ANOTACION FK_ANOTACION_SOLICITUD    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ANOTACION"
    ADD CONSTRAINT "FK_ANOTACION_SOLICITUD" FOREIGN KEY ("iCodSolicitud") REFERENCES renlim."SOLICITUD"("iCodSolicitud");
 N   ALTER TABLE ONLY renlim."ANOTACION" DROP CONSTRAINT "FK_ANOTACION_SOLICITUD";
       renlim          admin    false    3528    268    243            �           2606    50534 *   ASIENTO_LIMITE FK_ASIENTO_LIMITE_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_ASIENTO_LIMITE_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 X   ALTER TABLE ONLY renlim."ASIENTO_LIMITE" DROP CONSTRAINT "FK_ASIENTO_LIMITE_ANOTACION";
       renlim          admin    false    3499    245    243            �           2606    50539 '   ASIENTO_LIMITE FK_ASIENTO_LIMITE_LIMITE    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_ASIENTO_LIMITE_LIMITE" FOREIGN KEY ("iCodLimite") REFERENCES renlim."LIMITE"("iCodLimite");
 U   ALTER TABLE ONLY renlim."ASIENTO_LIMITE" DROP CONSTRAINT "FK_ASIENTO_LIMITE_LIMITE";
       renlim          admin    false    253    245    3513            �           2606    50544 4   DOCUMENTO_ASIENTO_LIMITE FK_DOCUMENTO_ASIENTO_LIMITE    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE" FOREIGN KEY ("iCodAsiento") REFERENCES renlim."ASIENTO_LIMITE"("iCodAsiento");
 b   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE" DROP CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE";
       renlim          admin    false    245    250    3502            �           2606    50549 C   DOCUMENTO_ASIENTO_LIMITE FK_DOCUMENTO_ASIENTO_LIMITE_TIPO_DOCUMENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE"
    ADD CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE_TIPO_DOCUMENTO" FOREIGN KEY ("iCodTipDocumento") REFERENCES renlim."PARTABLA"("IdTabla");
 q   ALTER TABLE ONLY renlim."DOCUMENTO_ASIENTO_LIMITE" DROP CONSTRAINT "FK_DOCUMENTO_ASIENTO_LIMITE_TIPO_DOCUMENTO";
       renlim          admin    false    250    3526    266            �           2606    50554 4   DOCUMENTO_SOLICITUD FK_DOCUMENTO_SOLICITUD_SOLICITUD    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD"
    ADD CONSTRAINT "FK_DOCUMENTO_SOLICITUD_SOLICITUD" FOREIGN KEY ("iCodSolicitud") REFERENCES renlim."SOLICITUD"("iCodSolicitud");
 b   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD" DROP CONSTRAINT "FK_DOCUMENTO_SOLICITUD_SOLICITUD";
       renlim          admin    false    268    3528    252            �           2606    50559 9   DOCUMENTO_SOLICITUD FK_DOCUMENTO_SOLICITUD_TIPO_DOCUMENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD"
    ADD CONSTRAINT "FK_DOCUMENTO_SOLICITUD_TIPO_DOCUMENTO" FOREIGN KEY ("iCodTipDocumento") REFERENCES renlim."PARTABLA"("IdTabla");
 g   ALTER TABLE ONLY renlim."DOCUMENTO_SOLICITUD" DROP CONSTRAINT "FK_DOCUMENTO_SOLICITUD_TIPO_DOCUMENTO";
       renlim          admin    false    252    266    3526            �           2606    50564 .   DOCUMENTO_ANOTACION FK_DOC_ANOTACION_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION"
    ADD CONSTRAINT "FK_DOC_ANOTACION_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 \   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION" DROP CONSTRAINT "FK_DOC_ANOTACION_ANOTACION";
       renlim          admin    false    248    243    3499            �           2606    50569 3   DOCUMENTO_ANOTACION FK_DOC_ANOTACION_TIPO_DOCUMENTO    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION"
    ADD CONSTRAINT "FK_DOC_ANOTACION_TIPO_DOCUMENTO" FOREIGN KEY ("iCodTipDocumento") REFERENCES renlim."PARTABLA"("IdTabla");
 a   ALTER TABLE ONLY renlim."DOCUMENTO_ANOTACION" DROP CONSTRAINT "FK_DOC_ANOTACION_TIPO_DOCUMENTO";
       renlim          admin    false    248    266    3526            �           2606    50574 !   LIMITE FK_LIMITE_CIRCUSCRIPCION_A    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."LIMITE"
    ADD CONSTRAINT "FK_LIMITE_CIRCUSCRIPCION_A" FOREIGN KEY ("iCodSuscripcionA") REFERENCES renlim."CIRCUNSCRIPCION"("iCodCircunscripcion");
 O   ALTER TABLE ONLY renlim."LIMITE" DROP CONSTRAINT "FK_LIMITE_CIRCUSCRIPCION_A";
       renlim          admin    false    253    246    3505            �           2606    50579    MEMORIA FK_MEMORIA_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA"
    ADD CONSTRAINT "FK_MEMORIA_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 J   ALTER TABLE ONLY renlim."MEMORIA" DROP CONSTRAINT "FK_MEMORIA_ANOTACION";
       renlim          admin    false    255    243    3499            �           2606    50584 *   MEMORIA_NORMALIZADA FK_MEMORIA_NORMALIZADA    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA"
    ADD CONSTRAINT "FK_MEMORIA_NORMALIZADA" FOREIGN KEY ("iCodMemoria") REFERENCES renlim."MEMORIA"("iCodMemoria");
 X   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA" DROP CONSTRAINT "FK_MEMORIA_NORMALIZADA";
       renlim          admin    false    259    3515    255            �           2606    50589 0   MEMORIA_DESCRIPTIVA FK_MEM_DESCRIPTIVA_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA_DESCRIPTIVA"
    ADD CONSTRAINT "FK_MEM_DESCRIPTIVA_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 ^   ALTER TABLE ONLY renlim."MEMORIA_DESCRIPTIVA" DROP CONSTRAINT "FK_MEM_DESCRIPTIVA_ANOTACION";
       renlim          admin    false    243    257    3499            �           2606    50594 0   MEMORIA_NORMALIZADA FK_MEM_NORMALIZADA_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA"
    ADD CONSTRAINT "FK_MEM_NORMALIZADA_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 ^   ALTER TABLE ONLY renlim."MEMORIA_NORMALIZADA" DROP CONSTRAINT "FK_MEM_NORMALIZADA_ANOTACION";
       renlim          admin    false    3499    259    243            �           2606    50599 /   MOVIMIENTO_ANOTACION FK_MOV_ANOTACION_ANOTACION    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MOVIMIENTO_ANOTACION"
    ADD CONSTRAINT "FK_MOV_ANOTACION_ANOTACION" FOREIGN KEY ("iCodAnotacion") REFERENCES renlim."ANOTACION"("iCodAnotacion");
 ]   ALTER TABLE ONLY renlim."MOVIMIENTO_ANOTACION" DROP CONSTRAINT "FK_MOV_ANOTACION_ANOTACION";
       renlim          admin    false    261    243    3499            �           2606    50604 /   MOVIMIENTO_SOLICITUD FK_MOV_SOLICITUD_SOLICITUD    FK CONSTRAINT     �   ALTER TABLE ONLY renlim."MOVIMIENTO_SOLICITUD"
    ADD CONSTRAINT "FK_MOV_SOLICITUD_SOLICITUD" FOREIGN KEY ("iCodSolicitud") REFERENCES renlim."SOLICITUD"("iCodSolicitud");
 ]   ALTER TABLE ONLY renlim."MOVIMIENTO_SOLICITUD" DROP CONSTRAINT "FK_MOV_SOLICITUD_SOLICITUD";
       renlim          admin    false    263    3528    268            �      x�3������ S �      z   J   x�s�O.�M�+�/�ϼ����TǼ������<������kp��cH���������������^AJW� a,�      {   U   x�s�O.�M�+�/���Ҥ���ԒĢ���`O��h@Q~ejrI�ojn~L����?X*��������������H� %�+F��� %t      }   v  x����r�0���z�F�ݕ@�F�2��ɡ�\h��$���>}W;�q/<��J|���T�Q ��a� ��ݯn��s{ľ����f{w��q;����G�n��`�R�PB�p6a" qI*e�(�(�	H�ؤ�&O�U�.��zU��1M�i^c�C�t$"��N++���0a,����vx��3���u:" A����eH"j�g�DZ�ғ��v�N�Zj�A�)�2��.A�k�s
�Bb� D���a�P�q�9��w߶{�e�����y�;�xڴ�&��ʄ�x����щ�=0!k�������m��h�p������߱�kgV*�W�$A�Y�	���7����Y!Ql����,F���q�E�Jx)������v��_�������ȡ�d̢��S�4�	$3Ԇ�y����N}ގ}��tl�s�/�_2w,f	��%#�[��xb&!_�N�K
וxZ�r-^$RG�Ԃ�nYM���Rp}�ڨ����'n��"��|-B*�죿N�is_�E�)�U�֫���<e�^��:Y!�Uy[gl/�]�i�9�De^�o���6o���K���U�7)�]Ue�׶�fN����3�o��x�)��A�a�z�K�      s   b  x���ݍ�0 �gg�.P�?f�N�1n�w'���EQm}�7҆�����H7�4�(ο#�7���݅f���2�1��d7��#/�x��Q��w��ͤ.��.k�G SG#F\�� � �����5Ó�,C.�A��*э8HB�*��F��د�e�5���� d�e_b>"���܉�Mhk*�+B.^�Z�s�,B/�$���� �B���e��<	����!e�=g���y��f�w$@��1�3���_��1�9�~��,ػ��#'�I������I��8��!e�1��#�nI�����]=f�:�cζ�~ѓ�Z`��^������۶}{�E�      u     x����n�0 ��~�
"��ۺ�
�݀^{�os�؅���G�M���P7�K��$E�AV<T9��7�l�N�B�Q�C����H�<��G���q�?���⮭v�y�97|/�ܥ}Y�bW�C��wܢ 5|�!宪�|����0Q�H(�!\�"AD�Jy��e����w��|-�Qo�t��{�i����w����z�q�F<�vRk,�"ꨭD�
�T�R*�r'I���:	i����BT�" _!z.��2$5���Kj�*�Aą�e7JE�����T����o	�j�:���|l'�z��n/Pn.!J��f�L��m�˼Mu4!���
�f@8͉q��V��<mӕ���>��3F�����Z�M�ʥ�]$/-9�`rC{�Ώ�=��|u}�s7�H���_�5���mj-Ef#I��&JGe�!�[�m��:��Pv�ym�U��y�8̪^��,Z�o4^w���x�ӄWr�̵�|%f���-Վ�R[B.��oxMV��3x�
n�k1:c��[�=��f�_��         �  x��W�n1<��b ����f��Eд^ǧ ����(�ml����q��hHɕ��HO6>��ry9-0�a�����<��������1a�/yA�c���{�	�7�pmoB������?^�H�8_r>�"Z8f���E�V��o�1�H��	��_o��4���o�y�EL���*�����
ڹLhb$��t�f�uՀp���G�̔M	R|X2�P%#��CF2d=tخ9�v�� �T5P�+�"�U"\�]�.�3䥨=��9:�j��(mh}iuJC�b�/�YW��j�cIX:ް੫T�����5h�L���]�h�Nį�1s,��b�.U"_|�.�/��4����0͇i����q�r���9�M,��U,˔RX�e�XF�H��fM�`�h��@%�A��"m�2.�:���jߖbK7K��@���%��PK�mOٲ��,����Q����e���K��t�&�K����^c�!�#6X�
�3Q�E�]V4mk�����|�G[�4�E#�پ-��Rf���M��{�hXڌ��K]���dk=�3m0�����<˭�f4mF�p��HdS�km�m�>�hl�]϶�2�Aw�7рK�k��cz�v��n��X����H5�~,����LHN2o������HP'�V""��:sWbũ%�"�-\�qlG��-Qs�D5�LR�^Yc�����j4�o�r�e�bu��Q��F���v�?���<      �   W  x����N�@@���$������!uA�J��*��Ri�E��wB!c�P��b�%���ChȜo����?���J_��O���fw�x�].?���7�ۿ��n{��߮VWW�{�-�� ��-~�2G���7�6́g �JBY�DdV_���>"3k��6��3p�!k���-D˃�x�F��M��0��ܱ>���C���$�V1$b�>��5&��D������ m�_C9�a�X
��� �֤鑔�`���+b�l��
F�=�����޺�ԋ�b�Q������Dr4����P���T�Иx�q7CH�b]�(e�@Δ��z�М؎���}s�$s_��l&n�͆�Oi������<$%!���`~��5LF�4�Eh�2KXH��OD4�$�OT������\�oή��D�Tuċ�������������!�%�ç�������|�"X`:���n�����v����vJ����v`P���j��ndr����Ǡ[xm�X�	;){�gC�h�OUD�o��Ƥ$8�:�{Q%��|
;M)Ʊu� ���|NJ�׬};MG;ն�qx���J�'%d��`5q0wXt��+����ם̍�j	we��'n]�U�J�U)i>֥t�_ ,4R�%,�B���JX������D~h�'�+`�O�����P�N�e��ٯ�2�l;���%?[�)�����b�t�?+���_^e��ڕ�~hx�����p����3����*zl�M=]p�]w`����0�."���e˓���e�n;�:�pR�p�M�HݮO���G�^a��`�OC��{�����
���I7���j�4�?�yx      �   	  x���ˍj1���
��o;)b*�2n���$��@ ��'�ǿ8.���w�@� =������z��^���E�IS4�|�K\��k��zh���<"]�����1�yFb[ZJ��iH�Ā���V߱k�Zu0�f[����Z��Cx5��=���N탸1.��Њ�)�}k�χd�a����e�k�
U�mM��� ���N�+Jř����au��vE�zh���&�l+��n:��\*�KK����p$'�r~�+J���x׹Q��1ǭ[ו9�AM�#̉�s�F}j�S���h�:J�s]r"}H/L'�\������\>ᛦ�<�Qw��v.���I��4�m�M����h���Ş_��S�\�.�K���c ~�ٴ��=�d�K��M��p$�$�o}[�{���vp�����(Sۀh��u��Q�@r��v�u(��Է,�9/��ͻf//�u(�֕��Yd',�]^�R��yҤ���J�y^;��|�YΛt�?�����:oLi��m������>&      �   �  x��V�j�@}���? 13;{}�-T+���%P��Cb����w$ז|M�I�� ��9sF
"�1�7�ґ�H��b��ve��ߏ��r�r+W>�_<?N��b9��-��f4,�/e����TpD���%O����e�uI� Ye�t	��aO�h��hd�6�����n6y��,'e���b��]<���z8��x��|�n�W�(/F����N{�6S�}�4M˒�M �#�?Ŕ���Q�o63�a�ϋ�����[���ʫњ�A�MMa�7+n�l0���鐉P��.����U�2��� �;s���@�X��&�H]����·�luVҁmb%�^չ��z� �W�/��J �v�%Pۣ�0B��P��@����<�G������w�� �ѕ��k�[��t�ًb�����B{�b�SxJ1|W1�AK��?�� ���F�`Wn�?Z2���L������Y�p��U!�5�gMU�s�A���5�W�ao���j=IUb���]U%�����A;�ԙ(����@7ա��� ,��6��ꄦ�hI{��֐4B��X���	lŔ�lZ1���W�v���#t���"��o����sL��i�X�{&ak�{ƍ�팃G�,�A�Cr��uT�P�?!�ߖEA�h��B�u&a%��I^W3]��`:Ȳ�j�E�����ze z�����Q�!}R-k|O-F~6EN�����]� ���;o�N��ʨ�n      �   �   x���O�  �3~
��P���Y[�jK�]i�������.զ�������C�����N4��F�g�t�b��1)b�1e�4_P�dg�>Ӊ��9�C�g:%A\�s��6�z��S�#�����F9a@ORhP�oeY���N���&L����3m�Y���#�,�_s��V7p9a�4f��\�
�E��M�g���tk��^����8�DQ� #^��      w   �   x�u�Kn�0D��)|�R$%m�nO���8��")Z���U�E��������\�i���խ�"�!�!b�TJ$l����ŭ��;~�O�!�� ��8^���i��*dϰOn��Vw�3� ���$���I�&W�@���������ͥ��f����%َ A�u�«ߦ;H����f��]���(,B��w���#)n�$���$I�=A��S��� ��[�      �   x   x�e�;�0��SpV������D��q�W)B�y�XJ=����Th��6�<�,�Cv�d1����A�V�mP����y"7M�H�&���=��5�c?�Z�]�.�1I�ݍ�W$�      y   �   x���Mj� ���^ ���'N�]��.gc�B&�s���)eRH�Ѝ��}O��N}�E�|�FF��]��!���������n	[��5Ȯo�R{�ȉ���ӽK�QRȋ�d��d��-��I��ϊ�"	K��=��?��n��}j�1�u\|�����U����Rc��)#�F����U��W[A`$�7lNk��q�>k��������J(E�"�WJ$+�)>�����/LC��      �   z  x����nA�s��@]Kos��8r �,'_z)�@���Ocb,�������bRhYi�@l��i����qX����i�_�Z��_�p:�Y]�p8�b�y<���>E�`�i��+�d,$���\�s����F �H؆��=s�ر6V��N��;ujq�|A�9m�a�8��+8k�B�l@&E�VG!T���Vnqd;1�y�V'�:t���vz����Mr��X�G¹�a]s)(���[ �mnm�;g���i��Ԑ��d��&�j�*U �R��C	3Q��tQh�
�%�^�g�6�۷ �зc���ރ�@!7��$�E��if.If[9��0h�k$�D�3��x�Yk>C>���o�v��\<O�b��X��      �   #  x��X�n��}f�bs�3{��7F��Q K���`Hm�(Prpҿ�hѷ>6?�=�,K�e�m*�n�����-�|<���ɘ���9r�ۧ|<�?���K��p�X6��eK>�������)[2�e�����^43R��ړ*��fޅE���_Rry;o�Y�~���#������FN��\��	���\��<#y�5��ѣ��o�N��my{f�v�v�1��˕o=�;�i���R3����Y`jQU6�Ϯ����\��8��OA 2�O�� �jc���e\� Fa�ޟ�,c�8�x��1���7��+��ƗW�e�O����2���(O>\���eT����rW8*�6��Z�;�z!�sL���g}V*5F����owl����]��e����.��{puI@gRdʥ�	��Q��LA���Q��}>!q�O�۹�2?O�\2c�)���3;���ssU���]2�0�)��uV2�b3J�:�K*��(x������UX�d�Y�`���FR���2�����2?��ם��;����5�-4���h��0�ؤ��7~���\5KG�esOz�\�"��
Pa�o*FyiD)*�U�v&d?�"fP�8���YwY���L&]j�d��N�*���uz���v��'�������d�_\�O>��O��������P�����z�����J�J/d�g )S����W�L���AVxY�јd��L�Y�}��#����Q�&}���4��~k��6�����TMɍ��X���xbC�a�ߒg�c�?��C��x�?��?��~���C���e�8V�chFk��7?J=����ؙQ��m�������y���qf�l��!�z���`ͻ��n��b�f�#�@�#�ۮ����>N�2�\P����QFp{�F �T���c����x2��P�ޟ"*�-�X�\��"O���×��{�\�z�R����j��Ri$Т֒�P:VI�P���~$LE��	�H*�-%_1��4G�b�f�kD5�6��:m�0+���;m;O(yr����������{�?����=�Ӧ�9���M�~���a�g-y��?�Ӱ��y;E/fhr�(q>Wn������w3����`�Y�_0��\!����g�.� ���#�#yq�ܔrk@�÷�F�@��i��&�'���A�%�Ɖa�(��}�KGG����k�,U����d}C���j���U+-
����:	~���|�������Fy׻�>��a��Gu�Gb>C�y�5�ѣPa�����1d�$��^*x"Ј0�.U륷�0�FUs��i���
wÓ�.�Lq���6���`��$_/BB�<j#2������8@��-�H��"RS���.BA����K$.蒗��r� ��Q�i�H9�Q����p�@~�j��3Z�6��N ��r��ۉU&�[t�A�bK�A�Z��]�6�D���c�њօ؂����5j5k�b�Py��Y�W�x�4�]]T�y��ִ�5����ҳ�f�]��R+��q�3v;� �Eh��0[*����M����������=J�s��BQ��Z�Bz�НJqS`��Bb�����n�8Y�*�
��@�n���^Vu�$:���>�|��ׅgԾ�d�X�1�a�������4���-����^����"�Up�Ji&��y�.����7F"@3�X���_� �\����;/�i��Y=	D�o�K�q����k!�(tL8����)��̽�ܱIU_�G�WB�g8?�̘D�f�bl���e	�8��+/۞ӏ�*��ri��r$�B�:h�U������uՓ�HA[`^��K�.Hpz2*�����C�ꨍF���9�e�����IA�w�EJR�9#��^��V'~��ث�An jxi�dC��A�v�����qG�	�V�g�#��A�-�yV����U��O\�)��F����-�ceg��6l��D]���Zq(vbX�9�M4ư	����&�m��ś�)^�h�P<�S�Ky��~M_�z�o7��      �     x�}�I��@D��)|78��;%�"A� N����ۃl�@�ƫR�"R����2������yx��XE1VY�j�Z*:�<;L���aY�A�5��@0�	�n5�?Ɵ_����<�;]qA'�c:��Q�֧i�=JiL%�#_�r����yaa]�WBe�%\pAz����Os��`���=R���Jh�ty�:�e[X��y�����@�GohM�� .�� >�*�����`	'�	,���/�[7U�?_��O������3u�EI��E�4$1�̞�
�����s^�w%y��~�r�GKq��q��'84�Mj��0��}N����qU}c��72�-��@m�=��D�]@P{&$M9"�v�/��D�mtV|�����F���S	3���Q���.´�����ؽ�\%ƦT�Y�n���J�:�+�s���W��y��w9�)"|��Y�z����1,'<%�IP�P�>�74r�S�W����u+ꉓ���_J*M����}�}��n�l�@�      �      x���[�㺒%��3
}��8m��?�b*�"���:
�a�	� �#�)'v�� �n3-��*OZ��������P���M��J��1S鱮�4S�˦������U�=��/�w��;�I����e����*;�������T4t?HU��&9��T�nj���_U�޶�ۆ��7Z��Y�:Z���kO�����u��f������N��m�~L�B{�:�.3���y�����`4�z���0lz9��em�-��p?�������jՑ>oI�ؽ��}@��>��3A��X��=�O1�H?i���o��F?�ז>&�q���l�8Q�ܓr��Xe����8�)�_�۱%5�X[���m���p9I�o�]�[�4ݯ!\�'�R}�7m	���c�sx�菘�R�ʺ힋�jHXfݎ����6\7��IL�����/IdyK������_�?pBD���a��A��䍿l������G{h��2�P�m�6��"��d\��#�閛n#��^�a���Fm�X�m�pZ�Qݷ�Y
�J�Df�l��8X��>�Ӂ4�4��
�{��N�l�m7������_#�δ��A������Aݦ��(�d�C�w&��0��CR�/#eG���;�\Fw�������g�r�W�ʔ&��^,Y.V}�i���
 �Pۉ�%��H�k�v�����S�2�;km��Y!ܰs>� pt9�E[��5�'͓o����hrt�~�y���L.I����nЛ�� G���",��Jc�Qғ�Q��֓8D+}Po�	����曤��6�E�6�O��+@��G?�Rl�HԬ��en�s.[E�!����,,Sd M���}�?��}��U�K����S���b�ŢR��-�k �����Ϋ����T��,E���8�דn���	��}'�d)��z����|̖#�1ͱ��i�'4�ԕ�9�镬7n���1��(��_pJ�M{�ї�'<��^6䯐/��������(A��](Zk��[ Z�n�QGQ�C��� y�p^��)"G�p�����W?'o-���'@�&?�I8ZZCw��!�^}�y�<4`�5��Y_Z���f���7�~�%Ĭ���릝�h�:����煬��kNr�"�R��M���R��v1�鈷���Ȋ�ӗ���a��4�[׆v4�s��jR.�pe=�d�8ܰu��6rd&��w+�+����HX;�8(Rh���=v��&�F�o@6��';/�*< R�ԜԹ�7��jD,H�Ozy���䆷�~������q�?&2�5�ka��	i�����H�l��]r=#�+X�t�F7{D��Pc띠1|^���gr�K3b�������r^���%�Zc�Y��%&��~X��E���BE��������gc�u_B�쒃>�����t��$Z���l�~Ϟ%�!�,U���hW	����.�sD�,��?!iR?��n��m��� �=��#ʷL�d��w��4amx��ʺ3_��p:G;6�ES6��l�����\E\]���Ӵ_��vه<O���Y�����S �g\ҴRs�m;��m�4�%b���D�����:�t]ّ�i?O��H���(Kؕ����v�B2�v Ԭ
��k�����R@l�\��AX�f��FN�^�i�b@z���J���w+AH��Z�e��H�f��49�>9䡒|pǗ��V��\rB�K��_�a�Y�!�P~T�p藁v;�/�\��i�ph���?��t9�_���_���oXΏ�{���ʹ@x�'�(�9\��Υ��&YrfY"k���Ԧ�k X����K���|�F _�8�|��Y�Z�Uz�jO��2�\���4O��w� Pd��1����/W����Uȑ���H�M��[�^! 'E)������Q�)+*�K�5<�Yc1���~��k?ZQ� P�U74�W?����\Ӆ����hG��	����HKn7�����II��g8T��� ��s�hZr)�۰+^A>h�VR���Ɣl�u�h�?-k�	�#H�	`ӑ"[8g���h�Jb�7?h��8Ѿ�� ��c�h�{��8��: ��XF�nc�%S�s�uNnDօ����wI������^���F�k?w�9Z�(���y�l9iJ���#X�|&�;|���Zre�[���]��|���*��;�.�����g�G�)�o0s#ؾ��ߚl������n-t�IF�s����?������1I�J_��bl)z>�m�Y��F"���v4m�l�}_��+v�XȞYR�+�H��(?�"|K���០������Q��_ aّ�G�3����gG����]��z]�e�TiQ�?{,��u�.���z�:�~i��`��۽�4�oz�~	�ozh?|�94n��ͩ���5+uj��ֲt��
9�Z��0��x��~|i�p�R$4d�%G�n�6<��q
y��i9��~��M&R=�\��0򚑚��Ӻ��gn�-�)${]�e���?|����,)����d�~��#u:Oڷ�� W����Nr�`�����I��H����]�ן�,���M�s��4Ss;�훞��'E?���Q K��s�Q�q�/76H��{��]�wih��~�o���O����M�6�2ݹ�\/��~^"�0;>�ǋ$8c�v�ܰ	zMI�-�N�:Ą��u�����:�> ��@��
|(@w��Sw��(�d%�M�~ɐ��0�x���t)�f�j�����F�%�8���y�������$i(�@pr	s�e��uh��������˟�����,�Θm���/�{�&�U�����( �����ܳ�D��Or�.��b�L��C�
T�gy#9$��(@���a@�I����ݲc����%/:�b�:�F��K`�-Y�?^W'�*���0m2�'#G�K�[1lK�(�L�N8��&�"١���~��wH8}����LҿҶ��Ę�~ÛT���"8a�]\���S+Q��\�V:����e�X��k��@�`�p�0g��]"�z�K��Ɲ4]ۋ����l��0(�L鸣8������i�/pQ+	�iv�AM6�@�{=-Sw���]?p�h%\�,�Sp5IV���� ��*=I�z���G9?�a���V%Y�}rsͶK��o,�p�f;�&�I�ʴ���N�i¸l��ͩ��+oA���&���4s�]�?A�����+��ci�U\�U�]�MV��7�i�:9��$�s��a��n�e��!���Ͼ9~[��F���e�^j�K�οnV�	�j�ﰾ�Y���M��?Տ�!�P�v�Kk�F��4����gм���>�R4��jC��g}���e����b��"?>�������]��5�C�
3��Xo�+��	s���,{��u� �$1�!5�Y��ol�aW���D����oAS���/�4G������6��[���u�TJ��#K�n@7o�RW6	�C7�G2��Ĕ�I���*a�um���hg�iL���G&��>q%�HO�&���0oqr�kC�WhZ1/�O<�K�|y�.òrVy��{��Z�Ye![��� �I�>�?��%�I��kw��TZ
��X��Y@S����<ͤE�E�S�����ƍ�K׏�]��������u�J�r�=6��橸�Q��A3��y�c�@�dNv�t�{^3 \Y���'ܾ<������{��<����V��s��n��Y�<� Krs���,7Ih�<B�l��ue�ܙ�IME�O�8�z\��uv<�tr&k?IY:e�K���<O��ѓS��/.5���m���`�+��28�J8X.�lF87X���2��}
���v�b������޽(	�"�9_4u�o��Y�<��q�Q�%���~��ꑙ~$1�����@�K����V�B�}�`����G9���M�{���j��ٷ��Yٶ�]�S�J��[9�����k!9��q�ƍ��j��8=!��g�����.,���e�=����������9�PB[����Ly����U#nf@	��bF����g�3�h�2	I��ǔ
    �Tt���pr�Q�t�c�k��~J��[ ��nz�2�d�)/n��=�k$�«����^4�I��"�����\0֗�p�J��k�|�NϹ�ȀB�j�5���Ƌ�������U�|��^�1������I+�E��X�������n������49ݠFy1�:S�Zg'�
.�4W-��G�d�P^w� *�ŗ�5�o�����דc������;
VcZQ�$ș�7G��A]7�������ј0+K�.SdQto�C�����p^m�nG,`��A,�D�2%�WR��.�����R��^c{�����82��4�������Gp��8&�T׳&���������f�P�g ����l��Ø�n1��@�vA�\�F�	 ���J�j�/�8b�'�K[�@"ߨQ��֕U;�D6���o��&�z}���}�3tlC�/�d�xBN��B�\�e��ER�a��'�B�~
ii��th6��Ə¼�I�5�{�c-��y<���$��<���s@f�"ez����VA��cG�<w�x��u�0��'�*0S���y�RE��SO''�8ޥ �%}$明���NlG���nҾȀg�ۭɻ^#Y)Rp,7M���h��H墐�s�L��M�Y�͓1�W����r��o$)_r��`	C�e^D����6
z �g�y��2�z��s��0`i�	��4록��"�����v�9&����Zd59�`xJ�H]O��t��m�iY?�o�,�KX�߶餾�ζᅥ�8^�]Ep�y���B�0��r��C_�;?��-<Q_�7F/�Ό�uIE�/�#/�M�����^����T����{�b�,\3��h�E�,����>P_W��A���`C�9������R���~h;��6VQ����LC[.;4Z�_p�=��m]�*�\}1CwYZ��v[�, ��LO%Y�{ce_��tWߦ�W����o�?e�>�yv�h� �|8$ģ=�^��
�~'/�x����d)l�l�Fؤ@�_�j�!�.O�g�+Lw�k\�}�_�
���L�n�É~��kK�m�	�\Gs��Q���58�؞cl:W�4�[��� T��;�\.;�E��J���Ĭ��.�wB��(CO��n�o�"P�!���ao�>J{g�K#ۖs`�X�D=q�Ա)�.�?E��L��'�o|��G��	��B]��sG^hX���2�ÕI]���_���3�£�B������֢9
C9y-�`"��|7�Wȉ�ú�s�� *SZ�+�a��m����m���.R�e�t�Su���)�l�澛ξ#�R��_���E�^Z������}{�N��aK���f��`�n���
�zڵT��*����͆��^��3��zc�3��K�ߧmǡNry,U?hr���6����:#������ȃx�����_��Lcn��`��4Ӝ�q�|�ȝ���	��ue��E �.��dJ�����y03/-����������j����?�5��4.���+"�U�?���z=�P򿞀�=p����=���ȕ)L���z��S�����iЯ��X�}�8��L]x&���
�������Lsz��ǘ�a`�_; �J�a��i>�ci�N�<�17x]����d�9]8tͽ/k��2h�]I��T�,C���m�ӟ�Z��C?'���=\'{P�e�����k��9�A��Nn��G'o�a]�~8~f�mg۽��d�����S%w�k�i�l�C4J����&�r���17t#������-���%=i��<�y՟��ι��ʵ�t�����d�c�d�T�Z��{A�27�"b̉(�B��?L1F�J�Q�c����_�G\-z��Q��i�����>I��.��*�����D����<C$²2�=��B1;�Ua��w⟡���BV�g1;$�8V�y�=� ��8��0p̌gr��:]���˼o	<��LH�2	�:�B�+<�n fe�tt��q��Ӟ��[`��ٴ9wh$8\�h��'��=�zfZ~����Y�ݔY FW6�ޯd�Z�88(���&��,3��!�����u7���XA�R�����4]�}.dPa7�md��<�~mp��ʄ GnQ.�)�Z���H�Z��z�W'	��W����5�c��-�(��#M0�٨3�N3מv��8}��r���f/�$wd��ѝs���l�~�C�������`�!YW�����,%C���KINos��H8�樆����?��x��0P���N�ᰜ�����i�h�K��^��ߛ��5V w�)�T�p������`a��N��\��B���ge���pyl'�J���r�͈������v�k�ē�&.����P��H�zX�:f����c���H~�4:��q��^K�����K�q�J-������X;e>�%���
UG��(eG�PZ����6t���-�*����TΈ�$R��ݴw�K�!+�w_�Ck�����'�Jޚ[���Y?�ca]���/[���,��E��1y+k���w�?���V�Y(�b܂4�Tam��%0޵�2䋦\���G������N0o�=�H��_������~�F��o�l滇�|����Gx��Zz��lptt�6^���E#��r�z�����]/�>d��E J����`� ��EPE�g�n`�f;��Zc-C#XefZj�dD��Ҥ���v���5�������('_��l�.�`%j��\+<�U�z�OO�g��؉���~i�{U��������
��=��|h���˧s@A����Ϛ�p��a+���ku����,B��p���(�d�4�����ɂ��rJy��(�"��b���zƭzL����V��z7	�_A�K
`%�B�_"ՓA6|)�Z�Jz���bW݄�Q���y��l�ݢ#��L��;�KU���L�Vf����Ҿb-.�+*e.�3K�GN����dB�,T2�"i�%U2��\r�~P����2�5צ| ��Fѓ4]�~�k^�;UM�x��6g0hh)��G;D@Kɴ���{n���mW��U�\�&�=�å-z��H�5�@GIU���	[$@I�}�����Cҹ�SЁY��ws�Vx�rE�Z*��V(p\�i�$�s�Kz'R�h)L��#z�($����X���(���v�k�Z&�ރ�Vtp��:���!�䭬iT��dM	0�h&+}�΄3C9�FbbW��X�,�k���j��f�ݢ�������} 3����0i�h��S�&k_�,���m7�ֆ��7�+�����(�oT�Н��<��H���<u�D�~��4;sbk���Tqf{y�_?��~mxl��
C��ETs���D�p��o.a|b��^��*�"�D	ȳ�7_] �>6j��>�D����������櫼�E� �n�Ǟ��ꄙ#��~_k�=�3O����\b��]$���x�`�)�׍�:�bD귡"̳���n�A�V|��r�ws��J\�����[��d�i�U	�7!��Qo}��·��y5��<���29Y���u8��y�@��!��nj.��Q���n�%��!&�Z1�?P�ԟ�;p��л�@�x��J,�Q��6DtL1���aX[v�
�]��e�D1�sx3@��d	����=9�jʾ�'=�;�:0�d��=D�
���@B� jý���G:��[ƅo���څ�H���Q�&��!���u.�|�8��5َ�-�ه��L���Ё�C�����s�� `�|b�؄�)�s|��t��ȹ��<���I�+�1;D2��²��F��~4���E�����Q�`�Q�Zg�HX[���y2��U��T��"a�aCsP�:%�84W���mZ}�P%s���=�f��'��ٽȧ����'x�n��{����������h��m0]6�^��R�lk��s�Z)�"c])�wo��SɅ�����*';����QA,�WϞ��/�9_�8�ˀ�PreQ��Jd������ KC%�7��#��}�r�Gt�� ��!$    [׾��&/�br<gH7,����<\޶(����ԟ��n�;�
����c�py&���3��u�V��'��gJ��>���K9cm����_� ng�HD�N*U����,�\�P9�߁:Wb`�ˍ���=\�3��bW�q�}��������|�J�<��j-͊�gp��	�)��OR�ϬI`�$c;	���aZ�x��1/#s���'�ə���m�'�)���yP }�qi���&"]z��lo�a��NgD̑�[�gm7y�p���K�z����h\V�l��>��1Q�BW��`2��e;�-����&���*H|����i�n��by��*T��vD�(�6���کZ��[��<���ŭ��0�~��6Ssl8ZF��ۓ�A����[\FB�1���;���(Љ�Ԡbo��=�/�LM�����/��C��~�uߨd���T�MR)rN;��Vm�iќ"X�M½8��dP`Y�Ql�mW�\N�ͬ��&M��a�[d��!�F��&͟����V�����B��}��R�� <S)7f�\W���&����N�������g�-�f��XB�Ef��7����6Kͨ���+pE͸g�+�Q�V��[�u�[	�Uzu|��3�<q�3���w�+��>�t����"���D�=eZ���~���*a(��yͤv{� <�y0|��l�+�t�w:p}y�37z<�� ��H+�� N�棞�(����ߋ�zT�λwY��%0�6ʠa6�׍ |�6�"v���hZ����ɖ�,��%u��5G�W.��7�����D�/n��Y�����}�QJEIN~��USHiR�_�_Ŝ����62�u��ay-%�t�;cе�B#�ˑu��� ����8��L	��A�o;[Pmen�t�(L1~`���ج��,���t�'��Q9e,,yv�� <z���dHSr�a�0Ԇ�Y�N� jXV��������E�����Pq�a\w<p�t,ݓ�3 f䑆�f�ոU�:���+)��v\q�~v�h卿�:��Q5��PSr��Ӡ�)�4�R�4��= \�I���$ 8����f	&��g��K �~sf$�t|f毹�m�Úއ[��
@ο�h�w�(L��љ�#�4����<S�un�
C5� Q���&eg��J���~kp}8����%��;�b��TX�/�������TZm�h��{TLa��lQ�[.�`�;~p�	3h?Ȧ�<)�[,2���lj������̟�)�V��~ٖ�[ߎr���+V�/n�3@+�"�~G$_c�I7?x\��]���1Xd��?&�Q�������[��.B�"�[���G%�!ƻY|>� t�f`m;��z]��۴P }�2/��g(�²�2�}��%��"�Q��/�;�@gwz#��ӄ}y*�t��wU��{?��=�b�,�t��� r3?~��P%G���)X[���VV6������5�V�?�;F�;�܏�_�z���A�3z=H�o>�2t�2��p�>�ox��Я�Lq8S.�4~]2�.[?��*��nw
	�Td`��`�+O�2�Y����߄s'L��sE ͐q�a�e��A<x�3w��L|����$ʸ�8�Jɿ���'�$G��^��&�G`n"�ygA���7��:�m�e�������:2����-l�Jڝ/t����{���kie�"U��ȏ��1���ղ�^�w�}�d	kC{�;$��ô��%�t�F}�sd���j3&�O�Aza����U��0�=*ef������ӻ�)��#�&����#� 5PJӐ��R�u�v㜠��L/0�p$���������G�ipx�a#��'�f�'��V�s���nvtx�Q+�ߊ�Ujׇ�o������F	q�w&�ǉm'K�듊-�m���:�χCe��:������(�.T�47��e�	� BUxcO����C�Lܽ�E:���*%�;�����5�O���'��&����%+��\y�u����$|Tl��sןc�e�R:��4ƀ˥	�Y�rY$�y�G��8�M�ۿ����KC��t1lźV^5,X�0�z�j'�/6'r���������6�W?���M�f�:��$7�ċ�2�ѽ98.M��ʮgյІ%���;A�RN�+-}����Hz���g�FHK6��Ul�_t4+�FH�%f:��{mX��?��3���0}��Tg������-�Y1�$��ݸL{�o�1��\��R��hH�|G3��Im$����gx�"��7��&Gsu�IC}�*��(��_Yb�-'�
@ڦ�������g�C�_�a�ަ?����$a�2Vz�D�%��Œ���@R:��Q�㙘Qч��_�e"	���n7�yJ$~�������>�I$!μ���]��	-0�?ݸ��������fY{�m��7���������J)csXa/��lN|<iӀ���X��=[�Bᒇ$mԠɞݱO"�NvT����!�D]9{���9�,�m��6�q�U���,W���5�:N2S45� ����)����Yq���bG��i���BlL���0ԥ��G�<1X�I� gP� ��<}$��a�Gp���%&
��W�w��U{1�΋�r�uG
�Eꞓ�tq^����i��Z�G�L����j�J��a%@X5!���T��Y� ��)n6�����k��7i�9`�L�?����8�t�׍~��Yd���.d���7V�x���y���ŀ�߹�������2��S9=���8b�-Ѥ�0�;Q>XjJ�.�}b�J����7�r&L�1L�2W�۬W�ZyP����%d��x��~�:�}p[�F���s�A`���R \��rr�;T̍��*Ό�ַ=� "��+��"������AB����9���r&l�G*��}��{	p~�+�}���ŀc�H�߄V����R��B
#dqI��ӸnvH�S��4L]A�bR�~�P<���G��SP!a����|�j�(��P7����$"�5��\��9�-��­5]��,s�[����j���~\��(����@u�4Gzҹ+B�2i$��Q
D��Tͤ������5F����pW��(��<v�F�QLLn���#	b4�Ѓ����?���@�$=��e�H�c�X%ݔ�eP��F]��]���	�����%�� gv�1Yct�;�V|�ߎm�8�'zD�E�)�U�l����G-�ʔ 8�>�3���GX�4Q_"�Vt�Ǡ�����Ci+^[���&�t�,y|��������q���:-�n��{��J���~�V
�X�{���Ro��ju&(r��E���3�v��7��޸�?�: ���"\I���uul���o�z\-�W˦o���J�zC�ᾴ4͹*���u��呦2�B�¢���D��p��ẅ4��i��lG������E��o�ޡ�(=��nq��dɮ��������k"}��.������ņ1� ��ŀ*��4�J���"�G���(yR�k�+�Q�!.�h�T7&��;p�\�c/?����ѽ�]HBO1O��V�Ø���|��*���<{Dƺ�I7��̿\��H^�HI�R�d��5��;���>�m�t�6a�t���=��!@��Z�>"���XC��Ք��e�n��c？�]�%��w8�#�-7�����,��6��X��L]��=��<F'f*��c��r�.�6w6�Vr����GV�|���aI�����#e��<ڹ��2�#���|�Ҕ$�g%�@9EZ�jGw�/�Rn�( �y���.d�Ǘv/,�Ŵ\���$�4�zA��v���r�i����#��A.��u�έP��v�l��Z��Q_�B�!9�7ц��AX~��G=��"s�s�D�jN˙��j Fb-�ۨ'_�!�y*���b]��ԙ���ώ�����Yĕ�sS��V��N
8�R���b��~|���ە!�׃�����l��r��CD����=���q�Z
��9q�os��֊
�!�ƴaDp�a9h/۲�1Fj�a�'N8�����:i� ��p    ��=q���|�V�SHe�4G�+˸w�	�@�䑇q��xn,3.v��nG'� ��m�bce�Xbi^��;����~76���=�?<Y�I6�[���1���1���>B�+KG:���fI�a�� yb����Fx3�+K�{إ �33$��?�J����D٨��4Ҏ���7�$`m�j�0�w���SY��OM��%�\�� z�ӭ{�VL�,��	e)�(ϛ�*��9��N,S� C0c�qf/��m�y��Ξ*.t�-=�����GZ�P�/Y+�wv�jL&�+na���a�,��$��Ո\p/5yZݴ�81�
������6�>�#��+ ��Y�K���8�d��͙�-���L���7X�1_.�E�2<�E\���I�E2�C�6�2�'�����Qd9�_���ȟ��7��G��2��ə�%넶�)��N��:,�
��O����W������T���ЁJBh섷����`����ػܞht[��p�[�U��u���:?�K����&V�?4�h���e*�%�);�TcbN V\�J9�ݤa��ܹ"3d�nH���Y�D񨊘��#@;-�}�� (v�/�V~a�5' �n�ר/z���Mf����3��8f�r�M��Ύ�iyw�Tѫ��9�W�g;�?�eN�����:�,�lTK+����Fn~Y�>_�8�r�iVr�`�������\�����]`Vp�z���ڐOZ%�0��H���?"�\�SC-S����f�����k�8�H�	y�������n�>eb��Xp�څ�������$S��J�pN	��H���v��c#�meZ�æ1�Ö�\gV(,�2{\�k�ö�3*���x�ȃF?:m�Y�����
�6��E��2�dF��=z
�b&
���W��ޑъ���1�y^�>��ȕ�r�g�,6�OL�{�7r��܂�LN�+arʷi��G=��l.|�c)1���oK�R��"�+{R.�o�	��x�Z!X���a���ݨu����s~<>a���%#�8ٿg�W��ۃ����	��3�6)�#W_ؖ3=�IS�dN]��!�o�Ñ5���x2�ˏ�Z޶љ1�/�~8BN�M�h�cC�����L��=�2ﴂ�xf=i����X��4@�'�q����;�s��}�C��<)�h֕Bn9�u7��ύ趤R��tމA��~ւ
�QJ;��A�	�;��&��Di
���A���]T�K��"Y[�v
�X�݆��Aɤ<eތ�3��\SDx�B1��=Q
N���c:]��1�mw���q�Z��[w��L�=5�ې6V�d�fҳ6�2� 7Lesf+�>3zO�����XA��$]�'�	Dͳ\��M�������"�sIq�y���VYz��-��U҈}�������������X_7gv��{Vk�ܯ<Q�i��:�_�<Uz�b.��983'�Б��Nvj�'���|�����u���D�@^�=���p��R-Y;�7�s�?�k��p $��t�?m�w�'agbW��l����
�v�JF{��V�����5��2��½�_��-�ۍ�*9��,���,��n���5�ο�^�=~W�E���" �{�D�7$�MK{�0L1��#��>�`�j�_ӸL���Ϋ[��MXr�i�7k�bϗ�4}�W���� FafO�d{�Q�&C[��͇�B�e�Q�8�䜓���e��j���"|Tf�e� �g�g�T��㈘@&�m}n��L�ঝ�.�9��	Y"�o����L�u1W��p�����3ЉV��]1+U�7ID��Y�����u�e�h�0���~넿�_q{���&�[����9'm����J}�#���y�?)�`7����z	\8xN��̳�bx����V�o�栏Zӳ;|D	�׍L��O>@1����'dƓ�P��K���>��^��Z~".%��_� `����Ks�D%�C�t�ٙ0��@�Oi0�ېڜ�O�J�ҏ�*�Zt��+����K���k���i�{o��\p�tW,3"x��-��P/=iNA,�~�G�ʟ��foAe6�g@��Vp��4O;ᅾ�cjG7�/�̕�X���ۇK���K>w��R�+*$	�	��G^�"!��BZ�k����.t[���U 8~5f�S�-8�͗��L!,������z���*5��箈	ª�س�(��1��9
�MÇ]���d�o�3#��M���C�>��v��n:�eؚĨ��UZD�Z�V��K��@y��v�?+�sS�]��A��UO�o{ ���I�ۅ5ߢ��Q�w=��]pYM��r�7=�ŗ�%j��͎ç��j�Ȋ8������= ��ʅ�'9���]E�V�h���\XY��5F�P!#�\	��Zk��u���c�����*OT?ʜc�H�[�����歋<{:�!`�l�ۣ�
�>�p��$/m��2i����Gcm�ҏ���Eވ�?DQ���I�ZN �o��a���EG�E���i��kDt
<����q�#2�(r�rJ��"EQ�]���T���灖t_r����Q�&۟��rovz�h�y�j���ھ<�İ�fK��]��-�s+Ij=���XHJJ~3�[�>����)�m�څ�V��J|�%�D�ӻ�� �
sq?a	 �����x|�F|��/�C�J��}��g���v����敯�Sf�=9��ӫ�7֙O�(�*Wwҙ�(2hȫX��|�\ϴk#@�k��~�5t���*��g�����һq�F�@R£�>:�]�ʒ������S-�w?��E���1	�I���w��c"6}���v��·a����e�/�q|�R��,�8��#᭚'��q��@��L��W?�_��ժ���}�1�J�R)��y]F��w�9��v�A��$�D�W^_�Sb�1��kĬw���� nڡ�DGAM���fwK`�R%��^��&��vI}�����-�3�jT;H1){��G���Oly<>���s/ݺm���PIf�:;$T�[[S��wǞ�-��~>1���0�3�T�-�OA�4\��e�#���Lĵ.��Zrv��4��ߔ�ŭQ==z:��臫��0�?�µ|ɣ����봁�Ȓ�A���i`*t��{���G�]�ɧ�d9/ȅ^~X';��1/�.G�{��u���6v�����k�:=�|خ�m���S<s���A��1�=|U׻v1�Ri}�!��۹=�^Q/W�*�20��d�h�q�柼D�JCj�Դ�v؉�=
����T�~Y��[�o7�k _�]Y���0�y��,�`��B�,O���.[C�,I�������������������L&�! DN�����~#���t�fH���+G����I����ctJR�$x�M}L뜬��#D��Tr�m�{sȩ��;�`.5e�z�+��:쵰՟�s}��S��.y2u�<����bI����n�_B|ԃ?a@,ra��[.�(ٺ��r�;%ka�1����f,~�4���w-Ԛ�	��ϛ&��cD���z��YG�[�ly�9 �k'a��%J��ؚ��a�:Θ����)��I�2�Ѿ���se}��V�*���e��Cs���*��n��+�PV}�es�@�g�?pƸ̙�_ا���~!W{9\�9�m�k%�-:�yW���2�z!�Zf�?Q�lq4�n�r��:+���0zWь(F��ڮ~r�)ɲꦝA+�"��f��Z`���?:½.�/nR��) �AD���@�U��}�o�U����v$nHˠ�2��R�ŷC�[�ȅ-�ge߸?SfL���r$�_�N@_�{���F��K� �f�q4������e%U�qVK��r����Z]Ó������:�5�I�o����E�DYܣ�綌��(b�W��>ͶE ���Ʃ��*훮�@�խ
5�vQ�9CDSU̯ƃM|�{}]�c�i��bFd>r�Ϛ���X��|`>o�����X<}��!bo�ᘬ�	͞Sa������A�    y���]�
r��jݟvP�N3~+��F�6����q�#ڪf��S�9g gR��2��n�!�4�d�үb�Վ)?L��  7�~��(!�9*�oA�}�&᢫����<��̦A��b f�yu��d�N"="skʆg��tI��5j b�`Qq�k����:�I�nN_^ej����,�f6���5}���Oݺ٣w���@��?Ï�:~�h��0�%V�ݽʓ 0���y��-�8�����p����({eN���(֛ks�U���y��Hߵ枏a#��F�3ձ�
5vo}�ox��ڙ~0xX@ܪJ��:���h����N3)�/��\^�v��_����C�;�Fn[�L��^��G��-S��\��9�#NU�@!=�Y��5�vG`���U9\�8�0\*A�V{�7�^�D=��=s�i���9:��Er���4�5������9eV��-�Ï�Td��}7���cT����X�UZ��:81���kL�ϗ:�˲Nk�naV���[�,U�z�Vq{ V�Hc�v/��3Ӆ���1�����!0r�퉛���M䂨˪����~�۠ۙ�cA��4_�1���LT8v��Ň��p"�q�"{�S5W��M3Uy�w}g~!O*ӕ�d��ULX�n�r�
�@L�������z��.�*�=F&��L���ڕ 8:�܇����xtK��w��x�ƛ�)m1���v����}Y,R�ݤ#�͇C��⋘�=��__�3n ���
v��?����Th�|sf�v�`A_�RBĹ��p� �bU���p��D��t;,䓐�����K �K�v�I��RC�m3K���pc�冬�Y��vW��e�����;��8w�����*៵�b���̦��d@�NJ ��ɖl�^ ��Ἕw��l���_��c����d����e������.�_�a�U
��M�81cE��Z�g�~��g�:lS>`�dB��ȑ��ӧ�k�Z,�[�</ �����Xҙ��!gZ��]����ü=}���+3�f>xKCY�ҳ��+Y;t��-��pz���m~�ʀm�� ���d��~|�7����:����dʬ-Ʀy��,��16J��mr��]�f� 7�g0�a���xc�x�\�ܗ���v�x��� ��>�bW����D�w�|���>2ԳL዁(ٽ6|-�4��n�� �c�;CZZ)̋�.FZ��c%�<τ�)��A�O^��1kov�l��G3,���n���ob��\��0i��5�;3B�qL<�#�g������Ρ��9��Y,oO�<WHP��e�D��9䨽�`���Q�U��~
�����S�]�a��2x�u��ɗ��$�֘�����s�A`ɒ�������$ƈ��!e8�$�5r�x�G�x^��)��a������*I��ւ�j��/�r�O�M���(�I�iZvt�_28y�% ��er9��̝{c���p�x����bp�cV[����Zs9+�lN]���������ե�~�Z�+�N��ju��	��k��A�Y���i��X�;�1؄#���l���l"��*��$m�P�y��۹A�ߒa�K��B��2�~;_��l/��ڎ�_]?&}�㵋fC묘�fm��-f��gY���7X�6�i>����>�C?Z�LU蚾���qQ=�0�>z!Ÿ쯟��ٷv�+_��c��e���Z	dx�k]�S�Ll�<��%=���O�۳��贒�xLZ� YY>ٍL��s�v���e񠍮����S�<:ƍ�����L��*S�r�����օv���̒�#�27�CGƍ.�W�AK�,�fڏv8��ݔ �T�v�Rn�$g�:�p#�R�vk��Ā�M��\�3s�M�S?�[�3hd��]q�}�<�.-����U���@�#fn��)�۽i�yq|����!�(��#F�zE�L�
Gb��D��5#*������M���Ak~����������S:{��g8l�����,�d���b0���P��-���!s�.��x�"韆�2�K���c��?����v��?q��^?%�:���e��5��6����@"��M����H�o���`$ir��� ����a�����}SX��΄st�_R%�x<�b�L@��៱1�_ Ný��;ģm�K���-Gu6R�!e�ډ;��#1W_@�BI��×ŕ��e��U��޹� X�Ȍ݂aJ���Jx�����.Hru�f
�J�^�(���������s��V(��}q���'�U���	U@P����~�@��Q�r��%�R'��b�9(u�hC�2i[)�	��^S.� ��=���݃�%G��i>�b��s�Ԧ�z�B�j���^��j�˽��L�6YvT�:qݾi�B�H�[c�B�2k<f����!!X�����=�Y�i�`��5+V�������ړ��������
J�>���-�C��K��C�#f��┆M�#�e�-]�A����3�S�n�\ϡH���&M��{a2O��}�n� �B\�Ѥ8����E0\�����P\'4yPU�V��BU�G�Ӈ�����8P.��}��`}�1G \)v�}uT����[����H�ۂ_1�L��Ō%����Y#�����h���m	,�U�Ll]�+҈N�@X��3O�Q�`�1�z��X��]J�s?��A�]8Z���<��"`e���%������(���o�8\`c[&(N�wgm�3��u��&-�ۭ�DJ/F�E�$��=|I<fk��G^s�շ��1��|�XI�w�B�(Ne�/ ,�]ל�����"�x�7���#��������U�jZ�O[��@�,q� �š��ʔ�8�p����f�(;�t���y,�R뼽k;��B1��.]���ΧD�2��y�At��������jЖ�k�O�V2'�1��0A��u�_K�*k��8���w���H��F0I��;7�U���_���������N�J͌`g���ar�d����S0�U��dzKrA��{-���1|I���V�4�jun��*ٵ�?�6��q>��YS�%��$�M� GSLB-+5L��(!X���cO���mRлf
� WzG)~�Ԩ�K
Z��>��ހBB\�pc��8����ޜ�"
�8��b �!���_��%�h���b��ɬ	!8.%o����T���K"'�S��?R� ����J�,�6�m�������(C(&'��b}Ei�>*��Cp2u퇋:@����-��
��S������1���*�ÁLE�<��4 Vq�G��"0�QB��C�|uΓ�@���ӲvA2�Y�_m>|�Nc=�(�ܟI~n��~����-����ҍ�[��ѷ0J�#0L)��õ_�<Ȳ�^��,��<������?�?_���FnB�s���o<���2����-���?�g"�������d��U����'�$Q����_�#-�f���8�G��>MI���v=c�E�&,�������xޖ7��TT`�4Af��Jz&!�q~��Ȼ���"����ˁ`����!lZ'�����۟�=2�K�5ֶ9�H����/f�s?j[^dZ+ �\�v�˨���(ZR7G��]��m��ҤV���	>�O���v��i�Go^��)R�������1�.ᛆ�|�r���!\�j엷�F�$.L8���4�9��n�WgNU�KB>i��u�=�Aݟ�}��u�>��0������98�~�t<�m�쑩5+� ��lg�A� $�f�jO���/��r��:����8Щ�m��^=.�koޡ$J&�k3��"����f�ݡHd�K���γ3t�<��3[�\?`S2��S���LL�9H��ӣ�:{W�ӱ}�~�^�C8�B�׻��
���z�AH�t��8��0����3.�]÷h"9�?��7HF��;g25��Lѱ?���_:a�~�rB,�B����D6��B	P�gǣ��8�����׳�g}�_�+#M��NL��6�u�H�ҡ՞ J  L���
��lK{� c�:��`և=�
���^Inwj����O��{�E1}���1�G����,-���ˬ�������8���e�}���A�V'[Ra4)r�f7�+f�{#1,�w����Ì����2=X2D�?��o��9��Y��Jʓ�ٓfc�&����$��z��s�Bs�W?�aPJ���^�"\��l�Ms筣���u�IK+�pvl�/�L�b�#��FM�\%TN꧳1P^s!��G��=�d�L���7+3Z$����uwM��Lv& ��$�L�D@����GN��$��;�0QB�����eHRr1�1��U�������7�����X%s�N�ߕ����S����F����H�ѳ�Rc�AX	=t�ܥv�j0^j%�Cp2�N�un�+{8k�p�P+�'c�Jn� ��ա���Q��tX;8�WX)�X�f�m�(�C ?p &$���$ʩ6G�*��е�[J�ڛ�#�0��eO�q
w�Sz�>0Pes��(O��
�����$*x%�թ	�pQ�aЧ~^�����'��i{�1J�F�9������z
���?������{5�      �   h  x���KO�X��ͯ�\S���˻ &�@����/K�&!�0R���q7$����2�?W�9��l��3Ll���w�����ǧ������������{z��������S�_��Ya�l�&6�$��C��R��mZ���#6BĿέ�Z;2���#�0�������	�'̼f�~�x��hV�Ww���.�����%ή/�ݟ��P�{oM�>-�M�)�dc���"޽p�w�!���ީ�ۗdT7�=��7�H�D�� |"���ݞ_������Ǉ��R��	��P���)��,v��r��w�)����n!
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