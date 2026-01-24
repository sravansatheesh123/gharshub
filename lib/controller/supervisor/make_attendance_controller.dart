import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/supervisor/attendance_log_model.dart';
import '../../models/supervisor/technician_model.dart';
import '../../services/supervisor/AttendanceService.dart';

class MakeAttendanceController extends GetxController {
  RxBool isLoading = false.obs;
  RxString error = "".obs;

  RxList<TechnicianModel> technicians = <TechnicianModel>[].obs;
  RxList<AttendanceLogModel> logs = <AttendanceLogModel>[].obs;

  RxSet<String> selectedUserIds = <String>{}.obs;

  RxString selectedDate = "".obs; // YYYY-MM-DD
  RxString selectedDateUi = "".obs; // MM/DD/YYYY

  @override
  void onInit() {
    super.onInit();

    final today = DateTime.now();

    selectedDate.value =
    "${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    selectedDateUi.value =
    "${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}/${today.year}";

    fetchAll(date: selectedDate.value);
  }

  int get selectedCount => selectedUserIds.length;
  bool get hasSelection => selectedUserIds.isNotEmpty;

  void _printJson(String title, dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent("  ");
      print("🟦 $title =>\n${encoder.convert(data)}");
    } catch (e) {
      print("❌ JSON PRINT ERROR => $e");
      print("🟥 RAW => $data");
    }
  }

  Future<void> fetchAll({required String date}) async {
    try {
      isLoading.value = true;
      error.value = "";

      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      print("📌 FETCH ALL STARTED FOR DATE => $date");
      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

      // TECH LIST
      final techRes = await AttendanceService.getTechnicians();
      technicians.assignAll(techRes);

      // LOG LIST
      final logRes = await AttendanceService.getAttendanceLogs(date: date);
      logs.assignAll(logRes);

      // Web behavior: do not auto select all
      selectedUserIds.clear();

      print("✅ TECH COUNT => ${technicians.length}");
      _printJson(
        "✅ TECH LIST (PARSED)",
        technicians
            .map((e) => {
          "id": e.id,
          "name": e.name,
          "employeeId": e.employeeId,
          "project": e.project,
          "projectId": e.projectId,
        })
            .toList(),
      );

      print("✅ LOG COUNT => ${logs.length}");
      _printJson(
        "✅ LOG LIST (PARSED)",
        logs
            .map((e) => {
          "id": e.id,
          "date": e.date,
          "userId": e.user.id,
          "name": e.user.name,
          "employeeId": e.user.employeeId,
          "inTime": e.inTime,
          "outTime": e.outTime,
          "displayInTime": e.displayInTime,
          "displayOutTime": e.displayOutTime,
          "status": e.status,
        })
            .toList(),
      );

      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      print("📌 FETCH ALL COMPLETED");
      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    } catch (e) {
      error.value = e.toString().replaceAll("Exception:", "").trim();
      print("❌ MAKE ATTENDANCE ERROR => ${error.value}");
    } finally {
      isLoading.value = false;
    }
  }

  AttendanceLogModel? getLogForUser(String userId) {
    try {
      return logs.firstWhere((e) => e.user.id == userId);
    } catch (_) {
      return null;
    }
  }

  void toggleSelection(String userId, bool isSelected) {
    if (isSelected) {
      selectedUserIds.add(userId);
    } else {
      selectedUserIds.remove(userId);
    }

    print("🟩 SELECTED USERS => ${selectedUserIds.toList()}");
    print("🟩 SELECTED COUNT => ${selectedUserIds.length}");
  }

  bool isSelected(String userId) {
    return selectedUserIds.contains(userId);
  }

  void selectAll() {
    selectedUserIds.clear();
    for (final t in technicians) {
      selectedUserIds.add(t.id);
    }
    print("🟩 SELECT ALL => ${selectedUserIds.toList()}");
  }

  void deselectAll() {
    selectedUserIds.clear();
    print("🟩 DESELECT ALL");
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value =
      "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      selectedDateUi.value =
      "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";

      print("📅 DATE PICKED => ${selectedDate.value}");
      print("📅 DATE UI => ${selectedDateUi.value}");
    }
  }

  Future<void> applyDate() async {
    print("📌 APPLY CLICKED => ${selectedDate.value}");
    await fetchAll(date: selectedDate.value);
  }

  String _nowTimeHHMM() {
    final now = DateTime.now();
    final hh = now.hour.toString().padLeft(2, '0');
    final mm = now.minute.toString().padLeft(2, '0');
    return "$hh:$mm";
  }

  bool _hasPunchIn(String userId) {
    final log = getLogForUser(userId);
    final inTime = log?.inTime;
    return inTime != null && inTime.toString().trim().isNotEmpty;
  }

  bool _hasPunchOut(String userId) {
    final log = getLogForUser(userId);
    final outTime = log?.outTime;
    return outTime != null && outTime.toString().trim().isNotEmpty;
  }

  List<String> _alreadyPunchedInIds(List<String> ids) {
    return ids.where((id) => _hasPunchIn(id)).toList();
  }

  List<String> _alreadyPunchedOutIds(List<String> ids) {
    return ids.where((id) => _hasPunchOut(id)).toList();
  }

  void _printSelectionStatus(List<String> ids) {
    final list = ids.map((id) {
      final tech = technicians.firstWhereOrNull((t) => t.id == id);
      print(
          "👤 EDIT REQUEST USER => $id | TECH FOUND => ${tech != null} | NAME => ${tech?.name}");

      final log = getLogForUser(id);

      return {
        "userId": id,
        "userIdType": id.runtimeType.toString(),
        "name": tech?.name ?? "",
        "employeeId": tech?.employeeId ?? "",
        "inTime": log?.inTime ?? "",
        "outTime": log?.outTime ?? "",
        "displayInTime": log?.displayInTime ?? "",
        "displayOutTime": log?.displayOutTime ?? "",
      };
    }).toList();

    _printJson("🟩 SELECTED EMPLOYEE STATUS", list);
  }
  Future<void> showPunchInPopup(BuildContext context) async {
    String selectedTime = _nowTimeHHMM();

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              actionsPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Punch In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Get.back();
                          await showEditPunchInPopup(context);
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Punching $selectedCount selected employee(s) as Site Supervisor",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      await pickDate(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedDateUi.value),
                          const Icon(Icons.calendar_month_outlined, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedTime = _nowTimeHHMM();
                          });
                        },
                        child: const Text(
                          "Set to Current Time",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        final hh = picked.hour.toString().padLeft(2, '0');
                        final mm = picked.minute.toString().padLeft(2, '0');
                        setState(() {
                          selectedTime = "$hh:$mm";
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(selectedTime),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "24-hour format only (e.g., 09:00, 13:30, 17:45)",
                    style: TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        final ids = selectedUserIds.toList();

                        print("🟩 PUNCH IN CLICKED");
                        print("🟩 SELECTED IDS => $ids");
                        print("🟩 IDS TYPE => ${ids.runtimeType}");
                        if (ids.isNotEmpty) {
                          print("🟩 FIRST ID TYPE => ${ids.first.runtimeType}");
                        }

                        if (ids.isEmpty) {
                          Get.snackbar("Error", "Please select employees");
                          return;
                        }

                        _printSelectionStatus(ids);

                        final alreadyIn = _alreadyPunchedInIds(ids);
                        if (alreadyIn.isNotEmpty) {
                          Get.snackbar(
                            "Already Punch In",
                            "${alreadyIn.length} employee(s) already punched in today",
                          );
                          return;
                        }

                        try {
                          final res = await AttendanceService.bulkManualPunch(
                            employeeIds: ids,
                            action: "in",
                            manualTime: selectedTime,
                            date: selectedDate.value,
                          );

                          Get.back();
                          Get.snackbar("Success",
                              res["message"] ?? "Punch In completed");

                          await fetchAll(date: selectedDate.value);
                        } catch (e) {
                          Get.snackbar("Failed", e.toString());
                        }
                      },
                      child: const Text("Punch In"),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showEditPunchInPopup(BuildContext context) async {
    String selectedTime = _nowTimeHHMM();
    final TextEditingController reasonController = TextEditingController(
      text: "Employee forgot to punch in/out",
    );

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              actionsPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Edit Punch In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Editing $selectedCount selected employee(s) as Site Supervisor",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      await pickDate(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedDateUi.value),
                          const Icon(Icons.calendar_month_outlined, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedTime = _nowTimeHHMM();
                          });
                        },
                        child: const Text(
                          "Set to Current Time",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        final hh = picked.hour.toString().padLeft(2, '0');
                        final mm = picked.minute.toString().padLeft(2, '0');
                        setState(() {
                          selectedTime = "$hh:$mm";
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(selectedTime),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Reason",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: reasonController,
                    decoration: InputDecoration(
                      hintText: "Enter reason",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        final ids = selectedUserIds.toList();

                        print("🟩 EDIT PUNCH IN CLICKED");
                        print("🟩 SELECTED IDS => $ids");

                        if (ids.isEmpty) {
                          Get.snackbar("Error", "Please select employees");
                          return;
                        }

                        _printSelectionStatus(ids);

                        try {
                          Map<String, dynamic>? lastResponse;

                          for (final userId in ids) {
                            print("🟩 SENDING EDIT FOR USER => $userId");

                            lastResponse = await AttendanceService.editPunch(
                              employeeId: userId,
                              date: selectedDate.value,
                              inTime: selectedTime,
                              reason: reasonController.text.trim().isEmpty
                                  ? "Employee forgot to punch in/out"
                                  : reasonController.text.trim(),
                            );
                          }

                          Get.back();

                          Get.snackbar(
                            "Success",
                            lastResponse?["message"] ??
                                "Punch edit request submitted for HR approval",
                          );

                          await fetchAll(date: selectedDate.value);
                        } catch (e) {
                          Get.snackbar("Failed", e.toString());
                        }
                      },
                      child: const Text("OK"),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showPunchOutPopup(BuildContext context) async {
    String selectedTime = _nowTimeHHMM();

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              actionsPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Punch Out",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Punching $selectedCount selected employee(s) as Site Supervisor",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      await pickDate(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedDateUi.value),
                          const Icon(Icons.calendar_month_outlined, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedTime = _nowTimeHHMM();
                          });
                        },
                        child: const Text(
                          "Set to Current Time",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        final hh = picked.hour.toString().padLeft(2, '0');
                        final mm = picked.minute.toString().padLeft(2, '0');
                        setState(() {
                          selectedTime = "$hh:$mm";
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(selectedTime),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        final ids = selectedUserIds.toList();

                        print("🟩 PUNCH OUT CLICKED");
                        print("🟩 SELECTED IDS => $ids");

                        if (ids.isEmpty) {
                          Get.snackbar("Error", "Please select employees");
                          return;
                        }

                        _printSelectionStatus(ids);

                        final noIn = ids.where((id) => !_hasPunchIn(id)).toList();
                        if (noIn.isNotEmpty) {
                          Get.snackbar(
                            "Punch In Missing",
                            "${noIn.length} employee(s) not punched in yet",
                          );
                          return;
                        }

                        final alreadyOut = _alreadyPunchedOutIds(ids);
                        if (alreadyOut.isNotEmpty) {
                          Get.snackbar(
                            "Already Punch Out",
                            "${alreadyOut.length} employee(s) already punched out today",
                          );
                          return;
                        }

                        try {
                          final res = await AttendanceService.bulkManualPunch(
                            employeeIds: ids,
                            action: "out",
                            manualTime: selectedTime,
                            date: selectedDate.value,
                          );

                          Get.back();
                          Get.snackbar("Success",
                              res["message"] ?? "Punch Out completed");

                          await fetchAll(date: selectedDate.value);
                        } catch (e) {
                          Get.snackbar("Failed", e.toString());
                        }
                      },
                      child: const Text("Punch Out"),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
