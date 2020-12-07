import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Gender {Boy, Girl}

class AuthProvider extends ChangeNotifier {
  int _registerIndex = 0;
  int _authIndex = 0 ;
  int _status;

  String _username;
  String _fullName;
  Gender _gender;
  String _email;
  String _password;
  String _alamat;
  String _genderString;

  // ignore: unnecessary_getters_setters
  int get indexRegister => _registerIndex;
  int get index => _authIndex;


  // ignore: unnecessary_getters_setters
  set username(String value) {
    _username = value;
  }

  // ignore: unnecessary_getters_setters
  set indexRegister(int val) {
    _registerIndex = val;
  }

  String get username => _username;
  String get fullName => _fullName;
  Gender get gender => _gender;
  String get getGenderString => _genderString;
  String get email => _email;
  String get password => _password;
  String get alamat => _alamat;

  String getGender() {
    switch(gender){
      case Gender.Boy:
        return "Pria";
        break;
      case Gender.Girl:
        return "Wanita";
        break;
    }
  }

  setGenderString(String n) {
    _genderString = n;
    notifyListeners();
  }

  setUsername(String n) {
    _username = n.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    notifyListeners();
  }

  setFullName(String n) {
    _fullName = n;
    notifyListeners();
  }

  setGender(Gender value) {
    _gender = value;
    notifyListeners();
  }

  setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  setEmail(String n) {
    _email = n + "@gmail.com";
    notifyListeners();
  }

  setAlamat(String n) {
    _alamat = n;
    notifyListeners();
  }

  double getHeightAuth(BuildContext context) {
    if(_authIndex == 0) {
      return MediaQuery.of(context).size.height/1.75;
    } else {
      return MediaQuery.of(context).size.height/2.5;
    }
  }

  void registerPage() {
    _authIndex = 1;
    notifyListeners();
  }

  void loginPage() {
    _authIndex = 0;
    notifyListeners();
  }

  void tapRegisterNext() {
    if(_registerIndex == 0 || _registerIndex < 5) {
      _registerIndex++;
      notifyListeners();
    }
  }

  void tapRegisterBack() {
    _registerIndex--;
    notifyListeners();
  }

  void tapExit() {
    _registerIndex = 0;
    _authIndex = 0;
    notifyListeners();
  }

  register() async{
    var resp = await http.post("http://192.168.100.3/udacoding/register.php", body:
    {
      'username': username,
      'full_name': fullName,
      'gender': getGender(),
      'email': email,
      'password': password,
      'address': alamat,
      'created_at': DateTime.now().toString()
    });

    final data = json.decode(resp.body);
    _status = data['value'];
    notifyListeners();
  }

  int get status => _status;

  // ignore: unnecessary_getters_setters
  set fullName(String value) {
    _fullName = value;
  }

  // ignore: unnecessary_getters_setters
  set email(String value) {
    _email = value;
  }

  // ignore: unnecessary_getters_setters
  set password(String value) {
    _password = value;
  }

  // ignore: unnecessary_getters_setters
  set alamat(String value) {
    _alamat = value;
  }

}