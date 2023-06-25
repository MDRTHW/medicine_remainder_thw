class Medicine {
  final List<dynamic>? notificationIds;
  final String? medicineName;
  final int? dosage;
  final String? medicineType;
  final String? startTime;
  final int? interval;

  Medicine({
    this.notificationIds,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.startTime,
    this.interval,
  });

  //getters
  List<dynamic>? get getNotificationIds => notificationIds!;
  String? get getMedicineName => medicineName!;
  int? get getDosage => dosage!;
  String? get getMedicineType => medicineType!;
  String? get getStartTime => startTime!;
  int? get getInterval => interval!;

  Map<String, dynamic> toJson() {
    return {
      'notificationIds': notificationIds,
      'medicineName': medicineName,
      'dosage': dosage,
      'medicineType': medicineType,
      'startTime': startTime,
      'interval': interval,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      notificationIds: parsedJson['notificationIds'],
      medicineName: parsedJson['medicineName'],
      dosage: parsedJson['dosage'],
      medicineType: parsedJson['medicineType'],
      startTime: parsedJson['startTime'],
      interval: parsedJson['interval'],
    );
  }
}
