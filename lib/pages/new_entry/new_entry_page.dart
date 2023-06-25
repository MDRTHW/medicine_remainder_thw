import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_remainder_thw/constants.dart';
import 'package:medicine_remainder_thw/global_block.dart';
import 'package:medicine_remainder_thw/models/errors.dart';
import 'package:medicine_remainder_thw/pages/new_entry/new_entry_block.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/convert_time.dart';
import '../../models/medicine.dart';
import '../../models/medicine_type.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController _medicineNameController;
  late TextEditingController _dosageController;
  late NewEntryBlock _newEntryBlock;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _medicineNameController.dispose();
    _dosageController.dispose();
    _newEntryBlock.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _medicineNameController = TextEditingController();
    _dosageController = TextEditingController();
    _newEntryBlock = NewEntryBlock();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBlock _globalBlock = Provider.of<GlobalBlock>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Medicine'),
      ),
      body: Provider<NewEntryBlock>.value(
        value: _newEntryBlock,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PanelTittle(tittle: 'Medicine Name', isRequired: true),
              TextFormField(
                controller: _medicineNameController,
                maxLength: 12,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: kOtherColor),
              ),
              const PanelTittle(tittle: 'Dosage in mg', isRequired: false),
              TextFormField(
                controller: _dosageController,
                maxLength: 12,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: kOtherColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              const PanelTittle(tittle: 'Medicine type', isRequired: false),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: StreamBuilder<MedicineType>(
                  //new entry block
                  stream: _newEntryBlock.selectedMedicineType$,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MedicineTypeColumn(
                          medicineType: MedicineType.capsule,
                          medicineTypeName: 'Capsule',
                          medicineTypeIcon: 'assets/icons/capsule.svg',
                          isSelected: snapshot.data == MedicineType.capsule
                              ? true
                              : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.bottle,
                          medicineTypeName: 'Bottle',
                          medicineTypeIcon: 'assets/icons/bottle.svg',
                          isSelected: snapshot.data == MedicineType.bottle
                              ? true
                              : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.syringe,
                          medicineTypeName: 'Syringe',
                          medicineTypeIcon: 'assets/icons/syringe.svg',
                          isSelected: snapshot.data == MedicineType.syringe
                              ? true
                              : false,
                        ),
                        MedicineTypeColumn(
                          medicineType: MedicineType.tablet,
                          medicineTypeName: 'Tablet',
                          medicineTypeIcon: 'assets/icons/tablet.svg',
                          isSelected: snapshot.data == MedicineType.tablet
                              ? true
                              : false,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const PanelTittle(tittle: 'Interval Selection', isRequired: true),
              const IntervalSelection(),
              const PanelTittle(tittle: 'Start time', isRequired: true),
              const SelectTime(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: SizedBox(
                  width: 80.w,
                  height: 8.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: kPrimaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: kScaffoldColor),
                      ),
                    ),
                    onPressed: () {
                      //add medicine
                      //some validations
                      //go to success screen
                      String? _medicineName;
                      int? _dosage;
                      if (_medicineNameController.text == '') {
                        _newEntryBlock.submiteError(EntryError.nameNull);
                        return;
                      }
                      if (_medicineNameController.text != '') {
                        _medicineName = _medicineNameController.text;
                      }

                      if (_dosageController.text == '') {
                        _dosage = 0;
                      }
                      if (_dosageController.text != '') {
                        _dosage = int.parse(_dosageController.text);
                      }

                      for (var medicine in _globalBlock.medicineList$!.value) {
                        if (medicine.medicineName == _medicineName) {
                          _newEntryBlock.submiteError(EntryError.nameDuplicate);
                          return;
                        }
                      }

                      if (_newEntryBlock.selecedtinterval$!.value == 0) {
                        _newEntryBlock.submiteError(EntryError.interval);
                        return;
                      }
                      if (_newEntryBlock.selectedTimeOfDay$!.value == 'none') {
                        _newEntryBlock.submiteError(EntryError.startTime);
                        return;
                      }
                      String _medicineType = _newEntryBlock
                          .selectedMedicineType$!.value
                          .toString()
                          .substring(13);
                      int _interval =
                          _newEntryBlock.selecedtinterval$!.value.toInt();
                      String _startTime =
                          _newEntryBlock.selectedTimeOfDay$!.value;
                      List<int> intIDs =
                          makeIDs(24 / _newEntryBlock.selecedtinterval$!.value);
                      List<String> notificationIds =
                          intIDs.map((i) => i.toString()).toList();
                      // to be continue...
                      Medicine _newEntryMedicine = Medicine(
                        medicineName: _medicineName,
                        dosage: _dosage,
                        medicineType: _medicineType,
                        interval: _interval,
                        startTime: _startTime,
                        notificationIds: notificationIds,
                      );

                      //update medicine list via global block
                      _globalBlock.updateMedicineList(_newEntryMedicine);

                      //schedule notification

                      // got to success screen
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;

        //update state via provider
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: kPrimaryColor,
          ),
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? 'Select time'
                  : '${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: kScaffoldColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me every',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: kTextColor,
                ),
          ),
          DropdownButton(
            iconEnabledColor: kOtherColor,
            dropdownColor: kScaffoldColor,
            itemHeight: 8.h,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            hint: _selected == 0
                ? Text(
                    'Select an interval',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: kPrimaryColor,
                        ),
                  )
                : null,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(() {
                _selected = newVal!;
              });
              //select interval
            },
          ),
          Text(
            _selected == 1 ? 'hour' : 'hours',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: kTextColor,
                ),
          ),
        ],
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn(
      {Key? key,
      required this.medicineTypeName,
      required this.medicineTypeIcon,
      required this.isSelected,
      required this.medicineType})
      : super(key: key);

  final MedicineType medicineType;
  final String medicineTypeName;
  final String medicineTypeIcon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final NewEntryBlock newEntryBlock = Provider.of<NewEntryBlock>(context);
    return GestureDetector(
      onTap: () {
        //select medicine type
        //create a new block for selecting and adding new entry
        newEntryBlock.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.h),
              color: isSelected ? kOtherColor : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 1.h,
                ),
                child: SvgPicture.asset(
                  medicineTypeIcon,
                  height: 6.h,
                  width: 6.w,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? kOtherColor : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  medicineTypeName,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: isSelected ? Colors.white : kOtherColor,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTittle extends StatelessWidget {
  const PanelTittle({Key? key, required this.tittle, required this.isRequired})
      : super(key: key);

  final String tittle;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: tittle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            TextSpan(
              text: isRequired ? '*' : "",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: kPrimaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
