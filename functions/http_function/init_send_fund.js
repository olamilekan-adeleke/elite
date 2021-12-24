const functions = require("firebase-functions");
const getUserByUsername = require("../controller/get_user_by_username");

/// this function is for getting the receiver data/details using just the username
/// expect data {"receiver_username": "username" }
/// return user details if exists,
/// note: as it may return no username error found if username is not found or user change username

const initSendFundFunction = async (req, res) => {
  try {
    const { receiver_username } = req.body;

    if (!receiver_username) {
      throw { code: 400, msg: "body must contain receiver_username!" };
    }

    const user = await getUserByUsername(receiver_username);

    res.status(200).json({ status: "success", data: user });
  } catch (error) {
    functions.logger.error(error);

    res
      .status(error.code ?? 400)
      .json({ status: "fail", msg: error.msg ?? "Something went wrong!" });
  }
};

module.exports = initSendFundFunction;
