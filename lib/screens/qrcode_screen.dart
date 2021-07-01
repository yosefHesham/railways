import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:railways/model/ticket.dart';
import 'package:railways/public/colors.dart';
import 'package:screenshot/screenshot.dart';

class QrCode extends StatefulWidget {
  final Ticket ticket;
  final String ticketId;

  QrCode(this.ticket, this.ticketId);

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Public.textFieldColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              tileColor: Theme.of(context).primaryColor,
              title: Text(
                'Get Ticket',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Public.textFieldFillColor,
                    fontWeight: FontWeight.w400),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Colors.white,
                ),
                onPressed: () async {
                  final status = await Permission.storage.request();
                  if (status.isGranted) {
                    _widgetShot();
                  }
                },
              ),
            ),
          ),
          body: FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: JumpingText(
                            'Generating QR Code...',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Screenshot(
                          controller: screenshotController,
                          child: TicketWithQrCode(
                              source: widget.ticket.source,
                              destination: widget.ticket.destination,
                              date: widget.ticket.date,
                              price: widget.ticket.price,
                              ticketId: widget.ticketId)))),
    );
  }

  Future<void> _widgetShot() async {
    Uint8List imageCapture = await screenshotController.capture();

    if (imageCapture != null) {
      //Return path
      final pdf = pw.Document();
      final image = pw.MemoryImage(imageCapture);
      print("width: ${image.width}");
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(image),
        ); // Center
      })); // Page
      final outPut = await DownloadsPathProvider.downloadsDirectory;
      final pdfFile = File('${outPut.path}/pdfticket${DateTime.now()}.pdf');
      final result = await pdfFile.writeAsBytes(await pdf.save());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Saved to ${result.path}"),
      ));
    } else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('error'),
      ));
  }
}

class TicketWithQrCode extends StatelessWidget {
  const TicketWithQrCode({
    Key key,
    @required this.source,
    @required this.date,
    @required this.destination,
    @required this.price,
    @required this.ticketId,
  }) : super(key: key);

  final String source;
  final String destination;
  final num price;
  final String date;
  final String ticketId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Source:    $source'),
            Text('Destination:      $destination'),
            Text('Date:    $date'),
            Text('Price:    $price'),
            Center(
              child: QrImage(
                data: ticketId,
                size: 300,
              ),
            )
          ]),
    );
  }
}
