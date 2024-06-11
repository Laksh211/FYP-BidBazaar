const emailController = require('../controllers/email_controller');

const emailRoutes = require('express').Router();




emailRoutes.post("/sentEmail",emailController.sentemailOTP
);//default function shift to user_controller



module.exports=emailRoutes;