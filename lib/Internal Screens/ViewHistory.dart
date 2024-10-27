import 'package:flutter/material.dart';

class ViewHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History', style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular',),),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(
            255, 19, 19, 73),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: chatHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chatHistory[index].text),
            subtitle: Text(chatHistory[index].sender),
          );
        },
      ),
    );
  }
}

// Sample chat message model
class ChatMessage {
  final String text;
  final String sender;

  ChatMessage({required this.text, required this.sender});
}

// Sample chat history data
List<ChatMessage> chatHistory = [
  ChatMessage(text: 'Hi there!', sender: 'John'),
  ChatMessage(text: 'Hello!', sender: 'Alice'),
  ChatMessage(text: 'How are you?', sender: 'John'),
  ChatMessage(text: 'I\'m good, thanks!', sender: 'Alice'),
  ChatMessage(text: 'Would you like to grab some coffee?', sender: 'John'),
  ChatMessage(text: 'Sure!', sender: 'Alice'),
  // Add more chat messages as needed
];
