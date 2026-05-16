import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/item.dart';

class ExportService {
  static Future<void> exportCsv(List<Item> items) async {
    final rows = <List<dynamic>>[
      // Header row
      [
        'Type', 'Country', 'Denomination', 'Year', 'Mint Mark',
        'Series', 'Variety', 'Metal', 'Grade', 'Grade (numeric)',
        'Grading Company', 'Cert Number', 'Slabbed', 'Designation',
        'Details Grade', 'Details Note', 'Submission Status',
        'Serial Number', 'Star Note', 'Quantity',
        'Historical Context', 'Attribution Notes', 'Provenance',
        'Internal Notes', 'Public',
      ],
    ];

    for (final item in items) {
      rows.add([
        item.itemType,
        item.country ?? '',
        item.denomination ?? '',
        item.yearStart?.toString() ?? '',
        item.mintMark ?? '',
        item.series ?? '',
        item.variety ?? '',
        item.metal ?? '',
        item.grade ?? '',
        item.gradeNumeric?.toString() ?? '',
        item.gradingCompany ?? '',
        item.certNumber ?? '',
        item.isSlabbed ? 'Yes' : 'No',
        item.designation ?? '',
        item.detailsGrade ? 'Yes' : 'No',
        item.detailsNote ?? '',
        item.submissionStatus,
        item.serialNumber ?? '',
        item.isStarNote ? 'Yes' : 'No',
        item.quantity.toString(),
        item.historicalContext ?? '',
        item.attributionNotes ?? '',
        item.provenance ?? '',
        item.internalNotes ?? '',
        item.isPublic ? 'Yes' : 'No',
      ]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final file = File('${dir.path}/coin_vault_$date.csv');
    await file.writeAsString(csv);

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Coin Vault — Collection Export ($date)',
    );
  }

  static Future<void> exportPdf(List<Item> items) async {
    final pdf = pw.Document();
    final date = DateFormat('MMMM d, yyyy').format(DateTime.now());

    // Column definitions: header label + field extractor
    final cols = <(String, String Function(Item))>[
      ('Country', (i) => i.country ?? ''),
      ('Denomination', (i) => i.denomination ?? ''),
      ('Year', (i) => i.yearStart?.toString() ?? ''),
      ('Mint', (i) => i.mintMark ?? ''),
      ('Grade', (i) => i.grade ?? ''),
      ('Service', (i) => i.gradingCompany ?? ''),
      ('Cert #', (i) => i.certNumber ?? ''),
      ('Type', (i) => i.itemType),
    ];

    final slabbed = items.where((i) => i.isSlabbed).length;
    final coins = items.where((i) => i.itemType == 'coin').length;
    final notes = items.where((i) => i.itemType == 'note').length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(36),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Coin Vault — Collection Report',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text(date,
                    style: const pw.TextStyle(
                        fontSize: 10, color: PdfColors.grey600)),
              ],
            ),
            pw.SizedBox(height: 6),
            pw.Row(children: [
              _pdfChip('${items.length} items'),
              pw.SizedBox(width: 8),
              _pdfChip('$slabbed slabbed'),
              pw.SizedBox(width: 8),
              _pdfChip('$coins coins'),
              pw.SizedBox(width: 8),
              _pdfChip('$notes notes'),
            ]),
            pw.Divider(thickness: 1, color: PdfColors.grey300),
            pw.SizedBox(height: 4),
          ],
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headers: cols.map((c) => c.$1).toList(),
            data: items
                .map((item) => cols.map((c) => c.$2(item)).toList())
                .toList(),
            headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: 8),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerDecoration:
                const pw.BoxDecoration(color: PdfColors.blueGrey50),
            rowDecoration: const pw.BoxDecoration(),
            oddRowDecoration:
                const pw.BoxDecoration(color: PdfColors.grey100),
            border: pw.TableBorder.all(
                color: PdfColors.grey300, width: 0.5),
            cellPadding: const pw.EdgeInsets.symmetric(
                horizontal: 4, vertical: 3),
          ),
        ],
        footer: (context) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Generated by Coin Vault',
                style: const pw.TextStyle(
                    fontSize: 8, color: PdfColors.grey500)),
            pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: const pw.TextStyle(
                    fontSize: 8, color: PdfColors.grey500)),
          ],
        ),
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename:
          'coin_vault_${DateFormat('yyyy-MM-dd').format(DateTime.now())}.pdf',
    );
  }

  static pw.Widget _pdfChip(String text) => pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: pw.BoxDecoration(
          color: PdfColors.blueGrey100,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        ),
        child: pw.Text(text,
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.blueGrey800)),
      );
}
