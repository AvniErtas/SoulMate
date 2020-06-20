import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/model/user.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {

  Future<User> getUser (String uid) async {
    var response =
    await http.post(Domain().getDomainApi() + "/user/fromUid", body: {
      "uid": uid,
    });
    if (response.statusCode == 200) {
      return User.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

}