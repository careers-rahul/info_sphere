import 'package:info_sphere/utils/imports.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, required this.retry});

  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No Internet", style: context.textTheme.headlineSmall),
            const SizedBox(width: 8),
            const Icon(Icons.signal_wifi_off),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Please check your internet connection and try again.',
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: context.theme.primaryColor),
          onPressed: retry,
          child: Text("Retry", style: context.textTheme.titleMedium),
        ),
      ],
    );
  }
}
