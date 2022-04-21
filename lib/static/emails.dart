import 'package:drive_easy/classes/game/email.dart';
import 'package:flutter/material.dart';

Map<String, List<GameEmail>> emailDatabase = {
  "level0": [
    GameEmail(
      // id: 0,
      content: ("Welcome new employee! We are happy to see new face, ")
        + ("our company provide services of delivering packages to different cloud storages")
        + (", and your job is to help us identifing the packages both incoming and outgoing.")
        + (" All the information inside packages should be correct and safe to send out.\n")
        + ("   Once again thank you for choosing our company to work with!")
        + (" Our aim is to provide a fast and safe services for our customers")
        + (", you will have to get used to our work in following days, once you are more familiar with these")
        + (", more complicaited works will be assigned to you. Noted that if you failed to handle a numbers of cases you will be punished or fired.\n")
        + ("\n")
        + ("\n")
        + ("Best regards,\n")
        + ("Drive easy\n"),
      title: "Welcome!",
      from: "Drive Easy",
      to: "Player",
      cc: "",
      dear: "Dear new employee, \n",
      read: false,
      time: DateTime(2022, 4, 1, 09, 00),
      style: [
        null,
        null,
        null,
        null,
        null,
        null,
      ]
    ),
    GameEmail(
      // id: 1,
      content: "You should check the rules before you work on, Here are some basic rules:\n"
      + ("- Each task handle a package, A package contain informations of the task \n")
      + ("- Some info should be matching our policy provided inside handbook\n")
      + ("- E.g. the destination cloud storage should only be our cooperating partners\n")
      + ("- deny the packages if wrong, proceed if correct\n")
      + ("\n")
      + ("   More details can be found on the employee handbook we sent to you. Please have a look if you encounter some problem.\n")
      + ("\n")
      + ("\n")
      + ("Best regards,\n")
      + ("Drive easy\n"),
      title: "Check out our rules!",
      from: "Drive Easy",
      to: "employees",
      cc: "Drive-Easy-Employees",
      dear: "Dear all employees, \n",
      read: false,
      time: DateTime(2022, 4, 1, 09, 00),
      style: [
        null,
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.blue),
        null,
        null,
        null,
        null,
        null,
        null,
      ]
    ),
  ],
  "level1": [
    GameEmail(
      // id: 1,
      content: "Hey you got a F on first day, this is so bad, you gotta work so hard before I re-consider your employment. "
      + ("And don't you blaming the tutorial AI yesterday, huh? The most perfect masterpiece I've ever made in my entire life? ")
      + ("Oh come on, it will never goes wrong, what are you talking about?\n")
      + ("\n")
      + ("God, youngers nowadays, sigh...\n")
      + ("\n")
      + ("Boss\n"),
      title: "What? F?",
      from: "Boss",
      to: "Player",
      cc: "",
      dear: "Hi, \n",
      read: false,
      time: DateTime(2022, 4, 2, 09, 00),
      style: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ]
    ),
    GameEmail(
      // id: 0,
      content: ("New updated on handbook:\n")
        + ("  - Chapter: Special Policy updated"),
      title: "Handbook updated.",
      from: "System",
      to: "user",
      cc: "",
      dear: "Auto generated email:\n",
      read: false,
      time: DateTime(2022, 4, 2, 09, 00),
      style: [
        null,
        TextStyle(color: Colors.blue),
      ]
    ),
  ],
  "level2": [
    GameEmail(
      // id: 0,
      content: ("New policy updated!\n")
        + ("  Due to needed by our partners, Authorization are need for every packages!\n")
        + ("  Check out the handbook for more details!\n")
        + ("\n")
        + ("\n")
        + ("Best regards,\n")
        + ("Drive easy\n"),
      title: "New Policy!!!!",
      from: "Drive Easy",
      to: "employees",
      cc: "Drive-Easy-Emplyees",
      dear: "Dear new employee, \n",
      read: false,
      time: DateTime(2022, 4, 3, 09, 00),
    ),
    GameEmail(
      // id: 0,
      content: ("New updated on handbook:\n")
        + ("  - Chapter: Authorization added\n")
        + ("  - Chapter: Special Policy updated"),
      title: "Handbook updated.",
      from: "System",
      to: "user",
      cc: "",
      dear: "Auto generated email:\n",
      read: false,
      time: DateTime(2022, 4, 3, 09, 00),
      style: [
        null,
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.blue),
      ]
    ),
  ],
  "level3": [
    GameEmail(
      // id: 1,
      content: "Hello my fellow employees, looks like there's something wrong with the Authorization system, "
      + ("but don't worry! It has nothing to do with us! just stick on your own responsibility and works, it should be fine!\n")
      + ("\n")
      + ("  Ahh... Stupid users and servers...\n")
      + ("\n")
      + ("Best regards,\nYour lovely Boss\n"),
      title: "Some Problem",
      from: "Boss",
      to: "employees",
      cc: "Drive-Easy-Emplyees",
      dear: "Hi guys, \n",
      read: false,
      time: DateTime(2022, 4, 4, 09, 00),
      style: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ]
    ),
  ],
  "level4": [
    GameEmail(
      // id: 0,
      content: ("New updated on handbook:\n")
        + ("  - Chapter: Data inspect added\n")
        + ("  - Chapter: Special Policy updated"),
      title: "Handbook updated.",
      from: "System",
      to: "user",
      cc: "",
      dear: "Auto generated email:\n",
      read: false,
      time: DateTime(2022, 4, 5, 09, 00),
      style: [
        null,
        TextStyle(color: Colors.blue),
        TextStyle(color: Colors.blue),
      ]
    ),
    GameEmail(
      // id: 1,
      content: "its been few days! Enjoy your work? I am here to promote you the honour of passing probation, "
      + ("you are now officially hired by us! You can now help handling the work of uhh.. what does my technician said? \n")
      + ("Oh yeah, data inspection! you can do those cool hacker stuff, to help lower our others employees workload! \n")
      + ("\n")
      + ("  ...why is everyone leaving...\n")
      + ("\n")
      + ("Best regards,\nBoss\n"),
      title: "Promote",
      from: "Boss",
      to: "Player",
      cc: "",
      dear: "Hello, \n",
      read: false,
      time: DateTime(2022, 4, 4, 09, 00),
      style: [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ]
    ),
  ],
  "level5": [

  ]
};


