import 'package:flutter/cupertino.dart';

import '../data/api_helper.dart';
import '../model/gemini_response_model.dart';
import '../model/massege_model.dart';

class MessageProvider extends ChangeNotifier {
  List<MessageModel> messagesList = [];

  sendMessage({required String messag}) async {
    try {
      // Add the user's message first
      messagesList.add(
        MessageModel(msg: messag, sendId: 0, sendAt: DateTime.now().toString()),
      );
      notifyListeners();

      // Call API
      var mData = await APIHelper().sendMsgApi(msg: messag);

      GeminiResponse geminiResponse = GeminiResponse.fromJson(mData!);

      // Add the bot's response AFTER the user message
      messagesList.add(
        MessageModel(
          msg: geminiResponse.firstText, // use helper for safety
          sendId: 1,
          sendAt: DateTime.now().toString(),
          isRead: false,
        ),
      );

      notifyListeners();
    } catch (e) {
      print("failed with error: ${e.toString()}");
    }
  }

  fetechAllMessages() {
    return messagesList;
  }

  void updateMessageRwad(int index) {
    if (index >= 0 && index < messagesList.length) {
      messagesList[index].isRead = true;
      notifyListeners();
    }  }
}
