import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imgUrlFocus = FocusNode();

  final _imageUrlInput = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  final Map<String, Object> _formDataInputs = {};

  @override
  void initState() {
    super.initState();
    _imageUrlInput.addListener(updateState);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imgUrlFocus.dispose();
    _imageUrlInput.removeListener(updateState);
  }

  void updateState() {
    setState(() {});
  }

  bool isValidUrl(String url) {
    bool withFile = Uri.tryParse(url)!.hasAbsolutePath;
    bool isWithFileExtension =
        url.toLowerCase().endsWith(".png") ||
        url.toLowerCase().endsWith(".jpg") ||
        url.toLowerCase().endsWith(".jpeg");
    return withFile && isWithFileExtension;
  }

  void onSubmitForm() {
    final isValid = _keyForm.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _keyForm.currentState!.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: _formDataInputs['name'] as String,
      description: _formDataInputs['description'] as String,
      price: _formDataInputs['price'] as double,
      imageUrl: _formDataInputs['url'] as String,
    );

    print(newProduct.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Produtos"),
        actions: [IconButton(onPressed: onSubmitForm, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _keyForm,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Nome")),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onSaved: (name) => _formDataInputs['name'] = name ?? "-",
                validator: (_name) {
                  final name = _name ?? false;

                  if (name.toString().trim() == '') {
                    return 'Campo nome é obrigatorio';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Preço")),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (price) =>
                    _formDataInputs['price'] = double.parse(price ?? '0'),
                validator: (_price) {
                  final price = _price ?? false;

                  if (price.toString().trim() == '') {
                    return 'Campo preço é obrigatorio';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Descrição")),
                textInputAction: TextInputAction.next,
                focusNode: _imgUrlFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                maxLength: 150,
                onSaved: (description) =>
                    _formDataInputs['description'] = description ?? "-",
                validator: (_description) {
                  final description = _description ?? false;

                  if (description.toString().trim() == '') {
                    return 'Campo descrição é obrigatorio';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text("URL da imagem")),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlInput,
                      onFieldSubmitted: (_) => onSubmitForm(),
                      onSaved: (url) => _formDataInputs['url'] = url ?? "-",
                      validator: (_url) {
                        final url = _url ?? false;

                        if (url.toString().trim() == '') {
                          return 'Campo url da imagem é obrigatorio';
                        }

                        if (!isValidUrl(url.toString())) {
                          return 'Url inválida! Extenções aceitas: png, jpg e jpeg.';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.black87, width: 1),
                    ),
                    child: _imageUrlInput.text.isEmpty
                        ? Text("Sem imagem!")
                        : FittedBox(child: Image.network(_imageUrlInput.text)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
