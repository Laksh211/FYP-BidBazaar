var nodemailer = require('nodemailer');

const otpGenerator = require('otp-generator');



var transporter = nodemailer.createTransport({
    host: 'smtp-relay.brevo.com',
    port: 587,
    secure: false,
    auth: {
      user: 'bscs2012307@szabist.pk',
      pass: 'tWqvHpQ9DmEN7IrG'
    },
    tls: {
      rejectUnauthorized: false
    }
  });

const emailController={


sentemailOTP:async function(req,res){

    try{
        const otp = otpGenerator.generate(6, { digits: true, alphabets: false, upperCase: false, specialChars: false , });

        const {email}=req.body;
          console.log(email+" "+otp);
        var mailOptions = {
            from: 'bscs2012307@szabist.pk',
            to: email,
            subject: 'Bidbazar',
            text: "Your otp is "+otp
          };
          
          transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
              throw error
            } else {
                return res.json({success:true,message:`otp successfull sent to you please check your email`,data:{otp:otp}});
              console.log('Email sent: ' + info.response);
            }
          });
          
                       
    }catch(e){
        return res.json({success:false,message:`account creation an error occured  ${e}`});
    }

},





};



module.exports =emailController;
