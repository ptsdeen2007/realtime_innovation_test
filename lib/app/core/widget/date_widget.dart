import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_innovations_test/app/core/AppColor.dart';
import 'package:realtime_innovations_test/app/core/widget/cancel_button.dart';
import 'package:realtime_innovations_test/app/core/widget/day_label.dart';
import 'package:realtime_innovations_test/app/core/widget/save_button.dart';
import 'package:realtime_innovations_test/app/modules/employee/controllers/employee_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

DateFormat shortDate=DateFormat("d MMM yyy");
DateFormat weekName=DateFormat("EEEE");
class DateWidget extends StatefulWidget {
  final bool isFromDate;
  const DateWidget({Key? key,required this.isFromDate}) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {

  DateTime? _selectedDay;

  DateTime? _focusedDay;
  var employeeController = Get.find<EmployeeController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var today=DateTime.now();
    var nextDay = DateTime.now().add(Duration(days: 1));
    var dayAfterTomorrow=nextDay.add(Duration(days: 1));
    var afterOneWeek=DateTime.now().add(Duration(days: 7));
    return Container(
      child: Container(
        height: Get.height*.74,
        color: Colors.white,
        width: Get.width*.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 16,),
           if(widget.isFromDate)...[
             Row(
               children: [
               DayLabel(text: "Today",isSelected: isSameDay(_selectedDay, today),onTap: (){
                 setState(() {
                 _selectedDay=DateTime.now();
                 });
               },),
               DayLabel(text: "Next ${weekName.format(nextDay)}",isSelected:  isSameDay(_selectedDay, nextDay),onTap: (){
                 setState(() {
                 _selectedDay=nextDay;
                 });
               },),
             ],),
             Row(children: [
               DayLabel(text: "Next ${weekName.format(dayAfterTomorrow)}",isSelected:  isSameDay(_selectedDay, dayAfterTomorrow),onTap: (){
                 setState(() {
                   _selectedDay=dayAfterTomorrow;
                 });
               },),
               DayLabel(text: "After One Week",isSelected: _selectedDay!.isAfter(afterOneWeek)|| isSameDay(_selectedDay, afterOneWeek),onTap: (){
                 setState(() {
                   _selectedDay=afterOneWeek;
                 });
               }),
             ],),
           ]else...[
             Row(children: [
               DayLabel(text: "No date",isSelected: _selectedDay==null,onTap: (){
                 setState(() {
                   _selectedDay=null;
                 });
               }),
               DayLabel(text: "Today",isSelected: isSameDay(_selectedDay, today),onTap: (){
                 setState(() {
                   _selectedDay=DateTime.now();
                 });
               },),
             ],)

           ],
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay!,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.blue
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle
                )
              ),
              headerVisible: true,
              headerStyle: HeaderStyle(
                titleCentered: true,
                // rightChevronVisible:
                // formatButtonShowsNext: false,
                formatButtonVisible: false,
              ),

            ),
            Divider(),
            Row(
              children: [
                Expanded(child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/date.png'),
                    ),
                    Text("${_selectedDay!=null?shortDate.format(_selectedDay!):"No Date"}")
                  ],
                )),
                Expanded(child: ButtonBar(
                  children: [
                    CancelButton(onPressed: (){
                      Navigator.pop(context);
                      print("Cancel Pressed");
                    }),
                    SaveButton(onPressed: (){
                      if(widget.isFromDate){
                        employeeController.setFromDate(_selectedDay!);
                      }else{
                        employeeController.setTodate(_selectedDay);
                      }
                      Navigator.pop(context);
                      print("Save Pressed");
                    })
                  ],
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
