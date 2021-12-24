const checkSendFundData = (req) => {
  const { receiver_id, sender_id, amount, type, wallet_pin } = req.body;

  if (!receiver_id) {
    throw { code: 400, msg: "receiver_id is required!" };
  }
  
  if (!sender_id) {
    throw { code: 400, msg: "sender_id is required!" };
  }

  if (!amount) {
    throw { code: 400, msg: "amount is required!" };
  }

  if (!type) {
    throw { code: 400, msg: "type is required!" };
  }

  if (!wallet_pin) {
    throw { code: 400, msg: "wallet_pin is required!" };
  }
};

module.exports = checkSendFundData;
