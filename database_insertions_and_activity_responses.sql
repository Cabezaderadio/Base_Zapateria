-- INSERCIÓN DE DATOS:
-- 1. Insertar 3 maestros zapateros, 2 ayudantes y 2 cortadores.
-- - Crear direcciones para los empleados.
INSERT INTO
  direccion (calle, carrera, numero, piso)
VALUES
  ('Calle 1', 'Carrera 1', 101, 1),
  ('Calle 2', 'Carrera 2', 202, 2),
  ('Calle 3', 'Carrera 3', 303, 3),
  ('Calle 4', 'Carrera 4', 404, 4),
  ('Calle 5', 'Carrera 5', 505, 5),
  ('Calle 6', 'Carrera 6', 606, 6),
  ('Calle 7', 'Carrera 7', 707, 7);

-- - Insertar los empleados en la tabla empleado.
-- Insertar maestros zapateros en 'empleado'
INSERT INTO
  empleado (
    nombre,
    edad,
    telefono,
    genero,
    fecha_nacimiento,
    id_direccion,
    tipo_empleado,
    fecha_contratacion
  )
VALUES
  (
    'Maestro Zapatero 1',
    45,
    '111-1111',
    'masculino',
    '1975-01-01',
    1,
    'maestro_zapatero',
    '2010-05-10'
  ),
  (
    'Maestro Zapatero 2',
    50,
    '222-2222',
    'femenino',
    '1970-02-02',
    2,
    'maestro_zapatero',
    '2008-06-15'
  ),
  (
    'Maestro Zapatero 3',
    55,
    '333-3333',
    'otro',
    '1965-03-03',
    3,
    'maestro_zapatero',
    '2005-07-20'
  );

-- Obtener los 'id_empleado' generados
SELECT
  id_empleado
FROM
  empleado
WHERE
  tipo_empleado = 'maestro_zapatero';

-- - Insertar los detalles específicos en las tablas maestro_zapatero, ayudante y cortador.
-- Insertar detalles en 'maestro_zapatero'
INSERT INTO
  maestro_zapatero (id_empleado, especialidad)
VALUES
  (1, 'Calzado formal'),
  (2, 'Calzado deportivo'),
  (3, 'Calzado casual');

-- Insertar ayudantes en 'empleado'
INSERT INTO
  empleado (
    nombre,
    edad,
    telefono,
    genero,
    fecha_nacimiento,
    id_direccion,
    tipo_empleado,
    fecha_contratacion
  )
VALUES
  (
    'Ayudante 1',
    30,
    '444-4444',
    'masculino',
    '1990-04-04',
    4,
    'ayudante',
    '2018-08-25'
  ),
  (
    'Ayudante 2',
    28,
    '555-5555',
    'femenino',
    '1992-05-05',
    5,
    'ayudante',
    '2019-09-30'
  );

-- Obtener los 'id_empleado' generados
SELECT
  id_empleado
FROM
  empleado
WHERE
  tipo_empleado = 'ayudante';

-- Insertar detalles en 'ayudante'
INSERT INTO
  ayudante (id_empleado, horas_trabajadas)
VALUES
  (4, 160),
  (5, 150);

-- Insertar cortadores en 'empleado'
INSERT INTO
  empleado (
    nombre,
    edad,
    telefono,
    genero,
    fecha_nacimiento,
    id_direccion,
    tipo_empleado,
    fecha_contratacion
  )
VALUES
  (
    'Cortador 1',
    35,
    '666-6666',
    'masculino',
    '1985-06-06',
    6,
    'cortador',
    '2015-10-05'
  ),
  (
    'Cortador 2',
    32,
    '777-7777',
    'femenino',
    '1988-07-07',
    7,
    'cortador',
    '2016-11-10'
  );

-- Obtener los 'id_empleado' generados
SELECT
  id_empleado
FROM
  empleado
WHERE
  tipo_empleado = 'cortador';

-- Insertar detalles en 'cortador'
INSERT INTO
  cortador (id_empleado, experiencia)
VALUES
  (6, 5),
  (7, 4);

-- 2. Insertar un nuevo diseño de zapato.
-- - Insertar nuevo diseño en 'diseño'
INSERT INTO
  diseño (color)
VALUES
  ('Negro');

-- 3. Insertar un lote de 10 zapatos usando ese diseño y los empleados creados anteriormente.
-- - Crear un lote en la tabla lote.
INSERT INTO
  lote (
    codigo_lote,
    fecha_agotamiento,
    fecha_recepcion,
    valor_lote
  )
VALUES
  ('LOTE001', '2023-12-31', '2023-10-01', 10000.00);

-- - Crear registros en material y relacionarlos en material_lote.
INSERT INTO
  material (
    codigo_material,
    nombre_material,
    valor_material,
    fabricante
  )
VALUES
  ('MAT001', 'Cuero', 500.00, 'Materiales SA');

INSERT INTO
  material_lote (codigo_material, codigo_lote)
VALUES
  ('MAT001', 'LOTE001');

-- - Crear registros en molde y relacionarlos en molde_lote.
INSERT INTO
  molde (fabricante, forma, talla)
VALUES
  ('Moldes SA', 'Casual', '43');

-- - Crear registros en suela y relacionarlos en suelas_lote.
INSERT INTO
  molde_lote (id_molde, codigo_lote)
VALUES
  (1, 'LOTE001');

-- - Crear registros en accesorio y relacionarlos en accesorios_lote.
INSERT INTO
  suela (color, fabricante, id_ayudante)
VALUES
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4),
  ('Negro', 'Suelas SA', 4);

INSERT INTO
  suelas_lote (id_suela, codigo_lote)
VALUES
  (1, 'LOTE001'),
  (2, 'LOTE001'),
  (3, 'LOTE001'),
  (4, 'LOTE001'),
  (5, 'LOTE001'),
  (6, 'LOTE001'),
  (7, 'LOTE001'),
  (8, 'LOTE001'),
  (9, 'LOTE001'),
  (10, 'LOTE001');

-- - Crear el lote de zapatos en lote_zapatos y relacionarlo con molde_lz.
INSERT INTO
  tipo_accesorio (nombre, material_accesorio, color)
VALUES
  ('Cordones', 'Algodón', 'Negro');

INSERT INTO
  accesorio (fabricante, valor, id_accesorio)
VALUES
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1),
  ('Accesorios SA', 10.00, 1);

INSERT INTO
  accesorios_lote (codigo_accesorio, codigo_lote)
VALUES
  (1, 'LOTE001'),
  (2, 'LOTE001'),
  (3, 'LOTE001'),
  (4, 'LOTE001'),
  (5, 'LOTE001'),
  (6, 'LOTE001'),
  (7, 'LOTE001'),
  (8, 'LOTE001'),
  (9, 'LOTE001'),
  (10, 'LOTE001');

-- Crear el lote de zapatos en 'lote_zapatos' y relacionarlo con 'molde_lz'
INSERT INTO
  lote_zapatos (
    codigo_lz,
    tiempo_estimado,
    numero_zapatos_fabricados,
    rango_tallas,
    cantidad_trozos,
    valor_lote
  )
VALUES
  ('LZ1001', 30, 10, '40-44', 1, 5000.00);

INSERT INTO
  molde_lz (id_molde, codigo_lz)
VALUES
  (1, 'LZ1001');

-- - Crear los trozos necesarios en trozo.
INSERT INTO
  trozo (color, codigo_material, id_cortador)
VALUES
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6),
  ('Café', 'MAT001', 6);

-- - Insertar los zapatos en zapato.
INSERT INTO
  tipo_zapato (nombre_tipo, color, diseño)
VALUES
  ('Modelo Clásico', 'Negro', 'Diseño Clásico');

INSERT INTO
  zapato (
    nombre_tipo,
    id_diseño,
    codigo_lz,
    id_suela,
    id_trozo
  )
VALUES
  ('Modelo Clásico', 1, 'LZ1001', 1, 1),
  ('Modelo Clásico', 1, 'LZ1001', 2, 2),
  ('Modelo Clásico', 1, 'LZ1001', 3, 3),
  ('Modelo Clásico', 1, 'LZ1001', 4, 4),
  ('Modelo Clásico', 1, 'LZ1001', 5, 5),
  ('Modelo Clásico', 1, 'LZ1001', 6, 6),
  ('Modelo Clásico', 1, 'LZ1001', 7, 7),
  ('Modelo Clásico', 1, 'LZ1001', 8, 8),
  ('Modelo Clásico', 1, 'LZ1001', 9, 9),
  ('Modelo Clásico', 1, 'LZ1001', 10, 10);

-- - Asociar maestros zapateros al lote en maestro_lz.