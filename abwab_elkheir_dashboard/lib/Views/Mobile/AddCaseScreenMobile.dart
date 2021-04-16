import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';

import '../../Constants/ConstantColors.dart';

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

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _statusFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Image _imageSelected;

  Future chooseImage() async {
    //Image _image = await FlutterWebImagePicker.getImage;
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    print("selectedddd");
    print(image);
    setState(() {
      //_imageSelected = _image;
    });
  }

  // void _updateImageUrl() {
  //   if (!_imageUrlFocusNode.hasFocus) {
  //     if ((!_imageUrlController.text.startsWith('http') &&
  //             !_imageUrlController.text.startsWith('https')) ||
  //         (!_imageUrlController.text.endsWith('.png') &&
  //             !_imageUrlController.text.endsWith('.jpg') &&
  //             !_imageUrlController.text.endsWith('.jpeg'))) {
  //       return;
  //     }
  //     setState(() {});
  //   }
  // }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _statusFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    //final id = context.vRouter.pathParameters['id'];
    //final id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: ConstantColors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFieldWidget(
                  initialValue: initValues['title'],
                  deviceSize: deviceSize,
                  labelText: 'عنوان الحالة',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل عنوان الحالة';
                    }
                    return null;
                  },
                  textDirection: TextDirection.rtl,
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
                TextFieldWidget(
                  initialValue: initValues['amount'],
                  textInputAction: TextInputAction.next,
                  textDirection: TextDirection.rtl,
                  inputType: TextInputType.number,
                  deviceSize: deviceSize,
                  labelText: ' المبلغ المطلوب',
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل المبلغ المطلوب للحالة';
                    }
                    if (double.tryParse(value) == null) {
                      return 'أدخل رقم صحيح لمبلغ الحالة ';
                    }
                    if (double.parse(value) <= 0) {
                      return 'يجب أن يكون المبلغ  من صفر.';
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
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: deviceSize.width * 0.3 < 250
                      ? 250
                      : deviceSize.width * 0.3,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_statusFocusNode);
                        },
                        isExpanded: true,
                        elevation: 10,
                        hint: Text(" درجة الحالة"),
                        value: initValues['status'] == ''
                            ? null
                            : initValues['status'],
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            value: "فى البداية",
                            child: Text("فى البداية"),
                          ),
                          DropdownMenuItem(
                            value: "قارب على الانتهاء ",
                            child: Text("قارب على الانتهاء "),
                          ),
                          DropdownMenuItem(
                            value: " جاري التجميع ",
                            child: Text(" جاري التجميع "),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            initValues['status'] = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                TextFieldWidget(
                  initialValue: initValues['description'],
                  deviceSize: deviceSize,
                  labelText: 'التفاصيل',
                  maxLines: 14,
                  textDirection: TextDirection.rtl,
                  inputType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validate: (value) {
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
                SizedBox(
                  height: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: deviceSize.width * 0.3 < 250
                            ? 250
                            : deviceSize.width * 0.3,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: _imageSelected == null
                            ? Image.asset('assets/placeholder.png')
                            : Image(image: _imageSelected.image)),
                    Container(
                      width: deviceSize.width * 0.3 < 250
                          ? 250
                          : deviceSize.width * 0.3,
                      margin: EdgeInsets.all(deviceSize.height * 0.01),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.black26),
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Expanded(
                              child: TextButton.icon(
                                onPressed: chooseImage,
                                icon: Icon(Icons.upload_rounded),
                                label: Text(
                                  'اختار صورة للحالة',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveForm();
                    },
                    child: Text('حفظ'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            ConstantColors.lightBlue)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
