
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ContinueWithGoogleController extends GetxController{

  String? _userName;
  String? _userEmail;
  String? _userPhotoUrl;

  String? get getUserName => _userName;
  String? get getUserEmail => _userEmail;
  String? get getUserPhotoUrl => _userPhotoUrl;

  bool _inProgress = false;
  String _msg = '';
  bool get getInProgress => _inProgress;
  String get getMessage => _msg;
  Future<bool> continueWithGoogle() async{
    String webClientId = '709065168042-r0j4ae63gjrvj9b8687aptpq2fd6b3hc.apps.googleusercontent.com';
    bool isSuccess = false;
    _inProgress = true;
    update();
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;
      signIn.initialize(serverClientId: webClientId);
      final GoogleSignInAccount account = await signIn.authenticate();
      final GoogleSignInAuthentication authentication = account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Get user info from Firebase
      final User? user = FirebaseAuth.instance.currentUser;

      _userName = user?.displayName;
      _userEmail = user?.email;
      _userPhotoUrl = user?.photoURL;

      isSuccess = true;
    } catch (e) {
      _msg = e.toString();
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}