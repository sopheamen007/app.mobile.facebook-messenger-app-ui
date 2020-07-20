import 'package:chat_messanger_ui/constant/data.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _sendMessageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.2),
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: primary,
            )),
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tyler Nix",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Active now",
                  style: TextStyle(color: black.withOpacity(0.4), fontSize: 14),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          Icon(
            LineIcons.phone,
            color: primary,
            size: 32,
          ),
          SizedBox(
            width: 15,
          ),
          Icon(
            LineIcons.video_camera,
            color: primary,
            size: 35,
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
                color: online,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white38)),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: getBody(),
      bottomSheet: getBottom(),
    );
  }
  Widget getBottom(){
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: grey.withOpacity(0.2)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 40)/2,
              child: Row(
                children: <Widget>[
              Icon(Icons.add_circle,size: 35,color: primary,),
              SizedBox(width: 15,),
              Icon(Icons.camera_alt,size: 35,color: primary,),
              SizedBox(width: 15,),
              Icon(Icons.photo,size: 35,color: primary,),
              SizedBox(width: 15,),
              Icon(Icons.keyboard_voice,size: 35,color: primary,),
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width- 40)/2,
              child: Row(
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width-140)/2,
                  height: 40,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextField(
                      cursorColor: black,
                      controller: _sendMessageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Aa",
                        suffixIcon: Icon(Icons.face,color: primary,size: 35,)
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Icon(Icons.thumb_up,size: 35,color: primary,),
              ],
            ),
            ),
            
            
            
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    
    return ListView(
      padding: EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 80),
      children: List.generate(messages.length, (index){
        return ChatBubble(isMe: messages[index]['isMe'],messageType: messages[index]['messageType'],message: messages[index]['message'],profileImg: messages[index]['profileImg']);
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  const ChatBubble({
    Key key, this.isMe, this.profileImg, this.message, this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isMe){
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
                          child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: getMessageType(messageType) 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: white,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }else{
      return Padding(
        padding:  EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            profileImg),
                        fit: BoxFit.cover)),
              ),
            SizedBox(
              width: 15,
            ),
            Flexible(
                          child: Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: getMessageType(messageType) 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: black,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    
  }
  getMessageType(messageType){
    if(isMe){
      // start message
      if(messageType == 1){
        return BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // middle message
      else if(messageType == 2){
        return BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // end message
      else if(messageType == 3){
        return BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // standalone message
      else{
        return BorderRadius.all(Radius.circular(30));
      }
    }
    // for sender bubble
    else{
      // start message
        if(messageType == 1){
          return BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // middle message
        else if(messageType == 2){
          return BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // end message
        else if(messageType == 3){
          return BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // standalone message
        else{
          return BorderRadius.all(Radius.circular(30));
        }
    }
    
    
  }
}
