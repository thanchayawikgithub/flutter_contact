import 'package:flutter/material.dart';
import 'package:my_contact/contact_provider.dart';
import 'package:my_contact/contact_widget.dart';
import 'package:my_contact/theme.dart';
import 'package:my_contact/util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ContactProvider())],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme =
        createTextTheme(context, "Abhaya Libre", "Abhaya Libre");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: ContactWidget());
  }
}
