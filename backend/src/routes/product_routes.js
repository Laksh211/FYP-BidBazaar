const productController = require('../controllers/product_controller');

const productRoute= require('express').Router();





productRoute.post("/",productController.createProduct
);//default function shift to user_controller

productRoute.get("/",productController.getAllProducts
);//default function shift to user_controller

productRoute.get("/category/:id",productController.getAllProductsById
);//default function shift to user_controller
productRoute.get("/userId/:user",productController.getUserProduct);

productRoute.post("/wishListProduct",productController.wishListProduct
);
productRoute.post("/RemoveProduct",productController.removeFromProducts
);

productRoute.post("/updateProduct",productController.updateProduct
);
productRoute.post("/soldqty",productController.updateSoldQty
);
productRoute.post("/renew",productController.renewProduct
);


module.exports=productRoute;