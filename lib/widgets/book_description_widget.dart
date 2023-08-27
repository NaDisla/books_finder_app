import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class BookDescriptionWidget extends StatelessWidget {
  final String bookTitle;
  final String bookDescription;
  final String bookId;
  final String volumeInfoTitle;

  const BookDescriptionWidget({
    super.key,
    required this.bookTitle,
    required this.bookDescription,
    required this.bookId,
    required this.volumeInfoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BookButtonInfoWidget(
      icon: Icons.arrow_forward_ios_rounded,
      text: AppLocale.bookDescription.getString(context),
      btnColor: Utils.darkYellowColor,
      onPressedFn: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const BookDetailScreen(),
        //   ),
        // );
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: Text(
        //           bookTitle,
        //           textAlign: TextAlign.justify,
        //           style: const TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 15.0,
        //           ),
        //         ),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //         ),
        //         content: Text(
        //           bookDescription,
        //           maxLines: 15,
        //           overflow: TextOverflow.ellipsis,
        //           textAlign: TextAlign.justify,
        //           style: TextStyle(),
        //         ),
        //         actions: [
        //           TextButton(
        //             onPressed: () => Navigator.pop(context),
        //             child: Text('OK'),
        //           ),
        //           TextButton(
        //             onPressed: () {
        //               Uri bookUrl = Uri.parse(
        //                 BookService.getBookUrl(bookId, volumeInfoTitle),
        //               );
        //               launchUrlString(
        //                 bookUrl.toString(),
        //                 mode: LaunchMode.externalApplication,
        //               );
        //             },
        //             child: Text(AppLocale.bookMoreDetails.getString(context)),
        //           )
        //         ],
        //       );
        //     });
      },
    );
  }
}
