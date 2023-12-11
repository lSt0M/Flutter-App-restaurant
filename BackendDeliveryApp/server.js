const express = require('express');
const app = express ();
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');
const multer =  require('multer');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');
const passport = require('passport');
const io = require('socket.io')(server);
const mercadopago = require('mercadopago');


/*
* configuracion de mercado pago
*/
mercadopago.configure({
    access_token:'TEST-530896369771023-050202-764ffb664d79afcdef2b0c270506aeb3-1365082736'
});


/*
* SOCKETS
*/
const orderDeliverySocket = require('./sockets/orders_delivery_socket');



/*
*INICIALIZAR FIREBASE ADMIN
*/
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
})

const upload = multer({
    storage: multer.memoryStorage()
})
 

/*
*RUTAS
*/
const users = require('./routes/usersRoutes');
const categories = require('./routes/categoriesRoutes');
const products = require('./routes/productsRoutes');
const address = require('./routes/addressRoutes');
const orders = require('./routes/ordersRoutes');
const mercadopagoRoutes = require('./routes/mercadoPagoRoutes');


const port = process.env.PORT || 3000;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use(cors());
//app.use(passport.initialize());
//app.use(passport.session());
//require('./config/passport')(passport);

app.disable('x-powered-by');

app.set('port', port);

//LLAMANDO A LOS SOCKETS
orderDeliverySocket(io);

/*
* LLAMANDO A LAS RUTAS
*/
users(app, upload);
categories(app);
address(app);
orders(app);
products(app, upload);
mercadopagoRoutes(app);



server.listen(3000, '192.168.0.113' || 'localhost', function(){
    console.log('Aplicacion de Nodejs ' + port + 'Iniciada...')
});


//manejo de error
app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
});


module.exports = {
    app: app,
    server: server,
};



//200 respuesta exitosa
//404 url no existe
//500 error interno del servidor 