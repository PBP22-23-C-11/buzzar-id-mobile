import 'package:buzzarid_mobile/obrolan/model/obrolan.dart';
import 'package:flutter/material.dart';

class ObrolanCard extends StatelessWidget {
  final Obrolan obrln;
  const ObrolanCard(this.obrln, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(obrln.fields.title),
      subtitle: Text('Pesan : ${obrln.fields.message}'),
      trailing: Text(
        '\nDari ${obrln.fields.username}\nKe ${obrln.fields.toWho}\n',
        style: const TextStyle(
            color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
