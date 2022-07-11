const express = require('express');
const userController = require("../controller/userController");
const router = express.Router();

router.get('/', (req, res, next)=>{
  res.status(200).send("<h1>API LOGIN</h1>");
})
 
router.get('/user', async(req, res, next)=>{
  user = await userController.get(req.headers);
  res.status(200).send(user);
})

router.post('/user/login', async(req, res, next)=>{
  user = await userController.login(req.body);
  res.status(200).send(user);
})

router.put('/user/:idUser', async(req, res, next)=>{
  user = await userController.put (req.headers, req.body, req.params.idUser );
  res.status(200).send(resp);
})

module.exports=router;