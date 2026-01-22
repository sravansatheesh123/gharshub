import 'package:flutter/material.dart';

class SalarySlipUI extends StatelessWidget {
  const SalarySlipUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salary Slip"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(130),
            border: TableBorder.all(color: Colors.black, width: 1),
            children: [
              /// HEADER
              TableRow(
                children: [
                  headerCell("Details of Pay", color: Colors.blueGrey),
                  headerCell("", color: Colors.blueGrey),
                  headerCell("Salary Payable", color: Colors.brown),
                  headerCell("", color: Colors.brown),
                  headerCell("", color: Colors.brown),
                ],
              ),

              tableRow(
                "Basic Salary",
                "1200.00",
                "Normal Hour",
                "184",
                "1200.00",
              ),
              tableRow(
                "Per day Salary",
                "39.45",
                "Normal OT Hour",
                "23",
                "141.78",
              ),
              tableRow(
                "Per Hour",
                "4.93",
                "Holidays OT Per Hour",
                "6",
                "44.38",
              ),
              tableRow("Normal OT Per Hour", "6.16", "", "", ""),
              tableRow("Holidays OT Per Hour", "7.40", "", "", ""),

              /// TOTAL ROW
              TableRow(
                children: [
                  totalCell("TOTAL"),
                  totalCell(""),
                  totalCell(""),
                  totalCell(""),
                  totalCell("1386.16"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- WIDGET HELPERS ----------

  TableRow tableRow(String c1, String c2, String c3, String c4, String c5) {
    return TableRow(
      children: [cell(c1), cell(c2), cell(c3), cell(c4), cell(c5)],
    );
  }

  Widget cell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget headerCell(String text, {required Color color}) {
    return Container(
      height: 45,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget totalCell(String text) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      color: Colors.grey.shade300,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
