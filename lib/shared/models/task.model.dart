import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.model.g.dart';

@JsonSerializable()
class TaskModel {
  String title;
  String dateRange;
  bool completed;

  TaskModel({required this.title, this.completed = false, required this.dateRange});

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  // get toStrMoment {
  //     // date
  //     final day = dateRange.day;
  //     final month = dateRange.month;
  //     final year = dateRange.year;
  //     // hour
  //     final hour = dateRange.hour;
  //     final minute = dateRange.minute;
  //
  //     return "$day/$month/$year $hour:$minute";
  // }
}
