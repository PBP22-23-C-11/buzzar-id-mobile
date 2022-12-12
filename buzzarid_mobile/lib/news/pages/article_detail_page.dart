import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/news/components/card_padding.dart';
import 'package:buzzarid_mobile/news/components/icon_value_button.dart';
import 'package:buzzarid_mobile/news/components/image_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:buzzarid_mobile/news/models/article.dart';
import 'package:buzzarid_mobile/news/models/comment.dart';
import 'package:buzzarid_mobile/news/utils/article_utils.dart';
import 'package:buzzarid_mobile/news/utils/comment_utils.dart';

import 'package:buzzarid_mobile/news/components/text_title_content.dart';
import 'package:buzzarid_mobile/news/components/comment_box.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key, required this.id});

  final int id;

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _formKey = GlobalKey<FormState>();

  String _commentBody = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getArticleById(request, widget.id),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Column(
                children: const [
                  SizedBox(height: 16.0),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else {
              if (!snapshot.hasData || snapshot.data!.length == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 8),
                    Text(
                      'Article Not Found',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                );
              } else {
                Article article = snapshot.data![0];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImageNetwork(
                        imageUrl: article.image,
                        height: 200.0,
                        fit: BoxFit.cover),
                    CardPadding(
                      padding: 8.0,
                      child: Text(
                        article.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    CardPadding(
                      padding: 8.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitleContent(
                              title: 'Author', content: article.author.name),
                          TextTitleContent(
                              title: 'Created At', content: article.createdAt),
                          (userProvider.user.type == 'Customer')
                              ? Row(
                                  children: [
                                    FutureBuilder(
                                        future: checkLike(request, article.id),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.data == null ||
                                              !snapshot.hasData) {
                                            return const IconValueButton(
                                              color: Colors.amber,
                                              icon:
                                                  Icon(Icons.thumb_up_outlined),
                                              value: '0',
                                              onPressed: null,
                                            );
                                          } else {
                                            bool isLiked =
                                                snapshot.data['liked'];
                                            return IconValueButton(
                                              color: Colors.amber,
                                              icon: (isLiked)
                                                  ? const Icon(Icons.thumb_up)
                                                  : const Icon(
                                                      Icons.thumb_up_outlined),
                                              value: '${article.likes}',
                                              onPressed: () {
                                                toggleLike(request, article.id)
                                                    .then((value) {
                                                  if (value) {
                                                    setState(() {});
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Couldn\'t connect to server'),
                                                    ));
                                                  }
                                                });
                                              },
                                            );
                                          }
                                        }),
                                    const SizedBox(width: 8.0),
                                    FutureBuilder(
                                        future: checkSubscribe(
                                            request, article.author.id),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.data == null ||
                                              !snapshot.hasData) {
                                            return const IconValueButton(
                                              color: Colors.amber,
                                              icon: Icon(
                                                  Icons.notifications_outlined),
                                              value: 'Subscribe',
                                              onPressed: null,
                                            );
                                          } else {
                                            bool isSubscribed =
                                                snapshot.data['subscribed'];
                                            return IconValueButton(
                                              color: Colors.amber,
                                              icon: isSubscribed
                                                  ? const Icon(
                                                      Icons.notifications)
                                                  : const Icon(Icons
                                                      .notifications_outlined),
                                              value: (isSubscribed)
                                                  ? 'Subscribed'
                                                  : 'Subscribe',
                                              onPressed: () {
                                                toggleSubscribe(request,
                                                        article.author.id)
                                                    .then((value) {
                                                  if (value) {
                                                    setState(() {});
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Couldn\'t connect to server'),
                                                    ));
                                                  }
                                                });
                                              },
                                            );
                                          }
                                        }),
                                  ],
                                )
                              : Container(),
                          (article.author.id == userProvider.user.id)
                              ? Row(children: [
                                  IconValueButton(
                                      color: Colors.red,
                                      icon: const Icon(Icons.delete),
                                      value: 'Delete',
                                      onPressed: () {
                                        deleteArticleById(request, article.id)
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      }),
                                ])
                              : Container(),
                        ],
                      ),
                    ),
                    CardPadding(
                      padding: 8.0,
                      child: Text(article.body),
                    ),
                    CardPadding(
                      padding: 8.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Comments:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          (<String>['Admin', 'Customer', 'UMKM']
                                  .contains(userProvider.user.type))
                              ? Column(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            maxLength: 100,
                                            minLines: 4,
                                            maxLines: 4,
                                            decoration: const InputDecoration(
                                              hintText: 'Comment here..',
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (String? value) {
                                              _commentBody = value!;
                                            },
                                            onSaved: (String? value) {
                                              _commentBody = value!;
                                            },
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Comment cannot be empty';
                                              }
                                              return null;
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(40),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                postArticleComment(request,
                                                        widget.id, _commentBody)
                                                    .then((value) {
                                                  if (value != null) {
                                                    _formKey.currentState!
                                                        .reset();
                                                    setState(() {});
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Couldn\'t post to server'),
                                                    ));
                                                  }
                                                });
                                              }
                                            },
                                            child: const Text('Post'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: getArticleComments(
                                            request, widget.id),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.data == null) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            if (!snapshot.hasData ||
                                                snapshot.data!.length == 0) {
                                              return Column(
                                                children: const [
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'No Comment Found',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                ],
                                              );
                                            } else {
                                              List<Comment> commentList =
                                                  snapshot.data!;
                                              return ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: commentList.length,
                                                itemBuilder: (_, index) =>
                                                    CommentBox(
                                                        name: commentList[index]
                                                            .user
                                                            .name,
                                                        createdAt:
                                                            commentList[index]
                                                                .createdAt
                                                                .toString(),
                                                        body: commentList[index]
                                                            .body,
                                                        showDelete:
                                                            (commentList[index]
                                                                    .user
                                                                    .id ==
                                                                userProvider
                                                                    .user.id),
                                                        onDelete: () {
                                                          deleteArticleComment(
                                                                  request,
                                                                  article.id,
                                                                  commentList[
                                                                          index]
                                                                      .id)
                                                              .then((value) {
                                                            setState(() {});
                                                          });
                                                        }),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                              );
                                            }
                                          }
                                        }),
                                  ],
                                )
                              : Text(
                                  (userProvider.user.type == 'guest')
                                      ? 'You need to login in order to see comments'
                                      : 'You need to complete second step of register in order to see comments',
                                  textAlign: TextAlign.center,
                                ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
