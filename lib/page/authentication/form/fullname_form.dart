import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

import 'const.dart';

// ignore: must_be_immutable
class FullNameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    return TextFormField(
        controller: fullName,
        onChanged: prov.setFullName,
        decoration: InputDecoration(
          labelText: 'Full Name',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(15),)
    );
  }
}