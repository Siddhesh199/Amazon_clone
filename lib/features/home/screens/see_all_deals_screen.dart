import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_deatails/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 42,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TypeAheadField(
                      loadingBuilder: (context) {
                        return const SizedBox();
                      },
                      minCharsForSuggestions: 1,
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                          helperStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      suggestionsCallback: (_) async {
                        return await searchServices.fetchSearchedProduct(
                          context: context,
                          searchQuery: _searchController.text,
                        );
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: const Icon(Icons.shopping_cart),
                          title: Text(suggestion.name),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _searchController.text = suggestion.name.toString();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(
                              searchQuery: suggestion.name,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
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
                    Navigator.pushNamed(
                      context,
                      ProductDetailsScreen.routeName,
                      arguments: productList![index],
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
