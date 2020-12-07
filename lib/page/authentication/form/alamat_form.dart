import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uda_health/provider/auth_provider.dart';

import 'const.dart';


// ignore: must_be_immutable
class AlamatForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: true);

    return Column(
      children: [
        TextFormField(
            controller: alamat,
            onChanged: prov.setAlamat,
            decoration: InputDecoration(
              labelText: 'Alamat',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(15),)
        ),
      ],
    );
  }
}
