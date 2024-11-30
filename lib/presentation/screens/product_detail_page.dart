import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oriflamenepal/config/color/app_colors.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late CarouselSliderController carouselBannerController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    carouselBannerController = CarouselSliderController();
  }

  List<Color> colorcodes = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.blue,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://images.unsplash.com/photo-1719937050679-c3a2c9c67b0f?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1631011714977-a6068c048b7b?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1719937050579-70e6f9ab58c4?q=80&w=2396&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1719937050814-72892488f741?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1610415393323-4b7f2a9adcda?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ];
    bool isSelected = false;
    return Scaffold(
      persistentFooterButtons: [
        Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kprimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          child: Center(
            child: Text(
              'Add to Cart',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        )
      ],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: carouselBannerController,
                  items: imageUrls.map((item) {
                    return CachedNetworkImage(
                      height: 200.h,
                      imageUrl: item,
                      imageBuilder: (p0, p1) {
                        return Container(
                          height: 200.h,
                          // margin: EdgeInsets.only(left: 16.w, right: 16.w),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(0.r),
                            image:
                                DecorationImage(image: p1, fit: BoxFit.cover),
                          ),
                        );
                      },
                      errorWidget: (p0, p1, p2) {
                        return Container(
                          height: 200.h,
                          margin: EdgeInsets.only(left: 16.w, right: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        );
                      },
                      placeholder: (p0, p1) {
                        return Container(
                          margin: EdgeInsets.only(left: 16.w, right: 16.w),
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.grey.shade200,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    initialPage: currentIndex,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    padEnds: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    viewportFraction: 1.0,
                  ),
                ),
                SizedBox(height: 16.h),
                Positioned(
                  bottom: 10.h,
                  left: 0.w,
                  right: 0.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (imageUrls).asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselBannerController.animateToPage(entry.key),
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds: 200), // Smooth transition effect
                          width: currentIndex == entry.key ? 20.w : 8.0.w,
                          height: 10.h,
                          margin: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: currentIndex == entry.key
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade200,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Smart Sync Lipstick',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(children: [
                          Icon(
                            Icons.remove,
                            size: 24.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '4',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.add,
                            size: 24.sp,
                          ),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Code: 46437',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(children: [
                    Text(
                      'Rs. 900',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Rs. 500',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '10% off',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 5.h),
                  Text(
                    'Color (Warm Cocoa)',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                      children: colorcodes
                          .map((e) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isSelected = !isSelected;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.transparent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Container(
                                        height: 20.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: e,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                              ))
                          .toList()),
                  SizedBox(height: 5.h),
                  Text(
                    'Product Description',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("fytguhijokl"),
                  Text(
                    'Product Ingredients',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("fytguhijokl"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
