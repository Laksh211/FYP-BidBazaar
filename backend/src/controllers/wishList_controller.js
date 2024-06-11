// const cartModel = require("../models/cart_model");
const wishListModel = require("../models/wishList_model");


const wishListController={

    wishListItem:async function(req,res) {
        try{
            const {product,user}=req.body;

            const foundCart = await wishListModel.findOne({product:product});

            if(!foundCart){
                const newWishList = new wishListModel({user:user,
                product:product
                });
                // newCart.items.push({product:product,quantity:quantity
                // });
                await newWishList.save();

                return res.json({success:true,message:"item added successfully",data:newWishList });
            }
            else
                
            await wishListModel.findOneAndDelete({user:user,product:product});
           
            // console.log(foundCart);

                return res.json({success:true,message:"Item removed from wishlist",data:{} });

        }catch(ex){
            return res.json({success:false,message:`Product can not added to cart :  ${ex}` });

        }

    },

    getWishList:async function(req,res){
        try{
            const user=req.params.user;
                      
            const foundCart =  await wishListModel.find(
                {user:user},                                
                ).populate("product");

                
                // console.log(foundCart);

            if(foundCart==""){
                return res.json({success:false,data:[],message:"There is no wishlist in your cart" });
            }

                return res.json({success:true,message:"Products found",data:foundCart});

        
        }catch(ex){
            return res.json({success:false,message:ex.message });

        }

    }


    // removeFromCart:async function(req,res){
    //     try{
    //         const {user,product}=req.body;
                      
    //         const updatedCart =  await cartModel.findOneAndUpdate(
    //             {user:user}, //match condition
    //             {$pull:{items:{product:product}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
    //             ).populate("items.product");

    //             return res.json({success:true,message:"Product removed from cart",data:updatedCart });

        
    //     }catch(ex){
    //         return res.json({success:false,message:ex });

    //     }

    // },

    // updateFromCart:async function(req,res){
    //     try{
    //         const {user,product,quantity}=req.body;
                      
    //         const updatedCart =  await cartModel.findOneAndUpdate(
    //             {user:user},
    //             {$push:{items:{product:product,quantity:quantity}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
    //             );

    //             return res.json({success:true,message:"Product updated from cart",data:updatedCart });

        
    //     }catch(ex){
    //         return res.json({success:false,message:ex });

    //     }

    // },

    


}


module.exports=wishListController;