import 'package:buzzarid_mobile/common/providers/user_provider.dart';
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
  };
  String _title = '';
  String _titleTemp = '';
  String _author = '';
  String _authorTemp = '';
  String _sortByAttribute = 'date';
  String _sortByDirection = 'desc';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
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
                ],
              ),
              // Get Params
              Form(
                key: _searchFormKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            _titleTemp = value!;
                          },
                          onSaved: (String? value) {
                            _titleTemp = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Author',
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            _authorTemp = value!;
                          },
                          onSaved: (String? value) {
                            _authorTemp = value!;
                          },
                        ),
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
                        Row(
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
                          itemBuilder: (_, index) => Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ArticleDetailPage(
                                          id: articleList[index].id)),
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(articleList[index].image,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                    return const Text('Couldn\'t Load Image');
                                  },
                                      width: double.infinity,
                                      height: 200.0,
                                      fit: BoxFit.cover),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            articleList[index].title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(articleList[index].author.name),
                                        Text(articleList[index].createdAt),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(Icons.thumb_up),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text('${articleList[index].likes}')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
