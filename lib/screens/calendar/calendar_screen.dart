import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/calendar.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  ValueNotifier<List<Event>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  int counter = 2;

  get validateAndSubmit => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Calendar',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorDark
              ])),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pushNamed(context, '/');
          },
        )
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                decoration: BoxDecoration(color: Color(0xFFE1E1E1)),
              ),
              calendarStyle: const CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                isTodayHighlighted: false,
                outsideDaysVisible: false,
                cellMargin: EdgeInsets.all(5.0),
                defaultTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Colors.white),
                // todayDecoration: BoxDecoration(
                //     color: Color(0xFF314AB1), shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(
                    color: Color(0xFF2F449B), shape: BoxShape.circle),
                withinRangeTextStyle: TextStyle(color: Colors.white),
                withinRangeDecoration: BoxDecoration(shape: BoxShape.circle),
                rangeStartDecoration: BoxDecoration(
                    color: Color(0xFF2F449B), shape: BoxShape.circle),
                rangeEndDecoration: BoxDecoration(
                    color: Color(0xFF2F449B), shape: BoxShape.circle),

                rowDecoration: BoxDecoration(color: Color(0xFFBA509D)),
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 20.0),
            // Expanded(
            //   child: ValueListenableBuilder<List<Event>>(
            //     valueListenable: _selectedEvents,
            //     builder: (context, value, _) {
            //       return ListView.builder(
            //         itemCount: value.length,
            //         itemBuilder: (context, index) {
            //           return Container(
            //             margin: const EdgeInsets.only(
            //                 top: 4.0, bottom: 4.0, left: 0, right: 0),
            //             decoration: BoxDecoration(
            //               color: const Color(0xFFCAD0E6),
            //               borderRadius: BorderRadius.circular(5.0),
            //             ),
            //             child: Container(
            //               decoration: new BoxDecoration(
            //                 color: const Color(0xFF2F449B),
            //                 borderRadius: BorderRadius.circular(6),
            //               ),
            //               child: ListTile(
            //                 leading: SizedBox(
            //                   width: 40,
            //                   height: 40,
            //                   child: Image.asset('assets/images/alarm.png'),
            //                 ),
            //                 title: const Text('Progress Test',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 20,
            //                       fontWeight: FontWeight.w900,
            //                     )),
            //                 subtitle: const Text(
            //                   'Class AA1DX',
            //                   style:
            //                       TextStyle(color: Colors.white, fontSize: 18),
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
