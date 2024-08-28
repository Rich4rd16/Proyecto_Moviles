const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');

/*
* RUTAS
*/
const users = require('./routes/usersRoutes');


const port = process.env.PORT || 3000;

app.use(logger('dev')); //debugear posibles errores en el backend
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use(cors());

app.disable('x-powered-by');

app.set('port', port);

/*
* LLAMANDO A LAS RUTAS
*/

users(app);

server.listen(3000, '192.168.18.157'  || 'localhost', function() {
    console.log('Aplicacion de nodejs ' + port + ' Iniciada... ')
});


//Configuracion para errores

app.use((err,req,res,next) => { 
    console.log(err);
    res.status(err.status || 500).send(err.stack); //Para capturar los errores 
})

module.exports ={ // Para usar estas variables en otros archivos
    app: app,
    sever: server
}

// 200 Ruta exitosa
// 404 URL no existe
// 500 Error interno dle servidor (En caso de escribir un código erroneo)