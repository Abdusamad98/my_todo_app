import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/data/my_repository.dart';
import 'package:my_todo_app/presentation/tabs/profile/widgets/language_item.dart';
import 'package:my_todo_app/utils/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String activeLanguage = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    activeLanguage = context.locale.toString();
    print(activeLanguage);
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: Text(tr("language_screen")),
      ),
      body: Column(
        children: [
          LanguageItem(
            onTap: () {
              if (activeLanguage != "ru_RU") {
                setState(() {
                  context.setLocale(const Locale('ru', 'RU'));
                  activeLanguage = "ru_RU";
                  MyRepository.updateMyLocale("ru");
                });
              }
            },
            text: tr("russian"),
            isActive: activeLanguage == "ru_RU",
          ),
          LanguageItem(
            onTap: () {
              if (activeLanguage != "en_EN") {
                setState(() {
                  context.setLocale(const Locale('en', 'EN'));
                  activeLanguage = "en_EN";
                  MyRepository.updateMyLocale("en");
                });
              }
            },
            text: "english".tr(),
            isActive: activeLanguage == "en_EN",
          ),
          LanguageItem(
            onTap: () {
              if (activeLanguage != "uz_UZ") {
                setState(() {
                  context.setLocale(const Locale('uz', 'UZ'));
                  activeLanguage = "uz_UZ";
                  MyRepository.updateMyLocale("uz");
                });
              }
            },
            text: "uzbek".tr(),
            isActive: activeLanguage == "uz_UZ",
          ),
        ],
      ),
    );
  }
}

//Login: donero
//Parol ewedon
