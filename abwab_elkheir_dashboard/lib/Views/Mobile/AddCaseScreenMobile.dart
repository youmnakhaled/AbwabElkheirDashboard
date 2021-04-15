import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

////////////////
///import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/CasesViewModel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../Constants/ConstantColors.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

////////////////////////////

class AddCaseScreenMobile extends StatefulWidget {
  final deviceSize;

  const AddCaseScreenMobile({Key key, this.deviceSize}) : super(key: key);
  @override
  _AddCaseScreenMobileState createState() => _AddCaseScreenMobileState();
}

class _AddCaseScreenMobileState extends State<AddCaseScreenMobile> {
  AuthenticationViewModel auth;

  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  var initValues = {
    'title': '',
    'description': '',
    'status': '',
    'amount': '',
  };
  // var editedCase = Case(
  //   id: null,
  //   title: '',
  //   price: 0,
  //   description: '',
  //   imageUrl: '',
  // );
  //
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _statusFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    if (id != null) print(id);
    // final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(" حالة جديدة "),
          backgroundColor: ConstantColors.lightBlue,
          actions: [
            IconButton(
              padding: EdgeInsets.all(7),
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: initValues['title'],
                decoration: InputDecoration(labelText: 'عنوان الحالة'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'أدخل عنوان الحالة';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _editedProduct = Product(
                //       title: value,
                //       price: _editedProduct.price,
                //       description: _editedProduct.description,
                //       imageUrl: _editedProduct.imageUrl,
                //       id: _editedProduct.id,
                //       isFavorite: _editedProduct.isFavorite);
                // },
              ),
              TextFormField(
                initialValue: initValues['amount'],
                decoration: InputDecoration(labelText: 'المبلغ'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'أدخل المبلغ المطلوب للحالة';
                  }
                  if (double.tryParse(value) == null) {
                    return 'أدخل رقم صحيح لمبلغ الحالة ';
                  }
                  if (double.parse(value) <= 0) {
                    return 'يجب أن يكون المبلغ المطلوب للحالة أعلى من صفر.';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _editedProduct = Product(
                //       title: _editedProduct.title,
                //       price: double.parse(value),
                //       description: _editedProduct.description,
                //       imageUrl: _editedProduct.imageUrl,
                //       id: _editedProduct.id,
                //       isFavorite: _editedProduct.isFavorite);
                // },
              ),
              TextFormField(
                initialValue: initValues['description'],
                decoration: InputDecoration(labelText: 'التفاصيل'),
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'أدخل تفاصيل الحالة';
                  }
                  return null;
                },
                // onSaved: (value) {
                //   _editedProduct = Product(
                //     title: _editedProduct.title,
                //     price: _editedProduct.price,
                //     description: value,
                //     imageUrl: _editedProduct.imageUrl,
                //     id: _editedProduct.id,
                //     isFavorite: _editedProduct.isFavorite,
                //   );
                // },
              ),
              Expanded(
                child: DropdownButton(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_statusFocusNode);
                  },
                  isExpanded: true,
                  elevation: 10,
                  hint: Text(" درجة الحالة"),
                  //value: "init ",
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text("فى البداية"),
                    ),
                    DropdownMenuItem(
                      child: Text("قارب على الانتهاء "),
                    ),
                    DropdownMenuItem(
                      child: Text(" جاري التجميع "),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'رابط صورة الحالة'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        // _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'أدخل رابط الصورة';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'رابط الصورة غير صحيح';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'رابط الصورة غير صحيح';
                        }
                        return null;
                      },
                      // onSaved: (value) {
                      //   _editedProduct = Product(
                      //     title: _editedProduct.title,
                      //     price: _editedProduct.price,
                      //     description: _editedProduct.description,
                      //     imageUrl: value,
                      //     id: _editedProduct.id,
                      //     isFavorite: _editedProduct.isFavorite,
                      //   );
                      // },
                    ),
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
