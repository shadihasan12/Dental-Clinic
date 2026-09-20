import 'dart:typed_data';

import 'package:dental_clinic_app/features/patients/presentation/widgets/details/case_file_preview.dart';
import 'package:flutter_test/flutter_test.dart';

/// The attachment API returns a signed URL with no extension and, often, no
/// file name - so what a case file actually is gets decided by these two
/// functions. Getting it wrong means a PDF rendered as a broken image, or a
/// photo sent to a PDF parser.
void main() {
  Uint8List bytes(List<int> head) =>
      Uint8List.fromList([...head, ...List.filled(16, 0)]);

  group('from the bytes', () {
    test('reads a PDF header', () {
      // '%PDF'
      expect(FileKind.ofBytes(bytes([0x25, 0x50, 0x44, 0x46])), FileKind.pdf);
    });

    test('reads the common image headers', () {
      expect(FileKind.ofBytes(bytes([0x89, 0x50, 0x4E, 0x47])), FileKind.image);
      expect(FileKind.ofBytes(bytes([0xFF, 0xD8, 0xFF, 0xE0])), FileKind.image);
      expect(FileKind.ofBytes(bytes([0x47, 0x49, 0x46, 0x38])), FileKind.image);
      expect(FileKind.ofBytes(bytes([0x42, 0x4D, 0x00, 0x00])), FileKind.image);
    });

    test('anything unrecognised is other, not a guess', () {
      expect(FileKind.ofBytes(bytes([0x00, 0x01, 0x02, 0x03])), FileKind.other);
    });

    test('a truncated download is other rather than a crash', () {
      expect(FileKind.ofBytes(Uint8List.fromList([0x25])), FileKind.other);
      expect(FileKind.ofBytes(Uint8List(0)), FileKind.other);
    });
  });

  group('from the name', () {
    test('reads the extension, whatever its case', () {
      expect(FileKind.ofName('lab-report.pdf'), FileKind.pdf);
      expect(FileKind.ofName('Scan.PDF'), FileKind.pdf);
      expect(FileKind.ofName('xray.JPG'), FileKind.image);
    });

    test('says nothing when the name says nothing', () {
      // A signed URL with no extension, and the media id the payload
      // sometimes arrives as - neither is evidence of anything.
      expect(FileKind.ofName(null), isNull);
      expect(FileKind.ofName('01a053eb-9e79-73d8-991c-6696c40496c5'), isNull);
      expect(FileKind.ofName('trailing.'), isNull);
    });

    test('an extension it does not know is other, not null', () {
      // Distinct from "no name": the file is known to be a document of some
      // kind, so the viewer can offer the way out instead of guessing.
      expect(FileKind.ofName('notes.docx'), FileKind.other);
    });
  });
}
