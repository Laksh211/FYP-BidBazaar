const orderController = require('../controllers/order_controller');

const orderRoutes= require('express').Router();




orderRoutes.post("/create",orderController.createOrder);
orderRoutes.get("/fetch/:buyerId",orderController.fetchOrders);
orderRoutes.get("/fetchForSeller/:sellerId",orderController.fetchordersForSeller);
orderRoutes.post("/statusupdate",orderController.updateOrderStatus);




module.exports=orderRoutes;