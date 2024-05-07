import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/NewsHeadlinesModel.dart';
import '../models/catgory_news_model.dart';
import '../view_models/new_view_models.dart';
import 'categoryscreen.dart';
import 'news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { thetimesofindia, thehindu, Google_News }

class _HomeScreenState extends State<HomeScreen> {
  String category = 'General';
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  String name = 'the-times-of-india'; // Default news source
  late Future<NewsHeadlinesModel> _newsModelFuture;
  final format = DateFormat('MMMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _newsModelFuture = newsViewModel
        .fetchNewsChannelHeadLinesApi(name); // Fetch news with default source
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoryScreen()));
          },
          icon: Image.asset(
            'images/cate.png',
            height: 30,
            color: Colors.black54,
          ),
        ),
        title: Row(
          children: [
            Text(
              'Just',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text('News',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.black26,
                    letterSpacing: 5))
          ],
        ),
        actions: [
          PopupMenuButton(
            color: Colors.black54,
            iconColor: Colors.black26,
            initialValue: selectedMenu,
            onSelected: (FilterList item) {
              if (item == FilterList.thetimesofindia) {
                name = 'the-times-of-india';
              } else if (item == FilterList.thehindu) {
                name = 'the-hindu';
              }
              setState(() {
                selectedMenu = item;
                _newsModelFuture = newsViewModel.fetchNewsChannelHeadLinesApi(
                    name); // Fetch news with selected source
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.thehindu,
                child: Text(
                  'The Hindu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.thetimesofindia,
                child: Text(
                  'The Times of India',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<NewsHeadlinesModel>(
            future: _newsModelFuture,
            builder: (BuildContext context,
                AsyncSnapshot<NewsHeadlinesModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final articles = snapshot.data!.articles!;
                return SizedBox(
                  //yaah pr hight 0 krke ak slide bnd ki gai hai
                  height: 0,
                  width: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      final dateTime =
                          DateTime.parse(article.publishedAt.toString());
                      return Container(
                        width: width * 0.7,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewDetailsScreen(
                                          newImage: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          newsTitle: snapshot
                                              .data!.articles![index].title
                                              .toString(),
                                          author: snapshot
                                              .data!.articles![index].author
                                              .toString(),
                                          newsdate: snapshot.data!
                                              .articles![index].publishedAt
                                              .toString(),
                                          descripton: snapshot.data!
                                              .articles![index].description
                                              .toString(),
                                          content: snapshot
                                              .data!.articles![index].content
                                              .toString(),
                                          source: snapshot.data!
                                              .articles![index].source!.name
                                              .toString(),
                                        )));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      article.urlToImage ??
                                          '', // Load image URL
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                          child: SpinKitFadingCircle(
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset('images/not.png'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title ??
                                              '', // Display headline
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              article.source?.name ?? '',
                                              // Display source
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              // Display date
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          Expanded(
            child: FutureBuilder<category_news_model>(
                future: newsViewModel.fetchcategorynewsApi(category),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.black45,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              elevation: 12,
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewDetailsScreen(
                                                    newImage: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    newsTitle: snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    author: snapshot.data!
                                                        .articles![index].author
                                                        .toString(),
                                                    newsdate: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .publishedAt
                                                        .toString(),
                                                    descripton: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    content: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .content
                                                        .toString(),
                                                    source: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                  )));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data!
                                                .articles![index].urlToImage ??
                                            '',
                                        fit: BoxFit.cover,
                                        height: height * 0.3,
                                        width: width * 0.9,
                                        placeholder: (context, url) =>
                                            Container(
                                                child: const Center(
                                          child: SpinKitCircle(
                                            size: 50,
                                            color: Colors.black45,
                                          ),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset('images/not.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].source
                                                ?.name ??
                                            '',
                                        // Display source
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        format.format(dateTime), // Display date
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
