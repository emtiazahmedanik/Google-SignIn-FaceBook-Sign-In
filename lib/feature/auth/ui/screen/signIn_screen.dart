import 'package:authentication_practice_project/feature/auth/controller/continue_with_google_controller.dart';
import 'package:authentication_practice_project/feature/auth/controller/create_account_controller.dart';
import 'package:authentication_practice_project/feature/auth/controller/sign_in_controller.dart';
import 'package:authentication_practice_project/feature/auth/ui/screen/create_account_screen.dart';
import 'package:authentication_practice_project/feature/home/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: const Text(
                    'Sign-In',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hint: Text('Enter email'),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hint: Text('Password'),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GetBuilder<SignInController>(
                  builder: (controller) {
                    if (controller.getInProgress) {
                      return const CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: _onTapSubmit,
                        child: Text('Submit'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccountScreen(),
                            ),
                          );
                        },
                        child: Text('Sign-Up'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GetBuilder<ContinueWithGoogleController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.getInProgress == false,
                      replacement: const CircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapSignInWithGoogle,
                        child: Wrap(children: [Text("Continue with Google")]),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Wrap(children: [Text("Continue with Facebook")]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignInWithGoogle() async {
    final bool isSuccess = await Get.find<ContinueWithGoogleController>()
        .continueWithGoogle();
    if (isSuccess) {
      Get.snackbar(
        'Success',
        Get.find<ContinueWithGoogleController>().getMessage,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (predicate) => false,
      );
    } else {
      Get.snackbar(
        'Failed',
        Get.find<ContinueWithGoogleController>().getMessage,
      );
    }
  }

  Future<void> _onTapSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final isSuccess = await Get.find<SignInController>().signIn(
        emailAddress: email,
        password: password,
      );
      if (isSuccess) {
        Get.snackbar('Successful', Get.find<SignInController>().getMessage);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (predicate) => false,
        );
      } else {
        Get.snackbar('Error', Get.find<SignInController>().getMessage);
      }
    }
    _clearTextField();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearTextField() {
    _emailController.clear();
    _passwordController.clear();
  }
}
