import 'package:flutter/widgets.dart';

import 'context.dart';

extension DateTimeExtension on DateTime {
  bool get isBeforeNow {
    return isBefore(DateTime.now());
  }

  bool isBeforeSecure(DateTime? dateTime) {
    if (dateTime == null) {
      return false;
    }
    return true;
  }

  String getLastUpdateTimeDesc(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    if (year <= 1970) {
      return appLocalizations.unknown;
    }
    final currentDateTime = DateTime.now();
    final difference = currentDateTime.difference(this);
    final days = difference.inDays;
    if (days >= 365) {
      final years = (days / 365).floor();
      return appLocalizations.yearsAgo(years);
    }
    if (days >= 30) {
      final months = (days / 30).floor();
      return appLocalizations.monthsAgo(months);
    }
    if (days >= 1) {
      return appLocalizations.daysAgo(days);
    }
    final hours = difference.inHours;
    if (hours >= 1) {
      return appLocalizations.hoursAgo(hours);
    }
    final minutes = difference.inMinutes;
    if (minutes >= 1) {
      return appLocalizations.minutesAgo(minutes);
    }
    return appLocalizations.justNow;
  }

  String get show {
    return toString().substring(0, 10);
  }

  String get showFull {
    return toString().substring(0, 19);
  }

  String get showTime {
    return toString().substring(10, 19);
  }
}

String getDateStringLast2(int value) {
  final valueRaw = '0$value';
  return valueRaw.substring(valueRaw.length - 2);
}

/// Formats elapsed VPN/core uptime for the start button.
///
/// Under 24 hours: `HH:MM:SS`. 24 hours and above: `Nd HH:MM:SS`, so
/// multi-day runs stay readable and are not clipped by a `999:59:59` /
/// two-digit-hour ceiling.
String getTimeText(int? timeStamp) {
  if (timeStamp == null) {
    return '00:00:00';
  }
  final totalSeconds = timeStamp < 0 ? 0 : timeStamp ~/ 1000;
  final days = totalSeconds ~/ Duration.secondsPerDay;
  final hours =
      (totalSeconds % Duration.secondsPerDay) ~/ Duration.secondsPerHour;
  final minutes =
      (totalSeconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
  final seconds = totalSeconds % Duration.secondsPerMinute;
  final clock =
      '${getDateStringLast2(hours)}:${getDateStringLast2(minutes)}:${getDateStringLast2(seconds)}';
  if (days <= 0) {
    return clock;
  }
  return '${days}d $clock';
}
