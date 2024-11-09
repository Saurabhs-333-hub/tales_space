// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

class UtilMethods {
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  static String capitalizeFirstofEach(String s) =>
      s.split(" ").map((str) => capitalize(str)).join(" ");
  // getPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
  //
  // Future<Position> getCurrentLatLong() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       locationSettings: LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 0,
  //   ));
  //
  //   return position;
  // }
  //
  // Future<List<File>> pickFile(FileType fileType) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //     allowCompression: true,
  //     type: fileType,
  //   );
  //   if (result != null) {
  //     return result.files.map((e) => File(e.path!)).toList();
  //   }
  //   return [];
  // }

  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  static String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (names.length < 2) {
      numWords = names.length;
    }

    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }

    return initials;
  }

  static String getUniqueUsername(String name, List<String> usernames) {
    String username = name.replaceAll(" ", "").toLowerCase();
    if (!usernames.contains(username)) {
      return username;
    }

    int i = 1;
    while (usernames.contains("$username$i")) {
      i++;
    }

    return "$username$i";
  }

  static String getFormattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String getFormattedTime(DateTime date) {
    return "${date.hour}:${date.minute}";
  }

  static String getFormattedDateTime(DateTime date) {
    return "${getFormattedDate(date)} ${getFormattedTime(date)}";
  }

  static String getFormattedCurrency(double amount) {
    return "\$${amount.toStringAsFixed(2)}";
  }

  static String getFormattedPercentage(double percentage) {
    return "${percentage.toStringAsFixed(2)}%";
  }

  static String getFormattedNumber(double number) {
    return number.toStringAsFixed(2);
  }

  static String getFormattedPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(RegExp(r"(\d{3})(\d{3})(\d{4})"),
        (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");
  }

  static String getFormattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String getFormattedDurationInMinutes(Duration duration) {
    return "${duration.inMinutes} minutes";
  }

  static String getFormattedDurationInHours(Duration duration) {
    return "${duration.inHours} hours";
  }

  static String getFormattedDurationInDays(Duration duration) {
    return "${duration.inDays} days";
  }

  static String getFormattedDurationInWeeks(Duration duration) {
    return "${(duration.inDays / 7).floor()} weeks";
  }

  static String getFormattedDurationInMonths(Duration duration) {
    return "${(duration.inDays / 30).floor()} months";
  }

  static String getFormattedDurationInYears(Duration duration) {
    return "${(duration.inDays / 365).floor()} years";
  }

  static String getFormattedDurationInWords(Duration duration) {
    if (duration.inDays > 365) {
      return getFormattedDurationInYears(duration);
    } else if (duration.inDays > 30) {
      return getFormattedDurationInMonths(duration);
    } else if (duration.inDays > 7) {
      return getFormattedDurationInWeeks(duration);
    } else if (duration.inDays > 1) {
      return getFormattedDurationInDays(duration);
    } else if (duration.inHours > 1) {
      return getFormattedDurationInHours(duration);
    } else if (duration.inMinutes > 1) {
      return getFormattedDurationInMinutes(duration);
    } else {
      return "Just now";
    }
  }

  static String getFormattedDurationInWordsShort(Duration duration) {
    if (duration.inDays > 365) {
      return "${(duration.inDays / 365).floor()}y";
    } else if (duration.inDays > 30) {
      return "${(duration.inDays / 30).floor()}m";
    } else if (duration.inDays > 7) {
      return "${(duration.inDays / 7).floor()}w";
    } else if (duration.inDays > 1) {
      return "${duration.inDays}d";
    } else if (duration.inHours > 1) {
      return "${duration.inHours}h";
    } else if (duration.inMinutes > 1) {
      return "${duration.inMinutes}m";
    } else {
      return "Just now";
    }
  }

  static String getFormattedDurationInWordsLong(Duration duration) {
    if (duration.inDays > 365) {
      return "${(duration.inDays / 365).floor()} years";
    } else if (duration.inDays > 30) {
      return "${(duration.inDays / 30).floor()} months";
    } else if (duration.inDays > 7) {
      return "${(duration.inDays / 7).floor()} weeks";
    } else if (duration.inDays > 1) {
      return "${duration.inDays} days";
    } else if (duration.inHours > 1) {
      return "${duration.inHours} hours";
    } else if (duration.inMinutes > 1) {
      return "${duration.inMinutes} minutes";
    } else {
      return "Just now";
    }
  }
}
