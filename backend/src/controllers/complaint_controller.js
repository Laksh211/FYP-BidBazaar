const bcryptjs = require("bcryptjs");
const complaintModel = require("../models/complaint_model");


const complaintController = {

    createComplaint: async function (req, res) {
        try {
            const {buyerid,reason,complaintExplanation} = req.body;//data send    
            const newComplaint = new complaintModel(
                {
                    buyer:buyerid,
                    reason:reason,
                    explanation:complaintExplanation
                }
            );

            await newComplaint.save();//data save to database
            return res.json({ success: true, message: "account successfully created", data: newComplaint });
        } catch (e) {
            return res.json({ success: false, message: `account creation an error occured  ${e}` });
        }

    },

    
    getAllcomplaint:async function(req,res){
        try{
            const complaints = await complaintModel.find().populate("buyer");           
            return res.json({success:true,message:"complaints Found",data:complaints}); 
        }catch(e){
            return res.json({success:false,message:`Erorr complaints Not Found   ${e}`});
        }
    },

};



module.exports = complaintController;