const axios = require("axios");
const functions = require("firebase-functions");
const admin = require("../firebase");
const sendNotificationToUser = require("../controller/send_notification_controller");


const verifyPaystackPayment = async (snapshot, context) => {
  const { reference, sender_id, amount } = snapshot.data();
  const kSecretKey = "sk_test_33dfdc0d792c01298c04c42bbc2dcabba2bf8913";

  const headers = {
    "Content-Type": "application/json",
    Accept: "application/json",
    Authorization: `Bearer ${kSecretKey}`,
  };

  const config = {
    method: "get",
    url: `https://api.paystack.co/transaction/verify/${reference}`,
    headers: headers,
  };

  try {
    const res = await axios(config);
    functions.logger.log(res);
    functions.logger.log(res.data.data.status);
    const result = res.data.data.status;

    if (result === "success") {
      // update user wallet
      await admin
        .firestore()
        .collection("wallets")
        .doc(sender_id)
        .update({
          cash_balance: admin.firestore.FieldValue.increment(parseInt(amount)),
        });

      // send success notification
      sendNotificationToUser(
        sender_id,
        "Transaction Successful 🎉🥳",
        `Your fund wallet transaction was successful and your wallet has` +
          ` been funded with \u20A6 ${amount}`
      );
    } else {
      // send transaction fail notification

      sendNotificationToUser(
        sender_id,
        "Transaction Failed 😥",
        "We were unable to fund your wallet, something went wrong!"
      );
    }
  } catch (err) {
    functions.logger.log(err);

    sendNotificationToUser(
      sender_id,
      "Transaction Failed 😥",
      "We were unable to fund your wallet, something went wrong!"
    );
  }
};

module.exports = verifyPaystackPayment;
