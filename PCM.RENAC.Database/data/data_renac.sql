
INSERT INTO renac."TIPO_ASIENTO" ("codigo", "descripcion", "activo", "fechaReg", "fechaMod", "usuarioReg", "usuarioMod")
VALUES 
    (2, 'Creación', True, '2023-07-21 18:07:55.626566', NULL, '0', NULL),
    (3, 'Cancelación', True, '2023-07-21 18:07:40.116077', '2023-07-21 18:08:05.147255', '0', '0'),
    (1, 'Modificación', True, '2023-07-21 18:08:22.311633', NULL, '0', NULL);

INSERT INTO renac."TIPO_MODIFICACION_ASIENTO" ("descripcion", "activo", "fechaReg", "fechaMod", "usuarioReg", "usuarioMod")
VALUES 
    ('Modificación en ámbito territorial', True, '2023-07-22 23:34:23.383357', NULL, '0', NULL),
    ('Cambio de nombre', True, '2023-07-22 23:34:57.513784', NULL, '0', NULL),
    ('Traslado de capital', True, '2023-07-22 23:35:19.044118', NULL, '0', NULL),
    ('Cambio de nombre de capital', True, '2023-07-22 23:35:37.926624', NULL, '0', NULL),
    ('Cambio de nombre de la circunscripción a la que pertenece', True, '2023-07-22 23:36:03.679389', NULL, '0', NULL),
    ('Cambio de la circunscripción a la que pertenece', True, '2023-07-22 23:36:24.264863', NULL, '0', NULL);



-- se inserta la data para las parametricas

DECLARE idPadre int;

-- Insert padre
INSERT INTO renac."PARAMETRICAS_RENAC" ("idGrupo", "codigo", "descripcion", "activo", "fechaReg", "usuarioReg")
VALUES (1001, '001', 'Estados de derivación', true, '2023-07-28 12:35:18.478281', '0')
RETURNING "idParametricasRenac" INTO idPadre;

-- Insert hijos
INSERT INTO renac."PARAMETRICAS_RENAC" ("idPadre", "idGrupo", "codigo", "descripcion", "activo", "fechaReg", "usuarioReg")
VALUES 
    (idPadre, 1001, '10', 'Especialista SSIAT', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '20', 'Subsecretario SSIAT', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '30', 'Subsecretario SSATDOT', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '40', 'Especialista SSATDOT', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '50', 'Subsecretario SSATDOT - Derivacion informes', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '60', 'Especialista SSIAT - Modificacion', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '70', 'Especialista SSIAT - Formatos de anotacion', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '80', 'Responsable de archivo', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '90', 'Especialista SSIAT - Solicitud informacion', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '95', 'Subsecretario SSIAT - Registro de anotacion', true, '2023-07-28 12:35:18.478281', '0'),
    (idPadre, 1001, '100', 'Responsable de archivo - Informes de anotacion', true, '2023-07-28 12:35:18.478281', '0');
