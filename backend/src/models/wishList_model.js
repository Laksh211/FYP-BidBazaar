const mongoose  = require("mongoose");


const wishListSchema =  mongoose.Schema({//nested object
    user:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User',
        required:true
    },
    product:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Product',
    },
}); 


wishListSchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


wishListSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;
next();
});



const wishListModel=mongoose.model("wishList",wishListSchema);

module.exports=wishListModel;