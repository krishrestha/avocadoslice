import 'package:avocadoslice/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChatroomScreen extends StatefulWidget {

  String chatroomName;
  String chatroomId;

  ChatroomScreen({super.key, required this.chatroomName, required this.chatroomId});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  var db = FirebaseFirestore.instance;
  TextEditingController messageText = TextEditingController();
  Future<void> sendMessage() async {
    if(messageText.text.isEmpty){
      return ;
    }
    Map<String,dynamic> messageToSend = {
    "text" : messageText.text,
      "sender_name" : Provider.of<UserProvider>(context,listen: false).userName,
      "sender_id" : Provider.of<UserProvider>(context,listen: false).userId,
      "chatroom_id" : widget.chatroomId,
      "timestamp" : FieldValue.serverTimestamp(),
    };
    messageText.text = "";
    try {
      await db.collection("messages").add(messageToSend);
    }
    catch(e){}
  }

  Widget singleChatItem({required String sender_name,required String text,required String sender_id}){
    return Column(
      crossAxisAlignment: sender_id ==Provider.of<UserProvider>(context,listen: false).userId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(6,0,6,3),
          child: Text(sender_name),
        ),
        Container(
          decoration: BoxDecoration(
            color:sender_id ==Provider.of<UserProvider>(context,listen: false).userId ? Colors.blue[600] : Colors.black,
            borderRadius: BorderRadius.circular(12)
          ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
                child: Text(text,style: TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.w600),),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatroomName),),
      body: Column(
        children: [
          Expanded(child: StreamBuilder(
            stream: db.collection("messages").where("chatroom_id",isEqualTo: widget.chatroomId).orderBy("timestamp",descending: true).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasError){
                print(snapshot.error);
                return Text('error occured');
              }
              var allMessages = snapshot.data?.docs ?? [];
              if(allMessages.length<1){
                return Center(
                  child: Text("no messages in the chatroom"),
                );
              }
            return ListView.builder(
              reverse: true,
              itemCount: allMessages.length,itemBuilder: (BuildContext context ,int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: singleChatItem(sender_name: allMessages[index]["sender_name"], text: allMessages[index]["text"], sender_id: allMessages[index]["sender_id"]),
                );
              });
          },)),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: messageText,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none
                    ),
                  )),
                  InkWell(
                    onTap: sendMessage,
                      child: Icon(Icons.send)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
