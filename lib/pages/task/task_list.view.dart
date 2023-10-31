import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/constant/asset_constants.dart';
import 'package:todo/pages/task/task_list.controller.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskListController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Task List"),
            leadingWidth: 60,
            leading: IconButton(
              onPressed: () => {context.go('/setting')},
              icon: const Icon(Icons.more_vert),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ActionChip(
                  onPressed: () {
                    setState(() {
                      controller.getStoragetasks();
                    });
                  },
                  label: const Icon(Icons.refresh, color: Colors.black),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: ShowContent(hasContent: controller.hasContent, controller: controller),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.formGroup.reset();
              context.go('/create-task');
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class ShowContent extends StatefulWidget {
  bool hasContent = false;
  late final TaskListController controller;

  ShowContent({super.key, required this.hasContent, required this.controller});

  @override
  State<ShowContent> createState() => _ShowContentState();
}

class _ShowContentState extends State<ShowContent> {
  late Widget showWidget = Container();

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.hasContent) {
        showWidget = ListView.separated(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 4),
          itemCount: widget.controller.tasks.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: GlobalKey(),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {
                  setState(() {
                    widget.controller.tasks.removeAt(index);
                    widget.controller.setStorageTask(context);
                  });
                }),
                children: const [
                  SlidableAction(
                    onPressed: null,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      widget.controller.isEditing = true;
                      widget.controller.initFormGroup();
                      context.pushNamed('create-task', queryParameters: {'index': '$index', 'isEditing': 'true'});
                    },
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: ListTile(
                selectedColor: Colors.green,
                selectedTileColor: Colors.green,
                title: Text(widget.controller.tasks[index].title),
                subtitle: Text(widget.controller.tasks[index].dateRange.toString().substring(0, 19)),
                leading: Checkbox(
                  value: widget.controller.tasks[index].completed,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.markTaskCompleted(index);
                    });
                  },
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 6),
        );
      } else {
        showWidget = Container(
          color: Colors.transparent,
          child: Image.asset(
            NOTHING_HERE,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        );
      }
    });

    return showWidget;
  }
}
