import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oriflamenepal/features/products/bloc/products_bloc.dart';
import 'package:oriflamenepal/features/products/presentation/screens/product_detail_page.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final currentState = context.read<ProductsBloc>().state;
        currentState.maybeWhen(
          loaded: (products, hasMore, currentPage, isPaginationLoading) {
            log("hasMore: $hasMore" "currentPage: $currentPage");
            if (hasMore && !isPaginationLoading) {
              context.read<ProductsBloc>().add(
                    ProductsBlocEvent.fetchAllProducts(page: currentPage + 1),
                  );
            }
          },
          orElse: () {},
        );
      }
    });
    context
        .read<ProductsBloc>()
        .add(const ProductsBlocEvent.fetchAllProducts(page: 1));
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state.when(
                        initial: () => const Padding(
                              padding: EdgeInsets.only(top: 200),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        loading: () => const Padding(
                              padding: EdgeInsets.only(top: 200),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        loaded: (products, hasMore, currentPage,
                            isPaginationLoading) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(children: [
                              GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                primary: false,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.w,
                                  mainAxisSpacing: 2.h,
                                  childAspectRatio: 0.7,
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final productData = products[index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                            slug: productData.slug ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: const Offset(0, 1),
                                            // blurRadius: 2,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade100,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  productData.images?.first ??
                                                      "",
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  height: 15.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    productData.brand?.name ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    productData.title ?? "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Rs. ${productData.price?.toString() ?? ""}"),
                                                      SizedBox(width: 1.5.w),
                                                      Flexible(
                                                        child: Text(
                                                          "Rs. ${productData.offPercent ?? "-"}",
                                                          style: const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (isPaginationLoading)
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                            ]),
                          );
                        },
                        error: (error) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Error occurred: $error"),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<ProductsBloc>().add(
                                          const ProductsBlocEvent
                                              .fetchAllProducts(page: 1),
                                        );
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
