import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/farmer.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/riceCrop.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/scheduleIrrigation.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/services/scheduleIrrigationService.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/view/irrigationView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AgregateIrrigation extends StatefulWidget {
  RiceCrop riceCrop;
  Scheduleirrigation? updateIrrigation;
  Farmer farmer;
  Account account;
  AgregateIrrigation(this.riceCrop, this.updateIrrigation, this.farmer, this.account, {super.key});

  @override
  _AgregateIrrigationState createState() => _AgregateIrrigationState();
}

class _AgregateIrrigationState extends State<AgregateIrrigation> {
  TextEditingController name = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController dateIrrigation = TextEditingController();
  TextEditingController hourIrrigation = TextEditingController();
  Scheduleirrigation? scheduleirrigation;
  Scheduleirrigation? scheduleirrigationCreate;
  Scheduleirrigationservice? scheduleirrigationservice;
  @override
  void initState() {
    scheduleirrigationservice = Scheduleirrigationservice();
    isUpdate();
    super.initState();
  }

  Future agregateIrrigation() async {
    DateTime selectedDate = DateTime.parse(dateIrrigation.text);
    DateFormat inputFormat = DateFormat("h:mm a");

    DateTime dateTimes = inputFormat.parse(hourIrrigation.text.trim());
    int hour = dateTimes.hour;
    int minute = dateTimes.minute;

    TimeOfDay selectedTime = TimeOfDay(hour: hour, minute: minute);

    DateTime irrigationDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    String formattedIrrigationDate = irrigationDateTime.toIso8601String();
    scheduleirrigationCreate = Scheduleirrigation(
        id: widget.updateIrrigation?.id,
        irrigationDate: formattedIrrigationDate,
        irrigationTime: double.parse(dateTime.text),
        status: widget.updateIrrigation?.status,
        name: name.text,
        riceCropId: widget.riceCrop.id);
    if (widget.updateIrrigation != null) {
      scheduleirrigation = await scheduleirrigationservice?.UpdateIrrigation(
          scheduleirrigationCreate!);
    } else {
      scheduleirrigation = await scheduleirrigationservice?.CreateIrrigation(
          scheduleirrigationCreate!);
    }
    setState(() {
      scheduleirrigation = scheduleirrigation;

      if (scheduleirrigation != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IrrigationView(widget.riceCrop, widget.farmer, widget.account),
        ));
      }
    });
  }

  Future<void> isUpdate() async {
    if (widget.updateIrrigation != null) {
      name.text = widget.updateIrrigation!.name!;
      dateTime.text = widget.updateIrrigation!.irrigationTime.toString();
      dateIrrigation.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.updateIrrigation!.irrigationDate!));
      hourIrrigation.text = DateFormat('h:mm a')
          .format(DateTime.parse(widget.updateIrrigation!.irrigationDate!));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateIrrigation.text =
            picked.toString().split(' ')[0]; // Formatea la fecha
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        hourIrrigation.text = picked.format(context); // Formatea la hora
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Add Irrigation Schedule',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Center(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                    child: Text(
                      'Irrigation Name',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF635C5C),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                    child: Text(
                      'Time (minutes)',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: dateTime,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF635C5C),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                    child: Text(
                      'Irrigation Date',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: dateIrrigation,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF635C5C),
                        ),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today_outlined),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                    child: Text(
                      'Irrigation Hour',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: hourIrrigation,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF635C5C),
                        ),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () => _selectTime(context),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/shedule-irrigation.png'),
                  ),
                  Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          agregateIrrigation();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF297739),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 60),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Bordes redondeados
                            ),
                          ),
                        ),
                        child: Text(
                          widget.updateIrrigation != null ? 'Update' : 'Save' ,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        });
  }
}
