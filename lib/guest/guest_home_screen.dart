import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:tflite/tflite.dart';
import 'guest_account.dart';


class guesthomeScreen extends StatefulWidget{
  @override
  _guesthomeScreen createState() => _guesthomeScreen();

  void initState()  {
    loadModel();
  }
}

Future loadModel() async {
  String model = (await Tflite.loadModel(model: 'assets/my_model.tflite', labels: 'assets/labels.txt'))!;
  if (kDebugMode) {
    print('Model loading status: $model');
  }
}

class _guesthomeScreen extends State<guesthomeScreen> {

  File? _image;
  List? _results;
  bool imageSelect= false;
  bool showWelcomeMessage = true;

  // get classify => _results.toString().split('label:').last.replaceAll(RegExp(r'[}\]]'),'');


  void clearResults() {
    setState(() {
      _results = null;
      _image = null;
      imageSelect = false;
      showWelcomeMessage=true;
    });
  }

  @override
  void initState()
  {
    super.initState();
    loadModel();
  }


  Future imageClassification(File image)
  async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results=recognitions!;
      _image=image;
      imageSelect=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SpinCircleBottomBarHolder(
                bottomNavigationBar: SCBottomBarDetails(
                  items: [
                    SCBottomBarItem(icon: Icons.home, onPressed: (){}),
                    SCBottomBarItem(icon: Icons.account_circle, onPressed: (){
                      clearResults();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  guestManageAccount()),


                      );
                    }),
                  ],
                  circleItems: [
                    SCItem(icon: Icon(Icons.camera_alt), onPressed: pickFromCamera),
                    SCItem(icon: Icon(Icons.photo), onPressed: pickFromGallery),
                  ],
                ),
                child: Column(

                    children: [
                      Card(
                        elevation: 4,
                        margin: EdgeInsets.all(16.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showWelcomeMessage)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome to the Application!',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Instructions:',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '1. Press the + button located at the bottom of the screen.',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '2. Choose whether to capture an image from the camera or select one from the gallery.',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '3. The selected image will be displayed on the screen.',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '4. If applicable, any detected results or classifications will be shown below the image.',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                  ],
                                ),
                              Column(
                                children: [
                                  if (_image != null)
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Image.file(_image!),
                                    ),
                                  if (_results != null)

                                    ..._results!.map((result) {
                                      showWelcomeMessage=false;
                                      return Card(
                                        color: Colors.limeAccent.shade100,
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          child: Text(
                                            result['label'].toString().split('label:').last,
                                            style: const TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold,),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      getTreatment(_results.toString().split('label:').last.replaceAll(RegExp(r'[}\]]'), '')),

                                      style: TextStyle(
                                        fontSize: 18.0,

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
            )
        )
    );
  }


  // Future addDetection(String userId, String classification, String imageUrl) {
  //   CollectionReference detections = FirebaseFirestore.instance.collection('detections');
  //   return detections.add({
  //     'userId': userId,
  //     'classification': classification,
  //     'imageUrl': imageUrl,
  //
  //   })
  //       .then((value) => print('Detection added'))
  //       .catchError((error) => print('Failed to add detection: $error'));
  // }

  Future  pickFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);



  }


  Future pickFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);

  }

  getTreatment(classification){
    print(classification);
    if (classification.trim() == 'Apple Blackrot') {
      return 'Fungicide treatments can be effective in controlling apple black rot. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Removing and destroying infected fruit and canes can also help reduce the spread of the disease.';
    } else if (classification.trim() == 'Apple Cedar apple rust') {
      return 'Fungicide treatments can be effective in controlling cedar apple rust. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Other cultural practices like removing infected leaves and debris can also help reduce the spread of the disease.';
    } else if (classification.trim() == 'Apple healthy') {
      return 'No treatment is necessary for healthy apple trees, but proper care like regular pruning, irrigation, and fertilization can help maintain tree health.';
    } else if (classification.trim() == 'Apple scab') {
      return 'Fungicide treatments can be effective in controlling apple scab. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Other cultural practices like removing infected leaves and debris can also help reduce the spread of the disease.';
    } else if (classification.trim() == 'Blueberry healthy') {
      return 'No treatment is necessary for healthy blueberry plants, but proper care like regular pruning, irrigation, and fertilization can help maintain plant health.';
    }
    else if (classification.trim() == 'Cherry including sour Powdery mildew') {
      return 'Fungicide treatments can be effective in controlling powdery mildew on cherry trees. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Removing infected leaves can also help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Cherry including sour healthy') {
      return 'No treatment is necessary for healthy cherry trees, but proper care like regular pruning, irrigation, and fertilization can help maintain tree health.';
    }
    else if (classification.trim() == 'Corn maize Cercospora leaf spot Gray leaf spot') {
      return 'Fungicide treatments can be effective in controlling cercospora leaf spot and gray leaf spot on corn. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Crop rotation and proper field sanitation can also help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Corn maize Common rust') {
      return 'Fungicide treatments can be effective in controlling common rust on corn. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Crop rotation and proper field sanitation can also help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Corn maize Northern Leaf Blight') {
      return 'Fungicide treatments can be effective in controlling northern leaf blight on corn. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Crop rotation and proper field sanitation can also help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Corn maize healthy') {
      return 'No treatment is necessary for healthy corn plants, but proper care like crop rotation, irrigation, and fertilization can help maintain plant health.';
    }
    else if (classification.trim() == 'Grape Black rot') {
      return 'Fungicide treatments can be effective in controlling black rot on grapes. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Removing and destroying infected fruit and canes can also help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Grape Esca Black Measles') {
      return 'No effective treatment is currently available for esca and black measles diseases in grapes. Cultural practices like pruning infected wood and removing infected vines can help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Grape Leaf blight Isariopsis Leaf Spot') {
      return 'Fungicide treatments can be effective in controlling leaf blight and isariopsis leaf spot on grapes. It is recommended to apply the fungicide before the disease appears, as a preventative measure. Removing infected leaves can also help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Grape healthy') {
      return 'No treatment is necessary for healthy grapevines, but proper care like regular pruning, irrigation, and fertilization can help maintain vine health.';
    }
    else if (classification.trim() == 'Orange Haunglongbing Citrus greening') {
      return 'No effective treatment is currently available for Huanglongbing disease in citrus trees. Cultural practices like removal of infected trees and insect vector management can help reduce the spread of the disease.';
    }
    else if (classification.trim() == 'Peach Bacterial spot') {
      return 'Apply copper-based fungicides during the dormant season. Prune and remove infected branches or fruits. Practice good sanitation and proper irrigation techniques to reduce the spread of bacteria.';
    }
    else if (classification.trim() == 'Peach healthy') {
      return 'No specific treatment is required. Monitor the tree for any signs of disease or pests and maintain good overall tree health.';
    }
    else if (classification.trim() == 'Pepper bell Bacterial spot') {
      return 'Apply copper-based fungicides or bactericides as a preventive measure. Remove and destroy infected plants or plant parts. Practice crop rotation and avoid overhead irrigation.';
    }
    else if (classification.trim() == 'Pepper bell healthy') {
      return 'No specific treatment required. Maintain proper garden management practices.';
    }
    else if (classification.trim() == 'Potato Early blight') {
      return 'Apply fungicides containing chlorothalonil or mancozeb. Practice crop rotation and remove infected plant debris. Ensure adequate spacing between plants for better air circulation.';
    }
    else if (classification.trim() == 'Potato Late blight') {
      return 'Apply fungicides containing chlorothalonil, mancozeb, or metalaxyl. Remove and destroy infected plants. Monitor nearby fields for the disease and take preventive measures accordingly.';
    }
    else if (classification.trim() == 'Potato healthy') {
      return 'No specific treatment is required. Monitor the plants for any signs of disease or pests and maintain good overall plant health.';
    }
    else if (classification.trim() == 'Raspberry healthy') {
      return 'No specific treatment is required. Monitor the plants for any signs of disease or pests and maintain good overall plant health.';
    }
    else if (classification.trim() == 'Soybean healthy') {
      return 'No specific treatment is required. Monitor the plants for any signs of disease or pests and maintain good overall plant health.';
    }
    else if (classification.trim() == 'Squash Powdery mildew') {
      return 'Apply fungicides containing sulfur, potassium bicarbonate, or neem oil. Maintain proper plant spacing and provide adequate air circulation. Remove and destroy infected plant parts.';
    }
    else if (classification.trim() == 'Strawberry Leaf scorch') {
      return 'Remove and destroy infected plants. Apply fungicides containing chlorothalonil or captan. Practice crop rotation and maintain proper plant spacing. ';
    }
    else if (classification.trim() == 'Strawberry healthy') {
      return 'No specific treatment is required. Monitor the plants for any signs of disease or pests and maintain good overall plant health.';
    }
    else if (classification.trim() == 'Tomato Bacterial spot') {
      return 'Apply copper-based fungicides or bactericides. Remove and destroy infected plants or plant parts. Practice crop rotation and avoid overhead irrigation.';
    }
    else if (classification.trim() == 'Tomato Early blight') {
      return 'Apply fungicides containing chlorothalonil or mancozeb. Remove and destroy infected plant debris. Ensure adequate spacing between plants for better air circulation.';
    }
    else if (classification.trim() == 'Tomato Late blight') {
      return 'Apply fungicides containing chlorothalonil, mancozeb, or metalaxyl. Remove and destroy infected plants. Monitor nearby fields for the disease and take preventive measures accordingly.';
    }
    else if (classification.trim() == 'Tomato Leaf Mold') {
      return 'Apply fungicides containing chlorothalonil or mancozeb. Maintain proper plant spacing and provide good air circulation. Avoid overhead irrigation.';
    }
    else if (classification.trim() == 'Tomato Septoria leaf spot') {
      return 'Apply fungicides containing chlorothalonil or mancozeb. Remove and destroy infected plant debris. Avoid overhead irrigation and provide good air circulation.';
    }
    else if (classification.trim() == 'Tomato Spider mites Two-spotted spider mite') {
      return 'Apply miticides containing abamectin or sulfur. Remove and destroy heavily infested plant parts. Maintain proper plant hydration.';
    }
    else if (classification.trim() == 'Tomato Target Spot') {
      return 'Apply fungicides containing chlorothalonil or mancozeb. Remove and destroy infected plant debris. Maintain proper plant spacing and provide good air circulation.';
    }
    else if (classification.trim() == 'Tomato Tomato Yellow Leaf Curl Virus') {
      return 'Control the whitefly population with insecticides. Remove and destroy infected plants. Use resistant tomato varieties if available.';
    }
    else if (classification.trim() == 'Tomato Tomato mosaic virus') {
      return 'There is no cure for viral diseases. Remove and destroy infected plants to prevent the spread. Control aphids, which can transmit the virus.';
    }
    else if (classification.trim() == 'Tomato healthy') {
      return 'No specific treatment is required. Monitor the plants for any signs of disease or pests.';
    }
    else{

      return '';
    }

  }

}