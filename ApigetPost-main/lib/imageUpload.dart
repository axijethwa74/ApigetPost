import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUploadApi extends StatefulWidget {
  const ImageUploadApi({super.key});

  @override
  State<ImageUploadApi> createState() => _ImageUploadApiState();
}

class _ImageUploadApiState extends State<ImageUploadApi> {
  File? image;
  final _picker = ImagePicker();
  bool ShowSpinner = false;

  Future getImage() async {
    final pickFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickFile != null) {
      image = File(pickFile.path);
      setState(() {});
    } else {
      Text("Image is Null ");
    }
  }

  Future<void> UplaodImage() async {
    //Show Spinner
    setState(() {
      ShowSpinner = true;
    });
    //Read Image
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    //Image Url length
    var length = await image!.length();
    //Url
    var uri = Uri.parse("https://fakestoreapi.com/products");
    //Request

    var request = new http.MultipartRequest("POST", uri);

    request.fields["title"] = "Static Title";

    var multiipart = new http.MultipartFile("image", stream, length);

    request.files.add(multiipart);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        ShowSpinner = false;
      });
      print(response.statusCode);
      Text("Uploaded");
    } else {
      Text("failed");
      setState(() {
        ShowSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: ShowSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Image Up"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.amberAccent,
              child: image == null
                  ? GestureDetector(
                      onTap: (() {
                        getImage();
                      }),
                      child:
                          Container(child: Center(child: Text("Image Picker"))))
                  : Container(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                UplaodImage();
              },
              child: Container(
                height: 50,
                color: Colors.green,
                child: Text("Upload"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
