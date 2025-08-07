import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/update_product_service.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/custom_text_field.dart';
import 'package:store/widgets/show_snack_bar.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({super.key});

  static String id = 'UpdateProductScreen';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  bool isLoading = false;
  String? productName, desc, image, price;

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  CustumTextField(
                    onChanged: (data) {
                      productName = data;
                    },
                    hintText: productModel.title,
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustumTextField(
                    hintText: productModel.description,
                    onChanged: (data) {
                      desc = data;
                    },
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustumTextField(
                    hintText: productModel.price.toString(),
                    onChanged: (data) {
                      price = data;
                    },
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustumTextField(
                    hintText: productModel.image,
                    onChanged: (data) {
                      image = data;
                    },
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // CustomButton(
                  //   TextButton: 'Update',
                  //   ColorButton: Colors.blue,
                  //   onTap: () async {
                  //     isLoading = true;
                  //     setState(() {});
                  //     try {
                  //       await UpdateProduct(productModel);
                  //       print('Update Data');
                  //       ShowSnackBar(context, 'Update Data');
                  //     } catch (e) {
                  //       ShowSnackBar(context, 'Error');
                  //       print(e.toString());
                  //     }
                  //     isLoading = false;
                  //     setState(() {});
                  //   },
                  // ),
                  CustomButton(
                    TextButton: 'Update',
                    ColorButton: Colors.blue,
                    onTap: () async {
                      isLoading = true;
                      setState(() {});
                      try {
                        await updateProduct(productModel);
                        ShowSnackBar(context, 'Update Data');
                      } catch (e) {
                        ShowSnackBar(context, 'Error');
                        print(e.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> updateProduct(ProductModel productModel) async {
    print('🔁 تم استدعاء updateProduct');
    await UpdateProductService().updateProduct(
      title: productName ?? productModel.title,
      price: double.tryParse(price ?? '') ?? productModel.price,
      desc: desc ?? productModel.description,
      image: image ?? productModel.image,
      category: productModel.category,
      id: productModel.id,
    );
  }
}
