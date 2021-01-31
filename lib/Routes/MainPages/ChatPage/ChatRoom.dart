import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

void main() {
  runApp(ChatRoom());
}

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    Map receivedData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        shadowColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[500],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline_outlined,
              color: Colors.grey[500],
            ),
            onPressed: () {},
          ),
        ],
      ),*/
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
              // OPTIONS
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
                    onPressed: () {},
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
                            IconButton(
                              icon: Icon(
                                Icons.attach_file_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            Expanded(
                              child: TextField(
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
                            IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                              onPressed: () {},
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
