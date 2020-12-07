import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

import 'const.dart';

class EmailForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: true);
    return TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        onChanged: prov.setEmail,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        suffixText: '@gmail.com',
          contentPadding: EdgeInsets.all(15),
        )
    );
  }
}
