import 'package:category/ui/category_screen/view.dart';

class SubScreen extends StatefulWidget {
  const SubScreen({super.key, required this.id});

  final int id;

  @override
  State<SubScreen> createState() => _SubScreenState();
}

class _SubScreenState extends State<SubScreen> {
  late CategoryModel modelCategory;
  List mahsulotList = [];

  _selectAllProduct() async {
    mahsulotList.clear();
    mahsulotList = [];

    mahsulotList = MahsulotModel.obyektlar.values
        .where((element) => element.categoryId == widget.id)
        .toList();
    setState(() {
      mahsulotList;
    });
  }

  @override
  void initState() {
    _selectAllProduct();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text('Sub Screen'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mahsulotList.length,
        itemBuilder: (context, index) {
          MahsulotModel item = mahsulotList[index];
          return ListTile(
            title: Text(item.nomi),
          );
        },
      ),
    );
  }
}
