import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:promotor_app/src/features/products/business/product_state.dart';
import 'package:promotor_app/src/features/products/business/product_store.dart';
import 'package:promotor_app/src/features/products/repositories/product_repository.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final int indexProduct;
  final String linkPhoto;
  final String description;
  final String barCode;
  final String validate;
  final bool isAddPage;
  const ProductPage({
    super.key,
    this.linkPhoto = '',
    this.description = '',
    this.barCode = '',
    this.validate = '',
    this.indexProduct = 0,
    required this.isAddPage,
    required this.title,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController description = TextEditingController();
  TextEditingController barCode = TextEditingController();
  TextEditingController validate = TextEditingController();
  late ProductStore productStore;

  var maskDate = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
    initialText: 'DD/MM/AAAA',
  );

  @override
  void initState() {
    super.initState();

    final productRepository = Provider.of<ProductRepository>(
      context,
      listen: false,
    );
    productStore = ProductStore(productRepository);
  }

  @override
  Widget build(BuildContext context) {
    description.text = widget.description;
    barCode.text = widget.barCode;
    validate.text = widget.validate;
    String pathPhoto = '';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        pathPhoto =
                            await productStore.getImage(ImageSource.gallery);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 100,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Descrição'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          controller: description,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 45,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Codigo de Barras'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              controller: barCode,
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            splashRadius: 30,
                            onPressed: () async {
                              barCode.text = await productStore.readBarCode();
                            },
                            icon: Container(
                              color: Colors.amber,
                              child: SvgPicture.asset(
                                'assets/icons/barcode_icon.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 120,
                        height: 45,
                        child: TextFormField(
                          inputFormatters: [
                            maskDate,
                          ],
                          decoration: const InputDecoration(
                            label: Text('Data de Validade'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          controller: validate,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.isAddPage) {
                      await productStore.addProduct(
                        ProductModel(
                          description: description.text,
                          barCode: barCode.text,
                          validate: maskDate.getMaskedText(),
                          linkPhoto: pathPhoto,
                        ),
                      );

                      await productStore.addImageStorage(
                        pathPhoto,
                        barCode.text,
                      );
                    } else {
                      await productStore.editProduct(
                        product: ProductModel(
                          description: description.text,
                          barCode: barCode.text,
                          validate: validate.text,
                          linkPhoto: pathPhoto,
                        ),
                        index: widget.indexProduct,
                      );

                      await productStore.addImageStorage(
                        pathPhoto,
                        barCode.text,
                      );
                    }
                    if (productStore.state is ProductSucessState) {
                      if (mounted) context.pop();
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
