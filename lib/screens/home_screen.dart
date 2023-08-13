import 'dart:async';
import 'dart:ui';
import 'package:book_finder_app/lang/languages.dart';
import 'package:book_finder_app/models/models.dart';
import 'package:book_finder_app/services/services.dart';
import 'package:book_finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _bookTitleController = TextEditingController();
  List<Item> _foundBooks = [];
  bool hasBooks = false, isEnglish = true, isVisible = false;
  BookService bookService = BookService();
  final FlutterLocalization _localization = FlutterLocalization.instance;

  void _searchBooks() async {
    String searchTerm = _bookTitleController.text;
    print(searchTerm);
    if (searchTerm == "") {
      _foundBooks = [];
    } else {
      _foundBooks = await bookService.getAllBooks(searchTerm);
    }
    setState(() => _foundBooks);
  }

  void translate(bool value) {
    setState(() {
      isEnglish = value;
      if (isEnglish) {
        _localization.translate('en');
      } else {
        _localization.translate('es', save: false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (this.mounted) {
        setState(() => isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.webp'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: const Color(0xFF8D8364).withOpacity(0.5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 55,
                    ),
                    SizedBox(
                      height: 120,
                      child: OverflowBox(
                        minHeight: 170,
                        maxHeight: 220,
                        child: Visibility(
                          visible: isVisible,
                          child: Lottie.asset(
                            'assets/icon-home.json',
                            width: 210.0,
                            height: 210.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'BooksFinder',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        shadows: <Shadow>[
                          Shadow(
                              color: Colors.black,
                              blurRadius: 4.0,
                              offset: Offset(0, 4))
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    //SearchFieldWidget(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     SearchButtonWidget(
                    //       context: context,
                    //       bookTitleController: bookTitleController,
                    //       hasBooks: changeHasBooks,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        onChanged: (value) => _searchBooks(),
                        controller: _bookTitleController,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Color(0xFF786C44).withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF786C44).withOpacity(0.7),
                            size: 28,
                          ),
                          hintText: AppLocale.hintText.getString(context),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xFF786C44).withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFFFFCF1),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 20.0),
                        ),
                      ),
                    ),
                    _foundBooks.isNotEmpty
                        ? Container(
                            height: 322,
                            child: BooksListWidget(bookItems: _foundBooks))
                        : HomeDescriptionWidget(context: context),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton:
              SwitchLanguageWidget(translate: translate, isEnglish: isEnglish),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          bottomNavigationBar: BottomNavigationBarWidget(),
        ),
      ),
      onWillPop: () async {
        if (hasBooks) {
          setState(() => hasBooks = false);
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
