import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int totalPageCount = 0, currentPage = 1;
  late PdfControllerPinch pdfControllerPinch;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/pdfs/flutter_tutorial.pdf'),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total pages ${totalPageCount}"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text("page $currentPage"),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
        child: PdfViewPinch(
      scrollDirection: Axis.vertical,
      controller: pdfControllerPinch,
      onDocumentLoaded: (doc) {
        setState(() {
          totalPageCount = doc.pagesCount;
        });
      },
      onPageChanged: (page) {
        setState(() {
          currentPage = page;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF viewer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: _buildUI(),
    );
  }
}
