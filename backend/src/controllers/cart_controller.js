const cartModel = require("../models/cart_model");
const productModel = require("../models/product_model");

const cartController={

    addToCart:async function(req,res) {
        try{
            const {product,user,quantity}=req.body;

            const foundCart = await cartModel.findOne({user:user});
            console.log("add to cart now");
            console.log(product.price);
            // productModel(quantity)
            if(!foundCart){
                const newCart = new cartModel({user:user});
                newCart.items.push({product:product,quantity:quantity
                });
                await newCart.save();

                return res.json({success:true,message:"Product added to cart",data:newCart });
            }

             await cartModel.findOneAndUpdate(
                {user:user,"items.product":product}, //match user and product 
                {$pull:{items:{product:product}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                );

            //if cart exists
            const updatedCart =  await cartModel.findOneAndUpdate(
                {user:user}, //match condition
                {$push:{items:{product:product,quantity:quantity}} }, // make a changes                //dollar push ->push value in  array function pull
                {new: true} // new version of doc
                ).populate("items.product");

                return res.json({success:true,message:"Product added to cart",data:updatedCart });

        }catch(ex){
            return res.json({success:false,message:`Product can not added to cart :  ${ex}` });

        }

    },
    removeAllFromCart:async function(req,res){
            try{
                const {user}=req.body;
                    const deleteCart = await cartModel.deleteOne({
                        user:user
                    });
            return res.json({success:true,message:"Successfully deleted" ,data:deleteCart });
                    
            }catch{
            return res.json({success:false,message:ex });
                
            }
    },
    removeFromCart:async function(req,res){
        try{
            const {user,product}=req.body;
                      console.log(product)
            const updatedCart =  await cartModel.findOneAndUpdate(
                {user:user}, //match condition
                {$pull:{items:{"product._id":product}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                ).populate("items.product");

                return res.json({success:true,message:"Product removed from cart",data:updatedCart });

        
        }catch(ex){
            return res.json({success:false,message:ex });

        }

    },

    updateFromCart:async function(req,res){
        try{
            const {user,product,quantity}=req.body;
                      
            const updatedCart =  await cartModel.findOneAndUpdate(
                {user:user},
                {$push:{items:{product:product,quantity:quantity}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                );

                return res.json({success:true,message:"Product updated from cart",data:updatedCart });

        
        }catch(ex){
            return res.json({success:false,message:ex });

        }

    },

    getAllFromCart:async function(req,res){
        try{
            const user=req.params.user;
                      
            const foundCart =  await cartModel.findOne(
                {user:user}
                ).populate("items.product");
            if(!foundCart){
                return res.json({success:false,data:[],message:"There is no item in your cart" });
            }

                return res.json({success:true,message:"Products found",data:foundCart.items });

        
        }catch(ex){
            return res.json({success:false,message:ex.message });

        }

    }


}


module.exports=cartController;