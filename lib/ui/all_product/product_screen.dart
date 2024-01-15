import 'package:category/constant/constant_fields.dart';
import 'package:category/data/model/category_model.dart';
import 'package:category/data/model/mahsulot_model.dart';
import 'package:category/ui/all_product/sub_screen/add_scren.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  List productList = [];
  MahsulotModel mahsulotModel = MahsulotModel();
  CategoryModel itemIn = CategoryModel();

  _selectAllProduct() {
    productList = MahsulotModel.obyektlar.values.toList();
    setState(() {
      productList;
    });
  }

  _allProduct() async {
    MahsulotModel.obyektlar = (await MahsulotModel.service.select())
        .map((key, value) => MapEntry(key, MahsulotModel.fromJson(value)));
    _selectAllProduct();
  }

  @override
  void initState() {
    _allProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Product"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TextField(),
          // const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                MahsulotModel mahsulotItem = productList[index];

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.teal, width: 3),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          'nomi: ${mahsulotItem.nomi}',
                          style: stylee,
                        ),
                        const Spacer(),
                        Text(
                          'id: ${mahsulotItem.id}',
                          style: stylee2,
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          'narxi: ${mahsulotItem.narxi}\$',
                          style: stylee,
                        ),
                        const Spacer(),
                        Text(
                          'categoryId: ${mahsulotItem.categoryId}',
                          style: stylee2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddItemScreen(),
            ),
          );
          _selectAllProduct();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
