const functions = require("firebase-functions");
const sendNotificationToUser = require("../controller/send_notification_controller");

const sendUserNotificationOnJoinEQueue = async (snapshot, context) => {
  try {
    const data = snapshot.data();

    await sendNotificationToUser(
      data.user.uid,
      "You have been added to the queue",
      `Hello ${data.user.username}, You joined the queue, you will get a notification to proceed` +
        ` to the park very soon. Please be on standby.`
    );

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};

module.exports = sendUserNotificationOnJoinEQueue;
