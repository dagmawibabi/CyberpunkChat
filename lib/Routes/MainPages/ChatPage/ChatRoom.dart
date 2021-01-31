import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

void main() {
  runApp(ChatRoom());
}

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String messageText;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void messagesStream() async {
    await for (var snapshots in _firestore.collection("messages").snapshots()) {
      for (var messages in snapshots.docs) {
        print(messages.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map receivedData = ModalRoute.of(context).settings.arguments;
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          height: MediaQuery.of(context).size.height,
          //MediaQuery.of(context).size.height * 0.89,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                /*Color(0xff283048),
                        Color(0xff859398),*/
                Color(0xffeb3349),
                Color(0xfff45c43),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          //(MediaQuery.of(context).size.height - 98.0),
          child: Column(
            children: [
              SizedBox(height: 50.0),
              // OPTIONS - BACK AND PROFILE VIEWER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      messagesStream();
                    },
                  ),
                ],
              ),
              // PROFILE
              Hero(
                tag: "profilePic",
                child: CircleAvatar(
                  backgroundImage: AssetImage(receivedData["image"]),
                  radius: 60.0,
                ),
              ),
              SizedBox(height: 10.0),
              // USERNAME
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    receivedData["name"].toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontFamily: DesignElements.tirtiaryFont,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // CHAT
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    /*image: DecorationImage(
                      image: AssetImage(
                        receivedData["image"],
                      ),
                      fit: BoxFit.cover,
                    ),*/
                    /*gradient: LinearGradient(
                      colors: [
                        Color(0xff283048),
                        Color(0xff859398),
                        /*Color(0xffeb3349),
                        Color(0xfff45c43),*/
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),*/
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection("messages").snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final messages = snapshot.data.docs;
                              List<Widget> messageWidgets = [];
                              for (var message in messages) {
                                final messageText = message["text"];
                                final messageSender = message["sender"];
                                final messageWidget = MessageContainer(
                                  messageSender: messageSender,
                                  messageText: messageText,
                                );
                                messageWidgets.add(messageWidget);
                              }
                              return Expanded(
                                child: ListView(children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: messageWidgets,
                                  ),
                                ]),
                              );
                            } else {
                              return CircularProgressIndicator(
                                backgroundColor: Colors.blue,
                              );
                            }
                          }),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          //borderRadius: BorderRadius.circular(50.0),
                          /*borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),*/
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            // ATTACH BTN
                            IconButton(
                              icon: Icon(
                                Icons.attach_file_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            // MESSAGE INPUT
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                onChanged: (value) {
                                  messageText = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "MESSAGE",
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: DesignElements.tirtiaryFont,
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: DesignElements.tirtiaryFont,
                                  ),
                                  border: InputBorder.none,
                                  /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide(
                                      width: 10.0,
                                      color: Colors.red,
                                    ),
                                  ),*/
                                ),
                              ),
                            ),
                            // SEND BTN
                            IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                messageController.clear();
                                _firestore.collection("messages").add({
                                  "text": messageText,
                                  "sender": _auth.currentUser.email,
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageContainer extends StatefulWidget {
  @override
  _MessageContainerState createState() => _MessageContainerState();
  MessageContainer({this.messageSender, this.messageText});
  final String messageSender;
  final String messageText;
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.all(14.0),
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.messageSender,
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
          ),
          Text(
            widget.messageText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
