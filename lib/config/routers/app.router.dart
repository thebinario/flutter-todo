import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/pages/setting/setting.controller.dart';
import 'package:todo/pages/setting/settings.view.dart';
import 'package:todo/pages/task/task_list.controller.dart';
import 'package:todo/pages/task/task_list.view.dart';
import 'package:todo/pages/task/widgets/create_task.view.dart';
import 'package:todo/shared/services/theme.service.dart';

/// The route configuration.
final GoRouter appRouters = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TaskListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'create-task',
          path: 'create-task',
          builder: (BuildContext context, GoRouterState state) {
            int index = 0;
            bool isEditing = false;

            if(state.uri.hasQuery){
              index = int.parse(state.uri.queryParameters['index']!);
              isEditing = bool.parse(state.uri.queryParameters['isEditing']!);
            }

            return CreateTask(index: index, isEditing: isEditing);
          },
        ),
        GoRoute(
          name: 'setting',
          path: 'setting',
          builder: (BuildContext context, GoRouterState state) {
            return Setting();
          },
        ),
      ],
    ),
  ],
);
