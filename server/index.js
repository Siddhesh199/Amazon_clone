const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://sid:naruto9976@cluster0.tucwjjl.mongodb.net/?retryWrites=true&w=majority';

app.use(express.json());
app.use(authRouter);
 
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
