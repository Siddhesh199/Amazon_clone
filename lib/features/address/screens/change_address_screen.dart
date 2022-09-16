import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flutter/material.dart';

class ChangeAddressScreen extends StatefulWidget {
  static const String routeName = '/change-address';
  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : Scaffold(
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
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
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Change Address',
                        onTap: () {
                          if (_addressFormKey.currentState!.validate()) {
                            addressServices.saveUserAddress(
                              context: context,
                              address:
                                  '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}',
                            );
                            setState(() {
                              loading = true;
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
