import 'package:soulmate/Pages/message/message_model.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/user.dart';
import 'package:http/http.dart' as http;

class MessageRepository {

  Future<Message> getMessage (String uid) async {
    var response =
    await http.post(Domain().getDomainApi() + "/user/fromUid", body: {
      "uid": uid,
    });
    if (response.statusCode == 200) {
      //return .fromRawJson(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

}