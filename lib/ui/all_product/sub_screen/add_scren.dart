import 'package:category/ui/all_product/view.dart';


class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController nomiController = TextEditingController();
  TextEditingController narxiController = TextEditingController();

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mahsulot Qo'shish",
          style: stylee,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: globalCategoryValue.length,
                  itemBuilder: (context, index) {
                    CategoryModel category = globalCategoryValue[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          value = category.id;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.yellow),
                        child: Center(
                          child: Text(category.nomi),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 15),
            const Text('categoriya'),
            TextField(
              controller: nomiController,
            ),
            const SizedBox(height: 15),
            const Text('narxi'),
            TextField(
              controller: narxiController,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  MahsulotModel addMahsulot = MahsulotModel();
                  addMahsulot.nomi = nomiController.text;
                  addMahsulot.narxi = int.parse(narxiController.text);
                  addMahsulot.categoryId = value;
                  await addMahsulot.insert();
                  setState(() {});
                },
                child: const Text("qo'shish"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
