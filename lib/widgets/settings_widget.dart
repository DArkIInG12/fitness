import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness/firebase/email_auth.dart';
import 'package:fitness/firebase/google_auth.dart';
import 'package:fitness/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final emailAuth = EmailAuth();
final googleAuth = GoogleAuth();
final imagePicker = ImagePicker();

List dropItems = [
  "Set New Photo",
  "View Photo",
];

String currentTopic = "Set New Photo";

File? image;

String? zeldaPhoto;

Future getImage() async {
  image = null;
  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    image = File(pickedFile.path);
  } else {
    print('No image selected.');
  }
}

Future uploadImageToFirebase(BuildContext context) async {
  if (image == null) {
    print('Select an image first');
  } else {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('profilePhotos/${DateTime.now()}.png');
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    if (uploadTask.snapshot.state == TaskState.success) {
      String downloadURL = await storageReference.getDownloadURL();
      print('Image uploaded successfully!');
      zeldaPhoto = downloadURL;
    } else {
      print('Failed to upload image');
    }
  }
}

void deleteImageFromFirebase(String imageUrl) async {
  FirebaseStorage storage = FirebaseStorage.instance;

  Reference reference = storage.refFromURL(imageUrl);

  try {
    await reference.delete();
    print('Imagen eliminada correctamente');
  } catch (e) {
    print('Error al eliminar la imagen: $e');
  }
}

Widget settingsWidget(BuildContext context, User user) {
  var provider = Provider.of<ProviderModel>(context);
  //user.updatePhotoURL(null);
  var providerId = user.providerData[0].providerId;
  TextEditingController nameController = TextEditingController();
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
          child: user.photoURL != null
              ? InkWell(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 98,
                              child: Column(children: [
                                providerId == 'password'
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              getImage().then((value) {
                                                uploadImageToFirebase(context)
                                                    .then((value) {
                                                  if (image != null) {
                                                    if (provider.userPhoto !=
                                                        "") {
                                                      deleteImageFromFirebase(
                                                          provider.userPhoto);
                                                    } else {
                                                      deleteImageFromFirebase(
                                                          user.photoURL!);
                                                    }
                                                    user.updatePhotoURL(
                                                        zeldaPhoto);
                                                    provider.userPhoto =
                                                        zeldaPhoto!;
                                                  }
                                                });
                                              });
                                            },
                                            child: const Text("Set New Photo")),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return provider.userPhoto == ""
                                                  ? Image.network(
                                                      user.photoURL!)
                                                  : Image.network(
                                                      provider.userPhoto);
                                            });
                                      },
                                      child: const Text("View Photo")),
                                )
                              ]),
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(provider.userPhoto == ''
                          ? user.photoURL!
                          : provider.userPhoto)),
                )
              : InkResponse(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 98,
                              child: Column(children: [
                                providerId == 'password'
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              getImage().then((value) {
                                                uploadImageToFirebase(context)
                                                    .then((value) {
                                                  if (image != null) {
                                                    if (provider.userPhoto !=
                                                        "") {
                                                      deleteImageFromFirebase(
                                                          provider.userPhoto);
                                                    }
                                                    user.updatePhotoURL(
                                                        zeldaPhoto);
                                                    provider.userPhoto =
                                                        zeldaPhoto!;
                                                  }
                                                });
                                              });
                                            },
                                            child: const Text("Set New Photo")),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return provider.userPhoto == ""
                                                  ? Image.asset(
                                                      'assets/images/nophoto.jpg')
                                                  : Image.network(
                                                      provider.userPhoto);
                                            });
                                      },
                                      child: const Text("View Photo")),
                                )
                              ]),
                            ),
                          );
                        });
                  },
                  child: provider.userPhoto == ""
                      ? const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/nophoto.jpg'))
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(provider.userPhoto)),
                )),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        onLongPress: () {
          providerId == "password"
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 48,
                        child: Column(children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              const Text("Type your new name"),
                                          content: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            width: double.infinity,
                                            height: 20,
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                  hintText: "Name"),
                                              controller: nameController,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                user.updateDisplayName(
                                                    nameController.text);
                                                provider.userName =
                                                    nameController.text;
                                                nameController.text = "";
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Save'),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: const Text("Set New Name")),
                          ),
                        ]),
                      ),
                    );
                  })
              : null;
        },
        child: Text(
          provider.userName == ""
              ? user.displayName ?? "Unknown"
              : provider.userName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        user.email!,
        style: const TextStyle(
            color: Colors.grey, fontSize: 18, fontStyle: FontStyle.italic),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //color: const Color.fromRGBO(219, 219, 219, 0.929)
        ),
        width: double.infinity,
        height: 100,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListTile(
              leading: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.green),
                  //color: Colors.blue,
                  child: const Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                  )),
              title: const Text("Workout Settings"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                provider.currentSettings = "Workout Settings";
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.blue),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
              title: const Text("General Settings"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                provider.currentSettings = "General Settings";
                Navigator.pushNamed(context, '/settings');
              },
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
                maximumSize: MaterialStateProperty.all(
                    const Size(double.infinity, double.infinity))),
            onPressed: () {
              emailAuth.signOut();
              googleAuth.googleSignOut();
              provider.userPhoto = '';
              provider.userName = '';
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            child: const Text("Sign out")),
      )
    ],
  );
}
