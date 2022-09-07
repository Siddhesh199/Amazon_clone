import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductsScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionNameController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String category = 'Mobiles';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Select Product Images',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                  labelText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionNameController,
                  hintText: 'Description',
                  labelText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                  labelText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                  labelText: 'Quantity',
                ),
                const SizedBox(height: 10),
                // SizedBox(
                //   width: double.infinity,
                //   child: DropdownButton(
                //     value: category,
                //     icon: const Icon(Icons.keyboard_arrow_down),
                //     items: productCategories.map(
                //       (String item) {
                //         return DropdownMenuItem(
                //           value: item,
                //           child: Text(item),
                //         );
                //       },
                //     ).toList(),
                //     onChanged: (String? newVal) {
                //       setState(
                //         () {
                //           category = newVal!;
                //         },
                //       );
                //     },
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(
                        () {
                          category = value!;
                        },
                      );
                    },
                    selectedItemBuilder: (BuildContext context) {
                      // This is the widget that will be shown when you select an item.
                      // Here custom text style, alignment and layout size can be applied
                      // to selected item string.
                      return productCategories.map(
                        (String value) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(category),
                          );
                        },
                      ).toList();
                    },
                    items: productCategories.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sell',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
