const bidModel = require("../models/bid_model");



const bidController={

    createbid:async function(req,res) {
        try{
            const {product,seller,buyer,bidprice}=req.body;
            console.log("bid price: "+bidprice);
            
            const foundCart = await bidModel.findOne({seller:seller,buyer:buyer});
            // console.log(foundCart);
           
            if(foundCart==null){
            console.log(foundCart);

                const newBid = new bidModel({seller:seller,buyer:buyer});
                newBid.items.push({  product:product,bidprice:bidprice
                });
                await newBid.save();

                return res.json({success:true,message:"Product added to bid",data:newBid });
            }

             await bidModel.findOneAndUpdate(//first pull then push the item in db
                {seller:seller,buyer:buyer,"items.product":product}, //match user and product 
                {$pull:{items:{product:product,}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                );

            //if cart exists
            const updatedBid =  await bidModel.findOneAndUpdate(
                {buyer:buyer,seller:seller}, //match condition
                {$push:{items:{product:product,bidprice:bidprice}} }, // make a changes                //dollar push ->push value in  array function pull
                {new: true} // new version of doc
                ).populate("items.product");

                return res.json({success:true,message:"Product added to bid",data:updatedBid });

        }catch(ex){
            return res.json({success:false,message:`Product can not added to bid :  ${ex}` });

        }
        },

        fetchbidsForSeller:async function(req,res){
            try{
                const seller=req.params.seller;
                          
                const foundBid =  await bidModel.find(
                    {seller:seller},
                    // {_id:0, seller:0}//excluding this data       

                    ).populate("items.product").populate("seller");
              
                
                if(!foundBid){

                console.log(foundBid);
                    return res.json({success:false,data:[],message:"There is no item in your bid" });
                }else
    
                    return res.json({success:true,message:"bid found",data:foundBid });
    
            
            }catch(ex){
                return res.json({success:false,message:ex.message });
    
            }
    
        },

        fetchbidsForBuyer:async function(req,res) {
            try{
                const buyerId = req.params.buyerId;
                
                const foundbids = await bidModel.find({
                    "buyer":buyerId
                },
                // {_id:0,seller:0}
                ).populate("items.product")
                .populate("seller");
            //    let bidItems=[];
                // console.log(foundbids[0].items);
                // foundbids[0].items
                // if (foundbids && foundbids.length > 0) {
                //     foundbids.forEach(element => {
                //         element.items.forEach(innerElement => {
                //             bidItems.push(innerElement);    
                //         });
                //     });
                //     }
                    // console.log(bidItems);

                if(!foundbids){

                    
                        return res.json({success:false,data:[],message:"There is no item in your bid" });
                    }else
                return res.json({success:true,message:"bid found",data:foundbids});

                
            }catch(ex){
                return res.json({success:false,message:`"bid not found ${ex}"`});

            }
    },

    deletebid:async function(req,res) {
        try{
            const {bidId,buyerId} = req.params;
            console.log(bidId);
            // const foundbids = await bidModel.findByIdAndDelete({
            //     "buyer":"655bc3739287689f923902f5",
            //     "items":bidId
            // },)
            const foundbids =  await bidModel.findOneAndUpdate(
                {buyer:buyerId}, //match condition
                {$pull:{items:{_id:bidId}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
                );


            // if(!foundbids){
            //     return res.json({success:false,data:[],message:"There is no item in your bid to delete" });
            //     }else
            return res.json({success:true,message:"bid found and deleted",});

            
        }catch(ex){
            return res.json({success:false,message:`"bid not found ${ex}"`});

        }
},

deletebidForSeller:async function(req,res) {
    try{
        const {bidId,SellerId} = req.params;
        console.log(bidId);
        // const foundbids = await bidModel.findByIdAndDelete({
        //     "buyer":"655bc3739287689f923902f5",
        //     "items":bidId
        // },)
        const foundbids =  await bidModel.findOneAndUpdate(
            {seller:SellerId}, //match condition
            {$pull:{items:{_id:bidId}} }, //dollar pull is array function ->pull value from array means delete values from array using function pull
            );


        // if(!foundbids){
        //     return res.json({success:false,data:[],message:"There is no item in your bid to delete" });
        //     }else
        return res.json({success:true,message:"bid found and deleted",});

        
    }catch(ex){
        return res.json({success:false,message:`"bid not found ${ex}"`});

    }
},


    updateBidStatus:async function(req,res) {
        try{
            
            const {productId,status,buyerId}=req.body;  
            console.log("buyerid "+buyerId+" productId: "+ productId+" status: "+status);

            const updateBid = await bidModel.findOneAndUpdate(
                {
                    buyer: buyerId,
                    'items.product': productId
                },
                {
                    $set: {
                        'items.$.status': status
                    }
                },
                
                { new: true }
            );
            
            console.log(updateBid);
            if(updateBid==null){
            return res.json({success:false,message:"bid not found."});

            }
            return res.json({success:true,message:"bid found and updated status.",data:updateBid});

            
        }catch(ex){
            return res.json({success:false,message:`"bid not found ${ex}"`});

        }
}


};





module.exports=bidController;



