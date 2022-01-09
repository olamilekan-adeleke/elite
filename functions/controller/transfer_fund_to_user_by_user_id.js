const admin = require("../firebase");
const sendNotificationToUser = require("./send_notification_controller");
const addTransferToHistory = require("./add_transfer_to_history");

const transferFundToUserByUserId = async (req) => {
  const { receiver_id, sender_id, amount, type } = req.body;

  const batch = admin.firestore().batch();
  const sendDoc = admin.firestore().collection("wallets").doc(sender_id);
  const receiverDoc = admin.firestore().collection("wallets").doc(receiver_id);

  if (type === "cash") {
    // deduct sender
    batch.update(sendDoc, {
      cash_balance: admin.firestore.FieldValue.increment(-parseInt(amount)),
    });

    // update receiver
    batch.update(receiverDoc, {
      cash_balance: admin.firestore.FieldValue.increment(parseInt(amount)),
    });
  } else if (type === "coin") {
    // deduct sender
    batch.update(sendDoc, {
      coin_balance: admin.firestore.FieldValue.increment(-parseInt(amount)),
    });

    // update receiver
    batch.update(receiverDoc, {
      coin_balance: admin.firestore.FieldValue.increment(parseInt(amount)),
    });
  }

  await batch.commit();

  // send notification to sender
  await sendNotificationToUser(
    sender_id,
    "Fund Transfer 🎉💵",
    `Your fund transfer of \u20A6 ${amount} to @${receiverDoc.username} was successful.`
  );

  // send notification to receiver
  await sendNotificationToUser(
    sender_id,
    "Fund Transfer 🎉💵",
    `You just received a fund transfer of \u20A6 ${amount} from @${sendDoc.username}.`
  );

  // add history to sender
  addTransferToHistory(sender_id, amount, sender_id, receiverDoc, "send_fund");

  // add history to receiver
  addTransferToHistory(
    receiver_id,
    amount,
    sender_id,
    send_fund,
    "receive_fund"
  );
};

module.exports = transferFundToUserByUserId;
