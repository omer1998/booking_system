import 'package:booking_system/locale/locale.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  List<String> _timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];
  String? _selectedTimeSlot;
  bool selctDate = false;
  // DateTime? _date ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).doctors),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildDateWidgets(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_timeSlots[index]),
                  tileColor: _selectedTimeSlot == _timeSlots[index]
                      ? Colors.green[100]
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedTimeSlot = _timeSlots[index];
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _selectedDate != null && _selectedTimeSlot != null
                ? () {
                    // Implement booking logic here
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Booking Confirmation'),
                        content: Text(
                          'You have successfully booked a seat on\n'
                          '$_selectedDate at $_selectedTimeSlot.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
            child: Text('Book Now'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDateWidgets() {
    final List<Widget> dateWidgets = [];

    for (int i = 0; i < 7; i++) {
      final date = DateTime.now().add(Duration(days: i));
      final weekday = date.weekday;
      final weekdayName = _getWeekdayName(weekday);

      final dateWidget = GestureDetector(
        onTap: () {
          setState(() {
            // selctDate = true;
            _selectedDate = date;

            // _selectedTimeSlot = null;
          });
        },
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: _selectedDate==date? Colors.blue[100] : Colors.white, 
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weekdayName,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );

      dateWidgets.add(dateWidget);
    }

    return dateWidgets;
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
