import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixalive/providers/fireStore_user_provider.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_loader.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_snackbar.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:pixalive/utils/app_validations.dart';
import 'package:country_code_picker/country_code_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // image file
  File? _imageFile;

  // Date
  DateTime? pickedDate;

  // provider object
  final UserProvider _userProvider = UserProvider();
  // From key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // country code
  String _countryCode = "+91";

  // Image picker
  final ImagePicker _picker = ImagePicker();

  // Text Controllers
  final TextEditingController _name = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _aboutMe = TextEditingController();

  // Focus Nodes Declaration
  FocusNode? _nameFocus;
  FocusNode? _userNameFocus;
  FocusNode? _emailFocus;
  FocusNode? _mobFocus;
  FocusNode? _genderFocus;
  FocusNode? _dobFocus;
  FocusNode? _loactionFocus;
  FocusNode? _aboutMeFocus;

  @override
  void initState() {
    // controllers
    _name.text = AppPrefrences.getName();
    _userName.text = AppPrefrences.getUsetName();
    _email.text = AppPrefrences.getEmail();
    _dob.text = AppPrefrences.getDOB();
    _aboutMe.text = AppPrefrences.getAboutMe();
    _gender.text = AppPrefrences.getGender();
    _mob.text = AppPrefrences.getMob();

    if (AppPrefrences.getMob() != null) {
      final int _spaceIndex = _mob.text.indexOf(" ");
      _mob.text = AppPrefrences.getMob().substring(_spaceIndex + 1);
      _countryCode = AppPrefrences.getMob().substring(0, _spaceIndex);
    }

    /// image file
    // _imageFile = null;

    // Focus Node
    _nameFocus = FocusNode();
    _userNameFocus = FocusNode();
    _emailFocus = FocusNode();
    _mobFocus = FocusNode();
    _genderFocus = FocusNode();
    _dobFocus = FocusNode();
    _loactionFocus = FocusNode();
    _aboutMeFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // Text Controllers
    _name.dispose();
    _userName.dispose();
    _email.dispose();
    _mob.dispose();
    _gender.dispose();
    _dob.dispose();
    _location.dispose();
    _aboutMe.dispose();

    // focus nodes
    _nameFocus?.dispose();
    _userNameFocus?.dispose();
    _emailFocus?.dispose();
    _mobFocus?.dispose();
    _genderFocus?.dispose();
    _dobFocus?.dispose();
    _loactionFocus?.dispose();
    _aboutMeFocus?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: AppTextStyle.white24,
          ),
          centerTitle: true,
          elevation: 0,
          leading: AppButtons.appBarButton(context, AppImages.cancelImage, () {
            Navigator.pop(context);
          }),
          actions: <Widget>[
            AppButtons.appBarButton(context, AppImages.rightTick, () async {
              AppLoader.start(context);
              await _userProvider.updateUserProfileProvider(
                _name.text.trim(),
                _userName.text.trim(),
                _email.text.trim(),
                _countryCode + " " + _mob.text.trim(),
                _gender.text.trim(),
                _dob.text.trim(),
                _aboutMe.text.trim(),
                await _uploadImage(),
              );
              AppLoader.close();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.viewProfile,
              );
            }),
            SizedBox(width: _screensize.width * 0.01),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: AppColor.gradientColor,
              ),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: <Widget>[
                // Image
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      _bottomSheet();
                    },
                    child: Container(
                      height: _screensize.height * 0.18,
                      width: _screensize.width * 0.3,
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: _imageFile != null
                        //       ? FileImage(_imageFile)
                        //       : AppPrefrences.getPhotoUrl() == null
                        //           ? AssetImage(AppImages.defaultProfilePic)
                        //           : NetworkImage(AppPrefrences.getPhotoUrl()),
                        //   fit: BoxFit.contain,
                        // ),
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                // name
                AppTextFormField(
                  validatorName: (value) => AppValidations.nameValidator(value),
                  labelText: "Name",
                  focusNodeName: _nameFocus,
                  nextFocus: _userNameFocus,
                  controller: _name,
                  isPassword: false,
                ),
                SizedBox(height: _screensize.height * 0.02),

                // User name
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.userNameValidator(value),
                  labelText: "User Name",
                  focusNodeName: _userNameFocus,
                  nextFocus: _mobFocus,
                  controller: _userName,
                  isPassword: false,
                ),
                SizedBox(height: _screensize.height * 0.02),

                // email
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.emailValidator(value),
                  labelText: "Email Address",
                  focusNodeName: _emailFocus,
                  nextFocus: _mobFocus,
                  controller: _email,
                  isPassword: false,
                  isEditable: false,
                ),
                SizedBox(height: _screensize.height * 0.02),

                // mobile
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CountryCodePicker(
                          onChanged: _onCountryChange,
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          initialSelection: _countryCode,
                          flagDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        SizedBox(height: _screensize.height / 120),
                        Container(
                          height: 1,
                          width: _screensize.width / 5,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    Expanded(
                      child: AppTextFormField(
                        labelText: "Phone Number",
                        validatorName: (val) =>
                            AppValidations.mobileNumberValidator(val),
                        focusNodeName: _mobFocus,
                        nextFocus: _genderFocus,
                        controller: _mob,
                        isPassword: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _screensize.height * 0.02),

                // gender
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.salmon,
                      ),
                    ),
                  ),
                  focusNode: _genderFocus,
                  onChanged: (val) {
                    FocusScope.of(context).requestFocus(_dobFocus);
                    if (val == 1) {
                      setState(() => _gender.text = "Male");
                    } else if (val == 2) {
                      setState(() => _gender.text = "Female");
                    }
                  },
                  hint: Text(
                    "Gender",
                    style: AppTextStyle.grey16W700,
                  ),
                  items: [
                    DropdownMenuItem(value: 1, child: Text('Male')),
                    DropdownMenuItem(value: 2, child: Text('Female')),
                  ],
                ),
                SizedBox(height: _screensize.height * 0.02),

                // DOB
                AppTextFormField(
                  labelText: "Date of Birth",
                  focusNodeName: _dobFocus,
                  nextFocus: _loactionFocus,
                  controller: _dob,
                  isPassword: false,
                  suffixButton: AppButtons.textFromFieldButton(
                      context, AppImages.calendarIcon, () {}),
                ),
                SizedBox(height: _screensize.height * 0.02),

                // Location
                AppTextFormField(
                  labelText: "Location",
                  focusNodeName: _loactionFocus,
                  nextFocus: _aboutMeFocus,
                  controller: _location,
                  isPassword: false,
                  suffixButton: AppButtons.textFromFieldButton(
                      context, AppImages.locationIcon, () {}),
                ),
                SizedBox(height: _screensize.height * 0.02),

                // about me
                AppTextFormField(
                  labelText: "About Me",
                  focusNodeName: _aboutMeFocus,
                  nextFocus: null,
                  controller: _aboutMe,
                  isPassword: false,
                ),
                SizedBox(height: _screensize.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 180.0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: AppTextStyle.grey20Shade700,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo,
                    color: AppColor.salmon,
                    size: 30.0,
                  ),
                  onTap: () async {
                    await _checkStoragePermission();
                    Navigator.pop(context);
                  },
                  title: Text(
                    "Gallery",
                    style: AppTextStyle.black24,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColor.salmon,
                    size: 30.0,
                  ),
                  onTap: () async {
                    await _checkCameraPermission();
                    Navigator.pop(context);
                  },
                  title: Text(
                    "Camera",
                    style: AppTextStyle.black24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _checkCameraPermission() async {
    final PermissionStatus _cameraStatus = await Permission.camera.request();
    if (_cameraStatus.isGranted) {
      _chooseImage(ImageSource.camera);
    } else if (_cameraStatus.isDenied) {
      Permission.camera.request();
    } else if (_cameraStatus.isPermanentlyDenied) {
      AppSnackbar.customSnackBar("Allow required permission", context);
    }
  }

  Future _checkStoragePermission() async {
    final PermissionStatus _storageStatus = await Permission.storage.request();
    if (_storageStatus.isGranted) {
      _chooseImage(ImageSource.gallery);
    } else if (_storageStatus.isDenied) {
      Permission.storage.request();
    } else if (_storageStatus.isPermanentlyDenied) {
      AppSnackbar.customSnackBar("Allow required permission", context);
    }
  }

  void _chooseImage(ImageSource _source) async {
    final XFile? _pickedFile = await _picker.pickImage(source: _source);
    setState(() => _imageFile = File(_pickedFile?.path ?? ""));
  }

  _uploadImage() async {
    if (_imageFile != null) {
      final String? _imageUrl =
          await _userProvider.updateProfileImage(_imageFile);
      return _imageUrl;
    } else {
      return null;
    }
  }

  void _onCountryChange(CountryCode _countryCode) {
    this._countryCode = _countryCode.toString();
  }
}
