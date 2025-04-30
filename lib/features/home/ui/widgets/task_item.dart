import 'package:daily_app/core/theming/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskItem extends StatefulWidget {
  TaskItem(
      {super.key,
      required this.task,
      required this.onPressed,
      required this.pushPadge,
      required this.icon,
      this.opacity = 1}); 
  final TodoModel task;
  Function() onPressed;
  String pushPadge;
  Icon icon;
  double opacity;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class TodoModel {
  String title;
  String subTitle;
  String date;
  int color;

  TodoModel({
    required this.title,
    required this.subTitle,
    required this.date,
    required this.color,
  });
}

class _TaskItemState extends State<TaskItem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.pushPadge, arguments: widget.task);
      },
      child: Opacity(
        opacity: widget.opacity,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.only(right: 16, left: 5),
          height: 140,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(widget.task.color),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isCompleted = !isCompleted;
                        });
                      },
                      icon: Icon(
                        isCompleted
                            ? Icons.check_box
                            : Icons.check_box_outline_blank_outlined,
                        size: 30,
                        color: Colors.black,
                      )),
                  Expanded(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 1),
                        child: Text(
                          widget.task.title,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.black,
                              decorationThickness: 2),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: Text(
                          widget.task.subTitle,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.black.withOpacity(0.5),
                              decorationThickness: 1.5),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: widget.onPressed,
                        icon: widget.icon,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  widget.task.date,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
