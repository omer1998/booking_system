class Message{
final  String message;
final String date;


factory Message.fromJson(json) {
    return Message(
      json['data'] as String,
      json['date'] as String,
    );
  }

  Message(this.message, this.date);
}