import 'package:info_sphere/utils/imports.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  void hideKeyboard() => FocusScope.of(this).requestFocus(FocusNode());
  Color get primaryColor => theme.primaryColor;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
  Color get canvasColor => theme.canvasColor;
}
