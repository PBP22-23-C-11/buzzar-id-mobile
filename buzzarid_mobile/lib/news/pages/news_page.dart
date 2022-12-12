import 'package:buzzarid_mobile/common/providers/user_provider.dart';
import 'package:buzzarid_mobile/news/components/article_box.dart';
import 'package:buzzarid_mobile/news/pages/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:buzzarid_mobile/common/components/drawer.dart';
import 'package:buzzarid_mobile/news/utils/article_utils.dart';
import 'package:buzzarid_mobile/news/components/icon_toggle_button.dart';
import 'package:buzzarid_mobile/news/models/article.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _searchFormKey = GlobalKey<FormState>();
  String _category = 'UMKM';
  Map<String, String> categoryMap = {
    'UMKM': 'umkm',
    'Official': 'official',
    'Subscribed': 'subscribed',
  };
  String _title = '';
  String _titleTemp = '';
  String _author = '';
  String _authorTemp = '';
  String _authorType = 'name';
  String _sortByAttribute = 'date';
  String _sortByDirection = 'desc';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _category == 'UMKM'
                              ? Colors.amber
                              : Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            _category = 'UMKM';
                          });
                        },
                        child: const Text(
                          'UMKM',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _category == 'Official'
                              ? Colors.amber
                              : Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            _category = 'Official';
                          });
                        },
                        child: const Text(
                          'Official',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    (userProvider.user.type == 'Customer')
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: _category == 'Subscribed'
                                    ? Colors.amber
                                    : Colors.transparent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _category = 'Subscribed';
                                });
                              },
                              child: const Text(
                                'Subscribed',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              // Get Params
              Form(
                key: _searchFormKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 8.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            _titleTemp = value!;
                          },
                          onSaved: (String? value) {
                            _titleTemp = value!;
                          },
                        ),
                        (_category == 'UMKM')
                            ? Column(
                                children: [
                                  const SizedBox(height: 12.0),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Author',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (String? value) {
                                      _authorTemp = value!;
                                    },
                                    onSaved: (String? value) {
                                      _authorTemp = value!;
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  _authorType == 'name'
                                                      ? Colors.amber
                                                      : Colors.transparent,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _authorType = 'name';
                                              });
                                            },
                                            child: const Text(
                                              'Name',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  _authorType == 'username'
                                                      ? Colors.amber
                                                      : Colors.transparent,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _authorType = 'username';
                                              });
                                            },
                                            child: const Text(
                                              'Username',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                          ),
                          onPressed: () {
                            setState(() {
                              _title = _titleTemp;
                              _author = _authorTemp;
                            });
                          },
                          child: const Text('Search'),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sort By:'),
                        const SizedBox(height: 8.0),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width - 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconToggleButton(
                                      isElevated: (_sortByAttribute == 'date'),
                                      elevatedColor: Colors.amber,
                                      icon: const Icon(Icons.calendar_month),
                                      onPressed: () {
                                        setState(() {
                                          _sortByAttribute = 'date';
                                        });
                                      },
                                    ),
                                    IconToggleButton(
                                      isElevated: (_sortByAttribute == 'likes'),
                                      elevatedColor: Colors.amber,
                                      icon: const Icon(Icons.thumb_up),
                                      onPressed: () {
                                        setState(() {
                                          _sortByAttribute = 'likes';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconToggleButton(
                                      isElevated: (_sortByDirection == 'asc'),
                                      elevatedColor: Colors.amber,
                                      icon: const Icon(Icons.arrow_upward),
                                      onPressed: () {
                                        setState(() {
                                          _sortByDirection = 'asc';
                                        });
                                      },
                                    ),
                                    IconToggleButton(
                                      isElevated: (_sortByDirection == 'desc'),
                                      elevatedColor: Colors.amber,
                                      icon: const Icon(Icons.arrow_downward),
                                      onPressed: () {
                                        setState(() {
                                          _sortByDirection = 'desc';
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Articles
              Container(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: fetchArticleList(
                      request,
                      _title,
                      _author,
                      _authorType,
                      '${_sortByAttribute}_$_sortByDirection',
                      categoryMap[_category]!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData || snapshot.data!.length == 0) {
                        return Column(
                          children: const [
                            Text(
                              'No Articles Found',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {
                        List<Article> articleList = snapshot.data!;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: articleList.length,
                          itemBuilder: (_, index) {
                            return ArticleBox(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ArticleDetailPage(
                                        id: articleList[index].id);
                                  }),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              imageUrl: articleList[index].image,
                              title: articleList[index].title,
                              author: articleList[index].author.name,
                              createdAt: articleList[index].createdAt,
                              likes: articleList[index].likes,
                            );
                          },
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ((userProvider.user.type == 'UMKM' &&
                  _category == 'UMKM') ||
              (userProvider.user.type == 'Admin' && _category == 'Official'))
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news/post');
              },
              tooltip: 'Post Article',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
