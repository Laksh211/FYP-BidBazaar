const mongoose = require('mongoose');


var complaintSchema = new mongoose.Schema({
    buyer:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        required:true
    },
    reason:{
        type:String,
        required:true
    },
    explanation:{
    type:String,
    default:"" 
    },
});

complaintSchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


complaintSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;
next();
});



const  complaintModel= mongoose.model("Complaint",complaintSchema);

module.exports = complaintModel;