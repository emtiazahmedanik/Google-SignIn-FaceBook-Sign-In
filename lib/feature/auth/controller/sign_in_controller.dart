import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  String _msg = '';
  bool get getInProgress => _inProgress;
  String get getMessage => _msg;
  Future<bool> signIn({required String emailAddress, required String password}) async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _msg = 'weak-password';
      } else if (e.code == 'email-already-in-use') {
        _msg = 'The account already exists for that email.';
      }
    } catch (e) {
      _msg = e.toString();
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}