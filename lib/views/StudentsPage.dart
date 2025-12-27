import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';
import '../models/attendance_model.dart';

class StudentsPage extends StatelessWidget {
  final List<AttendanceModel> students;
  final String sessionId;

  const StudentsPage({
    super.key,
    required this.students,
    required this.sessionId,
  });

  String getSessionLink() {
    switch (sessionId) {
      case "Mobile_programming":
        return "https://docs.google.com/spreadsheets/d/1dOZ0o847up-LyXTESZtm7HOncdDq7C7N2-t7I7GjTs4/edit?gid=1763640481#gid=1763640481";
      case "IoT_Programmin":
        return "https://docs.google.com/spreadsheets/d/1dOZ0o847up-LyXTESZtm7HOncdDq7C7N2-t7I7GjTs4/edit?gid=37429216#gid=37429216";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionLink = getSessionLink();

    return Scaffold(
      appBar: AppBar(
        title: const Text("قائمة الحضور"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text(
              "رابط المادة",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                if (sessionLink.isNotEmpty) {
                  _launchURL(sessionLink);
                }
              },
              child: Text(
                sessionLink.isEmpty ? "لا يوجد لينك" : sessionLink,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 20),

            
            Expanded(
              child: students.isEmpty
                  ? const Center(
                      child: Text(
                        "لا يوجد حضور بعد",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(
                            Colors.blueAccent,
                          ),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          dataRowHeight: 60,
                          columns: const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Code')),
                            DataColumn(label: Text('Time')),
                          ],
                          rows: students
                              .map(
                                (s) => DataRow(
                                  cells: [
                                    DataCell(Text(s.name)),
                                    DataCell(Text(s.id)),
                                    DataCell(Text(s.time)),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// فتح الرابط في المتصفح الخارجي
  Future<void> _launchURL(String urlString) async {
    if (urlString.isEmpty) return;

    try {
      bool launched = await launchUrlString(
        urlString,
        mode: LaunchMode.externalApplication, // يفتح المتصفح الخارجي
      );
      if (!launched) {
        print("لا يمكن فتح الرابط");
      }
    } catch (e) {
      print("حدث خطأ أثناء فتح الرابط: $e");
    }
  }
}
