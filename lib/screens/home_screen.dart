import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/get_all_prodect_service.dart';
import 'package:store/widgets/custom_card.dart';
import 'package:store/widgets/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.cartPlus,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'New Trend',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustumTextField(
                            hintText: 'Product Title',
                            inputType: TextInputType.text),
                      ],
                    )));
              });
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 65),
        child: FutureBuilder<List<ProductModel>>(
            future: AllProductService().getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('📡 جاري تحميل البيانات...');
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print('❌ حدث خطأ: ${snapshot.error}');
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                print('✅ البيانات واصلة: ${snapshot.data}');
                List<ProductModel> products = snapshot.data!;
                return GridView.builder(
                    itemCount: products.length,
                    clipBehavior: Clip.none,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 100,
                    ),
                    itemBuilder: (context, index) {
                      return CustomCard(
                        productModel: products[index],
                      );
                    });
              } else {
                print('⚠ لا توجد بيانات');
                return Center(child: Text('No Data Found'));
              }
            }),
      ),
    );
  }
}


//  if (snapshot.hasData) {
//                 List<ProductModel> products = snapshot.data!;
                
//                 return GridView.builder(
//                     itemCount: products.length,
//                     clipBehavior: Clip.none,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 1.5,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 100,
//                     ),
//                     itemBuilder: (context, index) {
//                       return CustomCard(
//                         productModel: products[index],
//                       );
//                     });
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }