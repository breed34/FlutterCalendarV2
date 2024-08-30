import 'dart:async';

import 'package:calendar_v2/assignments/course_manager/dialogs/file_upload_dialog/file_upload_dialog_presenter.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:calendar_v2/assignments/shared/color_dropdown_widget.dart';
import 'package:calendar_v2/assignments/shared/course_csv_parser.dart';
import 'package:calendar_v2/server/dtos/create_course_request.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:widget_zoom/widget_zoom.dart';

class FileUploadDialog extends StatefulWidget {
  const FileUploadDialog({super.key});

  @override
  State<FileUploadDialog> createState() => _FileUploadDialogState();
}

class _FileUploadDialogState extends State<FileUploadDialog> {
  final FileUploadDialogPresenter _presenter = FileUploadDialogPresenter();
  final BehaviorSubject<bool> _uploadDisabled = BehaviorSubject.seeded(true);
  final BehaviorSubject<PlatformFile?> _pickedFile = BehaviorSubject();
  final DropdownController<AssignmentColor> _colorController =
      DropdownController();
  late final StreamSubscription<bool> _uploadDisabledSub;

  @override
  void initState() {
    _uploadDisabledSub = Rx.combineLatest2(
      _pickedFile,
      _colorController.getStream(),
      (a, b) => a == null || b == null,
    ).listen((event) {
      _uploadDisabled.sink.add(event);
    });

    super.initState();
  }

  @override
  void dispose() {
    _uploadDisabledSub.cancel();
    super.dispose();
  }

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
                const SizedBox(height: 16.0),
                ColorDropdownWidget(
                  label: 'Default Color',
                  controller: _colorController,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<PlatformFile?>(
                      stream: _pickedFile.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.name);
                        } else {
                          return const Text('No file selected.');
                        }
                      },
                    ),
                    const SizedBox(width: 16.0),
                    IconButton(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.upload_file_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                StreamBuilder<bool>(
                  stream: _uploadDisabled.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FilledButton(
                        onPressed: snapshot.data!
                            ? null
                            : () {
                                _uploadFile(context);
                              },
                        child: const Text('Upload'),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      _pickedFile.sink.add(result.files.single);
    }
  }

  void _uploadFile(BuildContext context) {
    try {
      _presenter.createCourseFromFile(
        _pickedFile.value!.bytes!,
        _colorController.value!,
      );

      Navigator.of(context).pop();
    } on CourseCSVParseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
