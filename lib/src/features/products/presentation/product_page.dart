import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:promotor_app/src/features/products/business/product_state.dart';
import 'package:promotor_app/src/features/products/business/product_store.dart';
import 'package:promotor_app/src/features/products/repositories/product_repository.dart';
import 'package:promotor_app/src/shared/componets/my_clipper.dart';
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
  String pathPhoto = '';

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
    pathPhoto = widget.linkPhoto;
  }

  void showSnackBar({required Color? color, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        behavior: SnackBarBehavior.floating,
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    description.text = widget.description;
    barCode.text = widget.barCode;
    validate.text = widget.validate;

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
          child: Observer(builder: (context) {
            if (productStore.state is ProductFailureState) {
              final errorMessage =
                  (productStore.state as ProductFailureState).errorMessage;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackBar(color: Colors.red[300], message: errorMessage);
              });
            }

            if (productStore.state is ProductLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 150,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // InkWell(
                                        //   onTap: () async {
                                        //     pathPhoto = await productStore
                                        //         .getImage(ImageSource.camera);
                                        //   },
                                        //   splashFactory:
                                        //       NoSplash.splashFactory,
                                        //   child: const ListTile(
                                        //     leading: Icon(Icons.camera_alt),
                                        //     title: Text('Câmera'),
                                        //   ),
                                        // ),
                                        // const Divider(),
                                        InkWell(
                                          onTap: () async {
                                            if (barCode.text.isNotEmpty ||
                                                barCode.text != '') {
                                              context.pop();

                                              await productStore
                                                  .getImage(
                                                    source: ImageSource.gallery,
                                                    barCode: widget.barCode,
                                                  )
                                                  .then(
                                                    (value) =>
                                                        pathPhoto = value,
                                                  )
                                                  .onError((error, stackTrace) {
                                                setState(() {});
                                                return '';
                                              });
                                            } else {
                                              context.pop();
                                              showSnackBar(
                                                  color: Colors.red[300],
                                                  message:
                                                      'Preencha o Código de Barras');
                                            }
                                          },
                                          splashFactory: NoSplash.splashFactory,
                                          child: const ListTile(
                                            leading:
                                                Icon(Icons.panorama_outlined),
                                            title: Text('Galeria'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ClipOval(
                            clipper: MyClipper(),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.green,
                              ),
                              child: pathPhoto.isEmpty || pathPhoto == ''
                                  ? const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 100,
                                      color: Colors.black,
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: pathPhoto,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 100,
                                        color: Colors.black,
                                      ),
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
                                  barCode.text =
                                      await productStore.readBarCode();
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
                          if (productStore.checkSingleBarCode(
                            barCode: barCode.text,
                          )) {
                            await productStore.addProduct(
                              ProductModel(
                                description: description.text,
                                barCode: barCode.text,
                                validate: maskDate.getMaskedText(),
                                linkPhoto: pathPhoto,
                              ),
                            );
                          } else {
                            showSnackBar(
                                color: Colors.red[300],
                                message: 'Codigo de Barras já existe na lista');
                          }
                        } else {
                          if (productStore.checkSingleBarCode(
                              barCode: barCode.text)) {
                            await productStore.editProduct(
                              product: ProductModel(
                                description: description.text,
                                barCode: barCode.text,
                                validate: validate.text,
                                linkPhoto: pathPhoto,
                              ),
                              index: widget.indexProduct,
                            );
                          } else {
                            showSnackBar(
                                color: Colors.red[300],
                                message: 'Codigo de Barras já existe na lista');
                          }
                        }
                        if (productStore.state is ProductSucessState) {
                          if (mounted) context.pop();
                        }
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  //TODO: Quando Salva reseta o conteudo da patPhoto
  // Widget changeImageProduct(){
  //   return Text();

  // }

  /**
   *                              widget.linkPhoto.isEmpty ||
                                      widget.linkPhoto == ''
                                  ? const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 100,
                                      color: Colors.black,
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: widget.linkPhoto,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 100,
                                        color: Colors.black,
                                      ),
                                    ),
   */
}
