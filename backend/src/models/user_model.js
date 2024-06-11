const mongoose = require('mongoose');
const uuid = require('uuid');
const bcryptjs = require("bcryptjs");


///for id generate auto we have install package 
// Declare the Schema of the Mongo model

var userSchema = new mongoose.Schema({
    id:{
        type:String,
        unique:true,
        index:true,
    },   
    fullname:{
        type:String,
        required:true,
        index:true,
    },
    email:{
        type:String,
        required:true,
        unique:true,
    },
    mobile:{
        type:String,
        required:true,
        unique:true,
    },
    cnic:{
        type:String,
        required:true,
        unique:true,
    },
    address:{
        type:String,
        default:"",
    },
    password:{
        type:String,
        required:true,

    },
    usertype:{
        type:String,
        required:true,
    },   
    block:{
        type:Boolean,
        required:true,
        default:false,
    },
    verification:{
        type:Boolean,
        required:true,
        default:false
    }, 
    cnicimages:{
        type:Array,
        default:[]
    },
    profileimages:{
        type:Array,
        default:[]
    },
},);

userSchema.pre("save",function(next){//save ke time kiya hoga
        this.id=uuid.v1();        
        this.password=bcryptjs.hashSync(this.password,8);
        next();
});


userSchema.pre(['update','findOneAndUpdate','updateOne'],function(next){
const update= this.getUpdate();
    delete update._id;
    delete update.id;
    // delete this.password;
    next();
});

const UserModel =mongoose.model('User', userSchema);//users collection

//Export the model
module.exports = UserModel;