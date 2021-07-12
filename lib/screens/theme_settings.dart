import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = '/themes_screen';

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx, listen: true).tm,
      onChanged: (newThemeValue) =>
          Provider.of<ThemeProvider>(ctx, listen: false)
              .themeModeChange(newThemeValue),
      title: Text(txt),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'Themes',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your theme MODE',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Choose your Theme MODE',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                buildRadioListTile(
                    ThemeMode.system, 'System Default Theme', null, context),
                buildRadioListTile(ThemeMode.light, 'Light MODE',
                    Icons.wb_sunny_outlined, context),
                buildRadioListTile(ThemeMode.dark, 'Dark MODE',
                    Icons.nights_stay_outlined, context),
                buildListTile(context, 'primary'),
                buildListTile(context, 'accent'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, txt) {
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =
        Provider.of<ThemeProvider>(context, listen: true).accentColor;
    return ListTile(
        title: Text(
          'Choose yor $txt color',
          //style: Theme.of(context).textTheme.headline6,
        ),
        trailing: CircleAvatar(
          backgroundColor: txt == 'primary' ? primaryColor : accentColor,
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  elevation: 4,
                  titlePadding: const EdgeInsets.all(0.0),
                  contentPadding: const EdgeInsets.all(0.0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: txt == 'primary'
                          ? Provider.of<ThemeProvider>(ctx, listen: true)
                              .primaryColor
                          : Provider.of<ThemeProvider>(ctx, listen: true)
                              .accentColor,
                      onColorChanged: (newColor) =>
                          Provider.of<ThemeProvider>(ctx, listen: false)
                              .onChanged(newColor, txt == 'primary' ? 1 : 2),
                      colorPickerWidth: 300,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false,
                      displayThumbColor: true,
                      showLabel: false,
                    ),
                  ),
                );
              });
        });
  }
}
