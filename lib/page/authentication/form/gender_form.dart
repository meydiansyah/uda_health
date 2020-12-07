import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

// ignore: must_be_immutable
class GenderForm extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    return Row(
      children: [
        Expanded(
          child: ListTile(
            leading: Radio(
              value: Gender.Boy,
              groupValue: prov.gender,
              onChanged: (Gender g) => prov.setGender(g),
            ),
            title: Text("Boy"),
            onTap: () {
              prov.setGender(Gender.Boy);
              print(prov.getGender());
            },
          ),
        ),
        Expanded(
          child: ListTile(
            leading: Radio(
              value: Gender.Girl,
              groupValue: prov.gender,
              onChanged: (Gender g) => prov.setGender(g),
            ),
            title: Text("Girl"),
            onTap: () {
              prov.setGender(Gender.Girl);
              print(prov.getGender());
            },
          ),
        ),
      ],
    );
  }
}