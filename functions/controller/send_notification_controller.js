const admin = require("../firebase");

async function sendNotificationToUser(userId, Heading, message) {
  const payload = {
    notification: {
      title: `${Heading}`,
      body: `${message}`,
    },
    data: {
      data_to_send: "msg_from_the_cloud",
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
  };

  const options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
  };

  return admin
    .messaging()
    .sendToTopic(`${userId}`, payload, options)
    .then(() => {
      console.info("function executed successfully: sent notification");
      // return {msg: "function executed successfully"};
    })
    .catch((error) => {
      console.info("error in execution: notification not sent");
      console.log(error);
      return { msg: "error in execution: notification not sent" };
    });
}

module.exports = sendNotificationToUser;
