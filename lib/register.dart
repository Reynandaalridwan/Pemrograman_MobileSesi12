// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:praktikum_12/service.dart';
import '../text_field_builder.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController nimController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            textFieldBuilder(
              label: "Name",
              controller: nameController,
              obsecureText: false,
            ),
            SizedBox(
              height: 8,
            ),
            textFieldBuilder(
                label: "NIM", controller: nimController, obsecureText: false),
            SizedBox(
              height: 8,
            ),
            textFieldBuilder(
              label: "Password",
              controller: passwordController,
              obsecureText: true,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {
                  showConfirmationDialog(context);
                }, child: Text("Register")),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Apakah anda yakin?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tidak')
              ),
              ElevatedButton(
                  onPressed: () async{
                    String name = nameController.text.trim();
                    String nim = nimController.text.trim();
                    String password = passwordController.text;
                    try {
                      Response? response = await Services.register(
                        name: name,
                        nim: nim,
                        password: password,
                      );
                      if (mounted) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text ('Berhasil'),
                                content: Text(response!.data['message']),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'),
                                  )
                                ],
                              );
                            }
                        );
                        nameController.clear();
                        nimController.clear();
                        passwordController.clear();
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                      if (mounted) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Gagal'),
                              content: Text(
                                e.toString(),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                )
                              ],
                            ),
                        );
                      }
                    }
                  },
                  child: const Text('Ya')
              ),
            ],
          );
        }
    );
  }
}
