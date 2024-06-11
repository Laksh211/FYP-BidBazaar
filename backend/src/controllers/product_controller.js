const productModel = require("../models/product_model");
const wishListModel = require("../models/wishList_model");
const customDate = require("./date_controller");

const productController = {

    createProduct:async function(req,res){
        try{
            const productData = req.body;//data send    
            // console.log(productData);
            // const jsonData = JSON.stringify(productData);
            const newProduct = new productModel(productData);             
            await newProduct.save();//data save to database

            return res.json({success:true,message:"Product successfully created",data:newProduct}); 
        }catch(e){
            return res.json({success:false,message:`Product creation an error occured  ${e}`});
        }
    },

    updateProduct:async function(req,res){
        try{
            const {productId,name,price,specs,quantity}=req.body;
                  console.log(productId);    

            const updatedProduct =  await productModel.findOneAndUpdate(
                {_id:productId},
                {
                    $set:{ name:name,
                        specs:specs,
                        price:price,
                        qty:quantity} 
                }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                { new: true }
                );
                

                return res.json({success:true,message:"Product updated",data:updatedProduct });

        
        }catch(ex){
            return res.json({success:false,message:ex });

        }

    },
    updateSoldQty:async function(req,res){
        try{
            const {productId,soldqty}=req.body;
                  console.log(productId);    

            const product = await productModel.findOne({_id:productId})

            const updatedProduct =  await productModel.findOneAndUpdate(
                {_id:productId},
                {
                    $set:{
                        soldqty:product.soldqty+soldqty} 
                }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                { new: true }
                );


                return res.json({success:true,message:"Product updated",data:updatedProduct });

        
        }catch(ex){
            return res.json({success:false,message:ex });

        }

    },

    removeFromProducts:async function(req,res){
        try{
            const {id,userId,productId}=req.body;
            

            await wishListModel.findOneAndDelete({user:userId,product:productId});
            
                await productModel.findOneAndDelete({_id:id}); 

                //also remove from cart 
                return res.json({success:true,message:"Product removed successfully",data:{}});
        
        }catch(ex){
            return res.json({success:false,message:ex });
        }

    },

        //This function is not in use
    wishListProduct:async function(req,res){//add product to wishlist  function remove and add 
        try{
            const {id}=req.body;
            // console.log(id);
            
            wishlist = await productModel.findOne(
                {_id:id},        
                {_id:0,user:0,name:0,specs:0,price:0,images:0,category:0 , __v:0}//excluding this data       
                ) ;
            // console.log(wishlist["wishlist"]);
              await productModel.findOneAndUpdate(
                {_id:id},
                {wishlist:!wishlist["wishlist"]} , //dollar pull is array function ->pull value from array means delete values from array using function pull
                
                {new:true}
                );

                return res.json({success:true,message:"Product added to wishList ",data:!wishlist["wishlist"]});
        
        }catch(ex){
            return res.json({success:false,message:ex });

        }

    },


    getAllProducts:async function(req,res){

        try{
            const getProducts = await productModel.find()
            // .populate("user");
            // .populate("user");//it uses mongoose local client which fetch all data from db   
                         
            return res.json({success:true,message:"Product Found",data:getProducts}); 
        }catch(e){
            return res.json({success:false,message:`Erorr Product Not Found   ${e}`});
        }
    },
  
    getAllProductsById:async function(req,res){// for category
        try{
            const id=   req.params.id;
            
            // const  products=await productModel.findById(id);
            const  products=await productModel.find({category:id});
            
            return res.json({success:true,message:"",data:products}); 
    
        }catch(e){
         return res.json({success:false,message:`Product not found!  ${e}`});
    
        }
    },

    // getAllProductsByCategory:async function(req,res){// for category
    //     try{
    //         const {categoryId} =   req.Body;
            
    //         // const  products=await productModel.findById(id);
    //         const  products=await productModel.find({category:id});
            
    //         return res.json({success:true,message:"",data:products}); 
    
    //     }catch(e){
    //      return res.json({success:false,message:`Product not found!  ${e}`});
    
    //     }
    // },
    
    renewProduct:async function(req,res){// for category
        try{
            const id=   req.body.id;  
            console.log(id);
            // const  products=await productModel.findById(id);
            const  product=await productModel.findOneAndUpdate(
                {_id:id},
                {createdat:customDate.getStringFormattedDate()}
        );
            return res.json({success:true,message:"product found and renew",data:product["createdat"]}); 
        }catch(e){
         return res.json({success:false,message:`Product not found!  ${e}`});
    
        }
    },



    
    getUserProduct:async function(req,res){ // for user
        try{
            const user=req.params.user;
                      
            const foundProduct =  await productModel.find(
                {user:user}
                );
                // console.log("product "+foundProduct);
            if(foundProduct==""){
                
                return res.json({success:false,data:[],message:"There is no product to display" });
            }else

                return res.json({success:true,message:"Products found",data:foundProduct });

        
        }catch(ex){
            return res.json({success:false,message:ex.message });

        }

    }
    


}


module.exports = productController;