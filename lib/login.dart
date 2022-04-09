import 'package:drive_easy/classes/user.dart';
import 'package:drive_easy/game/game_home.dart';
import 'package:drive_easy/global.dart';
import 'package:drive_easy/ui/pages/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  Widget? _current;
  bool? success;
  final game = GameMain();

  @override
  void initState() {
    super.initState();

    _current = LoginCard();
  }
  
  Future<void> signIn() async {
    await Firebase.initializeApp();
    FirebaseAppCheck appCheck = FirebaseAppCheck.instance;
    await appCheck.activate(
      webRecaptchaSiteKey: 'AIzaSyC6vpRvWVrPByuW0obOdXDUrfAcGSPnuXQ'
    );
    String? token = await appCheck.getToken(true);
    
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      await _auth.signInWithEmailAndPassword(
        email: _email ?? '', 
        password: _password ?? '',
      ).then((value) => {
        app_user = AppUser(
          user_firebase: value.user,
          userCredential_firebase: value,
          auth_fail: false,
          app_check_token: token ?? 'undefined'
        ),
        appCheck.onTokenChange.listen((token) {
          app_user?.app_check_token = token;
        }),
        print("id: " + (value.user?.uid ?? '').toString()),
        success = true
      });
    } on FirebaseAuthException catch(e){
      print(e);
      success = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed, ' + (e.message ?? ''))
        ),
      );
    }
    
  }

  Widget LoginCard(){
    return Center(
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text('Email: '),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Center(
                    child: TextFormField(
                      validator: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text('Password: '),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: TextFormField(
                      validator: (value) {
                        _password = value;
                      },
                      obscureText: true,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _current = 
                                  const Center(child: CircularProgressIndicator());
                            });
                            if (_formKey.currentState?.validate() ?? false){
                              await signIn();
                              if (success ?? false){
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: ((context) =>  MainPage(game: game,))
                                  )
                                );
                                setState(() {
                                  _current = LoginCard();
                                });
                              }
                              else{
                                setState(() {
                                  _current = LoginCard();
                                });
                              }
                            }

                            
                          },
                          child: const Text('login'),
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: ((context) =>  MainPage(game: game,))
                        )
                      );
                    }, child: Text("bypass"))
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _current ?? const Center(child: CircularProgressIndicator());
  }
}