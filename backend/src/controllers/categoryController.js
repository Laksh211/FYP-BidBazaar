const bcryptjs = require("bcryptjs");
const complaintModel = require("../models/complaint_model");
const categoryModel = require("../models/categ_model");


const categopryController = {

    createCategory: async function (req, res) {
        try {
            const {title,description} = req.body;//data send   

            const newCat = new categoryModel(
                {
                    title:title,
                    description:description
                }
            );

            await newComplaint.save();//data save to database
            return res.json({ success: true, message: "Category successfully created", data: newCat });
        } catch (e) {
            return res.json({ success: false, message: `Category creation an error occured  ${e}` });
        }

    },


};



module.exports = categopryController;