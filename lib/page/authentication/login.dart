import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              prov.username != null
                  ? prov.username.length < 6
                      ? Text(
                          "Username must > 6",
                          style: TextStyle(color: Colors.red[200]),
                        )
                      : Container()
                  : Container(),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: name,
                  onChanged: prov.setUsername,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(15),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              TextFormField(
                  controller: password,
                  onChanged: prov.setPassword,
                  obscureText: _show,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: () => setState(() => _show = !_show),
                      child: Icon(
                        _show ? Icons.visibility_off : Icons.visibility,
                        color: _show ? Colors.grey : Colors.orange,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(15),
                  )),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Lupa sandi ?",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
