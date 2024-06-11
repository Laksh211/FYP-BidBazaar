import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/complaintController.dart';

class ComplaintScreen extends StatelessWidget {
  final List<DropdownMenuItem> reasons = List<DropdownMenuItem>.of([]);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintController());

    RxString selectedReason = "Other".obs;
    reasons.add(
      const DropdownMenuItem(
        value: "Product not as described",
        child: Text("Product not as described"),
      ),
    );

    reasons.add(
      const DropdownMenuItem(
        value: "Late delivery",
        child: Text("Late delivery"),
      ),
    );
    reasons.add(
      const DropdownMenuItem(
        value: "Wrong item delivered",
        child: Text("Wrong item delivered"),
      ),
    );
    reasons.add(
      const DropdownMenuItem(
        value: "Other",
        child: Text("Other"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Complaint"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reason for Complaint',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => DropdownButton(
                  value: selectedReason.value,
                  items: reasons,
                  onChanged: (newValue) {
                    selectedReason.value = newValue!;
                  },
                  // validator: (value) =>
                  //     value == null ? 'Please select a reason' : null,
                  // decoration: const InputDecoration(
                  //   border: OutlineInputBorder(),
                  //   hintText: 'Select a reason',
                  // ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Complaint Explanation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: controller.complaintController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your complaint here...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your complaint';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.complaint(reason: selectedReason.value);
                      Get.snackbar('Success', 'Submitting your complaint',
                        snackPosition: SnackPosition.TOP);
                    controller.complaintController.clear();
                    selectedReason.value = "Other";
                  }
                },
                child: const Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
