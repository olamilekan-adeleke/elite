const functions = require("firebase-functions");
const admin = require("../firebase");

const getUserByUsername = async (username) => {
  const users = await admin
    .firestore()
    .collection("users")
    .where("username", "==", username)
    .limit(1)
    .get();

  if (!users.docs || !users.docs.length) {
    throw {
      code: 404,
      msg: "user with the username " + username + " does not exist!",
    };
  }

  const user = users.docs[0].data();
  functions.logger.log(user);

  delete user.wallet_pin;
  delete user.has_verify_number;
  delete user.has_create_wallet_pin;
  delete user.has_create_wallet_pin;
  delete user.date_joined;

  return user;
};

module.exports = getUserByUsername;
