import 'view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [];
  int selectIndex = 0;

  @override
  void initState() {
    screens = [
      const AllProduct(),
      const CategoryScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          selectIndex == 0 ? "All Product" : "Category Product",
          style: stylee,
        ),
      ),
      body: screens[selectIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.orange,
          currentIndex: selectIndex,
          onTap: (v) {
            setState(
              () {
                selectIndex = v;
              },
            );
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits_rounded),
                label: "product"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: "category"),
          ],
        ),
      ),
    );
  }
}
