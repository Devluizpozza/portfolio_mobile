import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portfolio_app/app/consts/const.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfControllerPinch pdfControllerPinch;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset(Const.assetPathCV),
    );
  }

  Future<void> _sharePDF() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/$Const.assetPathCV');

      final byteData = await rootBundle.load(Const.assetPathCV);
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      if (await tempFile.exists()) {
        debugPrint('Arquivo salvo em: ${tempFile.path}');
        await Share.shareXFiles([
          XFile(tempFile.path),
        ], text: 'Confira este PDF!');
      } else {
        debugPrint('Erro: Arquivo não encontrado.');
      }
    } catch (e) {
      debugPrint('Erro ao compartilhar o PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _sharePDF),
        ],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(mainAxisSize: MainAxisSize.max, children: [_pdfView()]);
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
      ),
    );
  }
}
