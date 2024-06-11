const path = require("path");
const multer = require("multer");
const image = require("../controllers/image_controller");

const imageRoute= require('express').Router();



const storage = multer.diskStorage({
    destination:'./upload/images',
    filename:(req,file,cb)=>{

        // file.forEach((file, index) => {

            // Customize the filename for each file
            const uniqueFileName = `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`;
            // Pass the unique filename to the callback
            cb(null, uniqueFileName);
        //   });s
    }
});

const upload=multer({
    storage:storage,
    // dest:'./upload/images',
});

const profileStorage = multer.diskStorage({
    destination:'./upload/profile',
    filename:(req,file,cb)=>{

        // file.forEach((file, index) => {

            // Customize the filename for each file
            const uniqueFileName = `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`;
            // Pass the unique filename to the callback
            cb(null, uniqueFileName);
        //   });s
    }
});

const uploadProfile=multer({
    storage:profileStorage,
    // dest:'./upload/images',
});

const cnicStorage = multer.diskStorage({
    destination:'./upload/cnic',
    filename:(req,file,cb)=>{

        // file.forEach((file, index) => {

            // Customize the filename for each file
            const uniqueFileName = `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`;
            // Pass the unique filename to the callback
            cb(null, uniqueFileName);
        //   });s
    }
});

const uploadCnic=multer({
    storage:cnicStorage,
    // dest:'./upload/images',
});


imageRoute.post("/upload", upload.array('images'),image.imageUpload );
imageRoute.post("/cnicImages", uploadCnic.array('images'),image.cnicUpload );
imageRoute.post("/profileImages", uploadProfile.array('images'),image.profileUpload );

imageRoute.delete('/delete',image.deleteImage );



module.exports=imageRoute;
