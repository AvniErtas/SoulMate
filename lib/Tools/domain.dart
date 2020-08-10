
class Domain {

/*String domainApi="http://books.loseyourip.com:8082";
  String domain="http://books.loseyourip.com";*/

String domainApi="http://7fa6f33c8d56.ngrok.io";
String domain="http://f87ed3e7cfcf.ngrok.io";
String profile="/profile/";
String thumb="thumb/";
/*String domainApi="http://192.168.43.121:8085";
String domain="http://192.168.43.121";*/

  String getDomain() {
    return domain;
  }
  String getDomainApi() {
    return domainApi;
  }
  String getProfile() {
    return domain+profile;
  }
  String getThumb() {
    return domain+profile+thumb;
  }
}
