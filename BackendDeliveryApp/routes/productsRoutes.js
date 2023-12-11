const productsController = require('../controllers/productsController');
const passport = require('passport');


module.exports = (app, upload) => {

    app.get('/api/products/findByCategory/:id_category', productsController.findByCategory);
    //app.get('/api/products/findByCategory/:id_category',passport.authenticate('jwt', {session: false}), productsController.findByCategory);
    app.get('/api/products/findByCategoryAndProductName/:id_category/:product_name', productsController.findByCategoryAndProductName);
    //app.get('/api/products/findByCategoryAndProductName/:id_category/:product_name',passport.authenticate('jwt', {session: false}), productsController.findByCategoryAndProductName);

    app.post('/api/products/create', upload.array('image', 3), productsController.create);
    //app.post('/api/products/create',passport.authenticate('jwt', {session: false}), upload.array('image', 3), UsersControllers.registerWithImage);
}