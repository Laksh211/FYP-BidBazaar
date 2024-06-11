const mongoose = require('mongoose');


var categorySchema = new mongoose.Schema({
    title:{
        type:String,
        required:true
    },
    
    description:{
    type:String,
    default:"" 
    },
});

categorySchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


categorySchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;
next();
});



const  categoryModel= mongoose.model("Category",categorySchema);

module.exports = categoryModel;