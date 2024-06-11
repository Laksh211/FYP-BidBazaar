const categopryController = require('../controllers/categoryController');

const categoryRoutes = require('express').Router();




categoryRoutes.post("/add",categopryController.createCategory
);//default function shift to user_controller


module.exports=categoryRoutes;