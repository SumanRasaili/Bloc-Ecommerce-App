import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oriflamenepal/config/color/app_colors.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:readmore/readmore.dart';

class ColorValues {
  final Color color;
  final String colorName;
  ColorValues({required this.color, required this.colorName});
}

List<ColorValues> colorValues = [
  ColorValues(color: Colors.teal, colorName: 'Teal'),
  ColorValues(color: Colors.purple, colorName: 'Purple'),
  ColorValues(color: Colors.red, colorName: 'Red'),
  ColorValues(color: Colors.green, colorName: 'Green'),
  ColorValues(color: Colors.blue, colorName: 'Blue'),
  ColorValues(color: Colors.yellow, colorName: 'Yellow'),
];

class ColorAttributes {
  final String productCode;
  final String colorName;
  final Color color;
  final num productPrice;
  final num productDiscount;
  final num productDiscountPercent;
  ColorAttributes({
    required this.productCode,
    required this.productPrice,
    required this.productDiscount,
    required this.productDiscountPercent,
    required this.colorName,
    required this.color,
  });
}

List<ColorAttributes> colorAttributes = [
  ColorAttributes(
      productCode: '1234',
      colorName: 'Teal',
      color: Colors.teal,
      productPrice: 500,
      productDiscount: 20,
      productDiscountPercent: 6),
  ColorAttributes(
      productCode: '345',
      colorName: 'Purple',
      color: Colors.purple,
      productPrice: 400,
      productDiscount: 30,
      productDiscountPercent: 5),
  ColorAttributes(
      productCode: '432',
      colorName: 'Red',
      color: Colors.red,
      productPrice: 544,
      productDiscount: 90,
      productDiscountPercent: 20),
  ColorAttributes(
      productCode: '76',
      colorName: 'Green',
      color: Colors.green,
      productPrice: 345,
      productDiscount: 23,
      productDiscountPercent: 8),
  ColorAttributes(
      productCode: '890',
      colorName: 'Blue',
      color: Colors.blue,
      productPrice: 0989,
      productDiscount: 345,
      productDiscountPercent: 7),
  ColorAttributes(
    productCode: '2342',
    colorName: 'Yellow',
    color: Colors.yellow,
    productPrice: 2345,
    productDiscount: 654,
    productDiscountPercent: 55,
  ),
];

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late CarouselSliderController carouselBannerController;
  int currentIndex = 0;
  late ColorAttributes selectedAttributesValue;
  @override
  void initState() {
    super.initState();
    carouselBannerController = CarouselSliderController();
    selectedAttributesValue = colorAttributes[0];
  }

  String selectedColor = colorAttributes[0].colorName;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://images.unsplash.com/photo-1719937050679-c3a2c9c67b0f?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1631011714977-a6068c048b7b?q=80&w=2874&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1719937050579-70e6f9ab58c4?q=80&w=2396&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1719937050814-72892488f741?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1610415393323-4b7f2a9adcda?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ];

    return Scaffold(
      extendBody: true,
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Successfully Added to Cart',
            );
          },
          child: Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                          decoration: BoxDecoration(
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
                          duration: const Duration(milliseconds: 200),
                          width: currentIndex == entry.key ? 20.w : 8.0.w,
                          height: 10.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Smart Sync Lipstick',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                              color: quantity > 1
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Colors.grey,
                            ),
                            visualDensity: const VisualDensity(
                                vertical: -3, horizontal: -3),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: -3, vertical: -3),
                          ),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Code : ${selectedAttributesValue.productCode}",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(children: [
                    Text(
                      "Rs. ${selectedAttributesValue.productPrice}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Rs. ${selectedAttributesValue.productDiscount}",
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
                        "${selectedAttributesValue.productDiscountPercent} % off",
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
                    "Rs. ${selectedAttributesValue.colorName}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                      children: colorAttributes
                          .map((e) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = e.colorName;
                                        selectedAttributesValue = e;
                                      });
                                    },
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selectedColor == e.colorName
                                              ? Colors.black
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(1),
                                        height: 35.h,
                                        width: 35.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: e.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                              ))
                          .toList()),
                  SizedBox(height: 5.h),
                  _ratingsBar(),
                  SizedBox(height: 5.h),
                  _readMoreSection(
                    context: context,
                    title: 'Product Description',
                    description:
                        'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                  ),
                  _readMoreSection(
                    context: context,
                    title: 'Product Ingredients',
                    description:
                        'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                  ),
                  _messageSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_ratingsBar() {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(
      "Ratings",
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(width: 10.w),
    RatingBar.builder(
      itemSize: 30,
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    )
  ]);
}

_messageSection(BuildContext context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      'Contact Seller',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 10.h),
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        hintText: 'Send a message',
        suffixIcon: IconButton(
          icon: Icon(
            Icons.send,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        ),
      ),
    )
  ]);
}

_readMoreSection(
    {required BuildContext context,
    required String title,
    required String description}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: 5.h),
    ReadMoreText(
      description,
      trimMode: TrimMode.Line,
      trimLines: 2,
      colorClickableText: Colors.pink,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: kprimaryColor,
      ),
    ),
    SizedBox(
      height: 10.h,
    ),
  ]);
}
