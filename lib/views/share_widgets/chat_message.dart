import 'package:booking_system/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: Theme.of(context).primaryColor.withOpacity(0.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  message.message,
                  style: Theme.of(context)
                      .textTheme
                      .copyWith(
                          bodyText1:
                              TextStyle(color: Colors.white, fontSize: 20))
                      .bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( left: 4, bottom: 4, right: 4),
            child: Text(DateFormat.jm().format(DateTime.parse(message.date)).toString() ,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Color.fromARGB(255, 57, 57, 57))),
              )
            ],
          ),
        ));
  }
}
