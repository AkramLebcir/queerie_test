import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queerie_test/core/core.dart';
import 'package:queerie_test/dependencies_injection.dart';
import 'package:queerie_test/features/features.dart';
import 'package:queerie_test/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with MainBoxMixin {
  late final ActiveTheme _selectedTheme = sl<SettingsCubit>().getActiveTheme();

  late final List<DataHelper> _listLanguage = [
    DataHelper(title: Constants.get.english, type: "en"),
    DataHelper(title: Constants.get.french, type: "fr"),
  ];
  late DataHelper _selectedLanguage =
      (getData(MainBoxKeys.locale) ?? "en") == "en" ? _listLanguage[0] : _listLanguage[1];

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimens.space16),
          child: Column(
            children: [
              DropDown<ActiveTheme>(
                key: const Key("dropdown_theme"),
                hint: Strings.of(context)!.chooseTheme,
                value: _selectedTheme,
                prefixIcon: const Icon(Icons.light),
                items: ActiveTheme.values
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          _getThemeName(data, context),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  context.read<SettingsCubit>().updateTheme(value ?? ActiveTheme.system);
                },
              ),
              DropDown<DataHelper>(
                key: const Key("dropdown_language"),
                hint: Strings.of(context)!.chooseLanguage,
                value: _selectedLanguage,
                prefixIcon: const Icon(Icons.language_outlined),
                items: _listLanguage
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          data.title ?? "-",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (DataHelper? value) async {
                  _selectedLanguage = value ?? _listLanguage[0];

                  if (!mounted) return;
                  context.read<SettingsCubit>().updateLanguage(value?.type ?? "en");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getThemeName(ActiveTheme activeTheme, BuildContext context) {
    if (activeTheme == ActiveTheme.system) {
      return Strings.of(context)!.themeSystem;
    } else if (activeTheme == ActiveTheme.dark) {
      return Strings.of(context)!.themeDark;
    } else {
      return Strings.of(context)!.themeLight;
    }
  }
}
