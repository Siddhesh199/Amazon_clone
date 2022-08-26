const express = require("express");

const authRouter = express.Router();

authRouter.post("/api/signup", (req, res) => {
  //get the data from the user
  const { username, email, password } = req.body;

  //post that data in database
  //return that data to the user
});

module.exports = authRouter;
