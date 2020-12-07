import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

import 'const.dart';

// ignore: must_be_immutable
class UsernameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prov.username != null
            ? prov.username.length < 6
              ? Text("Username must > 6", style: TextStyle(color: Colors.red[200]),)
              : Container()
            : Container(),
        SizedBox(height: 10,),
        TextFormField(
            controller: username,
            onChanged: prov.setUsername,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(15),)
        ),
      ],
    );
  }
}