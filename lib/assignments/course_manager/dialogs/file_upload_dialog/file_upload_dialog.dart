import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

class FileUploadDialog extends StatelessWidget {
  const FileUploadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "Import Course",
      content: Column(
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  'All files should be of type \'.csv\' following the format below.',
                ),
                const SizedBox(height: 12.0),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: WidgetZoom(
                    heroAnimationTag: 'upload_tag',
                    zoomWidget: Image.asset('sample_course_upload.png'),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No file selected.'),
                    const SizedBox(width: 16.0),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Upload'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
