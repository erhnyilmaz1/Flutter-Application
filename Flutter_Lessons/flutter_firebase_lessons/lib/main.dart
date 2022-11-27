import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_lessons/firestore_process.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: FireStoreProcess(),
      home: const MyHomePage(title: 'Flutter Firebase Lessons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseAuth auth;
  late String _email;
  late String _password;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    _email = "erhnyilmaz1@gmail.com";
    _password = "pwdGs9466*";

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently sign out!');
      } else {
        debugPrint('User is sign in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      createUser();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text('Email/Password Create')),
                ElevatedButton(
                    onPressed: () {
                      signUser();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: const Text('Email/Password Login')),
                ElevatedButton(
                    onPressed: () {
                      signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                    ),
                    child: const Text('Sign Out')),
                ElevatedButton(
                    onPressed: () {
                      deleteUser();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                    ),
                    child: const Text('Delete User')),
                ElevatedButton(
                    onPressed: () {
                      changePassword();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                    child: const Text('Change Password')),
                ElevatedButton(
                    onPressed: () {
                      changeEmail();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
                    child: const Text('Change Email')),
                ElevatedButton(
                    onPressed: () {
                      loginWithGmail();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: const Text('Login With Gmail')),
                ElevatedButton(
                    onPressed: () {
                      loginWithGmail();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                    child: const Text('Login With Phone Number')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void createUser() async {
    try {
      var _userCredentialCreateUser = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint("USER CREDENTIAL CREATE INFO  : " +
          _userCredentialCreateUser.toString());

      var _myUser = _userCredentialCreateUser.user;

      if (!_myUser!.emailVerified) {
        _myUser.sendEmailVerification();
      } else {
        debugPrint('Verfied The Mail Of User, Go To The Interested Page');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signUser() async {
    try {
      var _userCredentialSignInUser = await auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      debugPrint("USER CREDENTIAL SIGN IN INFO  : " +
          _userCredentialSignInUser.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signOut() async {
    try {
      if (auth.currentUser != null) {
        var _user = GoogleSignIn().currentUser;
        if (_user != null) {
          await GoogleSignIn().signOut(); // Google Email - SignOut
        }
        await auth.signOut(); // Firebase Email - SignOut
      } else {
        debugPrint('Dont Sign Out Because User Session Is Close');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteUser() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.delete();
      } else {
        debugPrint(
            'Cant Delete Because User Session Is Close Or User Is Not Found');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changePassword() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.updatePassword("newpwdGs9466");
        await auth.signOut();
      } else {
        debugPrint('Cant Update Password');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint('Will Be ReAuthenticate');
        var credential =
            EmailAuthProvider.credential(email: _email, password: _password);
        await auth.currentUser!.reauthenticateWithCredential(credential);
        await auth.currentUser!.updatePassword("newpwdGs9466");
        await auth.signOut();
        debugPrint('Password Was Updated!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeEmail() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.updateEmail("erhnyilmaz.280031@gmail.com");
        await auth.signOut();
      } else {
        debugPrint('Cant Email Password');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint('Will Be ReAuthenticate');
        var credential =
            EmailAuthProvider.credential(email: _email, password: _password);
        await auth.currentUser!.reauthenticateWithCredential(credential);
        await auth.currentUser!.updateEmail("erhnyilmaz.280031@gmail.com");
        await auth.signOut();
        debugPrint('Email Was Updated!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void loginWithGmail() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void loginWithPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+905393688351',
      verificationCompleted: (PhoneAuthCredential credential) async {
        debugPrint("VerificationCompleted Was Trigged");
        debugPrint(credential.toString());
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) async {
        debugPrint("Code Sent Was Trigged");
        String _smsCode = "123456";
        var _credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: _smsCode);
        debugPrint(_credential.toString());
        await auth.signInWithCredential(_credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("Code Auto Retreival Timeout Was Trigged");
      },
    );
  }
}
