import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/obrolan/model/obrolan.dart';
import 'package:buzzarid_mobile/obrolan/page/obrolan_home.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ObrolanCard extends StatelessWidget {
  final Obrolan obrln;
  const ObrolanCard(this.obrln, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final username = context.watch<UserProvider>().user.username;

    return Card(
        child: ListTile(
      title: Text(obrln.fields.title),
      leading: Container(
          child: username == obrln.fields.username
              ? SizedBox(
                  width: 50, // <-- Your width
                  height: 30, // <-- Your height
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 255, 0, 0)),
                    ),
                    onPressed: () async {
                      await request.post(
                          "https://buzzar-id.up.railway.app/obrolan/delete-disc/${obrln.pk.toString()}/",
                          {}).then((value) {
                        if (value != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Delete success!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ObrolanHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("An Error Occured"),
                          ));
                        }
                      });
                    },
                    child: const Text(
                      "Un\nsend",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ))
              : const Icon(Icons.chat_outlined)),
      subtitle: Text('Pesan : ${obrln.fields.message}'),
      trailing: Text(
        '\nDari ${obrln.fields.username}\nKe ${obrln.fields.toWho}\n',
        style: const TextStyle(
            color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
