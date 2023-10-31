import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo/shared/models/task.model.dart';
import 'package:todo/shared/providers/storage.provider.dart';
import 'package:todo/shared/services/notification.service.dart';

class TaskListController extends ChangeNotifier {
  List<TaskModel> tasks = [];
  int index = 0;
  bool isEditing = false;
  bool hasContent = false;
  final BuildContext context;

  NotificationService notificationService = NotificationService();

  TaskListController({required this.context}) {
    autoUpdate();
  }

  void onInit() {
    initFormGroup();

    getStoragetasks();
  }

  final formGroup = fb.group({
    'task': [null, Validators.required],
    'dateRange': [null, Validators.required],
  });

  void addTask() {
    final title = formGroup.control("task").value;
    final dateRange = formGroup.control("dateRange").value;

    tasks.add(TaskModel(title: title, dateRange: dateRange));
    setStorageTask(context);
    notifyListeners();
  }

  void updateTask(index) {
    final title = formGroup.control("task").value;
    final dateRange = formGroup.control("dateRange").value;

    tasks[index].title = title;
    tasks[index].dateRange = dateRange;
    notifyListeners();
  }

  void markTaskCompleted(int index) {
    tasks[index].completed = !tasks[index].completed;
  }

  delStorageTask() {
    // storageService.del("tasks");
  }

  void autoUpdate() {
    Future.delayed(Duration(seconds: 1), () {
      getStoragetasks();
    });
  }

  getStoragetasks() {
    var sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(context, listen: false);
    List? tasksJsonList = sharedPreferencesProvider.get('tasks');

    if (tasksJsonList == null) return;

    List<TaskModel>? _tasks = tasksJsonList.map((taskJson) {
      Map<String, dynamic> decodedTask = jsonDecode(taskJson);
      return TaskModel(title: decodedTask['title'], completed: decodedTask['isCompleted'], dateRange: decodedTask['dateRange']);
    }).toList();

    tasks = _tasks;
    hasContent = tasks.isNotEmpty;
    notifyListeners();
  }

  setStorageTask(context) {
    var sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(context, listen: false);

    List<String> tasksJsonList = tasks.map((task) {
      Map<String, dynamic> taskJson = {'title': task.title, 'isCompleted': task.completed, 'dateRange': task.dateRange.toString()};
      return jsonEncode(taskJson);
    }).toList();

    sharedPreferencesProvider.set('tasks', tasksJsonList);
  }

  initFormGroup() {
    TaskModel? task = getTask(index);
    if (task != null && isEditing) {
      formGroup.control("task").patchValue(task.title);
      formGroup.control("dateRange").patchValue(task.dateRange);
    } else {
      formGroup.reset();
    }
  }

  TaskModel? getTask(index) {
    return tasks.elementAtOrNull(index);
  }

  createOrUpdate(index, isEdit) {
    isEdit == true ? updateTask(index) : addTask();

    final title = formGroup.control("task").value;
    DateTime date = DateTime.parse(formGroup.control("dateRange").value);
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;

    showScheduleNotification("Todo App", title, year, month, day, hour, minute, second);
    notifyListeners();
  }

  get hasIndex {
    (index) {
      return index == null;
    };
  }

  void showImmediateNotification() {
    notificationService.showNotification(
      id: 0,
      title: 'Título da Notificação',
      body: 'Corpo da Notificação',
    );
  }

  void showScheduleNotification(String title, String body, year, month, day, hour, minute, second) {
    DateTime scheduledDateTime = DateTime.utc(year, month, day, hour, minute, second);

    print("Agendado>>>>>>>>>>>>>>>>   ${scheduledDateTime.second}");
    print("HASHCODE>>>>>>>>>>>>>>>>   ${scheduledDateTime.hashCode}");

    notificationService.scheduleNotification(
      id: scheduledDateTime.hashCode,
      title: title,
      body: body,
      scheduledNotificationDateTime: scheduledDateTime,
    );
  }
}
