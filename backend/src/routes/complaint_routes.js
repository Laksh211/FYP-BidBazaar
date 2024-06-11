const complaintController = require('../controllers/complaint_controller');

const complaintRoutes = require('express').Router();




complaintRoutes.post("/add",complaintController.createComplaint
);//default function shift to user_controller

complaintRoutes.get("/get",complaintController.getAllcomplaint
);

module.exports=complaintRoutes;