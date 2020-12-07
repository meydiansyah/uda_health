import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

import 'form/alamat_form.dart';
import 'form/email_form.dart';
import 'form/fullname_form.dart';
import 'form/gender_form.dart';
import 'form/password_form.dart';
import 'form/username_form.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final option = <Widget>[
    UsernameForm(),
    FullNameForm(),
    GenderForm(),
    EmailForm(),
    PasswordForm(),
    AlamatForm()
  ];

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: true);

    return PageTransitionSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder:
          (child, primaryAnimation, secondaryAnimation) =>
          SharedAxisTransition(
            animation: primaryAnimation,
            fillColor: Colors.white,
            secondaryAnimation: secondaryAnimation,
            child: child,
            transitionType: SharedAxisTransitionType.horizontal,
          ),
      child: option[prov.indexRegister],
    );
  }
}