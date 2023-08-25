import 'package:book_finder_app/core/utils.dart';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:transparent_image/transparent_image.dart';

class BookDetailScreen extends StatelessWidget {
  final VolumeInfo book;
  final String? id;
  const BookDetailScreen({super.key, required this.book, this.id});

  @override
  Widget build(BuildContext context) {
    TextStyle dateTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF6A6A6A),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Lottie.asset(
              'assets/icon-home.json',
              width: 90.0,
              height: 90.0,
            ),
            Text(
              'BooksFinder',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF786C44),
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      body: BackgroundWidget(
        color: Colors.white.withOpacity(0.75),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 90.0,
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'book-image-${id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: book.imageLinks!.thumbnail,
                        fit: BoxFit.fill,
                        width: 180.0,
                        height: 250.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Text(
                              book.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                            if (book.title.length > 26)
                              Positioned(
                                top: 52,
                                bottom: 0,
                                right: 0,
                                child: Material(
                                  child: InkWell(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                            title: Text(
                                              book.title,
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                    ),
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      size: 20.5,
                                      color: Utils.darkYellowColor,
                                    ),
                                  ),
                                  color: Colors.transparent,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        AuthorsListWidget(currentAuthors: book.authors),
                        SizedBox(height: 10.0),
                        book.publishedDate != ''
                            ? Text(
                                book.publishedDate,
                                style: dateTextStyle,
                              )
                            : Text(
                                AppLocale.bookUnknownPublishedDate
                                    .getString(context),
                                style: dateTextStyle,
                              ),
                        SizedBox(height: 10.0),
                        BookButtonInfoWidget(
                          text: AppLocale.addToFavorites.getString(context),
                          onPressedFn: () => print('Add to favorites'),
                          icon: Icons.add_circle_sharp,
                        ),
                        SizedBox(height: 10.0),
                        BookButtonInfoWidget(
                          text: "Google Books info",
                          onPressedFn: () => print('Google Books info'),
                          icon: Icons.arrow_forward_ios_rounded,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
