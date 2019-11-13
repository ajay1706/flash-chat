import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{

    try{
    final user = await _auth.currentUser();
    if(user != null){
loggedInUser = user;
print(loggedInUser.email);
    }}
    catch(e){
      print(e);
    }
  }


//  void getMessages()async{
//   final messages = await  _firestore.collection('messages').getDocuments();
//   for (var message in messages.documents){
//
//     print(message.data);
//   }
//  }


  void messagesStream() async{
 await for ( var snapshot in _firestore.collection('messages').snapshots()){
  for (var message in snapshot.documents){
    print(message.data);
  }
 };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot){

               if(!snapshot.hasData ){
                 return Center(
                   child: CircularProgressIndicator(
                     backgroundColor: Colors.lightBlueAccent,
                   ),
                 );
               }

                final messages = snapshot.data.documents;
                List<MessageBubble> messageBubbles = [];
                for(var message in messages){
                  final messageText = message.data['text'];
                  final messageSender = message.data['sender'];

                  final messageBubble =MessageBubble(text: messageText,sender: messageSender);

                  messageBubbles.add(messageBubble);
                // ignore: missing_return
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  children: messageBubbles,
                  ),
                );



              },
        ),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      //messageText + loggedInUser
                      _firestore.collection('messages').add({
                        'text' : messageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {

  final String sender;
  final String text;

  const MessageBubble({Key key, this.sender, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 20),
      child: Column(
        children: <Widget>[
          Text(sender,style: TextStyle(
            fontSize: 12,
            color: Colors.black54
          ),),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),

            color: Colors.lightBlueAccent,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
