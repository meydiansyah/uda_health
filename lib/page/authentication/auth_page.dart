import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uda_health/provider/auth_provider.dart';
import 'package:uda_health/page/authentication/form/const.dart';
import 'package:uda_health/page/authentication/login.dart';
import 'package:uda_health/page/authentication/register.dart';
import 'package:uda_health/page/home_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final option = <Widget>[
    Login(),
    Register(),
  ];

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Center(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 24),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: Text(
                              "uda",
                              style: GoogleFonts.majorMonoDisplay(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Health",
                          style: GoogleFonts.majorMonoDisplay(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: AnimatedContainer(
                margin: EdgeInsets.all(20),
                duration: Duration(milliseconds: prov.index == 0 ? 0 : 700),
                height: prov.getHeightAuth(context),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _headerLogin(),
                          _form(),
                          prov.index == 0 ? _actionLogin() : _actionRegister()
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    var prov = Provider.of<AuthProvider>(context, listen: true);

    return PageTransitionSwitcher(
      duration: Duration(milliseconds: prov.index == 0 ? 0 : 850),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          FadeThroughTransition(
        animation: primaryAnimation,
        fillColor: Colors.white,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
      child: option[prov.index],
    );
  }

  String status(int st) {
    switch (st) {
      case 0:
        return "Register berhasil !!!\n\nSilahkan masuk dengan username dan password anda";
        break;
      case 1:
        return "Registrasi Gagal !!!\n\nSilahkan lengapi data anda dengan benar";
        break;
      case 2:
        return "Register Gagal !!!\n\nUsername telah digunakan";
        break;
      case 3:
        return "Register Gagal !!!\n\nEmail telah digunakan";
        break;
    }
  }

  VoidCallback actionTapRegister(AuthProvider prov) {
    switch (prov.indexRegister) {
      case 0:
        if (prov.username != null) {
          if (prov.username.length != 0 && prov.username.length >= 6) {
            return () => prov.tapRegisterNext();
          }
        } else
          return null;
        break;
      case 1:
        if (prov.fullName != null) {
          if (prov.fullName.length != 0) {
            return () => prov.tapRegisterNext();
          }
        } else
          return null;
        break;
      case 2:
        if (prov.getGender() != null) {
          return () => prov.tapRegisterNext();
        } else
          return null;
        break;
      case 3:
        if (prov.email != null) {
          if (prov.email.length != 0) {
            return () => prov.tapRegisterNext();
          }
        } else
          return null;
        break;
      case 4:
        if (prov.password != null) {
          if (prov.password.length != 0) {
            return () => prov.tapRegisterNext();
          }
        } else
          return null;
        break;
      case 5:
        if (prov.alamat != null) {
          if (prov.alamat.length != 0) {
            return () {
              prov.register();

              if (prov.status == 3) {
                prov.indexRegister = 3;
                prov.email = null;
                email.clear();
              } else {
                prov.indexRegister = 0;
                username.clear();
                fullName.clear();
                email.clear();
                password.clear();
                alamat.clear();

                prov.username = null;
                prov.fullName = null;
                prov.email = null;
                prov.password = null;
                prov.alamat = null;
              }

              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Column(
                        children: [
                          Text("Status"),
                          Divider(
                            thickness: 1.5,
                          )
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      content: Text(status(prov.status)),
                      actions: [
                        RaisedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Oke"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.blue,
                        )
                      ],
                    );
                  });
              prov.loginPage();
            };
          }
        } else
          return null;
        break;
      default:
        return null;
    }
  }

  Widget _actionRegister() {
    var prov = Provider.of<AuthProvider>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          child: Text(
            prov.indexRegister == 0 ? "Sudah punya akun ?" : "Kembali",
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
          onPressed: prov.indexRegister == 0
              ? () => prov.index == 0 ? prov.registerPage() : prov.loginPage()
              : () => prov.tapRegisterBack(),
        ),
        RaisedButton(
          onPressed: actionTapRegister(prov),
          child: Text(
            prov.indexRegister == 5 ? "Masuk" : "Lanjut",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          color: prov.indexRegister == 5 ? Colors.blue : Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }

  VoidCallback _actionTapLogin(AuthProvider prov) {
    if (prov.username != null && prov.password != null) {
      if (prov.username.length > 5) {
        return () async {
          int status;

          var resp = await http
              .post("http://192.168.100.3/udacoding/login.php", body: {
            'username': prov.username,
            'password': prov.password,
          });

          final data = json.decode(resp.body);

          status = data['value'];

          if (status == 0) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setBool('login', true);
            await pref.setString('idUser', data['id']);
            await pref.setString('name', data['username']);
            await pref.setString('fullName', data['full_name']);
            await pref.setString('email', data['email']);
            await pref.setString('gender', data['gender']);
            await pref.setString('address', data['address']);
            await pref.setString('created', data['craeted_at']);
            return Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Column(
                      children: [
                        Text("Login Gagal !"),
                        Divider(
                          thickness: 1.5,
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    content: Text("Periksa kembali username dan password anda"),
                    actions: [
                      RaisedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Oke"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.blue,
                      )
                    ],
                  );
                });
          }
        };
      }
    }
    return null;
  }

  Widget _actionLogin() {
    var prov = Provider.of<AuthProvider>(context, listen: true);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          child: Text(
            "Buat akun",
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
          onPressed: () =>
              prov.index == 0 ? prov.registerPage() : prov.loginPage(),
        ),
        RaisedButton(
          onPressed: _actionTapLogin(prov),
          child: Text(
            "Masuk",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }

  Widget _headerLogin() {
    var prov = Provider.of<AuthProvider>(context, listen: true);

    String description() {
      switch (prov.indexRegister) {
        case 0:
          return "Masukkan username";
          break;
        case 1:
          return "Masukkan nama lengkap";
          break;
        case 2:
          return "Pilih jenis kelamin";
          break;
        case 3:
          return "Masukkan alamat email";
          break;
        case 4:
          return "Password";
          break;
        case 5:
          return "Dimana anda tinggal ?";
          break;
        default:
          return "";
          break;
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          prov.index == 0 ? "Login" : "Register",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          prov.index == 0 ? "Selamat datang kembali" : description(),
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
