import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/medicine.dart';

class GlobalBlock {
  BehaviorSubject<List<Medicine>>? _medicineList$;

  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;

  GlobalBlock() {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicineList();
  }

  Future updateMedicineList(Medicine newMedicine) async {
    var blockList = _medicineList$!.value;
    blockList.add(newMedicine);
    _medicineList$!.add(blockList);

    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
      sharedUser.setStringList('medicines', medicineJsonList);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicineJson);

    }
    else{
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicineJson);

    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future makeMedicineList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];
    if (jsonList == null) {
    } else {
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      //state update
      _medicineList$!.add(prefList);
    }
  }

  void dispose() {
    _medicineList$!.close();
  }
}
