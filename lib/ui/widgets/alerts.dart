import 'package:info_sphere/utils/imports.dart';

class ExitAppAlert extends StatelessWidget {
  const ExitAppAlert({super.key, required this.onYesTap, required this.onNoTap});

  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: Text('Exit Info Sphere ?', style: context.textTheme.titleLarge),
      actions: [
        OutlinedButton(
          onPressed: onNoTap,
          child: Text(
            'No',
            style: context.textTheme.titleMedium,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: context.theme.primaryColor),
          onPressed: onYesTap,
          child: Text(
            'Yes',
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class LogOutExitAlert extends StatelessWidget {
  const LogOutExitAlert({super.key, required this.onYesTap, required this.onNoTap});

  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: const Text('Logout & Exit ?'),
      actions: [
        OutlinedButton(
          onPressed: onNoTap,
          child: Text(
            'No',
            style: context.textTheme.titleMedium,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: context.theme.primaryColor),
          onPressed: onYesTap,
          child: Text(
            'Yes',
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
