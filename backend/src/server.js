const express= require('express');
const bodyParser=require('body-parser');
const helmet=require('helmet');
const morgan=require('morgan');
const cors=require('cors');
//for image uploading

const mongoose = require('mongoose');
//all routes
const userRouter=require('./routes/user_routes');
const catRouter = require('./routes/cat_routes');
const productRoute = require('./routes/product_routes');
const cartRoutes = require('./routes/cart_routes');
const bidRoutes = require('./routes/bid_routes');
const image = require('./controllers/image_controller');
const imageRoute = require('./routes/image_route');
const wishListRoutes = require('./routes/wishList_route');
const IP = require('ip');
const emailRoutes = require('./routes/email_routes');
const orderRoutes = require('./routes/order_routes');
const complaintRoutes = require('./routes/complaint_routes');
const categoryRoutes = require('./routes/category_routes');

//Set up default mongoose connection
// var mongoDB = 'mongodb://127.0.0.1/my_database';
// mongoose.connect(mongoDB, { useNewUrlParser: true });
//  //Get the default connection
// var db = mongoose.connection;
// //Bind connection to error event (to get notification of connection errors)
// db.on('error', console.error.bind(console, 'MongoDB connection error:'));
// db.on('error', console.error.bind(console, 'MongoDB connection error:'));

const app=express();//all request are handle by app
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
// app.use(bodyParser.)
app.use(bodyParser.urlencoded({extended:false}));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

const port=4000;
// const hostname=process.env.IP || '192.168.185.172';
const hostname=IP.address('Wi-Fi');

mongoose.connect("mongodb://localhost:27017/bidbazar");
// mongoose.connect("mongodb+srv://bidbazarusers:HFShL1EE9X8qcV58@cluster0.6tyzwic.mongodb.net/?retryWrites=true&w=majority");

app.get("/",(req,res)=>{
// console.log("najeebullah");

// const response={message:'AIPs is working '}
res.json({success:true,message:"vercel working"},);
// res.send(response);
});

app.use("/api/user",userRouter);//user routes
app.use("/api/category",catRouter);
app.use("/api/product",productRoute);
app.use("/api/cart",cartRoutes);
app.use("/api/bid",bidRoutes);
app.use("/api/images", express.static('upload/images'),express.static('upload/profile'),express.static('upload/cnic'), imageRoute );
app.use("/api/wishList",wishListRoutes);
app.use("/api/email",emailRoutes);
app.use("/api/order",orderRoutes);
app.use("/api/complaint",complaintRoutes);
app.use("/api/category",categoryRoutes);



app.listen(port,hostname,()=>{

    // console.log("server is up http://localhost:4000");
    console.log(`server is up http://${hostname}:${port}`);

});


