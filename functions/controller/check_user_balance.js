const admin = require("../firebase");
const functions = require("firebase-functions");

const checkUserBalanceAndPin = async (req) => {
  const { sender_id, amount, type, wallet_pin } = req.body;

  const userWalletData = await admin
    .firestore()
    .collection("wallets")
    .doc(sender_id.trim())
    .get();

  const userData = await admin
    .firestore()
    .collection("users")
    .doc(sender_id.trim())
    .get();

  functions.logger.log(userWalletData.data());
  functions.logger.log(userData.data());

  const userWallet = {
    cash_balance: userWalletData.data().cash_balance ?? 0,
    coin_balance: userWalletData.data().coin_balance ?? 0,
  };

  if (wallet_pin !== userData.data().wallet_pin) {
    throw {
      code: 404,
      msg: "Wallet Pin Is InCorrect!",
    };
  }

  if (type === "cash") {
    if (userWallet.cash_balance < parseInt(amount)) {
      throw {
        code: 404,
        msg: "You do not have enough balance to perform this transaction!",
      };
    }
  } else if (type === "coin") {
    if (userWallet.coin_balance < parseInt(amount)) {
      throw {
        code: 404,
        msg: "You do not have enough balance to perform this transaction!",
      };
    }
  }
};

module.exports = checkUserBalanceAndPin;
