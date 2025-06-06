const jwt=require('jsonwebtoken');

const TOKEN_KEY="RANDOM_KEY";

function authenticateToken(req,res,next){
    const authHeader=req.headers['authorization'];
    const token=authHeader && authHeader.split(' ')[1];
    if(token==null) return res.sendStatus(401);
    if(!token){
        console.log("❌ No Token Provided!");
        return res.status(403).send(
            {
                message:"No Token Provided!"
            }
        );
    }
    jwt.verify(token,TOKEN_KEY,(err,user)=>{
        if(err) {
        return res.status(401).send({message:"Unauthorized!"});
        }
        console.log("✅ Decoded Token:", user);
        req.user=user.data;
        req.userId=user.data.userId;
        console.log("✅ req.userId set to:", req.userId);
        next();
    }
    );
}
function generateAccessToken(userModel){
    return jwt.sign({data:userModel}, TOKEN_KEY, {
        expiresIn: '1h'
    });
}

module.exports={
    authenticateToken,
    generateAccessToken
}
