const UsersControllers = require('../controllers/usersController');
const passport = require('passport');


module.exports = (app, upload) =>{

    //OBTENER DATOS
    app.get('/api/users/getAll', UsersControllers.getAll);
    app.get('/api/users/findById/:id', UsersControllers.findById);
    //app.get('/api/users/findById/:id',passport.authenticate('jwt', {session: false}), UsersControllers.findById);
    app.get('/api/users/findDeliveryMen', UsersControllers.findDeliveryMen);
    //app.get('/api/users/findDeliveryMen',passport.authenticate('jwt', {session: false}), UsersControllers.findDeliveryMen);
    app.get('/api/users/getAdminsNotificationTokens', UsersControllers.getAdminsNotificationTokens);
    //app.get('/api/users/getAdminsNotificationTokens',passport.authenticate('jwt', {session: false}), UsersControllers.getAdminsNotificationTokens);

    //GUARDAR DATOS
    app.post('/api/users/create', upload.array('image', 1), UsersControllers.registerWithImage);
    app.post('/api/users/login', UsersControllers.login);
    app.post('/api/users/logout', UsersControllers.logout);

    //ACTUALIZAR DATOS
    app.put('/api/users/update', upload.array('image', 1), UsersControllers.update)
    //app.put('/api/users/update', upload.array('image', 1),passport.authenticate('jwt', {session: false}), UsersControllers.update)
    app.put('/api/users/updateNotificationToken', UsersControllers.updateNotificationToken)
    //app.put('/api/users/updateNotificationToken', passport.authenticate('jwt', {session: false}), UsersControllers.updateNotificationToken)
}
