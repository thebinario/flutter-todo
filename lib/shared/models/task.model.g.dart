// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      title: json['title'] as String,
      dateRange: json['dateRange'] as String,
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'title': instance.title,
      'dateRange': instance.dateRange,
      'completed': instance.completed,
    };
