const functions = require("firebase-functions");
const admin = require("../firebase");

const createUserWallet = async (snapshot, context) => {
  try {
    const user = snapshot.data();

    await admin.firestore().collection("wallets").doc(user.uid).set({
      cash_balance: 100,
      coin_balance: 50,
    });

    functions.logger.log(`created wallet for user ${user.uid}`);

    return Promise.resolve();
  } catch (error) {
    functions.logger.error(error);
    return Promise.reject(error);
  }
};

module.exports = createUserWallet;
