const mercadopago = require('mercadopago');
const Order = require('../models/order');
const OrderHasProduct = require('../models/order_has_products');
const User = require('../models/user');


mercadopago.configure({
    sandbox: true,
    access_token: 'TEST-530896369771023-050202-764ffb664d79afcdef2b0c270506aeb3-1365082736'
});


module.exports = {

    async createPaymentCreditCart(req, res, next) {
        let payment = req.body;
        console.log(`PAYMENT: ${JSON.stringify(payment)}`);
        
        const payment_data = {
            description: payment.description,
            transaction_amount: payment.transaction_amount,
            installments: payment.installments,
            payment_method_id: payment.payment_method_id,
            token: payment.token,
            issuer_id: payment.issuer_id,   
            payer: {
                email: payment.payer.email,
                identification: {
                    type: payment.payer.identification.type,
                    number: payment.payer.identification.number,
                }
            }
        }
        console.log(`PAYMENT DATA: ${JSON.stringify(payment_data)}`);

        const data = await mercadopago.payment.create(payment_data).catch((err) => {
            console.log(err);
            return res.status(501).json({
                message: 'Error al creal el pago',
                success: false,
                error: err
            });
        });

        if (data) {
            console.log('Si hay datos correctos', data.response);
            if (data !== undefined) {
                const payment_type_id = module.exports.validatePaymentMethod(payment.payment_type_id);
                payment.id_payment_method = payment_type_id;

                let order = payment.order;

                order.status = 'PAGADO';
                const orderdata = await Order.create(order);

                //aca recorro todos los productos agregados a la orden
                for (const product of order.products) {
                    await OrderHasProduct.create(orderdata.id, product.id, product.quantity);
                }
 
                return res.status(201).json(data.response);
            }
        } else {
            return res.status(501).json({
                message: 'Error algun dato esta mal en la peticion',
                success: false
            });
        } 
    },


    validatePaymentMethod(status) {
        if (status == 'credit_cart') {
            status == 1
        }
        if (status == 'bank_transfer') {
            status == 2
        }
        if (status == 'ticket') {
            status == 3
        }
        if (status == 'upon_delivery') {
            status == 4
        }
        return status;
    }

}

