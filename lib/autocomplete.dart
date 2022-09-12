import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutoCompleteScreen extends StatefulWidget {
  const AutoCompleteScreen({Key? key}) : super(key: key);

  @override
  State<AutoCompleteScreen> createState() => _AutoCompleteScreenState();
}

class _AutoCompleteScreenState extends State<AutoCompleteScreen> {
  final SearchServices searchServices = SearchServices();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: textEditingController,
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
              searchQuery: textEditingController.text,
            );
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text(suggestion.name),
            );
          },
          onSuggestionSelected: (suggestion) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  searchQuery: suggestion.name,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
