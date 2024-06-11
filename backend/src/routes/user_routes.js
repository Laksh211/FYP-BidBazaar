const userRouter = require('express').Router();
const userController=require("./../controllers/user_controller");

userRouter.post("/createAccount",userController.createAccount
);//default function shift to user_controller

userRouter.post("/signIn",userController.SignIn
);//default function shift to user_controller


userRouter.post("/find",userController.userFindById
);//default function shift to user_controller

userRouter.post("/block",userController.userBlock
);//default function shift to user_controller
userRouter.post("/verification",userController.verification
);//default function shift to user_controller
userRouter.get("/allusers",userController.allusers
);//de
userRouter.get("/sellers",userController.Sellers
);//de
userRouter.get("/buyers",userController.Buyers
);//de
userRouter.post("/uploadcnic",userController.uploadCnicImages
);
userRouter.post("/uploadprofile",userController.uploadProfileImages
);
userRouter.post("/forgot",userController.forgot
);
module.exports=userRouter;