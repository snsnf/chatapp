class Message {
  final String senderID;
  final String senderEmail;
  final String senderName;
  final String receiverID;
  final String message;
  final String messageID;
  final String timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.senderName,
    required this.receiverID,
    required this.message,
    required this.messageID,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'receiverID': receiverID,
      'message': message,
      'messageID': messageID,
      'timestamp': timestamp,
    };
  }
}