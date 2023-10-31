import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/factories/app.factory.dart';
import 'package:todo/pages/setting/setting.controller.dart';
import 'package:todo/pages/task/task_list.controller.dart';

class Setting extends StatefulWidget {
  Setting();

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (BuildContext context, controller, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Setting"),
          ),
          body: SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                padding: EdgeInsets.only(top: 10, right: 6, left: 6),
                children: [
                  ListTile(
                    title: const Text(
                      "Theme dark",
                    ),
                    trailing: Switch(
                      onChanged: (value) {
                        setState(() {
                          controller.onChangeTheme();
                        });
                      },
                      value: controller.isLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
