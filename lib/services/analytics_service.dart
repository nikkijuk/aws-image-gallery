import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'analytics_events.dart';

class AnalyticsService {
  static void log(AbstractAnalyticsEvent event) {
    Amplify.Analytics.recordEvent(event: event.value);

    // ignore: avoid_print
    print ('Sent event $event');
  }
}