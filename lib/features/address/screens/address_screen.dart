import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Please enter your address');
      throw Exception('Please enter all the values');
    }
  }

  void placeOrder(String address) {
    addressServices.saveUserAddress(
      context: context,
      address: address,
    );

    addressServices.placeOrder(
      context: context,
      address: address,
      totalSum: double.parse(widget.totalAmount),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: loading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (address.isNotEmpty)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                address,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'OR',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    Form(
                      key: _addressFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: flatBuildingController,
                            hintText: 'Flat, House No., Building',
                            labelText: 'Flat, House No., Building',
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: areaController,
                            hintText: 'Area, Street',
                            labelText: 'Area, Street',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: pincodeController,
                            hintText: 'Pincode',
                            labelText: 'Pincode',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: cityController,
                            hintText: 'Town/City',
                            labelText: 'Town/City',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: 'Place Order',
                      onTap: () {
                        if (Provider.of<UserProvider>(context, listen: false)
                            .user
                            .address
                            .isNotEmpty) {
                          if (flatBuildingController.text.isNotEmpty ||
                              areaController.text.isNotEmpty ||
                              pincodeController.text.isNotEmpty ||
                              cityController.text.isNotEmpty) {
                            if (_addressFormKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              address =
                                  '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
                              placeOrder(address);
                            }
                          } else {
                            setState(() {
                              loading = true;
                            });
                            placeOrder(address);
                          }
                        } else {
                          if (_addressFormKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            address =
                                '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';

                            placeOrder(address);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    GooglePayButton(
                      onPressed: () => payPressed(address),
                      paymentConfigurationAsset: 'gpay.json',
                      onPaymentResult: onGooglePayResult,
                      paymentItems: paymentItems,
                      height: 50,
                      type: GooglePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15),
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
