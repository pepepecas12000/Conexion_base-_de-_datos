create database vet2care;
use vet2care;
drop database vet2care;

create table usuarios(
id_usuario int primary key auto_increment,
nombre_usuario varchar(50) not null ,
apellido_usuario varchar(50) not null,
contraseña  varchar(8) not null,
telefono varchar(30) not null,
correo varchar(30) not null,
intentos_fallidos int default 0,
cuenta_bloqueada boolean 
 );
create table Animales(
 id_animal int primary key auto_increment,
 nombre_animal varchar(20) not null,
especie_a varchar(20),
raza_a varchar(40) not null,
edad int  not null,
peso_a float not null, 
sexo_a varchar(20),
/*Color  */ info_adicional_a varchar(50),
fk_usuario int,
foreign key(fk_usuario ) references usuarios(id_usuario)
 );
 -- TRANSACCIONES 4.5
 show create table animales;
alter table citas drop foreign key citas_ibfk_1;
alter table citas add constraint citas_ibfk_1
foreign key (fk_animal) references animales(id_animal)
on delete cascade;
create table citas(
id_cita int primary key auto_increment,
fk_animal int,
fk_usuario int, 
fecha date, 
hora time, 
motivo_cita varchar(100),
foreign key(fk_animal) references animales(id_animal),
foreign key(fk_usuario) references usuarios(id_usuario) 
);
create table productos(
id_producto int primary key auto_increment,
nombre_producto varchar(30),
precio float,
descripcion varchar(100),
stock int );
create table ventas(
id_venta int primary key auto_increment,
fecha date,
cantidad_ve int,
fk_usuario int, 
fk_producto int,
monto_total float,
foreign key(fk_usuario ) references usuarios(id_usuario),
foreign key(fk_producto ) references productos(id_producto)); 

-- TABLA PARA DISPARADORES
-- DISPARADOR 1 - CAMBIO DE PRECIOS
create table cambio_productos(
id_cambio int primary key auto_increment,
id_producto int,
accion varchar(20),
nombre_producto varchar(30),
precio_anterior float,
precio_actual float,
descripcion varchar(100),
stock int );

-- DISPARADOR 2 - BLOQUEO DE CUENTAS
 create table intento_login(
 id_intento int primary key auto_increment,
 fk_id_usuario int,
 foreign key(fk_id_usuario ) references usuarios(id_usuario),
 contraseña_usuario_intento varchar(8) );

 create table temp_results_login(
id_intento1 int primary key,
    coincidencia1 boolean
);

-- Disparador 3: Eliminación de datos sensibles
create table metodo_pago_tarjeta(
id_tarjeta int primary key auto_increment,
num_tarjeta int,
cvv int,
tipo_tarjeta varchar (10),
fecha_caducidad varchar (25),
fk_usuario int,
foreign key(fk_usuario ) references usuarios(id_usuario)
);

create table registro_auditoria(
id_registro int primary key auto_increment,
accion varchar (20),
fk_usuario int,
num_tarjeta int,
cvv int,
fecha timestamp default current_timestamp
);

-- TABLAS PARA PROCEDIMIENTOS ALMACENADOS
-- Procedimiento almacenado 2: 
create table Departamentos(
id_departamento int primary key auto_increment,
nombre_departamento varchar(50) not null,
nombre_encargado varchar (50) not null
);
alter table animales add column fk_departamento int; 
alter table animales add constraint fk_departamento foreign key (fk_departamento) references Departamentos(id_departamento);

insert into departamentos (nombre_departamento, nombre_encargado)
values
('Vacunación', 'EricK Aguilar'),
('Cirugía', 'Austin Blanco'),
('Emergencias', 'Jaqueline Salazar'),
('Odontología Veterinaria', 'Jesus Jimenez'),
('Farmacia Veterinaria', 'Arturo Valladares'),
('Diagnóstico por Imagen', 'Gabriela Martínez'),
('Laboratorio', 'Fernando Morales'),
('Nutrición', 'Carolina Gómez'),
('Comportamiento y Entrenamiento', 'Luisa Sánchez'),
('Rehabilitación y Fisioterapia', 'Diego Ramírez'),
('Administración y Recepción', 'María Fernández'),
('Estética y Grooming', 'Roberto López');
/* update animales set fk_departamento = 8 where id_animal = 20;*/  

-- TABLAS PARA TRANSACCIONES
--  4.3  Tabla de registro de cambios
create table registro_usuarios(
nombre_usuario varchar (20) not null,
fk_usuario int not null,
contraseña varchar (20) not null,
telefono varchar (15) not null,
correo varchar (30) not null,
fecha timestamp default current_timestamp
);
alter table registro_usuarios add foreign key(fk_usuario) references usuarios (id_usuario);

-- 4.5 REGISTRO DE ELIMINACIONES EN ANIMALES
create table registro_mascotas (
    id_registro int  primary key auto_increment,
    id_animal int,
    accion varchar(10) not null,
    nombre_animal varchar(20) not null,
    especie_a varchar(20) not null,
    raza_a varchar(40),
    edad int,
    peso_a float,
    sexo_a varchar(20),
    info_adicional_a varchar(50),
    fk_usuario int,
    fk_departamento int,
    fecha timestamp default current_timestamp
);

-- Rango de animales cuya edad este dentro del periodo de castracion 
-- Registros 
insert into usuarios(nombre_usuario, apellido_usuario,
contraseña,telefono ,correo) values ('Juan', 'Pérez', 'abc12345', '555-1234', 'juan.perez@example.com'),
('María', 'González', 'xyz98765', '555-5678', 'maria.gonzalez@example.com'),
('Carlos', 'Rodríguez', 'pass5432', '555-8765', 'carlos.rodriguez@example.com'),
('Ana', 'Martínez', 'qwe85274', '555-4321', 'ana.martinez@example.com'),
('Luis', 'López', 'zxc78901', '555-6789', 'luis.lopez@example.com'),
('Sofía', 'Fernández', 'abc45678', '555-9876', 'sofia.fernandez@example.com'),
('Miguel', 'García', 'mno12345', '555-3456', 'miguel.garcia@example.com'),
('Lucía', 'Sánchez', 'xyz54321', '555-6543', 'lucia.sanchez@example.com'),
('Daniel', 'Ramírez', 'pass0987', '555-7890', 'daniel.ramirez@example.com'),
('Elena', 'Torres', 'qwe65432', '555-1230', 'elena.torres@example.com'),
('Jorge', 'Flores', 'zxc32109', '555-4567', 'jorge.flores@example.com'),
('Laura', 'Vargas', 'abc98765', '555-7654', 'laura.vargas@example.com'),
('Andrés', 'Morales', 'mno98765', '555-2345', 'andres.morales@example.com'),
('Gabriela', 'Rojas', 'xyz65432', '555-5432', 'gabriela.rojas@example.com'),
('Francisco', 'Navarro', 'pass4321', '555-6780', 'francisco.navarro@example.com');

INSERT INTO Animales (nombre_animal, especie_a, raza_a, edad, peso_a, sexo_a, info_adicional_a, fk_usuario) VALUES
('Rex', 'Perro', 'Labrador', 5, 30.5, 'Macho', 'Color dorado, muy juguetón', 7),
('Mimi', 'Gato', 'Siames', 3, 4.2, 'Hembra', 'Color gris, ojos azules', 2),
('Nibbles', 'Hámster', 'Sirio', 1, 0.1, 'Macho', 'Color marrón, muy curioso', 6),
('Polly', 'Perico', 'Australiano', 2, 0.05, 'Hembra', 'Plumaje verde, canta mucho', 14),
('Rocky', 'Perro', 'Pastor Alemán', 6, 35.0, 'Macho', 'Color negro y marrón, entrenado en obediencia', 5),
('Whiskers', 'Gato', 'Persa', 4, 3.5, 'Hembra', 'Color blanco, pelaje largo', 3),
('Squeaky', 'Hámster', 'Ruso', 2, 0.09, 'Macho', 'Color gris, muy activo', 10),
('Tweety', 'Perico', 'Argentino', 1, 0.04, 'Hembra', 'Color amarillo, muy sociable', 8),
('Luna', 'Perro', 'Golden Retriever', 5, 28.0, 'Hembra', 'Color dorado, le encanta nadar', 9),
('Shadow', 'Gato', 'Maine Coon', 3, 5.0, 'Macho', 'Color negro, gran tamaño', 1),
('Biscuit', 'Hámster', 'Chino', 1, 0.08, 'Hembra', 'Color beige, muy rápido', 11),
('Sunny', 'Perico', 'Africano', 3, 0.06, 'Macho', 'Plumaje multicolor, muy hablador', 5),
('Bella', 'Perro', 'Poodle', 2, 6.0, 'Hembra', 'Color blanco, pelaje rizado', 13),
('Simba', 'Gato', 'Bengala', 2, 4.8, 'Macho', 'Color naranja, pelaje con manchas', 4),
('Pip', 'Hámster', 'Roborovski', 1, 0.07, 'Macho', 'Color marrón claro, muy pequeño', 15),
('Buddy', 'Perro', 'Beagle', 4, 12.0, 'Macho', 'Color tricolor, muy activo', 1),
('Sasha', 'Gato', 'Ragdoll', 3, 4.5, 'Hembra', 'Color blanco, ojos azules', 12),
('Fluffy', 'Hámster', 'Sirio', 2, 0.12, 'Hembra', 'Color gris, muy peludo', 10),
('Rio', 'Perico', 'Australiano', 1, 0.05, 'Macho', 'Plumaje azul, canta todo el día', 4),
('Zeus', 'Perro', 'Bulldog', 5, 25.0, 'Macho', 'Color blanco y marrón, muy leal', 2);


INSERT INTO citas (fk_animal, fk_usuario, fecha, hora, motivo_cita) VALUES
(10, 1, '2023-10-07', '19:50:00', 'Vacunación para Shadow'),
(3, 6, '2023-01-17', '08:02:00', 'Chequeo anual para Nibbles'),
(1, 7, '2023-12-11', '09:42:00', 'Consulta general para Rex'),
(12, 5, '2024-05-06', '09:23:00', 'Control de peso para Sunny'),
(7, 10, '2023-06-21', '11:12:00', 'Revisión dental para Squeaky'),
(19, 4, '2024-10-09', '10:18:00', 'Chequeo anual para Polly'),
(4, 14, '2023-10-10', '08:10:00', 'Desparasitación para Polly'),
(6, 3, '2024-09-12', '14:19:00', 'Consulta dermatológica para Whiskers'),
(8, 8, '2024-04-30', '10:17:00', 'Corte de uñas para Tweety'),
(9, 9, '2024-05-29', '17:03:00', 'Consulta general para Luna'),
(11, 11, '2024-04-20', '20:09:00', 'Chequeo anual para Biscuit'),
(5, 5, '2024-05-09', '16:15:00', 'Control de peso para Rocky'),
(13, 13, '2023-06-06', '10:59:00', 'Consulta general para Bella'),
(9, 9, '2024-03-13', '10:33:00', 'Control de peso para Luna'),
(15, 15, '2023-11-23', '15:23:00', 'Revisión dental para Pip'),
(2, 2, '2024-02-02', '16:01:00', 'Vacunación para Mimi'),
(17, 12, '2024-11-01', '17:30:00', 'Consulta general para Mimi'),
(18, 10, '2023-08-02', '11:17:00', 'Control de peso para Nibbles'),
(14, 4, '2024-04-28', '13:33:00', 'Desparasitación para Simba'),
(20, 2, '2023-12-04', '09:10:00', 'Desparasitación para Rocky'),
(6, 3, '2023-08-22', '11:42:00', 'Vacunación para Whiskers'),
(7, 10, '2024-10-22', '12:32:00', 'Revisión dental para Squeaky'),
(8, 8, '2023-02-20', '09:40:00', 'Consulta general para Tweety'),
(16, 1, '2024-06-16', '13:56:00', 'Vacunación para Rex'),
(10, 1, '2024-08-15', '11:11:00', 'Chequeo anual para Shadow');

insert into productos(nombre_producto, precio, descripcion, stock)
values 
('Shampoo para perros', 135.50, 'Shampoo especial para perros, cuida su pelaje y piel', 50),
('Alimento para gatos', 300.00, 'Alimento balanceado para gatos adultos', 100),
('Collar antipulgas para gatos', 125.99, 'Collar que repele pulgas y garrapatas para gatos', 30),
('Juguete para perros', 45.75, 'Juguete mordedor para perros de tamaño mediano', 80),
('Rueda para correr', 170.00, 'Rueda para hamsters corredores', 120),
('Arena para gatos', 8.50, 'Arena para la bandeja sanitaria de gatos', 60),
('Jaula espaciosa', 65.00, 'Jaula para pericos con mucho más espacio', 20),
('Suplementos nutricionales', 183.25, 'Nutrientes para tus mascotas', 15),
('Comedor y bebedero', 180.50, 'Comedor y bebedero para tu hamster', 10),
('Correa retráctil para perros', 50.00, 'correa extensible para pasear a perros de manera cómoda', 40);

insert into ventas(cantidad_ve, fecha, fk_usuario, fk_producto)
values
(3, '2024-01-18', 1, 8),
(2, '2023-10-23', 2, 10),
(1, '2024-04-03', 3, 2),
(4, '2023-10-23', 4, 6),
(5, '2024-06-05', 5, 9),
(7, '2024-09-26', 6, 4),
(3, '2024-03-07', 7, 7),
(1, '2024-05-10', 8, 1),
(6, '2023-01-29', 9, 5),
(2, '2024-05-10', 10, 3),
(10, '2023-05-25',3,5),
(6, '2024-01-18', 1, 8),
(3, '2023-11-03', 2, 1),
(1, '2024-07-08', 3, 2),
(9, '2023-12-23', 4, 6);

-- Registro de la tabla "metodo_pago_tarjeta"
insert into metodo_pago_tarjeta (num_tarjeta, cvv, fecha_caducidad, tipo_tarjeta, fk_usuario) values
	(12345678, 123, '2025-12-31', 'Debito',1),
    (98765432, 456, '2026-06-30', 'Credito',2),
    (45678901, 789, '2027-03-31', 'Debito',3),
    (67890123, 159, '2028-09-30', 'Credito',4),
    (90123456, 753, '2029-12-31', 'Debito',5),
    (23456789, 951, '2030-06-30', 'Credito',6),
    (56789012, 357, '2031-03-31', 'Debito',7),
    (89012345, 753, '2032-09-30', 'Credito',8),
    (34567890, 159, '2033-12-31', 'Debito',9),
    (61234567, 951, '2034-06-30', 'Credito',10);

update ventas set monto_total=(ventas.cantidad_ve*(select precio from productos limit 1));
select * from ventas;


-- #Vista que devuelve las citas realizadas en el ultimo mes "Vista"
create view citas_ultimo_mes as
select * from Animales 
where id_animal in (select fk_animal from citas 
where fecha<=now() and fecha>=date_sub(now(), interval 1 month));
select * from citas_ultimo_mes;

-- #Indice que busca los datos por medio de la edad "Index"
create index idx_edad on Animales(edad);  
select nombre_animal from Animales where edad between 0 and 2; 

-- #Consulta para saber que producto se han vendido mas el ultimo mes, tomando en cuenta al cantidad vendida "Subconsulta"
select productos.nombre_producto, productos.stock, sum(ventas.cantidad_ve) as Productos_vendidos  from productos  
join ventas on ventas.fk_producto=productos.id_producto 
where productos.id_producto in 
(select ventas.fk_producto from ventas where ventas.fecha>=date_sub(now(), interval 1 month))
GROUP BY productos.id_producto, productos.nombre_producto, productos.stock;

-- #Consulta que devuelve cuantos productos se han vendido sin limite de tiempo "Sum()"
select productos.nombre_producto, sum(ventas.cantidad_ve) as Cantidad_Vendido 
from productos 
join ventas on ventas.fk_producto=productos.id_producto 
group by productos.id_producto 
Order by cantidad_vendido desc;

-- #Consulta que calcula la cantidad de animales registrados, ordenados por su raza "Count()"
select count(especie_a) as Total_de_animales, especie_a as Especie, raza_a as Raza from Animales group by raza_a, especie_a;

-- Consulta que indica el usuario que ha solicitado mas citas en el ultimo mes "max()"
alter table usuarios add column citas_totales int;
select id_usuario, nombre_usuario, citas_totales as Total_de_citas 
from usuarios 
where citas_totales=(select max(citas_totales) from usuarios)
and id_usuario in 
(select fk_usuario from citas where 
fecha>=date_sub(now(), interval 6 month))
group by id_usuario;

-- #Consulta que develve el producto que ha tenido menos ventas sin limite de tiempo "min()"
select productos.nombre_producto as Producto, ventas.cantidad_ve as Cantidad_Vendido,
 ventas.fecha as Fecha_Venta from productos 
 join ventas on ventas.fk_producto=productos.id_producto 
where (ventas.fecha>=date_sub(now(), interval 4 month) 
and fecha<=now()) and ventas.cantidad_ve in (select min(cantidad_ve)
 from ventas);

-- #Consulta del promedio de ganancias por ventas de producto, relializada en el año 2024  y agrupadas por cada mes. "Avg()"
select month(fecha) as Mes, avg(monto_total) as Promedio_Ventas 
from ventas 
where year(fecha)='2024' 
group by month(fecha) 
order by Promedio_Ventas desc;

-- Consulta que calcula la cantidad de animales, agrupados por la raza, que han agendado una cita en el ultimo ano "Group by"
select Animales.raza_a, count(citas.fk_animal) as Cantidad_de_animales_enfermos from Animales join citas on citas.fk_animal=Animales.id_animal 
where citas.fecha<=now() and citas.fecha>=date_sub(now(), interval 1 year) group by Animales.raza_a;

-- #Consulta que muestra una lista de todos los productos disponibles, ordenandolos de mayor a menor conforme a las ventas que tuvieron en el ultimo mes "Order by"
select productos.nombre_producto, sum(ventas.cantidad_ve) as Total_vendido from productos 
join ventas on ventas.fk_producto=productos.id_producto  where ventas.fecha<=now() and ventas.fecha>=date_sub(now(), interval 1 month)
group by productos.id_producto
order by Total_vendido asc;

#Procedimientos
DELIMITER //
create procedure InsertarCitas()
	Begin 
    declare i int default 1;
    while i<=15 do
		update usuarios set citas_totales=(select count(id_cita) from citas where fk_usuario=i group by fk_usuario) where id_usuario=i;
        set i=i+1;
        end while;
	end;
delimiter //
call InsertarCitas;
drop procedure InsertarCitas;



--                                               CONSULTAS: TRIGGER

-- 1. Disparador de registro de cambios de precios: Crea un disparador que se active después de actualizar el precio de un producto en una tabla 
-- de productos. Este disparador debería registrar automáticamente el cambio de precio en una tabla de registro de cambios de precios, 
-- incluyendo el ID del producto, el precio anterior y el nuevo precio.
DELIMITER //
create trigger actualizar_productos after update on productos
for each row 
begin
	IF OLD.precio != NEW.precio THEN
        INSERT INTO cambio_productos (id_producto, accion, nombre_producto, precio_anterior, precio_actual, descripcion, stock)
        VALUES (NEW.id_producto, 'UPDATE', NEW.nombre_producto, OLD.precio, NEW.precio, NEW.descripcion, NEW.stock);
    END IF;
end //

Delimiter ;


-- 2. Disparador de bloqueo de cuenta: Desarrolla un disparador que se active después de un intento fallido de inicio de sesión en un sistema. 
-- Este disparador debería verificar si el usuario ha excedido un cierto número de intentos de inicio de sesión fallidos y, si lo ha hecho, 
-- bloquear automáticamente su cuenta y enviar una notificación al administrador.

delimiter //
create trigger Bloqueo_de_cuentas
after insert on  intento_login
for each row
begin
declare temp_password varchar(8);
 
select contraseña into temp_password from usuarios
where id_usuario = new.fk_id_usuario;
    
 if  new.contraseña_usuario_intento = temp_password then 
 update usuarios
 set intentos_fallidos = 0
 where id_usuario = new.fk_id_usuario;
 
  insert into temp_results_login
set coincidencia1 = true ,  id_intento1 = new.id_intento; 
   
   else 
    
update usuarios
 set intentos_fallidos = intentos_fallidos + 1
 where id_usuario = new.fk_id_usuario;
 
insert into temp_results_login
	set coincidencia1 = false ,  id_intento1 = new.id_intento;
 
 
 if (select intentos_fallidos from usuarios where id_usuario = new.fk_id_usuario)>=5 then 
 update usuarios set cuenta_bloqueada =true
  where id_usuario = new.fk_id_usuario;
  
 end if;
 end if;
 end //
 delimiter ;
 

 insert into  intento_login (fk_id_usuario, contraseña_usuario_intento) values 
(1, 'abc12344');


-- 3. Disparador de auditoría de eliminación de datos sensibles: Crea un disparador que se active después de eliminar una fila de una tabla 
-- que contiene datos sensibles, como información financiera o datos personales. Este disparador debería registrar automáticamente los detalles
-- de la eliminación en una tabla de registro de auditoría, incluyendo el usuario que realizó la eliminación y la fecha y hora en que ocurrió.

 select * from metodo_pago_tarjeta;
 
 Delimiter //
 create trigger actualizar_registro
 after delete on metodo_pago_tarjeta
 for each row
	begin
		insert into registro_auditoria (accion, fk_usuario, num_tarjeta, cvv) values
        ('delete', old.fk_usuario, old.num_tarjeta, old.cvv);
        end //
delimiter ;
delete from metodo_pago_tarjeta where cvv=159;
select * from registro_auditoria;


-- 4. Disparador de generación de código único: Desarrolla un disparador que se active después de insertar una nueva fila en una tabla de 
-- clientes. Este disparador debería generar automáticamente un código único para cada cliente basado en su nombre y apellido, y actualizar 
-- el campo correspondiente en la tabla con el código generado.
alter table usuarios add codigo_unico varchar(20);

delimiter //
create trigger codigo_unico
before insert on usuarios
for each row
begin
    declare codigo varchar(20);
    declare rnd int;

    set rnd = floor(rand() * 1000);
    set codigo = concat(substring(new.nombre_usuario, 1, 3), substring(new.apellido_usuario, 1, 3), rnd);
    set new.codigo_unico = codigo;
end //
delimiter ;

insert into usuarios (nombre_usuario, apellido_usuario, contraseña, telefono, correo) values
('Ana', 'Martínez', 'xyz12345', '555-1111', 'ana.martinez@example.com'),
('José', 'Fernández', 'abc98765', '555-2222', 'jose.fernandez@example.com'),
('Laura', 'Gómez', 'pass6543', '555-3333', 'laura.gomez@example.com');

select * from usuarios;

-- 5.- Disparador de control de stock mínimo: Crea un disparador que se active después de actualizar la cantidad disponible de un producto en 
-- una tabla de inventario. Este disparador debería verificar si la nueva cantidad es menor que el stock mínimo establecido para ese producto y, si 
-- lo es, enviar una notificación al departamento de compras para abastecer el producto.

create table control_inventario_minimo(
id_control int primary key auto_increment,
nombre_producto varchar(30),
stock int, 
fecha timestamp default current_timestamp,
msg varchar(50));

Delimiter //
create trigger control_stock_minimo
after update on productos
for each row
begin
	if new.stock<8 then
	insert into control_inventario_minimo(nombre_producto, stock, msg)
    values(new.nombre_producto, new.stock, 'Stock por debajo de la cantidad recomendada');
    else 
    delete from control_inventario_minimo where 
    nombre_producto in (select nombre_producto from productos where stock>8);
    end if;
end //
delimiter ;

-- 														PROCEDIMIENTOS ALMACENADOS

-- 1. Procedimiento Almacenado para calcular el total de ventas por cliente: 
-- Desarrolla un procedimiento almacenado que acepte el ID del cliente como parámetro de entrada y devuelva el total de ventas 
-- realizadas por ese cliente.

DELIMITER //
CREATE PROCEDURE DetalleVentasPorCliente(IN clienteID INT)
BEGIN
    SELECT 
        v.fk_usuario AS id_cliente,
        v.cantidad_ve AS cantidad_vendida,
        p.precio AS precio_producto,
        (v.cantidad_ve * p.precio) AS total_venta
    FROM 
        ventas v
    JOIN 
        productos p ON v.fk_producto = p.id_producto
    WHERE 
        v.fk_usuario = clienteID;
END //
DELIMITER ;
call DetalleVentasPorCliente(2);

-- 2. Procedimiento Almacenado para obtener el nombre del departamento en el que se encuentra un animal:
-- Crea un procedimiento almacenado que acepte el ID del animal como parámetro de entrada y devuelva el nombre del departamento 
-- en el que se encuentra ese animal.
delimiter //
create procedure animales_departamentos(
p_id_animal int)
begin
select 
d.nombre_departamento,
a.nombre_animal,
a.especie_a
from animales a
join
departamentos d on a.fk_departamento = d.id_departamento
where a.fk_departamento = p_id_animal
order by a.nombre_animal;
end //
delimiter ;
    
call animales_departamentos(12);

-- 3. Procedimiento Almacenado para generar un informe de inventario: 
-- Desarrolla un procedimiento almacenado que genere un informe de inventario que incluya el nombre, la cantidad disponible y el
-- precio de todos los productos en stock.

Delimiter //
create procedure informe_de_inventario()
begin
	select id_producto, nombre_producto, precio, stock from productos;
end //
Delimiter ;

call informe_de_inventario;

-- 4. Procedimiento Almacenado para calcular la edad promedio de las mascotas de los clientes: 
-- Crea un procedimiento almacenado que calcule la edad promedio de todos los clientes en la base de datos.
delimiter //
create procedure promedio_edad()
	begin
		select avg(edad) from Animales;
	end //
delimiter ;
drop procedure promedio_edad;

call promedio_edad();



-- PROCEDIMIETOS ALMACENADOS
-- 5.Procedimiento ALmacenado para obtener la lista de pedidos pendietes: desarrolla 
-- un procedimiento almacenado que devuelva la lista de pedido que aun no se han completado.

create table pedidos(
id_pedido int primary key  auto_increment,
fk_producto int ,
foreign key(fk_producto) references productos(id_producto), 
fk_usuario int , 
foreign key(fk_usuario) references usuarios(id_usuario),
cantidad int , monto_total float,
estado_entrega boolean
);

insert into pedidos(fk_producto,fk_usuario, cantidad,estado_entrega) values 
(6, 13, 10, true),(9, 4, 2, false),(5, 5, 7, true),(10, 12, 1, false),(2, 7, 4, true),
(3, 1, 8,false),(1, 9, 6, false),(5, 10, 9, true),(8,3,2,false),(1,11,1,true);

delimiter //
create trigger actualizar_monto_total
before insert on pedidos
for each row
begin
    declare precio float;
    
    select precio into precio
    from productos 
    where id_producto = new.fk_producto;
    
    set new.monto_total = precio * new.cantidad;
end $$
delimiter ;

-- Procedimiento Almacenado

delimiter //
create procedure pedidos_pendientes()
begin
	select * from pedidos where estado_entrega = false; 
end //
delimiter ;
 call pedidos_pendientes;

-- 6.Procedimiento Almacenado para validar la disponibilidad de stock: Crea un procedimiento almacenado 
-- que acepte el ID del producto y la cantidad deseada como parámetros de entrada, y verifique si 
-- hay suficiente stock disponible para satisfacer el pedido

delimiter //
create procedure suficiente_stock( id_prod_ing int , can_salida int ) 
begin
declare cantidad_actual int ;
declare Mensaje_Aviso varchar(255);
 set cantidad_actual = (select stock from productos where id_prod_ing = id_producto );
 if (cantidad_actual < can_salida) then 
set Mensaje_Aviso = 'No existe sufuciente stock del producto ingresado';
else 
set Mensaje_Aviso = 'Existe sufuciente stock del producto ingresado';
end if ; 
select Mensaje_Aviso;
end //
delimiter ;

call suficiente_stock(2,101);
call suficiente_stock(2,100);
drop procedure suficiente_stock;
select * from productos;






-- PORTAFOLIO.- TRANSACCIONES
-- 1.Actualización de inventario y registro de transacción.
-- 2.Transferencia de fondos y actualización de registros.
-- 3.Cambio de estado de un pedido y actualización de registros.
-- 4.Actualización de información del cliente y registro de auditoría.
delimiter //
create trigger actualizar_usuarios after update on usuarios
for each row
	begin
    insert into registro_usuarios (accion, nombre_usuario, fk_usuario, contraseña, telefono, correo)
    values ('Update',new.nombre_usuario, new.id_usuario, new.contraseña, new.telefono, new.correo);
    end //
delimiter ;
select * from usuarios;

delimiter //
start transaction;
update usuarios set contraseña = '7654321'
where id_usuario=2; 
commit //
delimiter ;
select * from registro_usuarios;	


-- 5.Eliminación de un registro y registro de acción.
delimiter //
create trigger actualizador_registro_animales
after delete on animales
for each row
begin
    insert into registro_mascotas (accion, id_animal, nombre_animal,
    especie_a, raza_a, 
    edad, peso_a, sexo_a, info_adicional_a, fk_usuario, fk_departamento)
    values ('delete', old.id_animal, old.nombre_animal, old.especie_a, old.raza_a, 
    old.edad, old.peso_a, old.sexo_a, old.info_adicional_a, old.fk_usuario, old.fk_departamento);
    
    end //
delimiter ;


delimiter //
create procedure borrar_mascota(in id_ani int)
begin
    start transaction;
 delete from animales where id_animal = id_ani;
    commit;
end //
delimiter ;

call borrar_mascota(21);

select * from animales;
select * from registro_mascotas;
select * from citas;
drop procedure borrar_mascota;
drop table registro_mascotas;