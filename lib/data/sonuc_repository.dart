import 'package:soulmate/model/test.dart';
import 'package:soulmate/model/user.dart';

class SonucRepository {

  List<User> getUserResults() {
    List<User> users = new List<User>();

    users.add(new User(uid: "123",photo: "anann",test_score: "12",username: "avniertas"));
    users.add(new User(uid: "123",photo: "anann",test_score: "13",username: "avniertas2"));
    users.add(new User(uid: "123",photo: "anann",test_score: "100",username: "Onurs"));
    return users;
  }

}