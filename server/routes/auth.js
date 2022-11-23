const { Router } = require("express");
const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt=require("jsonwebtoken");

const authRouter = express.Router();

// authRouter.get("/auth", (req, res) => {
//   res.json({ hi: "Hello " });
// });

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    //findOne is a promise
    console.log(req.body);
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exist!" });
    }
    const hashedPassword = await bcryptjs.hash(password, 8);
    console.log("entered2");
    let user = new User({
      name: name,
      email: req.body.email,
      password: hashedPassword,
    });
    user = await user.save();
    res.json(user);
    console.log("done");
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
  //get the data from client
  //post the data in database
  //return thr data to the user
});

//SignIn
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email doesn't exist" });
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if(!isMatch){
      return res
        .status(400)
        .json({ msg: "Incorrect Password" });
    }

   const token=jwt.sign({id:user._id},"passwordKey");
   res.json({token,...user._doc});
   /*
   {
    'token':'tokensomething',
    'name':'gyan',
    'email':'ddd',
   }

   */
  } catch (error) {}
});

module.exports = authRouter;
