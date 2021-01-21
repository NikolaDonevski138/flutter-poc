
# Flutter app - READ ME

This file is created to layout steps for installation and starting the app,
described the most important parts of app and architecture.

# Installation environment
https://flutter.dev/docs/get-started/install/windows

<h4>Optional Text Editor</h4>
-Visual Studio Code 
-Extensions in Visual Studio Code which should be installed and enabled are Flutter and Dart for simple ussage.

<h4>Prerequsites</h4>

- set the flutter command (see from the link above for the full explanation).
- installed the Android studio (see from the link above for the full explanation)
- Android SDK (Android 11.0 R - API Level 30) - Open Android Studio -> into the right Tab Conrer press SDK Manager -> System Settings -> Android SDK -> check the check box Android 11.0 R than Ok, if you can't see Android 11.0 R than you should update the newest Android version.
- make sure that you installed also flutter and dart plugins into Android Studio (Open Android Studio ->
than right tab corner find SDK Manager -> Plugins -> type Dart than Flutter) To make sure that is everything succesfull go to Installed tab.


# How to start the project:
Clone the repo https://github.com/NikolaDonevski138/flutter-poc.git

<h4>1.Physical Device:</h4>
-For the physical device first you need to set your device into developer mode.
-connect through usb cable device and pc.
-run command into terminal flutter run.

<h4>2.Emulator.</h4>
-See the explanation into the link above (one way).
-SIMPLE WAY just open android studio -> AVD Manager -> if you haven't created previously virtual device create one -> launch the avd in the emulator ->
type into terminal where project is flutter run.

# ARCHITECTURE of App
<h4>There are several folders:</h4>

- Source code is placed into lib folder
- helpers folder folder for the api's classes to make api calls.
- models folder folder for model classes
- providers folder for state management and crud operation to the db, and controlling the api for get place address.
- screen folder.
- widgets folder folder for custom widgets.

<h3>Flow of the application.</h3>

Application will be executed from the main.dart.
<iframe src="https://drive.google.com/file/d/1v0ozuaT5S0n5Zo4yxQnvS8_sHkdOjVcv/preview" width="640" height="480"></iframe>

 Main dart uses state management system with help of 
 <h4>ChangeNotifierProvider.value(
 value:GreatPlaces()
) on Line 18 and 19 from the picture</h4> 

we register state management (Provider) which is imported from lib->providers->great_places.dart to be ready for use for the whole application.
there is also declared five screens including Login Screen.

<h4>1.Login</h4>

<iframe src="https://drive.google.com/file/d/1SeqQIVFdowrp6NKPRnkHqRLCsV1uytQa/preview" width="440" height="400"></iframe>


Login is a statefull widget with simple validation on the text inputs without backend, when user logs in "successfully" will be redirected to the Home Screen.</span> 

<h4>2.Home Screen</h4>
<iframe src="https://drive.google.com/file/d/1UfBIKo-b2YIRLP5zX_AYizywTodKVZOW/preview" width="440" height="400"></iframe>

Home Screen uses 3 Bottom Navigation Bar Items:
<b>Home Widget</b>,
<b>Places List Screen</b>, <b>Create Post</b>

* Home Widget:
lib -> widgets -> home.dart
Is Responsible for showing paginated data table, with the help of http services from(helpers -> apihelper) on initializing widget we make api call.
with future builder is build and mapped all data to show on the ui, and also uses Photos model class.
i used Pl Grid library for paginated table.


* Places List Screen:
<iframe src="https://drive.google.com/file/d/1z7-FMF5tfulIFZB2DeoYlNtk6BeHR3L3/preview" width="640" height="480"></iframe>
Is stateless widget responsible for showing list of places with picture and address.
we consuming the data from the provider (lib-> providers-> great_places.dart ) which is state management system who make api calls, and communicate to DB, we use this with a help of <b>Provider.of<>()</b> method to invoke methods from the management system.

On the plus icon we navigate to the Add Place Screen (lib->screen->add_place_screen.dart)

On tap on each item we sending the current id of the item through router with help of Navigator.of() method to the Details Screen.

<b>- Details Screen</b>
<iframe src="https://drive.google.com/file/d/1sxg66XL8bFvJpTc243U70HLgvcqvFUsf/preview" width="640" height="480"></iframe>

Is Stateless widget responsible to display the detail of image taken by the user
with ModelRoute.of() method we consume the id sent from Place List Screen to map through Provider to find selected item to display picture. Also here we send longitude and latitude to map_screen to display static map.
<iframe src="https://drive.google.com/file/d/12Jo97GFbTeb4toa7hIS7_3GXI_iRfGkv/preview" width="640" height="480"></iframe>

<b>- Add place Screen </b>
<iframe src="https://drive.google.com/file/d/1XOv7nQ3Pr7JZyIgr63RBjqaNYqCZh-5m/preview" width="640" height="480"></iframe>
is Statefull widget responsible to add places from camera.
This Screen uses 2 widgets ImageInput and LocationInput with help of callback is set the data

ImageInput widget uses image_picker package to make us easy working with camera to make pictures,set max width of picture, quality etc.
LocationInput uses geolocator package from pub.dev which help us to find current position of physical device.

<h4>3. Create Post screen.</h4>

<iframe src="https://drive.google.com/file/d/1fYnyXLMjMlNE-rm-YtOyNKkNGa7divhF/preview" width="640" height="480"></iframe>

-Widget responsible to make post request to api to write blogs.
-have simple validation
-notify user about blog is successfull created through modal.

