-- a. 3 maestros zapateros, 2 ayudantes y 2 cortadores.
-- Primero, debemos insertar direcciones para los empleados, ya que la tabla empleado requiere id_direccion.
-- Insertar direcciones
INSERT INTO
  direccion (calle, carrera, numero, tipo_domicilio)
VALUES
  ('Calle A', 'Carrera 1', 100, 'casa'),
  ('Calle B', 'Carrera 2', 200, 'apto'),
  ('Calle C', 'Carrera 3', 300, 'casa'),
  ('Calle D', 'Carrera 4', 400, 'apto'),
  ('Calle E', 'Carrera 5', 500, 'casa'),
  ('Calle F', 'Carrera 6', 600, 'apto'),
  ('Calle G', 'Carrera 7', 700, 'casa');

-- Insertar empleados en la tabla empleado y luego en sus tablas específicas:
-- Insertar 3 maestros zapateros
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
    'Pedro García',
    40,
    '1111111',
    'masculino',
    '1983-05-10',
    1,
    'maestro_zapatero',
    '2022-01-15'
  ),
  (
    'Laura Sánchez',
    35,
    '2222222',
    'femenino',
    '1988-08-20',
    2,
    'maestro_zapatero',
    '2021-06-30'
  ),
  (
    'Miguel Díaz',
    45,
    '3333333',
    'masculino',
    '1978-12-05',
    3,
    'maestro_zapatero',
    '2020-03-25'
  );

-- Insertar detalles en la tabla maestro_zapatero
INSERT INTO
  maestro_zapatero (id_empleado, especialidad)
VALUES
  (1, 'Calzado deportivo'),
  (2, 'Calzado formal'),
  (3, 'Calzado casual');

-- Insertar 2 ayudantes
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
    'Ana Ruiz',
    28,
    '4444444',
    'femenino',
    '1995-07-15',
    4,
    'ayudante',
    '2023-02-10'
  ),
  (
    'Carlos Vega',
    30,
    '5555555',
    'masculino',
    '1993-11-22',
    5,
    'ayudante',
    '2022-11-05'
  );

-- Insertar detalles en la tabla ayudante
INSERT INTO
  ayudante (id_empleado, horas_trabajadas)
VALUES
  (4, 160),
  (5, 150);

-- Insertar 2 cortadores
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
    'Elena López',
    32,
    '6666666',
    'femenino',
    '1991-04-18',
    6,
    'cortador',
    '2021-09-12'
  ),
  (
    'Jorge Morales',
    38,
    '7777777',
    'masculino',
    '1985-02-28',
    7,
    'cortador',
    '2020-07-08'
  );

-- Insertar detalles en la tabla cortador
INSERT INTO
  cortador (id_empleado, experiencia)
VALUES
  (6, 5),
  (7, 7);

-- b. Un nuevo diseño de zapato.
-- Insertar un nuevo tipo de zapato
INSERT INTO
  tipo_zapato (nombre)
VALUES
  ('Botas');

-- Insertar el nuevo diseño de zapato utilizando el id_tipo obtenido
INSERT INTO
  diseño (color)
VALUES
  ('Marrón');

-- relacionar los zapateros
INSERT INTO
  zapatero_diseño (id_empleado, id_diseño)
VALUES
  (2, 1),
  (1, 1);

-- c. Un lote de 10 zapatos usando ese diseño y los empleados creados anteriormente.
-- Insertar molde
INSERT INTO
  molde (fabricante, forma, talla)
VALUES
  ('Fabricante Ejemplo', 'Forma Deportiva', '42');

-- Insertar un nuevo lote de zapatos
INSERT INTO
  lote_zapatos (
    tiempo_estimado,
    numero_zapatos_fabricados,
    id_molde
  )
VALUES
  (80, 10, 1);

-- Asociar maestros zapateros al lote (tabla maestro_lz)
INSERT INTO
  maestro_lz (codigo_lz, id_zapatero)
VALUES
  (1, 1),
  (1, 2),
  (1, 3);

-- Insertar suelas creadas por los ayudantes
INSERT INTO
  suela (color, fabricante, id_ayudante)
VALUES
  ('Negro', 'SuelaMax', 4),
  ('Negro', 'SuelaMax', 5),
  ('Negro', 'SuelaMax', 4),
  ('Negro', 'SuelaMax', 5),
  ('Negro', 'SuelaMax', 4),
  ('Negro', 'SuelaMax', 5),
  ('Negro', 'SuelaMax', 4),
  ('Negro', 'SuelaMax', 5),
  ('Negro', 'SuelaMax', 4),
  ('Negro', 'SuelaMax', 5);

-- Insertar trozos de material cortados por los cortadores
INSERT INTO
  material (nombre_material, valor_material, fabricante)
VALUES
  ('Cuero', 50.00, 'Materiales SA');

-- insertar los numero de trozos que tiene cada zapato y su material
INSERT INTO
  diseño_trozo (id_diseño, numero_trozo, id_material)
values
  (1, 2, 1);

INSERT INTO
  trozo (color, codigo_material, id_cortador)
VALUES
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7),
  ('Marrón', 1, 6),
  ('Marrón', 1, 7);

-- Insertar zapatos asociados al lote y diseño
INSERT INTO
  zapato (id_diseño, codigo_lz, id_suela)
VALUES
  (1, 1, 1),
  (1, 1, 2),
  (1, 1, 3),
  (1, 1, 4),
  (1, 1, 5),
  (1, 1, 6),
  (1, 1, 7),
  (1, 1, 8),
  (1, 1, 9),
  (1, 1, 10);

-- Asociar trozos a los zapatos (tabla trozo_zapato)
INSERT INTO
  trozo_zapato (id_zapato, id_trozo)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 5),
  (3, 6),
  (4, 7),
  (4, 8),
  (5, 9),
  (5, 10),
  (6, 11),
  (6, 12),
  (7, 13),
  (7, 14),
  (8, 15),
  (8, 16),
  (9, 17),
  (9, 18),
  (10, 19),
  (10, 20);

-- Actualizar el tipo de empleado
UPDATE empleado
SET
  tipo_empleado = 'maestro_zapatero'
WHERE
  id_empleado = 4;

-- Insertar en maestro_zapatero
INSERT INTO
  maestro_zapatero (id_empleado, especialidad)
VALUES
  (4, 'Calzado infantil');

-- insertar el registro en tipo_historial_cambios
INSERT INTO
  tipo_historial_cambios (nombre, su_cargo_era, cargo_actual)
VALUES
  ('Ascenso', 'ayudante', 'maestro_zapatero');

-- Registrar en historial_de_cambios
INSERT INTO
  historial_de_cambios (id_tipo, id_empleado)
VALUES
  (1, 4);

-- Añade un nuevo accesorio a un diseño de zapato existente.
-- Insertar nuevo tipo de accesorio
INSERT INTO
  tipo_accesorio (nombre, material_accesorio, color)
VALUES
  ('Hebilla', 'Metal', 'Plateado');

-- Insertar el accesorio
INSERT INTO
  accesorio (fabricante, valor, id_accesorio)
VALUES
  ('Accesorios Huellitas', 5.00, 1);

-- Asociar el accesorio al diseño con id_diseño = 1
INSERT INTO
  diseño_accesorio (id_accesorio, id_diseño)
VALUES
  (1, 1);

-- Asociar el accesorio a todos los zapatos que tienen id_diseño = 1
INSERT INTO
  accesorio_zapato (codigo_zapato, codigo_accesorio)
SELECT
  z.codigo_zapato,
  1
FROM
  zapato z
WHERE
  z.id_diseño = 1;

-- Actualizar un diseño de un zapato agregando un trozo de un material diferente.
INSERT INTO
  diseño (color)
VALUES
  ('Negro');

-- Asignar el primer trozo de material existente
INSERT INTO
  diseño_trozo (id_diseño, numero_trozo, id_material)
VALUES
  (2, 1, 1);

-- Insertar un nuevo material en la tabla `material`
INSERT INTO
  material (nombre_material, valor_material, fabricante)
VALUES
  (
    'Tela Sintética',
    20.00,
    'Materiales Innovadores SA'
  );

-- Insertar un trozo de este nuevo material en la tabla `diseño_trozo`
INSERT INTO
  diseño_trozo (id_diseño, numero_trozo, id_material)
VALUES
  (2, 3, 2);

-- buscar los zapatos relacionados a un  molde
SELECT
  z.codigo_zapato,
  z.id_diseño,
  z.codigo_lz,
  z.id_suela
FROM
  zapato z
  JOIN lote_zapatos lz ON z.codigo_lz = lz.codigo_lz
WHERE
  lz.id_molde = 1;

-- buscar los materiales de un zapato
SELECT DISTINCT
  m.nombre_material,
  m.valor_material,
  m.fabricante
FROM
  zapato z
  JOIN diseño_trozo dt ON z.id_diseño = dt.id_diseño
  JOIN material m ON dt.id_material = m.codigo_material
WHERE
  z.codigo_zapato = 1;
  
-- Contar Zapatos por Diseño
SELECT COUNT(*) AS cantidad_zapatos
FROM zapato
WHERE id_diseño = 1;