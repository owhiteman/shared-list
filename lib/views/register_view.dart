import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_list/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_list/widgets/button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  Uint8List? _image;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    } else {
      print('No image selected');
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const SizedBox(height: 10),
          TextField(
            controller: _name,
            enableSuggestions: false,
            autocorrect: false,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(hintText: 'Enter your name here'),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email address here',
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _confirmPassword,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Confirm your password here',
            ),
          ),
          const SizedBox(height: 20),
          //circular widget to show accepted file
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                        "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                      ),
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: const Icon(Icons.add_a_photo),
                  ))
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          CustomButton(
            onPressed: () {
              if (_name.text.isNotEmpty &&
                  _email.text.isNotEmpty &&
                  (_password.text.isNotEmpty &&
                      _password.text == _confirmPassword.text)) {
                context.read<AuthService>().signUp(
                      email: _email.text.trim(),
                      password: _password.text.trim(),
                      name: _name.text,
                      file: _image,
                    );
                Navigator.of(context).pop();
              } else {
                print('Password must be the same as confirm password');
              }
            },
            inputText: 'Register',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('If you are already registered, click'),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text(' here to log in'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
