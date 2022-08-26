const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  //get the data from the user
  try {
    const { username, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User already exists" });
    }

    let user = new User({
      email,
      password,
      username,
    });
    user = await user.save();
    res.json(user);
    //post that data in database
    //return that data to the user
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
