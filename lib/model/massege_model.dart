class MessageModel {
  final String msg;
  final int sendId;
  final String sendAt;
  late final bool isRead;

  MessageModel({
    required this.msg,
    required this.sendId,
    required this.sendAt,
    this.isRead = false,
  });
}
