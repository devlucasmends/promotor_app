import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:promotor_app/src/features/products/services/product_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ProductServiceImp implements ProductService {
  @override
  Future<String> readBarCode() async {
    final code = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );

    if (code == '-1') {
      return '';
    }
    return code;
  }

  @override
  Future<String> getImage(ImageSource source) async {
    File? file;
    final imagePicker = ImagePicker();

    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      file = File(pickedFile.path);
    }

    return file!.path;
  }
}
