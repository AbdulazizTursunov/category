import 'view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController nomiController = TextEditingController();
  List categoryList = [];
  CategoryModel categoryModel = CategoryModel();

  _selectAllCategory() {
    categoryList = CategoryModel.obyektlar.values.toList();
    setState(() {
      categoryList;
      globalCategoryValue = categoryList;
    });
  }

  _obektCategoryModel() async {
    CategoryModel.obyektlar = (await CategoryModel.service.select())
        .map((key, value) => MapEntry(key, CategoryModel.fromJson(value)));
    _selectAllCategory();
  }

  @override
  void initState() {
    _obektCategoryModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Category",style: stylee.copyWith(fontSize: 20),),
      //   centerTitle: true,
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          CategoryModel item = categoryList[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.teal, width: 2),
                color: Colors.white70),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubScreen(id: item.id),
                  ),
                );
              },
              title: Row(
                children: [
                  Text('nomi: ${item.nomi}', style: stylee),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      nomiController.text = item.nomi;
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              Column(
                                children: [
                                  TextField(
                                    controller: nomiController,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        CategoryModel updateCategory =
                                            CategoryModel();
                                        updateCategory.nomi =
                                            nomiController.text;
                                        updateCategory.update();
                                        _selectAllCategory();
                                        setState(() {});
                                        nomiController.clear();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Tahrirlash"))
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text('id: ${item.id}', style: stylee),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      item.delete();
                      _selectAllCategory();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                Column(
                  children: [
                    TextField(
                      controller: nomiController,
                      decoration: const InputDecoration(hintText: 'category'),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        CategoryModel addcategory = CategoryModel();
                        addcategory.nomi = nomiController.text;
                        addcategory.insert();
                        nomiController.clear();
                        debugPrint("category:$addcategory");
                        _selectAllCategory();
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const Text("Qo'shish"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
