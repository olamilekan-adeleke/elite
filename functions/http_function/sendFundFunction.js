const functions = require("firebase-functions");
const checkSendFundData = require("../controller/check_send_fund_data");
const checkUserBalanceAndPin = require("../controller/check_user_balance");
const transferFundToUserByUserId = require("../controller/transfer_fund_to_user_by_user_id");

/* this function is for sending user fund using there user id
expect data:
{ 
    "receiver_id": "user_id", 
    "sender_id": "send id", 
    "amount": "amount you want to send eg. 100",
    "type": can be only two type of "cash" or "coin",
    "wallet_pin": sender wallet pin,
}

*/

const sendFundFunction = async (req, res) => {
  try {
    checkSendFundData(req);

    await checkUserBalanceAndPin(req);

    await transferFundToUserByUserId(req);

    res
      .status(200)
      .json({ status: "success", msg: "Transfer Operation successful!" });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 400)
      .json({ status: "fail", msg: error.msg ?? "Something went wrong!" });
  }
};

module.exports = sendFundFunction;
