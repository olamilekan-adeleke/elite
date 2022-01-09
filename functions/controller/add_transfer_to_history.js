const admin = require("../firebase");
const functions = require("firebase-functions");

const addTransferToHistory = async (
  userId,
  amount,
  sender_id,
  user_details,
  type,
) => {
  await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("transactions")
    .add({
      amount: amount,
      description: description,
      sender_id: sender_id,
      status: "success",
      user_details: user_details,
      type: type,
    });
};

module.exports = addTransferToHistory;
