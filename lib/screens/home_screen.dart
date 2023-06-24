import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_text/widgets/notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result='Pick an image to extract the text';
  File? image;
  Future <File>? imageFile;
  bool isText =false;
  ImagePicker? imagePicker;
 final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
 
 
 @override
  void initState() {
    super.initState();
    imagePicker= ImagePicker();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd6f2e5),
      body: Column(
        children: [
const SizedBox(width: 100,),

Center(
  child:   Container(
    height: 400,
    width: 400,
    margin: const EdgeInsets.only(top: 70),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/stickynote.png'),
        fit: BoxFit.cover
        )
    ),
    child:
   
     Stack(
       children: [
         isText? Container(
          margin: const EdgeInsets.only(left: 65,top: 50),
           child: IconButton(onPressed: (){
           FlutterClipboard.copy(result);
      Notifications.showSnackBar('Copied!',context);
         }, icon: const Icon(Icons.copy,color: Colors.black87,)),
         ):const SizedBox() ,
        Center(
        child: Container(
          width: 250,
          height: 300,
          margin: const EdgeInsets.only(left: 25,right: 25),
          child: Padding(padding: const EdgeInsets.all(12.0),
          child: ListView(children: [Text(result,style: const TextStyle(fontSize: 16.0),textAlign: TextAlign.justify,)]
          ),),
        ),
         ),]
     ),
  ),
),
Container(
 margin: const EdgeInsets.only(top: 20,right: 20,left: 20),
 child: Stack(
  children: [

    Center(
      child: InkWell(
        onTap:()=>pickImageFromGallery(),
        onDoubleTap:()=>captureImage(),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
        width: 200,
        height: 250,
            margin: const EdgeInsets.only(top: 25),
            child: image !=null ?
             Image.file(image!,width: 140,height: 192,fit: BoxFit.fill,)
             : const Icon(Icons.add_a_photo,size: 100,color:Colors.black87,)
          ),
        ),)
    )

  ],),
 ),

      ],)
    );
  }

  void pickImageFromGallery() async{
XFile? pickedFile =await imagePicker?.pickImage(source: ImageSource.gallery);
image=File(pickedFile!.path);
setState(() {
  image;
  performImageLabeling();

  //extraxt text from image
});
  }

  void captureImage() async{
    XFile? pickedFile =await imagePicker?.pickImage(source: ImageSource.camera);
image=File(pickedFile!.path);
setState(() {
  image;

  performImageLabeling();
});
  }
  
  void performImageLabeling()async {
    final inputImage=InputImage.fromFilePath(image!.path);
    final recognizedText=await _textRecognizer.processImage(inputImage);
final value=recognizedText.text;

setState(() {
 if (value!='')
{
  result=value;
  isText=true;
} else {
  isText=false;
  result='No text recognized ';}
});
    
  }
}