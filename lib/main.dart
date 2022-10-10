import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

/// Models
class SettingsModel {
  final Color color;
  final ThemeMode themeMode;

  const SettingsModel({
    required this.color,
    required this.themeMode,
  });

  SettingsModel copyWith({
    Color? color,
    ThemeMode? themeMode,
  }) =>
      SettingsModel(
        color: color ?? this.color,
        themeMode: themeMode ?? this.themeMode,
      );

  SettingsModel.initial()
      : this.color = Colors.blue,
        this.themeMode = ThemeMode.system;
}

/// State management
class Settings extends ChangeNotifier {
  SettingsModel data = SettingsModel.initial();

  void edit(SettingsModel model) {
    data = model;
    notifyListeners();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Settings(),
      builder: (context, Widget? child) {
        final Settings settings = context.watch<Settings>();
        return MaterialApp(
          title: 'Material 3 App',
          themeMode: settings.data.themeMode,
          theme: ThemeData(
            colorSchemeSeed: settings.data.color,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: settings.data.color,
            brightness: Brightness.dark,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController controller = ScrollController();
  int index = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material 3"),
        actions: [
          IconButton(
            onPressed: () {
              final Settings settings = context.read<Settings>();
              final bool isDark = Theme.of(context).brightness == Brightness.dark;
              settings.edit(settings.data.copyWith(themeMode: isDark ? ThemeMode.light : ThemeMode.dark));
            },
            icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ListView(
          controller: controller,
          physics: PageScrollPhysics(),
          itemExtent: constraints.maxHeight,
          children: <Widget>[
            ScrollPage(
              scrollController: controller,
              mainAxisAlignment: MainAxisAlignment.center,
              child: [
                ColorPicker(
                  pickerColor: context.watch<Settings>().data.color,
                  onColorChanged: (Color color) {
                    final Settings settings = context.read<Settings>();
                    settings.edit(settings.data.copyWith(color: color));
                  },
                ),
              ],
            ),
            ScrollPage(
              scrollController: controller,
              child: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      title: Text("LisTile"),
                      trailing: Icon(Icons.info),
                      onTap: () {},
                    ),
                    RadioListTile(
                      value: true,
                      onChanged: (value) {},
                      groupValue: true,
                      title: Text("RadioListTile"),
                    ),
                    CheckboxListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text("CheckboxListTile"),
                    ),
                    SwitchListTile(
                      value: true,
                      onChanged: (value) {},
                      title: Text("SwitchListTile"),
                    ),
                    Slider(
                      value: 0.5,
                      min: 0,
                      max: 1,
                      onChanged: (value) {},
                      label: "Slider",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Hint placeholder',
                        ),
                      ),
                    ),
                    CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                      lastDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      onDateChanged: (date) {},
                    ),
                  ],
                ),
              ],
            ),
            ScrollPage(
              scrollController: controller,
              child: <Widget>[
                Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(20),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.all(40),
                        child: Text("test"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(onPressed: () {}, child: Text("click")),
                        const SizedBox(width: 20),
                        OutlinedButton(onPressed: null, child: Text("click")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(onPressed: () {}, child: Text("click")),
                        const SizedBox(width: 20),
                        ElevatedButton(onPressed: null, child: Text("click")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(onPressed: () {}, child: Text("click")),
                        const SizedBox(width: 20),
                        TextButton(onPressed: null, child: Text("click")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        BackButton(),
                        CloseButton(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Chip(label: Text("Chip")),
                        Chip(label: Text("Chip"), onDeleted: () {}),
                        Chip(
                          label: Text("Chip"),
                          avatar: CircleAvatar(child: Text("AB")),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ScrollPage(
              scrollController: controller,
              child: <Widget>[
                Column(
                  children: <Widget>[
                    FittedBox(child: Text('displayLarge', style: Theme.of(context).textTheme.displayLarge)),
                    FittedBox(child: Text('displayMedium', style: Theme.of(context).textTheme.displayMedium)),
                    Text('displaySmall', style: Theme.of(context).textTheme.displaySmall),
                    Text('headlineMedium', style: Theme.of(context).textTheme.headlineMedium),
                    Text('headlineSmall', style: Theme.of(context).textTheme.headlineSmall),
                    Text('titleLarge', style: Theme.of(context).textTheme.titleLarge),
                    Text('titleMedium', style: Theme.of(context).textTheme.titleMedium),
                    Text('titleSmall', style: Theme.of(context).textTheme.titleSmall),
                    Text('bodyLarge', style: Theme.of(context).textTheme.bodyLarge),
                    Text('bodyMedium', style: Theme.of(context).textTheme.bodyMedium),
                    Text('bodySmall', style: Theme.of(context).textTheme.bodySmall),
                    Text('labelLarge', style: Theme.of(context).textTheme.labelLarge),
                    Text('labelSmall', style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ],
            ),
            ScrollPage(
              scrollController: controller,
              child: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    AppBar(title: Text("AppBar"), leading: BackButton()),
                    const SizedBox(height: 20),
                    DefaultTabController(
                      length: 3,
                      child: SizedBox(
                        height: kToolbarHeight,
                        child: AppBar(
                          bottom: TabBar(
                            tabs: [
                              Tab(icon: Icon(Icons.directions_car)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_bike)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ScrollPage(
              scrollController: controller,
              child: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(),
                    const SizedBox(height: 20),
                    Stepper(
                      physics: NeverScrollableScrollPhysics(),
                      currentStep: index,
                      onStepTapped: (int value) => setState(() => index = value),
                      onStepContinue: index == 2 ? null : () => setState(() => ++index),
                      onStepCancel: index == 0 ? null : () => setState(() => --index),
                      steps: <Step>[
                        Step(
                          isActive: index == 0,
                          title: Text("Part One"),
                          content: ListTile(
                            title: Text("Ninkasi c'est bon"),
                          ),
                        ),
                        Step(
                          isActive: index == 1,
                          title: Text("Part Two"),
                          content: ListTile(
                            title: Text("J'aime menti nano >"),
                          ),
                        ),
                        Step(
                          isActive: index == 2,
                          title: Text("Part Three"),
                          content: ListTile(
                            title: Text("Huuuum Burger King"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAboutDialog(
          context: context,
          applicationIcon: FlutterLogo(),
          applicationLegalese: "Ceci est une démo pour Matérial 3",
          applicationName: "Flutter Material 3",
          applicationVersion: "1.0.0",
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.info),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ScrollPage extends StatelessWidget {
  final ScrollController scrollController;
  final List<Widget> child;
  final MainAxisAlignment mainAxisAlignment;

  const ScrollPage({
    Key? key,
    required this.scrollController,
    required this.child,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollParent(
      controller: scrollController,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: MainAxisSize.max,
              children: child,
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollParent extends StatelessWidget {
  final ScrollController controller;
  final Widget child;

  ScrollParent({required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
      onNotification: (OverscrollNotification value) {
        if (value.overscroll < 0 && controller.offset + value.overscroll <= 0) {
          if (controller.offset != 0) controller.jumpTo(0);
          return true;
        }
        if (controller.offset + value.overscroll >= controller.position.maxScrollExtent) {
          if (controller.offset != controller.position.maxScrollExtent) controller.jumpTo(controller.position.maxScrollExtent);
          return true;
        }
        controller.jumpTo(controller.offset + value.overscroll);
        return true;
      },
      child: child,
    );
  }
}
