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
      body: Material(
        borderRadius: BorderRadius.circular(40),
        child: Padding(
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
                        highlightColor: Colors.purple.withOpacity(0.4),
                        splashColor: Colors.green.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          setState(() {
                            value = category.id;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border:
                                  Border.all(color: Colors.yellow, width: 2)),
                          child: Center(
                            child: Text(category.nomi),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 15),
              const Text('Nomi'),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'nomi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.black,
                  ),
                  controller: nomiController,
                ),
              ),
              const SizedBox(height: 15),
              const Text('Narxi'),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  controller: narxiController,
                  decoration: InputDecoration(
                    hintText: 'narxi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fillColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.withOpacity(0.8),
                      padding: const EdgeInsets.all(10),
                    ),
                    onPressed: () async {

                      MahsulotModel addMahsulot = MahsulotModel();
                      addMahsulot.nomi = nomiController.text;
                      addMahsulot.narxi = int.parse(narxiController.text);
                      addMahsulot.categoryId = value;
                      await addMahsulot.insert();
                      setState(() {});
                      final snackBar =  SnackBar(
                        duration: Duration(milliseconds: 200),
                        content:  Text('Mahsulot qo\'shildi!',style: TextStyle(color: Colors.black),),
                        backgroundColor: (Colors.white),
                        );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    },
                    child:  Text("Qo'shish",style: stylee2,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
