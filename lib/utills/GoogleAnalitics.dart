import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalysisObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({required String userId}) async {
    await _analytics.setUserId(id: userId);
    await _analytics.setUserProperty(name: "user_id", value: userId);
  }

  Future<void> setCurrentScreen({required String screenName}) {
    return _analytics.setCurrentScreen(screenName: screenName);
  }

  Future<void> sendAnalyticsEvent({required String logName}) async {
    await _analytics.logEvent(name: logName);
  }
}
