-- Crear las tablas principales sin dependencias
-- Tabla Dirección
CREATE TABLE
  direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    piso INT
  );

-- Tabla Empleado (esta tabla es fundamental y la utilizaremos en otras tablas)
CREATE TABLE
  empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad INT NOT NULL,
    telefono VARCHAR(15),
    genero ENUM ('masculino', 'femenino', 'otro') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_direccion INT,
    tipo_empleado ENUM ('cortador', 'maestro_zapatero', 'ayudante') NOT NULL,
    fecha_contratacion DATE NOT NULL,
    FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion) ON DELETE SET NULL
  );

-- Tabla Lote
CREATE TABLE
  lote (
    codigo_lote VARCHAR(20),
    fecha_agotamiento DATE NOT NULL,
    fecha_recepcion DATE NOT NULL,
    valor_lote DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (codigo_lote)
  );

-- Tabla Material
CREATE TABLE
  material (
    codigo_material VARCHAR(20),
    nombre_material VARCHAR(100) NOT NULL,
    valor_material DECIMAL(10, 2) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    PRIMARY KEY (codigo_material)
  );

-- Tablas dependientes de Empleado
-- Tabla Cortador
CREATE TABLE
  cortador (
    id_empleado INT PRIMARY KEY,
    experiencia INT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado) ON DELETE CASCADE
  );

-- Tabla Maestro_Zapatero
CREATE TABLE
  maestro_zapatero (
    id_empleado INT PRIMARY KEY,
    especialidad VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado) ON DELETE CASCADE
  );

-- Tabla Ayudante
CREATE TABLE
  ayudante (
    id_empleado INT PRIMARY KEY,
    horas_trabajadas INT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado) ON DELETE CASCADE
  );

-- Crear las tablas relacionadas con los productos (zapatos, accesorios, etc.)
-- Tabla Tipo_Zapato
CREATE TABLE
  tipo_zapato (
    nombre_tipo VARCHAR(100),
    color VARCHAR(50) NOT NULL,
    diseño VARCHAR(100),
    PRIMARY KEY (nombre_tipo)
  );

-- Tabla Diseño
CREATE TABLE
  diseño (
    id_diseño INT AUTO_INCREMENT,
    color VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_diseño)
  );

-- Tabla Lote_Zapatos
CREATE TABLE
  lote_zapatos (
    codigo_lz VARCHAR(20),
    tiempo_estimado INT NOT NULL,
    numero_zapatos_fabricados INT NOT NULL,
    rango_tallas VARCHAR(50),
    cantidad_trozos INT NOT NULL,
    valor_lote DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (codigo_lz)
  );

-- Tabla Molde
CREATE TABLE
  molde (
    id_molde INT AUTO_INCREMENT,
    fabricante VARCHAR(100) NOT NULL,
    forma VARCHAR(100) NOT NULL,
    talla VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_molde)
  );

-- Tabla Suela
CREATE TABLE
  suela (
    id_suela INT AUTO_INCREMENT,
    color VARCHAR(50) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    id_ayudante INT,
    PRIMARY KEY (id_suela),
    FOREIGN KEY (id_ayudante) REFERENCES ayudante (id_empleado)
  );

-- Tabla Trozo
CREATE TABLE
  trozo (
    id_trozo INT AUTO_INCREMENT,
    color VARCHAR(50) NOT NULL,
    codigo_material VARCHAR(20),
    id_cortador INT,
    PRIMARY KEY (id_trozo),
    FOREIGN KEY (codigo_material) REFERENCES material (codigo_material),
    FOREIGN KEY (id_cortador) REFERENCES cortador (id_empleado)
  );

-- Tabla Zapato (relaciona varios componentes como trozo, suela, etc.)
CREATE TABLE
  zapato (
    codigo_zapato INT AUTO_INCREMENT,
    nombre_tipo VARCHAR(100),
    id_diseño INT,
    codigo_lz VARCHAR(20),
    id_suela INT,
    id_trozo INT,
    PRIMARY KEY (codigo_zapato),
    FOREIGN KEY (nombre_tipo) REFERENCES tipo_zapato (nombre_tipo),
    FOREIGN KEY (id_diseño) REFERENCES diseño (id_diseño),
    FOREIGN KEY (codigo_lz) REFERENCES lote_zapatos (codigo_lz),
    FOREIGN KEY (id_suela) REFERENCES suela (id_suela),
    FOREIGN KEY (id_trozo) REFERENCES trozo (id_trozo)
  );

-- Crear tablas accesorias y de relación
-- Tabla Tipo_Accesorio
CREATE TABLE
  tipo_accesorio (
    id_accesorio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    material_accesorio VARCHAR(100) NOT NULL,
    color VARCHAR(50)
  );

-- Tabla Accesorio
CREATE TABLE
  accesorio (
    codigo_accesorio INT AUTO_INCREMENT PRIMARY KEY,
    fabricante VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    id_accesorio INT,
    FOREIGN KEY (id_accesorio) REFERENCES tipo_accesorio (id_accesorio) ON DELETE CASCADE
  );

-- Tabla Accesorio_Zapato
CREATE TABLE
  accesorio_zapato (
    codigo_zapato INT,
    codigo_accesorio INT,
    PRIMARY KEY (codigo_zapato, codigo_accesorio),
    FOREIGN KEY (codigo_zapato) REFERENCES zapato (codigo_zapato),
    FOREIGN KEY (codigo_accesorio) REFERENCES accesorio (codigo_accesorio)
  );

-- Tabla Material_Lote (relaciona materiales con lotes)
CREATE TABLE
  material_lote (
    codigo_material VARCHAR(20),
    codigo_lote VARCHAR(20),
    PRIMARY KEY (codigo_material, codigo_lote),
    FOREIGN KEY (codigo_material) REFERENCES material (codigo_material),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Molde_Lote (relaciona moldes con lotes)
CREATE TABLE
  molde_lote (
    id_molde INT,
    codigo_lote VARCHAR(20),
    PRIMARY KEY (id_molde, codigo_lote),
    FOREIGN KEY (id_molde) REFERENCES molde (id_molde),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Suelas_Lote
CREATE TABLE
  suelas_lote (
    id_suela INT,
    codigo_lote VARCHAR(20),
    PRIMARY KEY (id_suela, codigo_lote),
    FOREIGN KEY (id_suela) REFERENCES suela (id_suela),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Accesorios_Lote
CREATE TABLE
  accesorios_lote (
    codigo_accesorio INT,
    codigo_lote VARCHAR(20),
    PRIMARY KEY (codigo_accesorio, codigo_lote),
    FOREIGN KEY (codigo_accesorio) REFERENCES accesorio (codigo_accesorio),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Molde_LZ (relaciona moldes con lote de zapatos)
CREATE TABLE
  molde_lz (
    id_molde INT,
    codigo_lz VARCHAR(20),
    PRIMARY KEY (id_molde, codigo_lz),
    FOREIGN KEY (id_molde) REFERENCES molde (id_molde),
    FOREIGN KEY (codigo_lz) REFERENCES lote_zapatos (codigo_lz)
  );

-- Tabla Maestro_LZ (relaciona maestros zapateros con lote de zapatos)
CREATE TABLE
  maestro_lz (
    codigo_lz VARCHAR(20),
    id_zapatero INT,
    PRIMARY KEY (codigo_lz, id_zapatero),
    FOREIGN KEY (codigo_lz) REFERENCES lote_zapatos (codigo_lz),
    FOREIGN KEY (id_zapatero) REFERENCES maestro_zapatero (id_empleado)
  );

-- Tabla Tipo_Historial_Cambios
CREATE TABLE
  tipo_historial_cambios (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    su_cargo_era VARCHAR(100) NOT NULL,
    cargo_actual VARCHAR(100) NOT NULL
  );

-- Tabla Historial_de_Cambios
CREATE TABLE
  historial_de_cambios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo INT,
    id_empleado INT,
    FOREIGN KEY (id_tipo) REFERENCES tipo_historial_cambios (id_tipo) ON DELETE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
  );