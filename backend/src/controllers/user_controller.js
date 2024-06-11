const bcryptjs = require("bcryptjs");

//multiple function create update delete export

const UserModel = require("../models/user_model");
// const emailController = require("./email_controller");
const emailRoutes = require("../routes/email_routes");
// const nodemailer = require('nodemailer');

// var smtpTransport = nodemailer.createTransport("SMTP",{
//     service: "Gmail",
//     auth: {
//         user: "Your Gmail ID",
//         pass: "Gmail Password"
//     }
// });
// var rand,mailOptions,host,link;
// /*------------------SMTP Over-----------------------------*/

// /*------------------Routing Started ------------------------*/

const userController = {

    createAccount: async function (req, res) {

        try {
            const userData = req.body;//data send    
            const newUser = new UserModel(userData);

            await newUser.save();//data save to database
            return res.json({ success: true, message: "account successfully created", data: newUser });
        } catch (e) {
            return res.json({ success: false, message: `account creation an error occured  ${e}` });
        }

    },

    userFindById: async function (req, res) {
        try {
            const { id } = req.body;//data send  
            console.log(id);
            const user = await UserModel.findOne({ _id: id }

            );


            if (user == null) {
                return res.json({ success: false, message: `account not found an error occured  ${e}` });

            } else
                return res.json({ success: true, message: "account successfully find", data: user });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },

    uploadCnicImages: async function (req, res) {
        try {
            const { images, id } = req.body;//data send  
            console.log(id);
            const user = await UserModel.findOneAndUpdate(
                { _id: id },
                { cnicimages: images }
            );


            if (user == null) {
                return res.json({ success: false, message: `account not found an error occured  ${e}` });

            } else
                return res.json({ success: true, message: "image successfully uploaded", data: user });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },
    uploadProfileImages: async function (req, res) {
        try {
            const { images, id } = req.body;//data send  
            console.log(id);
            const user = await UserModel.findOneAndUpdate(
                { _id: id },
                { profileimages: images }
            );


            if (user == null) {
                return res.json({ success: false, message: `account not found an error occured  ${e}` });

            } else
                return res.json({ success: true, message: "image successfully uploaded", data: user });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },

    userBlock: async function (req, res) {
        try {
            const { id } = req.body;//data send  
            console.log(id);

            const user = await UserModel.findOne({ _id: id },
            );
            user["block"] = !user["block"];
            console.log(user["block"]);
            const data = await UserModel.findOneAndUpdate({ _id: id },
                { block: user["block"] } // if user is blocked then unblocked 
            );

            if (user == null) {
                return res.json({ success: false, message: `account not found an error occured  ${e}` });

            } else
                return res.json({ success: true, message: "account successfully find", data: user });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },
    verification: async function (req, res) {
        try {
            const { id } = req.body;//data send  
            console.log(id);
            const user = await UserModel.findOne({ _id: id },
            );
            user["verification"] = !user["verification"];
            const data = await UserModel.findOneAndUpdate({ _id: id },
                { verification: user["verification"] } // if user is blocked then unblocked 
            );
            if (data == null) {
                return res.json({ success: false, message: `account not found an error occured` });
            } else
                return res.json({ success: true, message: "account successfully find", data: data });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },

    allusers: async function (req, res) {
        try {

            const data = await UserModel.find({ usertype: { $in: ['Seller', 'Buyer'] } });
            if (data == null) {
                return res.json({ success: false, message: `account not found an error occured` });
            } else
                return res.json({ success: true, message: "account successfully find", data: data });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },

    Buyers: async function (req, res) {
        try {

            const data = await UserModel.find({ usertype: 'Buyer' });
            if (data == null) {
                return res.json({ success: false, message: `account not found an error occured` });
            } else
                return res.json({ success: true, message: "account successfully find", data: data });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },

    Sellers: async function (req, res) {
        try {

            const data = await UserModel.find({ usertype: 'Seller' });
            if (data == null) {
                return res.json({ success: false, message: `account not found an error occured` });
            } else
                return res.json({ success: true, message: "account successfully find", data: data });
        } catch (e) {
            return res.json({ success: false, message: `account not found an error occured  ${e}` });
        }
    },


    forgot: async function (req, res) {
        try {
           
            const { email, password,} = req.body;
              bcryptPassword=bcryptjs.hashSync(password,8);
            console.log(bcryptPassword)
            const foundUser = await UserModel.findOneAndUpdate(
                {email: email,},
                {password:bcryptPassword}
            );
            if (!foundUser) {
                return res.json({ success: false, message: `User not found! ` });
            }
       
            return res.json({ success: true, message: `password successfully changed! `, data: "password sucessfully changed" });

        } catch (e) {
            return res.json({ success: false, message: `An error occured to Login  ${e}` });
        }
    },

    // forgot: async function (req, res) {


    //     // // app.get('/send',function(req,res){
    //     //     rand=Math.floor((Math.random() * 100) + 54);
    //     //     const {email} = req.body;
    //     //     host=req.get('host');
    //     //     link="http://"+req.get('host')+"/verify?id="+rand;
    //     //     mailOptions={
    //     //         to : req.query.to,
    //     //         subject : "Please confirm your Email account",
    //     //         html : "Hello,<br> Please Click on the link to verify your email.<br><a href="+link+">Click here to verify</a>" 
    //     //     }
    //     //     console.log(mailOptions);
    //     //     smtpTransport.sendMail(mailOptions, function(error, response){
    //     //      if(error){
    //     //             console.log(error);
    //     //         res.end("error");
    //     //      }else{
    //     //             console.log("Message sent: " + response.message);
    //     //         res.end("sent");
    //     //          }
    //     // });
    //     // app.get('/verify',function(req,res){
    //     // console.log(req.protocol+":/"+req.get('host'));
    //     // if((req.protocol+"://"+req.get('host'))==("http://"+host))
    //     // {
    //     //     console.log("Domain is matched. Information is from Authentic email");
    //     //     if(req.query.id==rand)
    //     //     {
    //     //         console.log("email is verified");
    //     //         res.end("<h1>Email "+mailOptions.to+" is been Successfully verified");
    //     //     }
    //     //     else
    //     //     {
    //     //         console.log("email is not verified");
    //     //         res.end("<h1>Bad Request</h1>");
    //     //     }
    //     // }
    //     // else
    //     // {
    //     //     res.end("<h1>Request is from unknown source");
    //     // }
    //     // });
    //     // /*--------------------Routing Over----------------------------*/
    //     // app.listen(3000,function(){
    //     //     console.log("Express Started on Port 3000");
    //     // });   

    // },


    SignIn: async function (req, res) {
        try {
            const { email, password, usertype } = req.body;

            const foundUser = await UserModel.findOne({
                email: email,

            });
            if (!foundUser) {
                return res.json({ success: false, message: `User not found! ` });
            }
            //  const hashed = await bcryptjs.hash(password, 8);
            // console.log(hashed);
            passwordMatches =
                bcryptjs.compareSync(password, foundUser.password);
            // passwordMatches= foundUser.password==password?true:false;
            // console.log(passwordMatches);

            if (!passwordMatches) {
                console.log(passwordMatches);
                return res.json({ success: false, message: `Password not matches ! ` });
            }

            userType = foundUser.usertype;

            return res.json({ success: true, message: `Successfully login! `, data: foundUser });

        } catch (e) {
            return res.json({ success: false, message: `An error occured to Login  ${e}` });
        }
    }

    


};



module.exports = userController;