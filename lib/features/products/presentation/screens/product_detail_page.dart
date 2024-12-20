import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html/parser.dart';
import 'package:oriflamenepal/config/color/app_colors.dart';
import 'package:oriflamenepal/core/notification/local_notification.dart';
import 'package:oriflamenepal/features/products/bloc/cart/cart_bloc.dart';
import 'package:oriflamenepal/features/products/bloc/product_detail_bloc.dart';
import 'package:oriflamenepal/features/products/models/product_detail/product_detail_model.dart'
    as detail;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class ProductDetailPage extends StatefulWidget {
  final String slug;
  const ProductDetailPage({super.key, required this.slug});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late CarouselSliderController carouselBannerController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(ProductDetailEvent.getProductDetail(slug: widget.slug));

    carouselBannerController = CarouselSliderController();
  }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
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
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
        return state.when(initial: () {
          return const Center(child: CircularProgressIndicator());
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }, error: (message) {
          return Center(child: Text(message));
        }, loaded: (productDetail, String selectedColorAttribute,
            detail.ColorVariant colorVariant) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                automaticallyImplyLeading: true,
                expandedHeight: 27.sh,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: CarouselSlider(
                          carouselController: carouselBannerController,
                          items: (productDetail.images).map((item) {
                            return CachedNetworkImage(
                              imageUrl: item,
                              width: double.infinity,
                              imageBuilder: (p0, p1) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: p1, fit: BoxFit.cover),
                                  ),
                                );
                              },
                              errorWidget: (p0, p1, p2) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                );
                              },
                              placeholder: (p0, p1) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
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
                            aspectRatio: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            viewportFraction: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (productDetail.images)
                              .asMap()
                              .entries
                              .map((entry) {
                            return GestureDetector(
                              onTap: () => carouselBannerController
                                  .animateToPage(entry.key),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: currentIndex == entry.key ? 4.w : 4.w,
                                height: 1.5.h,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 1.5.w,
                                  vertical: 1.h,
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
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productDetail.brand?.name ?? '---',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                            return Container(
                              margin: EdgeInsets.only(left: 1.w),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (state.quantity > 1) {
                                          context.read<CartBloc>().add(
                                              CartEvent.decrementQuantity(
                                                  state.quantity));
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: state.quantity > 1
                                            ? Theme.of(context)
                                                .scaffoldBackgroundColor
                                            : Colors.grey,
                                      ),
                                      visualDensity: const VisualDensity(
                                          vertical: -3, horizontal: -3),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      state.quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    IconButton(
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                            CartEvent.incrementQuantity(
                                                state.quantity));
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      visualDensity: const VisualDensity(
                                          horizontal: -3, vertical: -3),
                                    ),
                                  ]),
                            );
                          })
                        ],
                      ),
                      // SizedBox(height: 5.0.h),
                      Text(
                        "Code : ${colorVariant.productCode ?? productDetail.slug}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Row(children: [
                        Text(
                          "Rs. ${colorVariant.price ?? productDetail.price}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          "Rs. ${colorVariant.strikePrice ?? productDetail.strikePrice}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(width: 3.w),
                        colorVariant.offPercent == 0 ||
                                productDetail.offPercent == 0
                            ? const SizedBox.shrink()
                            : Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "${colorVariant.offPercent ?? productDetail.offPercent} % off",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                      ]),
                      SizedBox(height: 0.5.h),
                      Text(
                        selectedColorAttribute,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: (5.h / 100)),
                      productDetail.colorAttributes.isNotEmpty
                          ? Row(
                              children: (productDetail.colorAttributes)
                                  .map((color) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<ProductDetailBloc>()
                                                  .add(ProductDetailEvent
                                                      .toggleColorAttribute(
                                                          colorName:
                                                              color.name ??
                                                                  ""));
                                            },
                                            child: Container(
                                              // padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color:
                                                      selectedColorAttribute ==
                                                              color.name
                                                          ? Colors.black
                                                          : Colors.transparent,
                                                ),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: color.colorValue !=
                                                          null
                                                      ? Color(int.parse(color
                                                          .colorValue!.first
                                                          .replaceAll(
                                                              '#', '0xff')))
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(width: 2.w),
                                        ],
                                      ))
                                  .toList())
                          : const SizedBox.shrink(),
                      SizedBox(height: 0.5.h),
                      _ratingsBar(
                          ratings:
                              double.parse(productDetail.ratings.toString())),
                      SizedBox(height: 1.h),
                      _readMoreSection(
                          context: context,
                          title: 'Product Description',
                          description: productDetail.description ?? ""),
                      _readMoreSection(
                          context: context,
                          title: 'Product Ingredients',
                          description: productDetail.ingredient ?? ""),
                      _messageSection(context),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
      }),
    );
  }
}

_ratingsBar({required double ratings}) {
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
      initialRating: ratings,
      // minRating: 1,
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
    SizedBox(height: 2.h),
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Send a message',
        suffixIcon: IconButton(
          icon: Icon(
            Icons.send,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () async {
            log("Tapped");
            await FlutterLocalNotificationManager.instance.displayNotification(
                title: "Oriflame Nepal", body: "Thank You for messaging us");
          },
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
    SizedBox(height: 0.5.h),
    ReadMoreText(
      parse(description).body?.text ?? "",
      trimMode: TrimMode.Line,
      trimLines: 2,
      colorClickableText: Colors.pink,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: kprimaryColor,
      ),
    ),
    SizedBox(
      height: 2.h,
    ),
  ]);
}
