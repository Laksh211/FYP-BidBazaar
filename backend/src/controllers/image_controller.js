const fs=require('fs/promises');


const image = {

    imageUpload:async function(req,res){

            try{
                // console.log(req.data);
                // console.log(req.element);
                // console.log(req.files);
                const imageUrls = req.files.map(element => `${element.filename}`);// ex http://192.168.137.1:4000/api/images/image123545.png
                // http://192.168.137.1:4000
                // console.log("new data");
                // console.log(imageUrls);
    //  return res.json({success:true,message:`Image uploaded!` , data:req.files});
             return res.json({success:true,message:`Image uploaded!` , data:imageUrls});


            }catch(ex){
     return res.json({success:false,message:`Image not found!  ${ex}`});


            }
    },

    cnicUpload:async function(req,res){

        try{
            const imageUrls = req.files.map(element => `${element.filename}`);// ex http://192.168.137.1:4000/api/images/image123545.png
            return res.json({success:true,message:`Image uploaded!` , data:imageUrls});

        }catch(ex){
            return res.json({success:false,message:`Image not found!  ${ex}`});
        }
},

profileUpload:async function(req,res){

    try{
        const imageUrls = req.files.map(element => `${element.filename}`);// ex http://192.168.137.1:4000/api/images/image123545.png
        return res.json({success:true,message:`Image uploaded!` , data:imageUrls});

    }catch(ex){
        return res.json({success:false,message:`Image not found!  ${ex}`});
    }
},

    deleteImage: async function (req, res) {
        try {
            console.log("working");
            const { images } = req.body;
            console.log(`/upload/images/${images}`);

            // Use Promise.all to await all fs.unlink promises
            await Promise.all(images.map(async (element) => {
                const filePath = `upload/images/${element}`; // Corrected path
                await fs.unlink(filePath);
                console.log(`${element} deleted successfully`);
            }));

            return res.json({ success: true, message: 'Images deleted successfully' });

        } catch (ex) {
            console.error(`Error deleting images: ${ex}`);
            return res.status(500).json({ success: false, message: `Internal server error: ${ex}` });
        }
    }
}



module.exports = image;
