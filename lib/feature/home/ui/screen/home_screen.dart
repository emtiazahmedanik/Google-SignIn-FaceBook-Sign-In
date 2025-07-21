import 'package:authentication_practice_project/feature/auth/controller/continue_with_google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<ContinueWithGoogleController>(
              builder: (controller) {
                return Center(
                  child: Column(
                    spacing: 12,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(controller.getUserPhotoUrl!,),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 5,
                                blurRadius: 5
                              )
                            ]
                          ),
                          child: Column(
                            spacing: 5,
                            children: [
                              Text(controller.getUserEmail!),
                              Text(controller.getUserName!)
                            ],
                          ),
                        )
                      ]
                  ),
                );
              }
            ),
          )
      ),
    );
  }
}
