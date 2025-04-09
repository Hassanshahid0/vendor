import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vendor_app/pages/chat_vendor_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../constant.dart';
import '../model/chat_list_model.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatListModel> chats = [];
  bool isLoading = true;
  getChats() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('Chats Vendor')
        .where('vendorID', isEqualTo: user!.uid)
        // .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((v) {
      setState(() {
        isLoading = false;
        chats.clear();
        for (var e in v.docs) {
          var result = ChatListModel.fromJson(e.data());

          chats.add(result);
        }
      });

      chats.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  @override
  void initState() {
    getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
        ),
        body: isLoading == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5, // Replace with the actual number of chat items
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 28,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: double.infinity,
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child:chats.isEmpty
                    ? Center(
                      child: Icon(
                          Icons.chat_bubble,
                          size: 200,
                          color: appColor,
                        ),
                    )
                    : ListView.builder(
                    shrinkWrap: true,
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      ChatListModel chatListModel = chats[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatVendorPage(userID: chatListModel.userID);
                          }));
                        },
                        child: chatListModel.userID.isNotEmpty
                            ? UserDetailWidget(
                                timestamp: chatListModel.timestamp,
                                userID: chatListModel.userID,
                              )
                            : const SizedBox.shrink(),
                      );
                    }),
              ));
  }
}

class UserDetailWidget extends StatefulWidget {
  final String userID;
  final DateTime timestamp;
  const UserDetailWidget(
      {super.key, required this.userID, required this.timestamp});

  @override
  State<UserDetailWidget> createState() => _UserDetailWidgetState();
}

class _UserDetailWidgetState extends State<UserDetailWidget> {
  String fullname = '';
  String email = '';
  String userPic = '';
  Future<void> _getUserDetails() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    setState(() {
      firestore
          .collection('users')
          .doc(widget.userID)
          .snapshots()
          .listen((value) {
        setState(() {
          fullname = value['fullname'];
          // email = value['email'];
          // userPic = value['photoUrl'];
        });
      });
    });
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fullname.isEmpty
        ? const SizedBox.shrink()
        : ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: appColor),
              child: Center(
                child: Text(
                  fullname[0],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.r),
                ),
              ),
            ),
            subtitle: Text(
              timeago.format(widget.timestamp, locale: 'en'),
              style: TextStyle(fontSize: 8.r),
            ),
            title: Text(fullname),
            trailing: const Icon(Icons.chevron_right),
          );
  }
}
