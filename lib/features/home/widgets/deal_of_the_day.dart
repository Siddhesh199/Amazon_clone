import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/screens/see_all_deals_screen.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();
  int displayedProduct = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailsScreen.routeName,
                    arguments: product,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 40,
                      ),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        product!.images[displayedProduct],
                        height: 235,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: RichText(
                        text: TextSpan(
                          text: 'Deal price: ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '\$${product!.price}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    displayedProduct =
                                        product!.images.indexOf(e);
                                  });
                                },
                                child: Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, SeeAllDealsScreen.routeName),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15)
                            .copyWith(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'See all deals',
                          style: TextStyle(
                            color: Colors.cyan[800],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
