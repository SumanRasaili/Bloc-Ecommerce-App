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
  @override
  Widget build(BuildContext context) {
    context
        .read<ProductsBloc>()
        .add(const ProductsBlocEvent.fetchAllProducts());
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state.when(
                        initial: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        loaded: (products) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GridView.extent(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              primary: false,
                              maxCrossAxisExtent: 84.w,
                              mainAxisSpacing: 5.h,
                              crossAxisSpacing: 5.w,
                              children: List.generate(
                                (products.docs ?? []).length,
                                (index) {
                                  final productData = products.docs?[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               ProductDetailPage(slug:   productData?.slug??"",),
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
                                                  productData?.images?.first ??
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
                                                    productData?.brand?.name ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    productData?.title ?? "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "Rs. ${productData?.price?.toString() ?? ""}"),
                                                      SizedBox(width: 1.5.w),
                                                      Flexible(
                                                        child: Text(
                                                          "Rs. ${productData?.offPercent ?? "-"}",
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
                            ),
                          );
                        },
                        error: (error) {
                          return Center(
                            child: Text("Error Occured $error"),
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
