const OrdersController = require('../controllers/ordersController');
const passport = require('passport');


module.exports = (app) => {


    /*
    * GET ROUTES
    */
    app.get('/api/orders/findByStatus/:status', OrdersController.findByStatus);
    //app.get('/api/orders/findByStatus/:status', passport.authenticate('jwt', {session: false}), OrdersController.findByStatus);
    app.get('/api/orders/findByDeliveryAndStatus/:id_delivery/:status', OrdersController.findByDeliveryAndStatus);
    //app.get('/api/orders/findByDeliveryAndStatus/:id_delivery/:status', passport.authenticate('jwt', {session: false}), OrdersController.findByDeliveryAndStatus);
    app.get('/api/orders/findByClientAndStatus/:id_client/:status', OrdersController.findByClientAndStatus);
    //app.get('/api/orders/findByClientAndStatus/:id_client/:status', passport.authenticate('jwt', {session: false}), OrdersController.findByClientAndStatus);
    /*
    * POST ROUTES 
    */ 
    app.post('/api/orders/create',  OrdersController.create);
    //app.post('/api/address/create', passport.authenticate('jwt', {session: false}),  AddressController.create);


    /*
    * PUT ROUTES
    */
    app.put('/api/orders/updateToDispatched',  OrdersController.updateToDispatched);
    //app.put('/api/orders/updateToDispatched', passport.authenticate('jwt', {session: false}),  OrdersController.updateToDispatched);
    app.put('/api/orders/updateToOnTheWay',  OrdersController.updateToOnTheWay);
    //app.put('/api/orders/updateToOnTheWay',passport.authenticate('jwt', {session: false}),  OrdersController.updateToOnTheWay);
    app.put('/api/orders/updateToDelivered',  OrdersController.updateToDelivered);
    //app.put('/api/orders/updateToDelivery',passport.authenticate('jwt', {session: false}),  OrdersController.updateToDelivery);
    app.put('/api/orders/updateLatLng',  OrdersController.updateLatLng);
    //app.put('/api/orders/updateLatLng',passport.authenticate('jwt', {session: false}),  OrdersController.updateLatLng);
}

