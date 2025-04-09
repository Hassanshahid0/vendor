class ChatListModel {
  final String userID;
  final DateTime timestamp;
  final String uid;
  final String vendorID;

  ChatListModel({
    required this.vendorID,
    required this.userID,
    required this.timestamp,
    required this.uid,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      vendorID: json['vendorID'],
      userID: json['userID'],
      timestamp: json['timestamp'].toDate(),
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toUtc(),
      'userID': userID,
      'vendorID': vendorID,
      'uid': uid,
    };
  }
}
