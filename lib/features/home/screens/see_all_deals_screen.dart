import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/common/widgets/search_bar.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SeeAllDealsScreen extends StatefulWidget {
  static const String routeName = '/see-all-deals';
  const SeeAllDealsScreen({Key? key}) : super(key: key);

  @override
  State<SeeAllDealsScreen> createState() => _SeeAllDealsScreenState();
}

class _SeeAllDealsScreenState extends State<SeeAllDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  final SearchServices searchServices = SearchServices();
  final TextEditingController _searchController = TextEditingController();
  final SearchBar searchBar = SearchBar();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSeeAllDeals();
  }

  fetchSeeAllDeals() async {
    productList = await homeServices.fetchSeeAllDeals(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.searchBar(
        context: context,
        textEditingController: _searchController,
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                product: productList![index],
                              ),
                            ),
                          );
                        },
                        child: SearchedProduct(
                          product: productList![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
