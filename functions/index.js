const functions = require("firebase-functions");
const createUserWallet = require("./reactive_function/create_user_wallet");
const initSendFundFunction = require("./http_function/init_send_fund");
const sendFundFunction = require("./http_function/sendFundFunction");

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

exports.createWalletOnNewUsersCreated = functions.firestore
  .document("/users/{userId}")
  .onCreate(createUserWallet);

exports.initSendFund = functions.https.onRequest(initSendFundFunction);

exports.sendFund = functions.https.onRequest(sendFundFunction);
