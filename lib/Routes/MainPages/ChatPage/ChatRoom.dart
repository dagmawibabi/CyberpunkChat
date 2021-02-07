import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

bool isMe;

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

  List usersInGroup = [];
  List messageSenderColors = [
    Colors.amber,
    Colors.black,
    Colors.blue,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.grey,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.primaries
  ];
  /*User loggedInUser;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }*/

  @override
  void initState() {
    super.initState();
    //getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Map receivedData = ModalRoute.of(context).settings.arguments;
    TextEditingController messageController = TextEditingController();
    bool isMe;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          height: MediaQuery.of(context).size.height,
          //MediaQuery.of(context).size.height * 0.89,
          decoration: BoxDecoration(
            /*gradient: LinearGradient(
              colors: [
                /*Color(0xff283048),
                        Color(0xff859398),*/
                Color(0xffeb3349),
                Color(0xfff45c43),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),*/
            color: Colors.black,
          ),
          //(MediaQuery.of(context).size.height - 98.0),
          child: Column(
            children: [
              SizedBox(height: 50.0),
              // Design 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BACK BTN
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Column(
                    children: [
                      SizedBox(width: 10.0),
                      Text(
                        receivedData["name"].toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: DesignElements.tirtiaryFont,
                        ),
                      ),
                      Text(
                        usersInGroup.length.toString() + " Members",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.0,
                          fontFamily: DesignElements.secondaryFont,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "graphicsViewer",
                            arguments: {
                              "graphics": receivedData["image"],
                              "assetOrNetwork": "asset",
                            },
                          );
                        },
                        child: Hero(
                          tag: receivedData["heroTag"],
                          child: CircleAvatar(
                            backgroundImage: AssetImage(receivedData["image"]),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.0),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.grey[300], thickness: 2.0),
              // CHAT
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        receivedData["image"],
                      ),
                      fit: BoxFit.cover,
                    ),
                    /*gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.purple[800],
                        /*Colors.grey[800],
                        Colors.grey[500],*/
                        /*Color(0xffeb3349),
                        Color(0xfff45c43),*/
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),*/
                    //color: Colors.grey[00],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  //padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection("messages")
                              .orderBy("time", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              setState(() {});
                            }
                            if (snapshot.hasData) {
                              final messages = snapshot.data.docs.reversed;
                              List<Widget> messageWidgets = [];
                              for (var message in messages) {
                                final messageText = message["text"];
                                final messageSender = message["sender"] != null
                                    ? message["sender"]
                                    : "Guest";
                                //usersInGroup.add(messageSender);
                                usersInGroup.indexOf(messageSender) == -1
                                    ? usersInGroup.add(messageSender)
                                    : print(usersInGroup.length);
                                final messageTime = message["time"];
                                if (messageSender == _auth.currentUser.email) {
                                  isMe = true;
                                } else {
                                  isMe = false;
                                }
                                final messageWidget = MessageContainer(
                                  isMe: isMe,
                                  messageSenderColor: Colors.accents[
                                      usersInGroup.indexOf(messageSender) +
                                          2], //messageSenderColors[
                                  //usersInGroup.indexOf(messageSender)],
                                  messageSender: messageSender,
                                  messageText: messageText,
                                  messageTime: messageTime as Timestamp,
                                );
                                messageWidgets.add(messageWidget);
                              }
                              return Expanded(
                                child: ListView(reverse: true, children: [
                                  Column(
                                    /*crossAxisAlignment: isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,*/
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
                                if (messageText != null) {
                                  messageController.clear();
                                  _firestore.collection("messages").add(
                                    {
                                      "text": messageText,
                                      "sender": _auth.currentUser.email,
                                      "time": FieldValue.serverTimestamp(),
                                    },
                                  );
                                  _firestore
                                      .collection('messages')
                                      .orderBy('createdAt', descending: true);
                                } else {
                                  print("empty text, not sent!");
                                }
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
  MessageContainer({
    this.isMe,
    this.messageSenderColor,
    this.messageSender,
    this.messageText,
    this.messageTime,
  });
  final bool isMe;
  final Color messageSenderColor;
  final String messageSender;
  final String messageText;
  final Timestamp messageTime;
}

class _MessageContainerState extends State<MessageContainer> {
  double containerWidth;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: widget.isMe
              ? widget.messageText.length > 30
                  ? 290.0
                  : null
              : widget.messageText.length > 30
                  ? 290.0
                  : 180.0,
          decoration: BoxDecoration(
            color: widget.isMe
                ? Colors.black87
                : Colors.grey[300].withOpacity(0.9),
            //border: Border.all(color: widget.messageSenderColor, width: 1.6),
            border: Border.all(
                color: widget.isMe ? Colors.grey[300] : Colors.black,
                width: 1.4),
            borderRadius: BorderRadius.only(
              topLeft:
                  widget.isMe ? Radius.circular(30.0) : Radius.circular(30.0),
              topRight:
                  widget.isMe ? Radius.circular(30.0) : Radius.circular(30.0),
              bottomLeft:
                  widget.isMe ? Radius.circular(30.0) : Radius.circular(0.0),
              bottomRight:
                  widget.isMe ? Radius.circular(0.0) : Radius.circular(30.0),
            ),
          ),
          padding: widget.isMe
              ? EdgeInsets.only(left: 20.0, right: 4.0)
              : EdgeInsets.all(0.0),
          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
          child: Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // SENDER
              widget.isMe
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color: widget.isMe ? Colors.black : Colors.black),
                        borderRadius: BorderRadius.only(
                          topLeft: widget.isMe
                              ? Radius.circular(0.0)
                              : Radius.circular(30.0),
                          topRight: widget.isMe
                              ? Radius.circular(30.0)
                              : Radius.circular(0.0),
                          bottomLeft: widget.isMe
                              ? Radius.circular(30.0)
                              : Radius.circular(0.0),
                          bottomRight: widget.isMe
                              ? Radius.circular(0.0)
                              : Radius.circular(30.0),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                      child: SelectableText(
                        widget.messageSender,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: DesignElements.secondaryFont,
                          color: widget.isMe
                              ? Colors.grey[300]
                              : widget.messageSenderColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
              SizedBox(height: 2.0),
              // MESSAGE
              Padding(
                padding: widget.isMe
                    ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
                    : const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8.0),
                child: SelectableText(
                  widget.messageText,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight:
                        widget.isMe ? FontWeight.normal : FontWeight.w600,
                    fontFamily: DesignElements.secondaryFont,
                    color: widget.isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),
              // TIMESTAMP
              Padding(
                padding: widget.isMe
                    ? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0)
                    : const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 6.0, right: 2.0),
                child: SelectableText(
                  '${DateTime.fromMillisecondsSinceEpoch(widget.messageTime.seconds * 1000)}'
                      .substring(0, 19),
                  style: TextStyle(
                    fontSize: 8.0,
                    fontFamily: DesignElements.secondaryFont,
                    color: widget.isMe ? Colors.grey[300] : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
