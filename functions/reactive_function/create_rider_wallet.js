const functions = require("firebase-functions");
const admin = require("../firebase");

const createRiderWallet = async (snapshot, context) => {
  try {
    const rider = snapshot.data();

    await admin.firestore().collection("wallets").doc(rider.uid).set({
      cash_balance: 0,
      coin_balance: 0,
    });

    functions.logger.log(`created wallet for rider ${rider.uid}`);

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};

module.exports = createRiderWallet;
