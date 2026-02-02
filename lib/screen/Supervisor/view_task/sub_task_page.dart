import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/controller/supervisor/view_task_controller.dart';

class SubTaskPage extends StatefulWidget {
  const SubTaskPage({super.key, this.projectId});
  final projectId;

  @override
  State<SubTaskPage> createState() => _SubTaskPageState();
}

class _SubTaskPageState extends State<SubTaskPage> {
  @override
  Widget build(BuildContext context) {
    final spv_ViewTaskController = Get.put(SPV_ViewTaskController());
    @override
    void initState() {
      spv_ViewTaskController.viewTask(widget.projectId);
      // TODO: implement initState
      super.initState();
    }

    return const Scaffold();
  }
}
