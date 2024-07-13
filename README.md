# Conexion_base-_de-_datos
Conectar de la pagina web con la base de datos, almacenando los datos proporcionado por un formulario.


El programa cuenta por un lado, una vista de EJS, misma que presenta un formulario en el que el usuario ingresara los datos de su mascota para registrarla dentro de nuestra veterinaria, adicionalmente se presentan archivos estáticos de CSS, para brindarle diseño al formulario y un archivo de js, para añadirle la funcionalidad extra de modificar las opciones que se muestran en el input para seleccionar raza, en virtud de lo seleccionado en la casilla de especie de la mascota.
Para la conexión a la base de datos relacional Mysql, se utiliza el paquete “mysql2” y a Node.js y su framework Express, para gestionar la lógica y la comunicación del lado del servidor.  

Endpoints de la API:
De momento la API cuenta con 2 endpoints:

server.get ("/registromascotas")  
Este es un Endpoint muy sencillo, al ingresar la dirección   http://localhost:3000/registromascotas, como respuesta la pagina nos va renderizar la vista index.ejs, mostrándonos el formulario, para el registro de nuevos animales dentro de la veterinaria. El usuario tras llenar la información y presionar el botón “enviar”, hace que el navegador envía una solicitud "post" a el endpoint de /validar con los datos del formulario.  

server.post("/verificar")  
Este endpoint recibe los datos ingresados en el formulario, y mediante el paquete “body-parse” lo puede analizar y almacenar en una lista.
Tras almacenar los datos, realiza una consulta en el query para acceder a los animales que tiene registrado el cliente que acaba de llenar el formulario, de modo que el mismo dueño no registre a la misma mascota dos veces, soltando una alerta en caso de que se presente el duplicado de datos, impidiendo que se realicen dos registros iguales. Si no se encuentra un registro duplicado, mediante una insercion en el query, se alamacenan  los datos de la nueva mascota en la tabla “Animales” dentro de la base de datos.

                                                                                                                          

