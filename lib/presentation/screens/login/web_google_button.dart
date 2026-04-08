import 'package:flutter/widgets.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

/// Renders Google's official GIS sign-in button on web.
/// The onCurrentUserChanged stream fires after the user authenticates.
Widget buildPlatformGoogleButton() {
  final plugin = GoogleSignInPlatform.instance as web.GoogleSignInPlugin;
  return plugin.renderButton(
    configuration: web.GSIButtonConfiguration(
      type: web.GSIButtonType.standard,
      theme: web.GSIButtonTheme.outline,
      size: web.GSIButtonSize.large,
    ),
  );
}
