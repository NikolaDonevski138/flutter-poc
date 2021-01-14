// import 'package:flutter/material.dart';
// import '../models/post.dart';

// class Images extends ChangeNotifier {
//   bool _isProcessing = true;
//   bool get isProcessing => _isProcessing;
//   List<ImageModel> _imageList = [];
//   List<ImageModel> get imagelist => _imageList;

//   setIsProcessing(bool value) {
//     _isProcessing = value;
//     notifyListeners();
//   }

//   setImagesList(List<ImageModel> list) {
//     _imageList = list;
//     notifyListeners();
//   }

//   mergePostList(List<ImageModel> list) {
//     _imageList.addAll(list);
//     notifyListeners();
//   }

//   ImageModel getImageByIndex(int index) => _imageList[index];

//   // Future<void> fetchData() async {
//   //   try {
//   //     final response = await http.get(api);
//   //     final extractedData = await json.decode(response.body) as List;
//   //     final List<ImageModel> loadedData = [];
//   //     extractedData.forEach((element) {
//   //       loadedData.add(
//   //         ImageModel(
//   //           albumId: element.albumId,
//   //           id: element.id,
//   //           thumbnailUrl: element.thumbnailUrl,
//   //           title: element.title,
//   //           url: element.url,
//   //         ),
//   //       );
//   //     });
//   //     print(loadedData);
//   //   } catch (error) {
//   //     throw (error);
//   //   }
//   // }
// }
