const wishListController = require("../controllers/wishList_controller");

const wishListRoutes= require('express').Router();

wishListRoutes.post("/",wishListController.wishListItem);

wishListRoutes.get("/:user",wishListController.getWishList);


module.exports=wishListRoutes;