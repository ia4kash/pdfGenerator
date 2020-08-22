import 'package:greenit/view_pdf.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart' as material;
import 'package:pdf/widgets.dart' as pw;

reportView(context, String heading, String sign) async {
  final Document pdf = Document();
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/GreenIT.pdf';
  final File file = File(path);
  var dt = DateTime.now();
  var newFormat = DateFormat("dd-MM-yy");
  String updatedDt = newFormat.format(dt);
  final image = PdfImage.file(
    pdf.document,
    bytes: File(sign).readAsBytesSync(),
  );

  pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      footer: (Context context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                pw.Container(height: 60.0, width: 80.0, child: pw.Image(image)),
                Text("(Your Name)",textScaleFactor: 1)
              ]),
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                  child: Text(updatedDt, textScaleFactor: 2))
            ]);
      },
      build: (Context context) => <Widget>[
            Header(
                level: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(heading, textScaleFactor: 3,style:TextStyle(color: PdfColors.green)),
                      PdfLogo()
                    ])),
          ]));
  await file.writeAsBytes(pdf.save());
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
}
