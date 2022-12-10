import 'package:buzzarid_mobile/news/utils/article_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ArticlePostPage extends StatefulWidget {
  const ArticlePostPage({super.key});

  @override
  State<ArticlePostPage> createState() => _ArticlePostPageState();
}

class _ArticlePostPageState extends State<ArticlePostPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _body = '';
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Article'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Post Article',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      _title = value!;
                    },
                    onSaved: (String? value) {
                      _title = value!;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 3200,
                    minLines: 6,
                    maxLines: 16,
                    decoration: const InputDecoration(
                      labelText: 'Body',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      _body = value!;
                    },
                    onSaved: (String? value) {
                      _body = value!;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Body cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      _imageUrl = value!;
                    },
                    onSaved: (String? value) {
                      _imageUrl = value!;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Image URL cannot be empty';
                      }
                      Uri uri;
                      try {
                        uri = Uri.parse(value);
                      } catch (error) {
                        return 'Image URL is not valid';
                      }
                      if (!(uri.isAbsolute)) return 'Image URL is not valid';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        postArticle(request, _title, _body, _imageUrl).then(
                          (value) {
                            if (!mounted) return;
                            if (value == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Couldn\'t post to server'),
                              ));
                            } else {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, '/news');
                            }
                          },
                        );
                      }
                    },
                    child: const Text('Post'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
