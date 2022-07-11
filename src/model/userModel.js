const mysql = require("./mysqlConnect");
const jwt = require("jsonwebtoken");
 get = async() => {
  //users=await mysql.query("SELECT *, (SELECT nome FROM pessoa WHERE id=u.pessoa_id_pessoa) as nome FROM usuario u");
  users = await mysql.query("SELECT u.nome, u.email, u.senha FROM usuario u")
  return users;                                                           
}

login = async (data)=>{
   sql="SELECT u.id_usuario as id, u.nome, u.email,"+
   " FROM usuario u"+
   " WHERE u.email='"+data.email+"' AND u.senha='"+data.senha+"' ";
   const usuarios = await  mysql.query(sql);
   result=null;
   if(usuarios){
      if(usuarios.length>0){
         if(usuarios[0].id){
            const id=usuarios[0].id;
            var token = jwt.sign({id} , 'CIMOL', {expiresIn:3600}); 
            console.log("Fez login e gerou token!");
            result={ auth: true, token: token , user:usuarios[0]}
         }
      }      
   }
   if(!result){
      return {"status":"error", "message":"Falha ao realizar login!"}
   }
   return result;
}

verifyJWT=(token)=>{ 
  if (!token){
     resp= { auth: false, message: 'Token não informado.' }; 
  }
  
  jwt.verify(token, 'CIMOL', function(err, decoded) { 
     
     if (err){
        resp= { auth: false, message: 'Token inválido.' };
     }
     if(decoded){
        resp= {auth:true, idUser:decoded.id};
     }
  });
  return resp;
} 

module.exports={get, login, verifyJWT}