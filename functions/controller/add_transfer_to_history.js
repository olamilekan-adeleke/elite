const admin = require("../firebase");
const functions = require("firebase-functions");

const addTransferToHistory = async (
  userId,
  amount,
  sender_id,
  user_details,
  type
) => {
  functions.logger.log({
    userId: userId,
    amount: amount,
    description: "fund transfer",
    sender_id: sender_id,
    status: "success",
    user_details: { ...user_details },
    type: type,
  });

  await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("transactions")
    .add({
      amount: amount,
      description: "fund transfer",
      sender_id: sender_id,
      status: "success",
      user_details: { ...user_details },
      type: type,
    });
};

module.exports = addTransferToHistory;
