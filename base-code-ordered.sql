-- Crear las tablas principales sin dependencias
-- Tabla Dirección
CREATE TABLE
  direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    tipo_domicilio ENUM ('casa', 'apto', 'otro') NOT NULL,
    piso INT,
    apto INT
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
    codigo_lote INT AUTO_INCREMENT PRIMARY KEY,
    fecha_agotamiento DATE NOT NULL,
    fecha_recepcion DATE NOT NULL,
    valor_lote DECIMAL(10, 2) NOT NULL
  );

-- Tabla Material
CREATE TABLE
  material (
    codigo_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre_material VARCHAR(100) NOT NULL,
    valor_material DECIMAL(10, 2) NOT NULL,
    fabricante VARCHAR(100) NOT NULL
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
    id_tipo_zapato INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100)
  );

-- Tabla Diseño
CREATE TABLE
  diseño (
    id_diseño INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_zapato INT NOT NULL,
    color VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_tipo_zapato) REFERENCES tipo_zapato (id_tipo_zapato) ON DELETE SET NULL
  );

-- creadores del diseño  
CREATE TABLE
  zapatero_diseño (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    id_diseño INT,
    FOREIGN KEY (id_empleado) REFERENCES maestro_zapatero (id_empleado) ON DELETE CASCADE,
    FOREIGN KEY (id_diseño) REFERENCES diseño (id_diseño) ON DELETE CASCADE
  );

-- Tabla Molde
CREATE TABLE
  molde (
    id_molde INT AUTO_INCREMENT PRIMARY KEY,
    fabricante VARCHAR(100) NOT NULL,
    forma VARCHAR(100) NOT NULL,
    talla VARCHAR(50) NOT NULL
  );

-- Tabla Lote_Zapatos
CREATE TABLE
  lote_zapatos (
    codigo_lz INT AUTO_INCREMENT PRIMARY KEY,
    tiempo_estimado INT NOT NULL,
    numero_zapatos_fabricados INT NOT NULL,
    id_molde INT,
    FOREIGN KEY (id_molde) REFERENCES molde (id_molde) ON DELETE SET NULL ON UPDATE CASCADE
  );

-- Tabla Suela
CREATE TABLE
  suela (
    id_suela INT AUTO_INCREMENT PRIMARY KEY,
    color VARCHAR(50) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    id_ayudante INT,
    FOREIGN KEY (id_ayudante) REFERENCES ayudante (id_empleado)
  );

-- Tabla Trozo
CREATE TABLE
  trozo (
    id_trozo INT AUTO_INCREMENT PRIMARY KEY,
    color VARCHAR(50) NOT NULL,
    codigo_material INT,
    id_cortador INT NOT NULL,
    FOREIGN KEY (codigo_material) REFERENCES material (codigo_material),
    FOREIGN KEY (id_cortador) REFERENCES cortador (id_empleado)
  );

-- tabla diseño_trozo
CREATE TABLE
  diseño_trozo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_diseño INT,
    numero_trozo INT NOT NULL,
    id_material INT,
    FOREIGN KEY (id_diseño) REFERENCES diseño (id_diseño) ON DELETE CASCADE,
    FOREIGN KEY (id_material) REFERENCES material (codigo_material)
  );

-- Tabla Zapato (relaciona varios componentes como trozo, suela, etc.)
CREATE TABLE
  zapato (
    codigo_zapato INT AUTO_INCREMENT PRIMARY KEY,
    id_diseño INT,
    codigo_lz INT,
    id_suela INT,
    FOREIGN KEY (id_diseño) REFERENCES diseño (id_diseño) ON DELETE SET NULL,
    FOREIGN KEY (codigo_lz) REFERENCES lote_zapatos (codigo_lz) ON DELETE SET NULL,
    FOREIGN KEY (id_suela) REFERENCES suela (id_suela) ON DELETE SET NULL
  );

-- Crear la tabla trozo_zapato
CREATE TABLE
  trozo_zapato (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_zapato INT NOT NULL,
    id_trozo INT NOT NULL,
    FOREIGN KEY (id_zapato) REFERENCES zapato (codigo_zapato) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_trozo) REFERENCES trozo (id_trozo) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE
  diseño_accesorio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_accesorio INT,
    id_diseño INT,
    FOREIGN KEY (id_accesorio) REFERENCES accesorio (codigo_accesorio),
    FOREIGN KEY (id_diseño) REFERENCES diseño (id_diseño)
  );

-- Tabla Accesorio_Zapato
CREATE TABLE
  accesorio_zapato (
    codigo_zapato INT,
    codigo_accesorio INT,
    PRIMARY KEY (codigo_zapato, codigo_accesorio),
    FOREIGN KEY (codigo_zapato) REFERENCES zapato (codigo_zapato) ON DELETE CASCADE,
    FOREIGN KEY (codigo_accesorio) REFERENCES accesorio (codigo_accesorio)
  );

-- Tabla Material_Lote (relaciona materiales con lotes)
CREATE TABLE
  material_lote (
    codigo_material INT AUTO_INCREMENT PRIMARY KEY,
    codigo_lote INT,
    PRIMARY KEY (codigo_material, codigo_lote),
    FOREIGN KEY (codigo_material) REFERENCES material (codigo_material),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Molde_Lote (relaciona moldes con lotes)
CREATE TABLE
  molde_lote (
    id_molde INT,
    codigo_lote INT,
    PRIMARY KEY (id_molde, codigo_lote),
    FOREIGN KEY (id_molde) REFERENCES molde (id_molde),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Suelas_Lote
CREATE TABLE
  suelas_lote (
    id_suela INT,
    codigo_lote INT,
    PRIMARY KEY (id_suela, codigo_lote),
    FOREIGN KEY (id_suela) REFERENCES suela (id_suela),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Accesorios_Lote
CREATE TABLE
  accesorios_lote (
    codigo_accesorio INT,
    codigo_lote INT,
    PRIMARY KEY (codigo_accesorio, codigo_lote),
    FOREIGN KEY (codigo_accesorio) REFERENCES accesorio (codigo_accesorio),
    FOREIGN KEY (codigo_lote) REFERENCES lote (codigo_lote)
  );

-- Tabla Maestro_LZ (relaciona maestros zapateros con lote de zapatos)
CREATE TABLE
  maestro_lz (
    codigo_lz INT,
    id_zapatero INT,
    PRIMARY KEY (codigo_lz, id_zapatero),
    FOREIGN KEY (codigo_lz) REFERENCES lote_zapatos (codigo_lz) ON DELETE CASCADE,
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