class PayslipData {
  final double basicSalary;
  final double perDaySalary;
  final double perHourSalary;

  final double normalOTHours;
  final double holidayOTHours;

  final double normalOTPayment;
  final double holidayOTPayment;

  final double normalOTTotal;
  final double holidayOTTotal;

  final double allowance;

  final double absentDays;
  final double absentDaysAmount;

  final double advance;
  final double airTicket;
  final double halfDay;

  final double otherPaymentsTotal;
  final String otherPaymentsRemarks;

  final double otherDeductionsTotal;
  final String otherDeductionsRemarks;

  final double totalDeductions;
  final double totalEarnings;
  final double netPayable;

  final String? signatureStatus;
  final String? receiptStatus;
  final String? downloadUrl;

  PayslipData({
    required this.basicSalary,
    required this.perDaySalary,
    required this.perHourSalary,
    required this.normalOTHours,
    required this.holidayOTHours,
    required this.normalOTPayment,
    required this.holidayOTPayment,
    required this.normalOTTotal,
    required this.holidayOTTotal,
    required this.allowance,
    required this.absentDays,
    required this.absentDaysAmount,
    required this.advance,
    required this.airTicket,
    required this.halfDay,
    required this.otherPaymentsTotal,
    required this.otherPaymentsRemarks,
    required this.otherDeductionsTotal,
    required this.otherDeductionsRemarks,
    required this.totalDeductions,
    required this.totalEarnings,
    required this.netPayable,
    this.signatureStatus,
    this.receiptStatus,
    this.downloadUrl,

  });

  factory PayslipData.fromJson(Map<String, dynamic> json) {
    double _toDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is int) return v.toDouble();
      if (v is double) return v;
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return PayslipData(
      basicSalary: _toDouble(json["basicSalary"]),
      perDaySalary: _toDouble(json["perDaySalary"]),
      perHourSalary: _toDouble(json["perHourSalary"]),
      normalOTHours: _toDouble(json["normalOTHours"]),
      holidayOTHours: _toDouble(json["holidayOTHours"]),
      normalOTPayment: _toDouble(json["normalOTPayment"]),
      holidayOTPayment: _toDouble(json["holidayOTPayment"]),
      normalOTTotal: _toDouble(json["normalOTTotal"]),
      holidayOTTotal: _toDouble(json["holidayOTTotal"]),
      allowance: _toDouble(json["allowance"]),
      absentDays: _toDouble(json["absentDays"]),
      absentDaysAmount: _toDouble(json["absentDaysAmount"]),
      advance: _toDouble(json["advance"]),
      airTicket: _toDouble(json["airTicket"]),
      halfDay: _toDouble(json["halfDay"]),
      otherPaymentsTotal: _toDouble(json["otherPaymentsTotal"]),
      otherPaymentsRemarks: (json["otherPaymentsRemarks"] ?? "").toString(),
      otherDeductionsTotal: _toDouble(json["otherDeductionsTotal"]),
      otherDeductionsRemarks: (json["otherDeductionsRemarks"] ?? "").toString(),
      totalDeductions: _toDouble(json["totalDeductions"]),
      totalEarnings: _toDouble(json["totalEarnings"]),
      netPayable: _toDouble(json["netPayable"]),

      signatureStatus: json["signatureStatus"],
      receiptStatus: json["receiptStatus"],
      downloadUrl: json["downloadUrl"],
    );
  }
}
