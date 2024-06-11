const catController = require('../controllers/category_controller');

const catRouter = require('express').Router();




//createCategory
catRouter.post("/",catController.createCat
);//default function shift to user_controller
//getAllCategories
catRouter.get("/",catController.fetchCat
);//default function shift to user_controller
catRouter.get("/:id",catController.fetchCatById
);//default function shift to user_controller



module.exports=catRouter;