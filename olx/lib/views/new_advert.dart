import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/models/advert.dart';
import 'package:olx/util/olx_settings.dart';
import 'package:olx/views/widgets/button_custom.dart';
import 'package:olx/views/widgets/input_custom.dart';
import 'package:validadores/validadores.dart';

class NewAdvert extends StatefulWidget {
  const NewAdvert({super.key});

  @override
  State<NewAdvert> createState() => _NewAdvertState();
}

class _NewAdvertState extends State<NewAdvert> {
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();
  List<File> _listImages = [];
  List<DropdownMenuItem<String>> _listState = [];
  List<DropdownMenuItem<String>> _listCategories = [];

  late Advert advert;

  String selectedState = '';
  String selectedCategory = '';

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerFone = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  
  BuildContext? _dialogContext;

  _selectImageGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if  ( image != null ) {
      setState(() {
        _listImages.add(File(image.path));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    
    _loadingItensDropdown();

    advert = Advert.generateId();
  }

  _loadingItensDropdown() {
    _listState = OlxSettings.getStates();

    _listCategories = OlxSettings.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo anúncio'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormField(
                  initialValue: _listImages,
                  validator: (images) {
                    if ( images!.isEmpty ) {
                        return 'Por favor, selecione uma imagem.';
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: _listImages.length + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if ( index == _listImages.length ) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric( horizontal: 8),
                                  child: GestureDetector(
                                    onTap: _selectImageGallery,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.grey[100]
                                          ),
                                          Text(
                                            'Adicionar',
                                            style: TextStyle(
                                              color: Colors.grey[100]
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if ( _listImages.isNotEmpty ) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.file( _listImages[index]),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _listImages.removeAt(index);
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Excluir',
                                                    style: TextStyle(
                                                      color: Colors.red
                                                    ),
                                                  ),

                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(_listImages[index]),
                                      radius: 50,
                                      child: Container(
                                        color: const Color.fromRGBO(255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.delete, color: Colors.red,),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }
                          ),
                        ),
                        if (state.hasError)
                          Text(
                            "[${state.errorText!}]",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14
                            ),
                          )
                      ],
                    );
                  }
                ),
                Row(
                  children: [
                    dropField(
                      hint: 'Estado',
                      listState: _listState,
                      onChanged: (value) {
                        setState(() {
                          selectedState = value!;
                        });
                      },
                      onSaved: (value) {
                        advert.state = value;
                      }
                    ),
                    dropField(
                      hint: 'Categorias',
                      listState: _listCategories,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      onSaved: (value) {
                        advert.category = value;
                      }
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustom(
                    controller: _controllerTitle,
                    hintText: 'Título',
                    validator: (value) {
                      return Validador().add(
                        Validar.OBRIGATORIO,
                        msg: "Campo Obrigatório."
                      ).valido(value);
                    },
                    onSaved: (title) {
                      advert.title = title;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustom(
                    controller: _controllerPrice,
                    hintText: 'Preço',
                    type: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(moeda: true)
                    ],
                    validator: (value) {
                      return Validador().add(
                        Validar.OBRIGATORIO,
                        msg: "Campo Obrigatório."
                      ).valido(value);
                    },
                    onSaved: (price) {
                      advert.price = price;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustom(
                    controller: _controllerFone,
                    hintText: 'Telefone',
                    type: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (value) {
                      return Validador().add(
                        Validar.OBRIGATORIO,
                        msg: "Campo Obrigatório."
                      ).valido(value);
                    },
                    onSaved: (phone) {
                      advert.phone = phone;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustom(
                    controller: _controllerDescription,
                    hintText: 'Descrição (200 caracteres)',
                    maxLines: null,
                    validator: (value) {
                      return Validador().add(
                        Validar.OBRIGATORIO,
                        msg: "Campo Obrigatório."
                      )
                      .maxLength(200, msg: 'Maximo de 200 caracteres.')
                      .valido(value);
                    },
                    onSaved: (description) {
                      advert.description = description;
                    },
                  ),
                ),
                ButtonCustom(
                  text: 'Cadastrar anúncio',
                  onPressed: () {
                    if ( _formKey.currentState!.validate() ) {
                      _formKey.currentState!.save();
                      _dialogContext = context;
                      _saveAdvert();
                    }
                  }
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  Expanded dropField({
    required String hint,
    required List<DropdownMenuItem<String>> listState,
    required void Function(String? value)? onChanged,
    void Function(String? value)? onSaved
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField(
          hint: Text(hint),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20
          ),
          validator: (value) {
            return Validador().add(
              Validar.OBRIGATORIO,
              msg: 'Campo obrigatório.'
            ).valido(value);
          },
          items: listState,
          onChanged: onChanged,
          onSaved: onSaved,
        ),
      ),
    );
  }

  _saveAdvert() async {
    _showDialogSavingAdvert(_dialogContext);
    await _uplodImages();

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('my_adverts')
      .doc(user!.uid)
      .collection('adverts')
      .doc(advert.id)
      .set(advert.toMap()).then((_) {
        firestore.collection('adverts')
          .doc(advert.id)
          .set(advert.toMap()).then((_) {
            if ( _dialogContext != null ) {
              Navigator.pop(_dialogContext!);
            }
            Navigator.pop(context);
          });
      });
  }

  Future _uplodImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference rootFolder = storage.ref();
    for (var image in _listImages as Iterable) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference file = rootFolder
        .child('my_adverts')
        .child(advert.id)
        .child(fileName);

      UploadTask uploadTask = file.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      advert.photos!.add(url);
    }
  }

  _showDialogSavingAdvert(BuildContext? context) {
    if (context == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Savando anúncio...')
            ],
          ),
        );
      }
    );
  }
}

