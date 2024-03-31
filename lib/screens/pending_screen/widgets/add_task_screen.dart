import 'package:flutter/material.dart';
import '../../../blocs/bloc_exports.dart';
import 'package:taskapp/models/task.dart';
import '../../../services/guid_gen.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    final dateController = MaskedTextController(mask: '00.00.0000');
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Add Task',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TextField(
            onTap: () {
              _selectDate(context, dateController); // Call function to open calendar
            },
            controller: dateController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Date'),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        TextField(
          autofocus: true,
          controller: descriptionController,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            label: Text('Description'),
            border: OutlineInputBorder(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                var task = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  id: GUIDGen.generate(),
                  date: dateController.text,
                );
                context.read<TasksBloc>().add(AddTask(task: task));
                context
                    .read<TasksBloc>()
                    .add(GetTodayTasks(date: dateController.text));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ]),
    );
  }

  // Function to open calendar and select date
  Future<void> _selectDate(BuildContext context, MaskedTextController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateController.text) {
      dateController.text = '${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}';
    }
  }
}
