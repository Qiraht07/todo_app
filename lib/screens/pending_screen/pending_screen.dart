import 'package:flutter/material.dart';
import 'package:taskapp/models/date_model.dart';
import 'package:taskapp/services/date_getter.dart';
import 'package:taskapp/screens/pending_screen/widgets/carousel/carousel.dart';
import 'package:taskapp/widgets/tasks_list.dart';

import '../../blocs/bloc_exports.dart';
import 'package:taskapp/models/task.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    List<DateModel> week = Date.getWeekDates();
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTasks;
        return Column(
          children: [
            const SizedBox(height: 30,),
            Stack(
              children: [
                Positioned(
                  child: Carousel(
                    categories: week,
                    onCategoryChanged: (value){
                      context.read<TasksBloc>().add(GetTodayTasks(date: week[value].fullDate));
                    },
                    current: Date.currentWeekday - 1,
                  ),
                ),
              ],
            ),
            Center(
              child: Chip(
                label: Text(
                  '${tasksList.length} Pending | ${state.completedTasks.length} Completed',
                ),
              ),
            ),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}


// pending_tasks_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:taskapp/widgets/tasks_list.dart';
// import 'package:taskapp/blocs/bloc_exports.dart';
// import 'package:taskapp/screens/pending_screen/widgets/carousel/image_urls.dart';
// import 'package:taskapp/models/task.dart';
//
// class PendingTasksScreen extends StatelessWidget {
//   const PendingTasksScreen({Key? key}) : super(key: key);
//   static const id = 'tasks_screen';
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TasksBloc, TasksState>(
//       builder: (context, state) {
//         List<Task> tasksList = state.pendingTasks;
//         List<String> imageUrls = state.imageUrls; // assuming you have a list of image URLs in your TasksState
//         return Column(
//           children: [
//             const SizedBox(height: 30,),
//             Stack(
//               children: [
//                 Positioned(
//                   child: ImageUrls(imageUrls: imageUrls), // Use the ImageUrls widget instead of Carousel
//                 ),
//               ],
//             ),
//             Center(
//               child: Chip(
//                 label: Text(
//                   '${tasksList.length} Pending | ${state.completedTasks.length} Completed',
//                 ),
//               ),
//             ),
//             TasksList(tasksList: tasksList)
//           ],
//         );
//       },
//     );
//   }
// }
