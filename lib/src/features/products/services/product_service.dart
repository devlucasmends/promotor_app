import 'package:image_picker/image_picker.dart';

abstract class ProductService {
  Future<String> readBarCode();

  Future<String> getImage(ImageSource source);
}
