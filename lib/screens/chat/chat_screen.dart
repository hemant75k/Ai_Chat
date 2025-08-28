import 'package:ai_bot/model/massege_model.dart';
import 'package:ai_bot/wigtes/ui_helper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/message_provider.dart';

class ChatScreen extends StatefulWidget {
  final String query;
  const ChatScreen({super.key, required this.query});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MessageProvider>(context, listen: false)
          .sendMessage(messag: widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            text: "Chat",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: "Bot",
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.face),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, __) {
                final chatList = provider.messagesList;
                return ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    final message = chatList[index];
                    return message.sendId == 0
                        ? UserMessageWidget(msgModel: message)
                        : BotMessageWidget(
                      msgModel: message,
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: chatController,
              style: mTextStyle18(fontColor: Colors.white70),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mic, color: Colors.white),
                suffixIcon: InkWell(
                  onTap: () {
                    final msg = chatController.text.trim();
                    if (msg.isNotEmpty) {
                      Provider.of<MessageProvider>(context, listen: false)
                          .sendMessage(messag: msg);
                    }
                    chatController.clear();
                  },
                  child: const Icon(Icons.send, color: Colors.blue),
                ),
                hintText: "Type Something...",
                hintStyle: mTextStyle18(fontColor: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- USER MESSAGE ----------
class UserMessageWidget extends StatefulWidget {
  final MessageModel msgModel;
  const UserMessageWidget({super.key, required this.msgModel});

  @override
  State<UserMessageWidget> createState() => _UserMessageWidgetState();
}

class _UserMessageWidgetState extends State<UserMessageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var time = DateFormat().add_jm().format(DateTime.parse(widget.msgModel.sendAt!));
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
            bottomLeft: Radius.circular(21),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(widget.msgModel.msg!,
                style: mTextStyle18(fontColor: Colors.white70)),
            Text(
              time,
              style: mTextStyle16(
                fontColor: Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- BOT MESSAGE ----------
class BotMessageWidget extends StatefulWidget {
  final MessageModel msgModel;
  final int index;
  const BotMessageWidget(
      {super.key, required this.msgModel, required this.index});

  @override
  State<BotMessageWidget> createState() => _BotMessageWidgetState();
}

class _BotMessageWidgetState extends State<BotMessageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var time = DateFormat().add_jm().format(DateTime.parse(widget.msgModel.sendAt!));

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
            bottomRight: Radius.circular(21),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.msgModel.isRead!
                ? SelectableText(
              widget.msgModel.msg!,
              style: mTextStyle18(fontColor: Colors.black87),
            )
                : AnimatedTextKit(
              key: UniqueKey(),
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
              isRepeatingAnimation: false,
              onFinished: () {
                context
                    .read<MessageProvider>()
                    .updateMessageRwad(widget.index);
              },
              animatedTexts: [
                TypewriterAnimatedText(
                  widget.msgModel.msg!,
                  textStyle: mTextStyle18(fontColor: Colors.white70),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.tortoise,
                      size: 20,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.msgModel.msg!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Copied..",
                              style: mTextStyle18(fontColor: Colors.white70),
                            ),
                            backgroundColor: Colors.blue.withOpacity(0.8),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.copy_all_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: mTextStyle16(
                    fontColor: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
