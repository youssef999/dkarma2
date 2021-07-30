import 'package:fire99/Helpers/alarm_list.dart';
import 'package:fire99/Helpers/local_notif.dart';
import 'package:fire99/Models/alarm_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildAlarmItemContainer(
    BuildContext context, AlarmItem alarmItem, LocalNotif fln) {
  if (alarmItem.description == null || alarmItem.description == "") {
    return Container();
  }
  return Container(
      margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
      decoration: BoxDecoration(
          color: Colors.white60, borderRadius: BorderRadius.circular(10)),
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              child: Icon(Icons.notifications,
                  size: 35,
                  color: alarmItem.isActive == 'true'
                      ? Colors.deepPurple
                      : Colors.grey[800]),
              onTap: () async {
                var currentActiveState = alarmItem.isActive;
                if (currentActiveState == 'true') {
                  currentActiveState = 'false';
                  await setIsActive(alarmItem.id, alarmItem.dateTime,
                      currentActiveState, fln);
                } else
                  currentActiveState = 'true';
                await setIsActive(
                    alarmItem.id, alarmItem.dateTime, currentActiveState, fln);
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(alarmItem.description),
              Text(DateFormat.Hm().format(alarmItem.dateTime),
                  style: TextStyle(fontSize: 30)),
            ],
          ),
          Container(
              width: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // GestureDetector(child: Icon(Icons.edit), onTap: () {}),
                    GestureDetector(
                        child: Icon(Icons.delete, color: Colors.red[400]),
                        onTap: () async {
                          await deleteAlarm(alarmItem.dateTime, alarmItem.id);
                          print('deleting');
                        })
                  ])),
        ],
      ));
}
