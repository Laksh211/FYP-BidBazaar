const categoryModel = require("../models/categ_model");

const catcontroller={

    createCat:async function(req,res) {         
        try{
             const  catData=req.body;
             const newCat =new  categoryModel(catData);
             await newCat.save();
          return res.json({success:true,message:"Category successfully created",data:newCat}); 
      }catch(e){
          return res.json({success:false,message:`Category creation an error occured  ${e}`,data:newCat});
      }
  
    }
,

fetchCat:async function(req,res){
    try{
        const  categories=await categoryModel.find();
        return res.json({success:true,message:"",data:categories}); 
 }catch(e){
     return res.json({success:false,message:`Category not found!  ${e}`});
 }
},
fetchCatById:async function(req,res){
    try{
        const id=   req.params.id;
        
        const  categories=await categoryModel.findById(id);

        return res.json({success:true,message:"",data:categories}); 

    }catch(e){
     return res.json({success:false,message:`Category not found!  ${e}`});

    }
}

}

module.exports=catcontroller;