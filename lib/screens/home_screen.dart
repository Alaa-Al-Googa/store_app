import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/add_product.dart';
import 'package:store/services/categories_service.dart';
import 'package:store/services/get_all_prodect_service.dart';
import 'package:store/widgets/category_list_view.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/custom_card.dart';
import 'package:store/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> productsFuture;
  String selectedCategory = 'all';
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productsFuture =
        AllProductService().getAllProducts(); // تحميل الكل بالبداية
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'all') {
        productsFuture = AllProductService().getAllProducts();
      } else {
        productsFuture = CategoriesService().getCategoriesProducts(
          categoryName: category,
        );
      }
    });
  }

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
            //isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustumTextField(
                          controller: titleController,
                          hintText: 'Product Title',
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustumTextField(
                          controller: priceController,
                          hintText: 'Product Price',
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustumTextField(
                          controller: descController,
                          hintText: 'Product Description',
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustumTextField(
                          controller: imageController,
                          hintText: 'Product Image',
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustumTextField(
                          controller: categoryController,
                          hintText: 'Product Category',
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          TextButton: 'Add Product',
                          ColorButton: Colors.blue,
                          onTap: () async {
                            try {
                              AddProduct addProduct = AddProduct();

                              ProductModel product =
                                  await addProduct.addProduct(
                                title: titleController.text,
                                price: priceController.text,
                                desc: descController.text,
                                image: imageController.text,
                                category: categoryController.text,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'تمت إضافة المنتج: ${product.title}')),
                              );
                              Navigator.of(context).pop();
                              // تنظيف الحقول
                              titleController.clear();
                              priceController.clear();
                              descController.clear();
                              imageController.clear();
                              categoryController.clear();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('خطأ: $e')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                CategoryListView(
                  onCategorySelected: onCategorySelected,
                  selectedCategory: selectedCategory,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 65),
              child: FutureBuilder<List<ProductModel>>(
                future: productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<ProductModel> products = snapshot.data!;
                    return GridView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 100,
                      ),
                      itemBuilder: (context, index) {
                        return CustomCard(productModel: products[index]);
                      },
                    );
                  } else {
                    return const Center(child: Text('No Data Found'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
