import '../provider/network_checker_provider.dart';
import '../provider/news_provider.dart';
import '../view/news/controller/pagination_scroll_control.dart';
import 'news_detail_screen.dart';
import '../widgets/animation.dart';
import '../widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import '../services/news_service.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsService newsService = NewsService(); // Add this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'News',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35.sp,
            fontFamily: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
            ).fontFamily,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 20.h),
          child: FutureBuilder<Map<String, dynamic>>(
            future: newsService.fetchNews(1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.hasData) {
                var articles = snapshot.data!['articles'] as List<dynamic>;

                return articles.isNotEmpty
                    ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    var article = articles[index];
                    return NewsCard(news: article);
                  },
                )
                    : const Center(child: Text('No news available.'));
              }

              return const Center(child: Text('No news available.'));
            },
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, this.news});
  final dynamic news;

  @override
  Widget build(BuildContext context) {
    final date =
    DateFormat('MMMM dd, yyyy').format(DateTime.parse(news['publishedAt']));
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(news: news),
          ),
        );
      },
      child: AnimatedPress(
        child: Container(
          // height: 120.h,
          // width: 50.h,
          margin: EdgeInsetsDirectional.symmetric(
            horizontal: 10.w,
            vertical: 10.w,
          ),
          padding:
          EdgeInsetsDirectional.symmetric(horizontal: 8.h, vertical: 8.w),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(1, 7),
                )
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  news['urlToImage'] != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      news['urlToImage'],
                      height: 80.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const SizedBox(),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      maxLines: 3,
                      news['title'],
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      news['source']['name'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
