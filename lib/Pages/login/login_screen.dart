import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:soulmate/Pages/login/signup_two.dart';
import 'package:soulmate/Tools/domain.dart';
import 'package:soulmate/data/user_repository.dart';

import '../../main.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool signIn=true;
  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);

    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: "Soulmate",
      logo: 'assets/kesfet.png',
      logoTag: "com.logo",
      titleTag: "com.title",
       messages: LoginMessages(
         usernameHint: 'Mail Adresi',
         passwordHint: 'Şifre',
         confirmPasswordHint: 'Confirm',
         loginButton: 'Giriş Yap',
         signupButton: 'Üye Ol',
         forgotPasswordButton: 'Şifremi unuttum',
         recoverPasswordButton: 'Şifreyi yenile',
         goBackButton: 'GO BACK',
         confirmPasswordError: 'Şifreler uyuşmuyor',
         recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
         recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
         recoverPasswordSuccess: 'Password rescued successfully',
       ),
       theme: LoginTheme(
         primaryColor: Colors.white,
         accentColor: Colors.yellow,
         errorColor: Colors.deepOrange,
         pageColorLight: Colors.lightBlue.shade300,
         pageColorDark: Colors.indigo.shade500,
         titleStyle: TextStyle(
           color: Colors.white,
           fontFamily: 'Quicksand',
           letterSpacing: 4,
         ),
         // beforeHeroFontSize: 50,
         // afterHeroFontSize: 20,
         bodyStyle: TextStyle(
           fontStyle: FontStyle.italic,
           decoration: TextDecoration.underline,
         ),
         textFieldStyle: TextStyle(
           color: Colors.white,
           shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
         ),
         buttonStyle: TextStyle(
           fontWeight: FontWeight.w800,
           color: Colors.yellow,
         ),
         cardTheme: CardTheme(
           color: Colors.cyan,
           elevation: 5,
           margin: EdgeInsets.only(top: 15),
           shape: ContinuousRectangleBorder(
               borderRadius: BorderRadius.circular(100.0)),
         ),
         inputTheme: InputDecorationTheme(
           filled: true,
           fillColor: Colors.purple.withOpacity(.1),
           contentPadding: EdgeInsets.zero,
           errorStyle: TextStyle(
             backgroundColor: Colors.orange,
             color: Colors.white,
           ),
           labelStyle: TextStyle(fontSize: 12),
           enabledBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
             borderRadius: inputBorder,
           ),
           focusedBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
             borderRadius: inputBorder,
           ),
           errorBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.red.shade700, width: 7),
             borderRadius: inputBorder,
           ),
           focusedErrorBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.red.shade400, width: 8),
             borderRadius: inputBorder,
           ),
           disabledBorder: UnderlineInputBorder(
             borderSide: BorderSide(color: Colors.grey, width: 5),
             borderRadius: inputBorder,
           ),
         ),
         buttonTheme: LoginButtonTheme(
           splashColor: Colors.purple,
           backgroundColor: Colors.pinkAccent,
           highlightColor: Colors.lightGreen,
           elevation: 9.0,
           highlightElevation: 6.0,

           // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
           // shape: CircleBorder(side: BorderSide(color: Colors.green)),
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
         ),
       ),
      emailValidator: (value) {
        if (!value.contains('@')) {
          return "Email must contain '@'";
    }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) async{
        signIn=true;
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');

        if(!await userRepo.signIn(loginData.name, loginData.password)){
          return "Kullanıcı adı ve şifre hatalı";
        }else return null;
//        return _emailLogin(loginData.name,loginData.password);
//        return _loginUser(loginData);
      },
      onSignup: (loginData) {
        signIn=false;
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _emailSignup(loginData.name,loginData.password);
      },
      onSubmitAnimationCompleted: () {
        debugPrint("submitanimation");
        if(signIn)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainWidget()),
                (Route<dynamic> route) => false,
          );
         else
         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupTwo()));
      },
      onFacebookClick: () => debugPrint("facebook tiklandi"),
      onGoogleClick: () => debugPrint("Google tiklandi"),
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
//        return _recoverPassword(name);
      return null;
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
  Future<String> _emailSignup(String mail,String password) async {
    var firebaseuser = await _auth
          .createUserWithEmailAndPassword(email: mail, password: password)
          .catchError((e) => debugPrint("Hata :"+e.toString()));
      if(firebaseuser==null) {
        return "Bu mail adresi kayıtlı.Lütfen başka mail adresi deneyiniz.";
      }
      else {
          var response =
        await http.post(Domain().getDomainApi()+"/user/save", body: {
      "uid": firebaseuser.user.uid,
      "mail_address": firebaseuser.user.email,
    });
   if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      // return Gonderi.fromJsonMap(json.decode(response.body));
      return null;
    } else {
      debugPrint(response.statusCode.toString());
    } 
    return null;
      }
  }
  Future<String> _emailLogin(String mail,String password) async {
    var firebaseuser_login = await _auth
        .signInWithEmailAndPassword(email: mail, password: password)
        .catchError((e) => debugPrint("Hata :"+e.toString()));
    if(firebaseuser_login==null) {
      return "Kullanıcı adı ve şifre hatalı";
    }
    else
    return null;
  }
}
