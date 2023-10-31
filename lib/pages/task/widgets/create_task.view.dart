import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo/pages/task/task_list.controller.dart';
import 'package:todo/shared/models/task.model.dart';

class CreateTask extends StatefulWidget {
  int index;
  bool isEditing;

  CreateTask({super.key, required this.index, required this.isEditing});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  DateTime _selectedDateTime = DateTime.now();

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    Completer<DateTime?> completer = Completer<DateTime?>();

    DateTime? selectedDateTime;

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    print("Date>>>>>>>>>> $pickedDate");

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Select Time with Seconds'),
                SizedBox(height: 20),
                Expanded(
                  child: CupertinoTimerPicker(
                    onTimerDurationChanged: (Duration duration) {
                      selectedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        duration.inHours,
                        duration.inMinutes.remainder(60),
                        duration.inSeconds.remainder(60),
                      );
                    },
                    mode: CupertinoTimerPickerMode.hms,
                  ),
                ),
                ElevatedButton(onPressed: () {
                  print("HOras Completas>>>>>>>>>> $selectedDateTime");
                  completer.complete(selectedDateTime);
                  Navigator.of(context).pop();
                }, child: Text("Save"))
              ],
            ),
          );
        },
      );

      if (pickedTime == null && !completer.isCompleted) {
        // Usuário cancelou a seleção, complete com null
        completer.complete(null);
      }
    } else {
      // Usuário cancelou a seleção, complete com null
      completer.complete(null);
    }

    return completer.future;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListController>(
      builder: (context, controller, child) {
        controller.index = widget.index;
        controller.isEditing = widget.isEditing;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Create task"),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: ReactiveForm(
                formGroup: controller.formGroup,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, right: 15, left: 15),
                  child: Column(
                    children: [
                      ReactiveTextField(
                        formControlName: 'task',
                        decoration: const InputDecoration(
                          labelText: 'Task Name',
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size.fromHeight(14),
                      ),
                      ReactiveTextField(
                        formControlName: 'dateRange',
                        onTap: (v) async {
                          DateTime? selectedDateTime = await _selectDateTime(context);
                          if(selectedDateTime == null) return;
                          controller.formGroup.control("dateRange").patchValue(selectedDateTime.toString());
                        },
                        decoration: const InputDecoration(
                          labelText: 'dateRange',
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (controller.formGroup.valid) {
                                  context.go("/");
                                  controller.createOrUpdate(widget.index, widget.isEditing);
                                }
                              },
                              child: Text(widget.isEditing == true ? "Edit task" : "Save task")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
