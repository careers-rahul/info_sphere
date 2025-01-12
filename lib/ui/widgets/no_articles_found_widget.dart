import 'package:info_sphere/utils/imports.dart';

class NoArticlesFoundWidget extends StatelessWidget {
  const NoArticlesFoundWidget({super.key, required this.onTryAgain});

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Sorry, No Articles found!",
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: context.theme.primaryColor),
          onPressed: onTryAgain,
          child: Text("Try Again", style: context.textTheme.titleMedium),
        )
      ],
    );
  }
}
