import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/utils/config.dart';
import 'package:news_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class HeadlinesPage extends StatefulWidget {
  const HeadlinesPage({super.key});

  @override
  State<HeadlinesPage> createState() => _HeadlinesPageState();
}

class _HeadlinesPageState extends State<HeadlinesPage> {
  Future getNews() async {
    await Provider.of<HeadlinesProvider>(context, listen: false)
        .loadHeadlines();
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HeadlinesProvider headlinesProvider, _) {
      return RefreshIndicator(
        onRefresh: () async {
          headlinesProvider.onRefresh(true);
          return await getNews();
        },
        color: CustomColors.primaryColor,
        backgroundColor: CustomColors.bgColor,
        child: headlinesProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: CustomColors.primaryColor,
                ),
              )
            : headlinesProvider.headlines.articles!.isEmpty
                ? const Center(child: Text('No Headlines Available'))
                : Container(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10.0),
                      itemCount: headlinesProvider.headlines.articles!.length,
                      itemBuilder: (context, index) {
                        final data =
                            headlinesProvider.headlines.articles![index];
                        return ListTile(
                          onTap: () {},
                          tileColor: CustomColors.bgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.only(right: 8.0),
                          minVerticalPadding: 0.0,
                          title: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                                child: FancyShimmerImage(
                                  width: 150.0,
                                  height: 125.0,
                                  boxFit: BoxFit.cover,
                                  imageUrl:
                                      data.urlToImage ?? Config.urlNoImages,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    Text(
                                      data.source!.name!,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.textSecondaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Divider(
                                      color: CustomColors.primaryColor,
                                    ),
                                    Text(
                                      data.title!,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: CustomColors.textColor,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      );
    });
  }
}
