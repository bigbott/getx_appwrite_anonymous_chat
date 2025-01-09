import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isFromInterlocutor;
  const MessageBubble(
      {super.key,
      required this.text,
      required this.isFromInterlocutor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isFromInterlocutor ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
             // width: 100,
              
              decoration: BoxDecoration(
                color: isFromInterlocutor ? Colors.purple.shade100 : Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text),
              ),
            )
          ],    
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
