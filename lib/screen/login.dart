import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_if22a/config/asset.dart';
import 'package:project_if22a/event/even_db.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _controllerUsername = TextEditingController();
  var _controllerPass = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: asset.colorPrimaryDark,
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                left: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Produk Smart Campus',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                          controller: _controllerUsername,
                      style: TextStyle(
                        color: asset.colorPrimaryDark,
                      ),
                      decoration: InputDecoration(
                          hintText: 'username',
                          hintStyle: TextStyle(
                            color: asset.colorPrimaryDark,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: asset.colorPrimaryDark,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: asset.colorPrimary,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: asset.colorPrimary,
                              width: 1,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.people,
                            color: asset.colorPrimaryDark,
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value == '' ? 'Jangan Kosong' : null,
                      controller: _controllerPass,
                      style: TextStyle(
                        color: asset.colorPrimaryDark,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: asset.colorPrimaryDark,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: asset.colorPrimaryDark,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: asset.colorPrimary,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: asset.colorPrimary,
                              width: 1,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: asset.colorPrimaryDark,
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: asset.colorAccent,
                      ),
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                          EventDb.login(
                          _controllerUsername.text, _controllerPass.text);
                          _controllerUsername.clear();
                          _controllerPass.clear();
                        }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}