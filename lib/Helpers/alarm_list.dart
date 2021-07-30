import 'dart:convert';

import 'package:fire99/Helpers/alarm_manager.dart';
import 'package:fire99/Helpers/remember_me.dart';
import 'package:fire99/Models/alarm_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_notif.dart';

//I am setting a list of alarms that will always be checked first,
//if it doesn't exist then a new list will be made.
//If it does, the list will be added to;
Future<int> addAnAlarm(Map<String, String> alarmItemMap) async {
  int idLength = 0;
  SharedPreferences pref = await getSharedPrefs();
  var alarmList = await getAlarmList();
  List<Map<String, dynamic>> currentAlarmList = [];
  if (alarmList != "") {
    var d = json.decode(alarmList);
    if (d is List) {
      idLength = d.length;
      print('this is $d');
      d.map((element) {
        return currentAlarmList.add(element);
      }).toList();
      currentAlarmList.add(alarmItemMap);
      print('this is currentList $currentAlarmList');
      idLength = currentAlarmList.length;
      await pref.setString('alarmList', json.encode(currentAlarmList));
      return idLength;
    } else
      currentAlarmList.add(d);
    idLength = currentAlarmList.length;

    await pref.setString('alarmList', json.encode(currentAlarmList));
    return idLength;
  } else {
    await pref.setString('alarmList', json.encode(alarmItemMap));
    return idLength;
  }
}

//A helper function for my other CRUD ops
Future getAlarmList() async {
  SharedPreferences pref = await getSharedPrefs();
  var valString = pref.get('alarmList') ?? '';
  return valString;
}

Future<List<AlarmItem>> getAlarmItems() async {
  List<AlarmItem> allAlarmItems = [];
  var aList = await getAlarmList();
  if (aList != "") {
    var decodedList = json.decode(aList);

    if (decodedList is List) {
      decodedList.forEach((item) {
        return allAlarmItems.add(AlarmItem.fromJson(item));
      });
    } else
      allAlarmItems.add(AlarmItem.fromJson(decodedList));

    return allAlarmItems;
  } else
    return allAlarmItems;
}

clearAllAlarms() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('alarmList', '');
}

// addAlarmToAlarmManager(
//     DateTime datetime, int id, callback, LocalNotif fln) async {
//   await AlarmManager.init();
//   await AlarmManager.oneShot(Duration(seconds: 5), id, (id) async {
//     print('Alarm done $id');
//     await fln.setNotification();
//   });
// }

Future deleteAlarm(DateTime dateTime, int id) async {
  List<AlarmItem> allAlarmItems = await getAlarmItems();
  SharedPreferences pref = await getSharedPrefs();

  int deleteIndex = allAlarmItems.indexWhere(
          (element) => (element.dateTime == dateTime && element.id == id));

  AlarmItem deletedItem = AlarmItem(
      id: allAlarmItems[deleteIndex].id,
      dateTime: allAlarmItems[deleteIndex].dateTime,
      isDeleted: 'true',
      description: null,
      day: null,
      isActive: null);
  allAlarmItems.removeAt(deleteIndex);
  print(allAlarmItems);
  allAlarmItems.insert(deleteIndex, deletedItem);
  print(allAlarmItems);

  try {
    await AlarmManager.cancel(allAlarmItems[deleteIndex].id);
  } catch (e) {
    print(e);
  }

  List newList = [];
  allAlarmItems.forEach((alarmItem) {
    newList.add(alarmItem.toJsonObject());
  });
  if (newList.length > 0) {
    await pref.setString('alarmList', json.encode(newList));
  }
}

// This is an unfinished function because I havent added alarm manager
// plus you need a page to use this function as you would need
// to collect some user input data
Future<String> editAlarm(DateTime dateTime, AlarmItem newItem) async {
  List<AlarmItem> allAlarmItems = await getAlarmItems();
  SharedPreferences pref = await getSharedPrefs();

  int editIndex =
  allAlarmItems.indexWhere((element) => element.dateTime == dateTime);

  allAlarmItems.removeAt(editIndex);
  allAlarmItems.insert(editIndex, newItem);

  List newList = [];
  allAlarmItems.forEach((alarmItem) {
    newList.add(alarmItem.toJsonObject());
  });
  if (newList.length > 0) {
    await pref.setString('alarmList', json.encode(newList));
    return 'Alarm edited';
  } else {
    return "Alarm not edited";
  }
}

Future setIsActive(
    int alarmId, DateTime dateTime, String isActive, LocalNotif fln) async {
  List<AlarmItem> allAlarmItems = await getAlarmItems();
  SharedPreferences pref = await getSharedPrefs();

  int editIndex = allAlarmItems.indexWhere(
          (element) => (element.dateTime == dateTime && element.id == alarmId));

  if (editIndex == -1) {
    print('Did not find the edited index');
  }
  AlarmItem oldItem = allAlarmItems[editIndex];
  AlarmItem newItem = AlarmItem(
      isActive: isActive,
      dateTime: oldItem.dateTime,
      day: oldItem.day,
      description: oldItem.description,
      id: oldItem.id,
      isRepeated: oldItem.isRepeated);
  try {
    if (newItem.isActive == 'true') {
      await AlarmManager.periodic(
        Duration(hours: 24),
        newItem.id,
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
          await fln.setNotification('alarm title', newItem.description);
        },
        startAt: newItem.dateTime,
      );
    }
  } catch (e) {
    print('Could not set active timer');
  }
  try {
    if (newItem.isActive == 'false') {
      await AlarmManager.cancel(alarmId);
    }
  } catch (e) {
    print(e);
    print('Could not activate timer');
  }

  allAlarmItems.removeAt(editIndex);
  allAlarmItems.insert(editIndex, newItem);

  List newList = [];
  allAlarmItems.forEach((alarmItem) {
    newList.add(alarmItem.toJsonObject());
  });

  if (newList.length > 0) {
    await pref.setString('alarmList', json.encode(newList));
    print('alarm has been edited');
  } else {
    print('Alarm has not been edited');
  }
}