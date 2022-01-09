const functions = require("firebase-functions");
const admin = require("../firebase");
const sendNotificationToUser = require("../controller/send_notification_controller");

const onLeaveEQueue = async (snapshot, context) => {
  try {
    const deletedData = snapshot.data();

    await sendNotificationToUser(
      data.user.uid,
      "You have been removed from the queue",
      `Hello ${deletedData.user.username}, you have been removed from the` +
        ` queue. You Money will be refunded to your wallet soon`
    );

    // Refund user money here

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};

module.exports = onLeaveEQueue;
