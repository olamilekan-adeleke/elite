const admin = require("../firebase");

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
};

module.exports = transferFundToUserByUserId;
