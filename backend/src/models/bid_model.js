const mongoose  = require("mongoose");
const customDate = require("../controllers/date_controller");

const bidProductSchema = new mongoose.Schema({//same as order but different logic
    product:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Product',
    },
    quantity:{
        type:Number,
        default:1
    },
    status:{
        type:String,
        default:"bid succefully placed" ,
    },
    bidprice:{
        type:Number,
        default:0 ,
    },
    createdat: {
        type: String,
        default: customDate.getStringFormattedDate() // Set default value to current date and time
    },
});


const bidSchema =  mongoose.Schema({//nested object
    seller:{
        type:mongoose.Schema.ObjectId,
        ref:"User",
        required:true

    },
    buyer:{
        type:mongoose.Schema.ObjectId,
        ref:"User",
        required:true
    },
    items:{
    type:[bidProductSchema],
    default:[],
    },
  

}); 


bidSchema.pre("save",function(next){//save ke time kiya hoga
    next();
});


bidSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
delete update._id;//the _id is  immutable we hhave delete it also mongoose implicitly do that
next();
});



const bidModel=mongoose.model("Bid",bidSchema);

module.exports=bidModel;
