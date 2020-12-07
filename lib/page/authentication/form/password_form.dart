import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

import 'const.dart';

class PasswordForm extends StatefulWidget {
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    return TextFormField(
        controller: password,
        onChanged: prov.setPassword,
        obscureText: _show,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: InkWell(
              onTap: () =>
                  setState(() => _show = !_show),
              child: Icon(
                _show
                    ? Icons.visibility_off
                    : Icons.visibility,
                color:
                _show ? Colors.grey : Colors.green,
              ),
            ),
          contentPadding: EdgeInsets.all(15),)
    );
  }
}