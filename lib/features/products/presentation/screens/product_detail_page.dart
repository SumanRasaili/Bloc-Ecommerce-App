import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:html/parser.dart';
import 'package:oriflamenepal/config/color/app_colors.dart';
import 'package:oriflamenepal/features/products/bloc/cart/cart_bloc.dart';
import 'package:oriflamenepal/features/products/bloc/product_detail_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

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

class ProductDetailPage extends StatefulWidget {
  final String slug;
  const ProductDetailPage({super.key, required this.slug});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late CarouselSliderController carouselBannerController;
  int currentIndex = 0;
  late ColorAttributes selectedAttributesValue;
  List<String> imageUrls = [];
  List<ColorAttributes> colorAttributes = [];
  String selectedColor = '';
  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(ProductDetailEvent.getProductDetail(slug: widget.slug));

    carouselBannerController = CarouselSliderController();
    colorAttributes = [
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
    selectedAttributesValue = colorAttributes[0];
    selectedColor = colorAttributes[0].colorName;
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
        }, loaded: (productDetail, selectedColorAttribute) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
                automaticallyImplyLeading: true,
                expandedHeight: 25.sh,
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
                            viewportFraction: 1.0,
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
                        "Code : ${selectedAttributesValue.productCode}",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Row(children: [
                        Text(
                          "Rs. ${selectedAttributesValue.productPrice}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          "Rs. ${selectedAttributesValue.productDiscount}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(width: 3.w),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
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
                      SizedBox(height: 0.5.h),
                      Text(
                        selectedAttributesValue.colorName,
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
                                              setState(() {
                                                selectedColor =
                                                    color.name ?? "";
                                                // selectedAttributesValue = color;
                                              });
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
                                                  color: Color(int.parse(color
                                                      .colorValue!.first
                                                      .replaceAll(
                                                          '#', '0xff'))),
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
