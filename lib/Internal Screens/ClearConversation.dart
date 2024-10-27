import 'package:flutter/material.dart';

class ClearConversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clear Conversation', style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular',),),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(
          255, 19, 19, 73),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ChatMessage(
            text: 'Hi there!',
            sender: 'John',
          ),
          ChatMessage(
            text: 'Hello!',
            sender: 'Alice',
          ),
          ChatMessage(
            text: 'How are you?',
            sender: 'John',
          ),
          ChatMessage(
            text: 'I\'m good, thanks!',
            sender: 'Alice',
          ),
          ChatMessage(
            text: 'Would you like to grab some coffee?',
            sender: 'John',
          ),
          ChatMessage(
            text: 'Sure!',
            sender: 'Alice',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle clear conversation action
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Clear Conversation', style: TextStyle(fontFamily: 'Poppins-Regular',),),
                    content: Text(
                        'Are you sure you want to clear the conversation?', style: TextStyle(fontFamily: 'Poppins-Regular'),),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Perform clear conversation action
                          // You can add your logic here to clear the conversation
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Conversation cleared!',
                                style: TextStyle(fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                  255, 19, 19, 73),// Set button color to purple
                        ),
                        child: Text(
                          'Clear',
                          style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Regular'
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(
                255, 19, 19, 73),
              // Set button color to purple
            ),
            child: Text(
              'Clear Conversation',
              style: TextStyle(
                fontSize: 18, color: Colors.white,
                  fontFamily: 'Poppins-Regular'
                // Set font size to 18
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      subtitle: Text(sender),
    );
  }
}
