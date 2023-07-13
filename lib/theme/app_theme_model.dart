// Copyright (c) 2021 zhanggenhua. All rights reserved.
//
// Author: zhanggenhua
// Date: 2021-05-20

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// import 'package:mobile_bank/util/hive_store.dart';

class AppThemeModel extends ChangeNotifier {
  static const _light = 0;
  static const _dark = 1;
  static const _system = 2;

  ThemeMode? _mode;

  ThemeMode get mode => _mode ?? _getSavedMode();

  /// If mode == [ThemeMode.system],
  /// try get device mode, may not exact. see [_getDeviceMode]
  ThemeMode get fixedMode => mode == ThemeMode.system ? _getDeviceMode() : mode;

  bool get isDark => fixedMode == ThemeMode.dark;

  ThemeMode _getSavedMode() {
    // int savedMode =
    //     Boxes.appConfigBox.get(ConfigKey.APP_THEME_MODE, defaultValue: -1);
    int savedMode = -1;
    ThemeMode sm;
    switch (savedMode) {
      case _light:
        sm = ThemeMode.light;
        break;
      case _dark:
        sm = ThemeMode.dark;
        break;
      case _system:
        sm = ThemeMode.system;
        break;
      default:
        sm = ThemeMode.system;
        break;
    }
    return sm;
  }

  ThemeMode _getDeviceMode() {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return darkModeOn ? ThemeMode.dark : ThemeMode.light;
  }

  setLightMode() => _applyThemeMode(ThemeMode.light, _light);

  setDarkMode() => _applyThemeMode(ThemeMode.dark, _dark);

  setSystemMode() => _applyThemeMode(ThemeMode.system, _system);

  void _applyThemeMode(ThemeMode mode, int modeInt) {
    // Boxes.appConfigBox.put(ConfigKey.APP_THEME_MODE, modeInt);
    _mode = mode;
    notifyListeners();
  }
}
