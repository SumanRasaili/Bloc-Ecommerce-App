import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oriflamenepal/presentation/screens/product_detail_page.dart';
import 'package:sizer/sizer.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    log("Device width ${MediaQuery.of(context).size.width}");
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverToBoxAdapter(
                    child: GridView.extent(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        primary: false,
                        maxCrossAxisExtent: 84.w,
                        mainAxisSpacing: 5.h,
                        crossAxisSpacing: 5.w,
                        children: List.generate(20, (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductDetailPage(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1631011714977-a6068c048b7b?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: 15.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
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
                                          const Text('Oriflame Lipstick'),
                                          const Text(
                                            'Oriflame Lipstick is the best in the town you can get',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            children: [
                                              const Text('Rs. 500'),
                                              SizedBox(width: 1.5.w),
                                              const Flexible(
                                                child: Text(
                                                  'Rs. 1000',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.grey),
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
                        })))),
          ],
        ));
  }
}
