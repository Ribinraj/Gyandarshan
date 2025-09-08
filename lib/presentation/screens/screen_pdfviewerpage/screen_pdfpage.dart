
import 'package:flutter/material.dart';
import 'package:gyandarshan/core/constants.dart';
import 'package:gyandarshan/domain/controllers/pdf_service.dart';
import 'package:gyandarshan/presentation/screens/screen_splashpage/screen_splashpage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';

import 'package:dio/dio.dart';
import 'dart:typed_data';

class ScreenPdfViewer extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const ScreenPdfViewer({super.key, required this.pdfUrl, required this.title});

  @override
  State<ScreenPdfViewer> createState() => _ScreenPdfViewerState();
}

class _ScreenPdfViewerState extends State<ScreenPdfViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  bool _isLoading = true;
  String? _error;
  double _currentZoom = 1.0;
  int _currentPage = 1;
  int _totalPages = 0;
  Uint8List? _pdfData;
  int _downloadProgress = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
        _pdfData = null;
        _downloadProgress = 0;
      });

      final pdfData = await PdfService.downloadPdf(
        widget.pdfUrl,
        onProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = ((received / total) * 100).round();
            });
          }
        },
      );

      if (pdfData != null) {
        setState(() {
          _pdfData = pdfData;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to download PDF';
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      setState(() {
        _error = PdfService.formatDioError(e);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Unexpected error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _showZoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Zoom Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [50, 75, 100, 125, 150, 200].map((zoom) {
            return ListTile(
              title: Text('$zoom%'),
              onTap: () {
                _pdfViewerController.zoomLevel = zoom / 100.0;
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showPageNavigationDialog() {
    final TextEditingController pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextStyles.body(text: 'Go to page'),
        content: TextField(
          controller: pageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle:TextStyle(color: AppColors.kprimarycolor),
            hintText: 'Enter page number (1-$_totalPages)',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final pageNumber = int.tryParse(pageController.text);
              if (pageNumber != null &&
                  pageNumber >= 1 &&
                  pageNumber <= _totalPages) {
                _pdfViewerController.jumpToPage(pageNumber);
                Navigator.pop(context);
              }
            },
            child:TextStyles.medium(text: 'Go', color: Appcolors.kprimarycolor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => CustomNavigation.pop(context),
          icon: const Icon(Icons.chevron_left, size: 27),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Appcolors.kprimarycolor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (_totalPages > 0) ...[
            IconButton(
              onPressed: _showZoomDialog,
              icon: const Icon(Icons.zoom_in),
              tooltip: 'Zoom',
            ),
            IconButton(
              onPressed: _showPageNavigationDialog,
              icon: const Icon(Icons.format_list_numbered),
              tooltip: 'Go to Page',
            ),
          ],
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'fit_width':
                  _pdfViewerController.zoomLevel = 1.0;
                  break;
                case 'fit_height':
                  _pdfViewerController.zoomLevel = 1.2;
                  break;
                case 'refresh':
                  _downloadPdf();
                  break;
              }
            },
            itemBuilder: (context) => [
              if (_totalPages > 0) ...[
                const PopupMenuItem(
                  value: 'fit_width',
                  child: Row(
                    children: [
                      Icon(Icons.fit_screen, color: Appcolors.kprimarycolor),
                      SizedBox(width: 8),
                      Text('Fit Width'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'fit_height',
                  child: Row(
                    children: [
                      Icon(Icons.height, color: Appcolors.kprimarycolor),
                      SizedBox(width: 8),
                      Text('Fit Height'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
              ],
              const PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    Icon(Icons.refresh, color: Appcolors.kprimarycolor),
                    SizedBox(width: 8),
                    Text('Refresh'),
                  ],
                ),
              ),
            ],
          ),
        ],
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          // Page indicator
          if (_totalPages > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page $_currentPage of $_totalPages',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Zoom: ${(_currentZoom * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // PDF Viewer
          Expanded(
            child: _error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Error loading PDF',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _downloadPdf,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  )
                : _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: Appcolors.kprimarycolor,
                        ),
                        const SizedBox(height: 16),
                        const Text('Loading...'),
                        if (_downloadProgress > 0) ...[
                          const SizedBox(height: 8),
                          Text(
                            '$_downloadProgress%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(
                              color: Appcolors.kprimarycolor,
                              value: _downloadProgress / 100,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : _pdfData != null
                ? SfPdfViewer.memory(
                    _pdfData!,
                    key: _pdfViewerKey,
                    controller: _pdfViewerController,
                    canShowPaginationDialog: false,
                    enableDoubleTapZooming: true,
                    canShowScrollHead: false,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      setState(() {
                        _totalPages = details.document.pages.count;
                      });
                    },
                    onPageChanged: (PdfPageChangedDetails details) {
                      setState(() {
                        _currentPage = details.newPageNumber;
                      });
                    },
                    onZoomLevelChanged: (PdfZoomDetails details) {
                      setState(() {
                        _currentZoom = details.newZoomLevel;
                      });
                    },
                  )
                : const Center(child: Text('No PDF data available')),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: _totalPages > 0
          ? Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _currentPage > 1
                        ? () => _pdfViewerController.previousPage()
                        : null,
                    icon: const Icon(Icons.chevron_left),
                    tooltip: 'Previous Page',
                  ),
                  IconButton(
                    onPressed: () {
                      final newZoom = (_pdfViewerController.zoomLevel - 0.25)
                          .clamp(0.25, 4.0);
                      _pdfViewerController.zoomLevel = newZoom;
                    },
                    icon: const Icon(Icons.zoom_out),
                    tooltip: 'Zoom Out',
                  ),
                  IconButton(
                    onPressed: () {
                      _pdfViewerController.zoomLevel = 1.0;
                    },
                    icon: const Icon(Icons.center_focus_strong),
                    tooltip: 'Reset Zoom',
                  ),
                  IconButton(
                    onPressed: () {
                      final newZoom = (_pdfViewerController.zoomLevel + 0.25)
                          .clamp(0.25, 4.0);
                      _pdfViewerController.zoomLevel = newZoom;
                    },
                    icon: const Icon(Icons.zoom_in),
                    tooltip: 'Zoom In',
                  ),
                  IconButton(
                    onPressed: _currentPage < _totalPages
                        ? () => _pdfViewerController.nextPage()
                        : null,
                    icon: const Icon(Icons.chevron_right),
                    tooltip: 'Next Page',
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
