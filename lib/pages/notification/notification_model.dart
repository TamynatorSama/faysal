class NotificationModel{
  late int id;
  late int userId;
  late String title;
  late String content;
  late bool read;
  late String createdAt;
  

  NotificationModel.fromjson(Map<String,dynamic>json){
    id = json["id"];
    userId = json["user_id"]??"";
    title = json["title"]??"";
    content = json["content"]??"";
    read = json["status"].toString().toLowerCase() == "unread";
    createdAt = json["created_at"];
  }
}