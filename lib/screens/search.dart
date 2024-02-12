import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/utils/config.dart';
import 'package:news_app/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future getNews() async {
    await Provider.of<SearchProvider>(context, listen: false).loadNews();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SearchProvider searchProvider, _) {
        return RefreshIndicator(
          onRefresh: () async {
            searchProvider.onRefresh(true);
            return await getNews();
          },
          color: CustomColors.primaryColor,
          backgroundColor: CustomColors.bgColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search for news...',
                    hintStyle: TextStyle(
                      color: CustomColors.textColor,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      searchProvider.searchKeyword = null;
                    } else {
                      searchProvider.searchKeyword = value;
                      searchProvider.onRefresh(true);
                      getNews();
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                searchProvider.searchKeyword == null
                    ? Container(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Enter a keyword to search',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.textColor,
                          ),
                        ),
                      )
                    : searchProvider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: CustomColors.primaryColor,
                            ),
                          )
                        : searchProvider.headlines.articles!.isEmpty
                            ? const Center(child: Text('No News Available'))
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10.0),
                                itemCount: searchProvider
                                            .headlines.articles!.length >
                                        10
                                    ? 10
                                    : searchProvider.headlines.articles!.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      searchProvider.headlines.articles![index];
                                  return ListTile(
                                    onTap: () {},
                                    tileColor: CustomColors.bgColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(right: 8.0),
                                    minVerticalPadding: 0.0,
                                    title: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: FancyShimmerImage(
                                            width: 150.0,
                                            height: 125.0,
                                            boxFit: BoxFit.cover,
                                            imageUrl: data.urlToImage ??
                                                Config.urlNoImages,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10.0),
                                              Text(
                                                data.source!.name!,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: CustomColors
                                                      .textSecondaryColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Divider(
                                                color:
                                                    CustomColors.primaryColor,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
