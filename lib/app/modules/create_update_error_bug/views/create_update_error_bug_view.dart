import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_update_error_bug_controller.dart';

class CreateUpdateErrorBugView extends GetView<CreateUpdateErrorBugController> {
  const CreateUpdateErrorBugView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateUpdateErrorBugView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreateUpdateErrorBugView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
