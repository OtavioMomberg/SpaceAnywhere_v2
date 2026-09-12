import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class DrawerPage extends StatefulWidget {
  const new({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final _drawerIcons = const [
    Icons.home,
    Icons.quiz,
    Icons.analytics,
    Icons.wallpaper,
    Icons.calculate,
    Icons.language,
  ];
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blue3,
      drawer: SafeArea(
        top: false,
        bottom: false,
        child: Drawer(
          backgroundColor: AppThemes.blue1,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              SizedBox(
                height: size.height * 0.15,
                child: const DrawerHeader(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Menu",
                      style: TextStyle(
                        color: AppThemes.whitePremium,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...List.generate(AppRoutes.pages.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    selected: selectedPage == index,
                    selectedTileColor: AppThemes.whitePremium.withValues(
                      alpha: 0.15,
                    ),
                    leading: Icon(
                      _drawerIcons[index],
                      color: selectedPage == index
                        ? AppThemes.yellow.withValues(alpha: 0.8)
                        : AppThemes.whitePremium,
                    ),
                    title: Text(
                      AppRoutes.pageNames[index],
                      style: TextStyle(
                        color: selectedPage == index
                          ? AppThemes.yellow.withValues(alpha: 0.8)
                          : AppThemes.whitePremium,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppThemes.borderRadius,
                    ),
                    onTap: () {
                      setState(() => selectedPage = index);
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
        child: SafeArea(child: AppRoutes.pages[selectedPage]),
      ),
    );
  }
}
