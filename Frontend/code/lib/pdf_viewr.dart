import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({super.key});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            title: const Align(
              alignment: Alignment.topRight,
              child: Text(
                "مجنون ليلى",
                textDirection: TextDirection.rtl,
              ),
            )),
        body: Center(
            child: SfPdfViewer.network(
                'https://www.arab-books.com/wp-content/uploads/2020/06/79283830.pdf')));
  }
}
