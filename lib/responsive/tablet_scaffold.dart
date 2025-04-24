import 'package:animate_do/animate_do.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TabletScaffold extends StatelessWidget {
  final List<Item> bookItems;

  const TabletScaffold({super.key, required this.bookItems});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight - 320,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: FadeInLeft(
        child: ListView.builder(
          padding: const EdgeInsets.all(0.0),
          itemCount: bookItems.length,
          itemBuilder: ((context, index) {
            return Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: BookImageWidget(
                    book: bookItems[index],
                    isMobile: false,
                  ),
                ),
                Positioned(
                  top: 70.0,
                  left: 9.0,
                  bottom: 70.0,
                  child: SizedBox(
                    width: deviceWidth - 225,
                    child: Card(
                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: BookDetailWidget(
                          book: bookItems[index],
                          isMobile: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
