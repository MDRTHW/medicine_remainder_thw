import 'package:rxdart/rxdart.dart';

import '../../models/errors.dart';
import '../../models/medicine_type.dart';

class NewEntryBlock {
  BehaviorSubject<MedicineType>? _selectedMedicineType$;
  ValueStream<MedicineType>? get selectedMedicineType$ =>
      _selectedMedicineType$!.stream;

  BehaviorSubject<int>? _selectedinterval$;
  BehaviorSubject<int>? get selecedtinterval$ => _selectedinterval$;

  BehaviorSubject<String>? _selectedTimeOfDay$;
  BehaviorSubject<String>? get selectedTimeOfDay$ => _selectedTimeOfDay$;

  //errorstate
  BehaviorSubject<EntryError>? _errorState$;
  BehaviorSubject<EntryError>? get errorState$ => _errorState$;

  NewEntryBlock() {
    _selectedMedicineType$ =
        BehaviorSubject<MedicineType>.seeded(MedicineType.none);
    _selectedinterval$ = BehaviorSubject<int>.seeded(0);
    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded('none');
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {
    _selectedMedicineType$!.close();
    _selectedinterval$!.close();
    _selectedTimeOfDay$!.close();
    _errorState$!.close();
  }

  void submiteError(EntryError error) {
    _errorState$!.add(error);
  }

  void updateInterval(int interval) {
    _selectedinterval$!.add(interval);
  }

  void updateTimeOfDay(String time) {
    _selectedTimeOfDay$!.add(time);
  }

  void updateSelectedMedicine(MedicineType type) {
    MedicineType _tempType = _selectedMedicineType$!.value;
    if (_tempType == type) {
      _selectedMedicineType$!.add(MedicineType.none);
    } else {
      _selectedMedicineType$!.add(type);
    }
  }
}
