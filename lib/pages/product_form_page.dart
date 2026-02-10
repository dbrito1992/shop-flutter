import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formDataInputs.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formDataInputs['id'] = product.id;
        _formDataInputs['name'] = product.name;
        _formDataInputs['price'] = product.price;
        _formDataInputs['description'] = product.description;
        _formDataInputs['imageUrl'] = product.imageUrl;

        _imageUrlInput.text = product.imageUrl;
      }
    }
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

    Provider.of<ProdcutList>(
      context,
      listen: false,
    ).saveProduct(_formDataInputs);
    Navigator.of(context).pop();
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
                initialValue: _formDataInputs['name']?.toString() ?? '',
                decoration: InputDecoration(label: Text("Nome")),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onSaved: (name) => _formDataInputs['name'] = name ?? "-",
                validator: (nameParam) {
                  final name = nameParam ?? false;

                  if (name.toString().trim() == '') {
                    return 'Campo nome é obrigatorio';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formDataInputs['price']?.toString() ?? '',
                decoration: InputDecoration(label: Text("Preço")),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (price) =>
                    _formDataInputs['price'] = double.parse(price ?? '0'),
                validator: (priceParam) {
                  final price = priceParam ?? false;

                  if (price.toString().trim() == '') {
                    return 'Campo preço é obrigatorio';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formDataInputs['description']?.toString() ?? '',
                decoration: InputDecoration(label: Text("Descrição")),
                textInputAction: TextInputAction.next,
                focusNode: _imgUrlFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                maxLength: 150,
                onSaved: (description) =>
                    _formDataInputs['description'] = description ?? "-",
                validator: (descriptionParam) {
                  final description = descriptionParam ?? false;

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
                      onSaved: (imageUrl) =>
                          _formDataInputs['imageUrl'] = imageUrl ?? "-",
                      validator: (urlParam) {
                        final imageUrl = urlParam ?? false;

                        if (imageUrl.toString().trim() == '') {
                          return 'Campo url da imagem é obrigatorio';
                        }

                        if (!isValidUrl(imageUrl.toString())) {
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
