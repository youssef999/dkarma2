import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fire99/Helpers/alarm_list.dart';
import 'package:fire99/Helpers/alarm_manager.dart';
import 'package:fire99/Helpers/local_notif.dart';
import 'package:fire99/Helpers/remember_me.dart';
import 'package:fire99/Models/alarm_item.dart';
import 'package:fire99/Screens/components/alarm_item_component.dart';
import 'package:fire99/colorr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  SharedPreferences prefs;
  LocalNotif fln = LocalNotif();
  String dateVal = '';
  String descVal = '';
  TextEditingController datePickerController = TextEditingController();
  TextEditingController textController = TextEditingController();
  int idLength = 1;

  @override
  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SchedulerBinding.instance.addPostFrameCallback((ts) {
      addPostFrame(context);
    });
    getSharedPrefs().then((sp) => prefs = sp);
    getAlarmItems().then((items) {
      myAlarmList = items;
      setState(() {});
    });
  }

  addPostFrame(BuildContext context) async {
    await fln.initializeLocalNotifPlugin(context);
    print('Local notif initialized');
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    datePickerController.dispose();
  }

  List<AlarmItem> myAlarmList = [];

  @override
  Widget build(BuildContext context) {
    getAlarmItems().then((items) {
      myAlarmList = items;
      setState(() {});
    });
    return Scaffold(
        backgroundColor: btnforGroundColr,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reminders',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: myAlarmList != null ? myAlarmList.length : 0,
                      itemBuilder: (context, i) {
                        return buildAlarmItemContainer(
                            context, myAlarmList[i], fln);
                      }),
                ),
                // ElevatedButton(
                //     style: ButtonStyle(backgroundColor:
                //         MaterialStateProperty.resolveWith<Color>((states) {
                //       return Colors.transparent;
                //     })),
                //     child: Container(
                //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                //         child: Text('Watch Ads', style: TextStyle(fontSize: 20))),
                //     onPressed: () async {
                //       var ud = await getUd();
                //       Navigator.of(context).push(
                //           MaterialPageRoute(builder: (context) => Screen2(ud)));
                //     })
              ],
            )),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: Colors.purple[800],
          onPressed: () async {
            showMyDialog(context, textController, datePickerController)
                .then((value) async {
              setState(() {});
            });
            // clearAllAlarms();
          },
          child: Icon(Icons.add, size: 35),
        ));
  }

  Future<Widget> showMyDialog(
      BuildContext context,
      TextEditingController textController,
      TextEditingController datePickerController,
      ) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add a new alert', textAlign: TextAlign.center),
            titlePadding: EdgeInsets.symmetric(vertical: 10),
            content: Container(
              width: 300,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Set time: '),
                  Container(
                    width: 200,
                    alignment: Alignment.center,
                    child: DateTimePicker(
                      autovalidate: true,
                      dateMask: ' d MMM, yyyy - hh:mm a',
                      type: DateTimePickerType.dateTime,
                      onFieldSubmitted: (p) {
                        dateVal = p;
                        setState(() {});
                      },
                      controller: datePickerController,
                      lastDate: DateTime(2022),
                      firstDate: DateTime(2020),
                    ),
                  ),
                  Text('Set Description'),
                  Container(
                      width: 170,
                      child: TextField(
                          controller: textController,
                          onSubmitted: (val) {
                            descVal = val;
                            setState(() {});
                          }))
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (states) => Colors.purple[900])),
                  child: Text('Save'),
                  onPressed: () async {
                    //Extract the time and date here and add to the alarmList
                    //plus set an alarmManager
                    AlarmItem myAlarm = new AlarmItem(
                        id: idLength + 1,
                        day: '',
                        isActive: 'true',
                        isRepeated: 'false',
                        dateTime:
                        DateTime.parse(datePickerController.text.trim()),
                        description: textController.text.trim());
                    idLength = await addAnAlarm(myAlarm.toJsonObject());

                    await AlarmManager.init().then((_) {
                      print('Alarm manager initialized');
                    });
                    await AlarmManager.periodic(
                      Duration(hours: 24),
                      myAlarm.id,
                          (id) async {
                        print('Alarm fired ');
                        // await AwesomeNotifications().createNotification(
                        //     content: NotificationContent(
                        //         bigPicture: 'assets/v3',
                        //         id: myAlarm.id,
                        //         backgroundColor: Colors.deepPurple,
                        //         channelKey: 'high_intensity',
                        //         title: 'Deal Karma',
                        //         body: myAlarm.description));
                        await fln.setNotification(
                            'alarm title', textController.text.trim());
                      },
                      startAt: DateTime.parse(datePickerController.text.trim()),
                    );

                    Navigator.pop(context);
                  }),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (states) => Colors.purple[900])),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancel'))
            ],
          );
        });
  }
}