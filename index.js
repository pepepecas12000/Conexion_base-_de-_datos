const express = require("express");
 const bodyParser= require("body-parser");
 const cors =require("cors")
 const server =express();
 const path=require('path');
 server.use(bodyParser.urlencoded({extended: false}))
 server.use(bodyParser.json());
 server.use(cors());


 server.set('views', path.join(__dirname, 'views'));
 server.set("view engine", "ejs")

 server.use(express.static(path.join(__dirname, 'public')));


 server.use(express.static(path.join(__dirname, 'app')));




 const db= require("mysql2");
 const conn=db.createConnection({
 host: "localhost",
 user: "root",
 password: "juanito1",
 database: "Vet2care",
 port: 3306,
 });

 conn.connect((err)=> {
    if(err){
        console.log("Error connection to database", err);
    }else{
    console.log("Connected to database");
}});

server.get("/registromascotas", (req,res)=>{
    res.render("index")
})



server.post("/validar", (req, res) => {
    const { NombreA, EspecieA, RazaA, EdadA, PesoA, SexoA, DescripcionColorA } = req.body;

    conn.query("SELECT * FROM animales WHERE fk_usuario = 3;", (err, trow) => {
        if (err) {
            console.log("Error fetching data", err);
            return res.status(500).send("Error fetching data");
        }

   

       const repetido= trow.some((row) => {
            return row.nombre_animal == NombreA && row.especie_a == EspecieA && row.raza_a == RazaA && row.edad == EdadA && row.peso_a == PesoA && row.sexo_a == SexoA && row.info_adicional_a == DescripcionColorA 
                
            
        });

        if (repetido) {
            console.log("Nombre repetido");
            return res.status(400).send("Repetido todo");
        } else{const insertQuery = `
                INSERT INTO animales(nombre_animal, especie_a, raza_a, edad, peso_a, sexo_a, info_adicional_a, fk_usuario)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?);
            `;
            const insertValues = [NombreA, EspecieA, RazaA, EdadA, PesoA, SexoA, DescripcionColorA, 3];

            conn.query(insertQuery, insertValues, (err, results) => {
                if (err) {
                    console.log("Error inserting data", err);
                    return res.status(500).send("Error inserting data");
                }

                console.log("Data inserted successfully");
                return res.send(results);
            });
        }
    });
});
            

server.listen(3000, () => {
    console.log("Esta madre funciona HAAAA");})