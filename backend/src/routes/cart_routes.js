const cartController = require("../controllers/cart_controller");

const cartRoutes= require('express').Router();

cartRoutes.post("/",cartController.addToCart);

cartRoutes.delete("/",cartController.removeFromCart);

cartRoutes.patch("/",cartController.updateFromCart);

cartRoutes.get("/:user",cartController.getAllFromCart);

cartRoutes.post("/removeAllFromCart",cartController.removeAllFromCart);

module.exports=cartRoutes;
