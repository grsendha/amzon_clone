//Creating API
// import 'package:express/express.dart'
const express = require("express");
const mongoose = require("mongoose");
const PORT = 3000;
const DB =
  "mongodb+srv://gyan:gyan11@cluster0.sfsj6yj.mongodb.net/?retryWrites=true&w=majority";
//INIT
const app = express();

//IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth.js");

//middleware
//CLIENT->middleware->SERVER->CLIENT
app.use(express.json());
app.use(authRouter);
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

//creating an API
app.get("/hello-world", (req, res) => {
  res.json({ hi: "Hello Worldd" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT} hello `);
});
