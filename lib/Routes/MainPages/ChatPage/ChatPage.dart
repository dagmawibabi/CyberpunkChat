import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

void main() {
  runApp(ChatPage());
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    List friendsList = [
      "Group Chat",
    ];
    return Scaffold(
      backgroundColor: DesignElements.scaffoldBG,
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: DesignElements.appBarBG,
        automaticallyImplyLeading: false,
        title: Text(
          "CYBERCHAT",
          style: TextStyle(
            color: DesignElements.appBarTitle,
            fontSize: DesignElements.appBarTitleFontSize,
            fontFamily: DesignElements.mainFont,
            letterSpacing: DesignElements.appBarTitleLetterSpacing,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: ListView.builder(
          itemCount: friendsList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
              child: Stack(
                children: [
                  CustomPaint(
                    painter: DentContainer(
                      396.0,
                      62.0,
                      14.0,
                      10.0,
                      Colors.grey[300],
                      PaintingStyle.fill,
                    ),
                  ),
                  CustomPaint(
                    painter: DentContainer(
                      396.0,
                      62.0,
                      14.0,
                      10.0,
                      Colors.black,
                      PaintingStyle.stroke,
                    ),
                  ),
                  Container(
                    height: 62.0,
                    //color: Colors.red,
                    padding: EdgeInsets.only(
                        top: 2.0, bottom: 2.0, left: 12.0, right: 4.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "chatRoom",
                              arguments: {
                                "heroTag": "profilepic$index",
                                "name": friendsList[index],
                                "image": "assets/images/GroupChatDP.png",
                              },
                            );
                          },
                          child: Hero(
                            tag: "profilepic$index",
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/GroupChatDP.png"),
                              radius: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 10,
                          child: Text(
                            friendsList[index].toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: DesignElements.tirtiaryFont,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.send_outlined),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "chatRoom",
                              arguments: {
                                "heroTag": "profilepic$index",
                                "name": friendsList[index],
                                "image": "assets/images/GroupChatDP.png",
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
