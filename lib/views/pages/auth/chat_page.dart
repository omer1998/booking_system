import 'package:booking_system/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/message_model.dart';
import '../../share_widgets/chat_message.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textFieldController = TextEditingController();
  // in order to make the page and specifically the list view scroll to the bottom
  // we need to use a scroll controller
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(AppConstants.messagesCollection);

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("date", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ohhhhh Something went wrong");
        }
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Chat Page"),
              centerTitle: true,
            ),
            body:
                // ChatMessage(message: snapshot.data!["data"],),
                Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // to reverse the list view in order to solve the the incoming messages not showing at the bottom of the reciever
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) => ChatMessage(
                      message: messagesList[index],
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).cardColor,
                //   ),
                //   child: Row(
                //     children: [
                //       const Expanded(
                //         child: TextField(
                //           decoration: InputDecoration(
                //             hintText: "Type a message",
                //             border: InputBorder.none,
                //             contentPadding: EdgeInsets.symmetric(
                //               horizontal: 8,
                //               vertical: 20,
                //             ),
                //           ),
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.send),
                //       ),
                //     ],
                //   ),
                // ),
                // or in other way using text field Only
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: textFieldController,
                    onSubmitted: (value) {
                      if (value.isEmpty != true) {
                        messages.add({
                          'data': value,
                          'date':DateTime.now().toString(),
                        }).then((value) => print("message addedd"));
                        textFieldController.clear();
                        // in order to make the page and specifically the list view scroll to the bottom

                        scrollController.animateTo(
                          0,
                          duration: const Duration(microseconds: 200),
                          curve: Curves.easeInSine,
                        );

                      } else {
                        return;
                      }
                    },
                    scribbleEnabled: true,
                    scrollPadding: const EdgeInsets.all(8),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.send),
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.black45)),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
