const functions = require("firebase-functions");
const createUserWallet = require("./reactive_function/create_user_wallet");
const initSendFundFunction = require("./http_function/init_send_fund");
const sendFundFunction = require("./http_function/sendFundFunction");
const sendUserNotificationOnJoinEQueue = require("./reactive_function/send_notification_on_join_queue");
const onLeaveEQueue = require("./reactive_function/on_leave_queue");

exports.createWalletOnNewUsersCreated = functions.firestore
  .document("/users/{userId}")
  .onCreate(createUserWallet);

exports.initSendFund = functions.https.onRequest(initSendFundFunction);

exports.sendFund = functions.https.onRequest(sendFundFunction);

exports.sendUserNotificationOnJoinEQueue = functions.firestore
  .document("/terminals/{terminalsId}/queue/{queueId}")
  .onCreate(sendUserNotificationOnJoinEQueue);

exports.sendUserNotificationOnLeaveQueue = functions.firestore
  .document("/terminals/{terminalsId}/queue/{queueId}")
  .onDelete(onLeaveEQueue);
