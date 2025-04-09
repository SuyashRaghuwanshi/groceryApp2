const userService=require("../services/user.services");

exports.register=(req,res,next)=>{
    userService.register(req.body,(error, results)=>{
        if(error){
            return next(error);
        }
        else{
            return res.status(200).send({
                message:"Success",
                data: results
            });
        }
    });
};

exports.login=(req,res,next)=>{
    const {email,password}=req.body;
    
    userService.login({email,password}, (error, results)=>{
        if(error){
            return next(error);
        }
        else{
            return res.status(200).send({
                message:"Success",
                data: results
            });
        }
    }
    );
};
