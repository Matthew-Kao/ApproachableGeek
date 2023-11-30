import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

//Root Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfileUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//Main Page of the Application
class ProfileUI extends StatefulWidget {
  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  //Initial values for the Application
  String _name = 'Micah Smith';
  String _bio ='Hi my name is Mica Smith. I am from Mesa but go to school in Salt Lake City. I make this drive all the time and have plenty of';
  String _phoneNumber = '(208) 206 - 5039';
  String _email = "micahsmith@gmail.com";
  String _firstName = '';
  String _lastName = '';
  String _selectedImagePath = 'images/pic5.jpeg';

  @override
  void initState() {
    super.initState();
    _splitName();
  }

  //split the full name by "" for values in nameEditPage
  void _splitName() {
    List<String> nameParts = _name.split(' ');
    if (nameParts.isNotEmpty) {
      _firstName = nameParts.first;
      _lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    }
  }

  // Navigation method to update the profile picture.
  void _navigateToProfilePictureViewPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProfilePictureViewPage(currentImagePath: _selectedImagePath),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _selectedImagePath = result;
      });
    }
  }

  // Navigation method to update the Phone Number.
  void _navigateToPhoneNumberEditPage() async {
    final updatedPhoneNumber = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PhoneNumberEditPage(initialPhoneNumber: _phoneNumber)),
    );

    if (updatedPhoneNumber != null) {
      setState(() {
        _phoneNumber = updatedPhoneNumber;
      });
    }
  }

  // Navigation method to update Email.
  void _navigateToEmailEditPage() async {
    final updatedEmail = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EmailEditPage(initialEmail: _email)),
    );

    if (updatedEmail != null) {
      setState(() {
        _email = updatedEmail;
      });
    }
  }

  // Navigation method to update the User's Bio
  // NOTE: I chose not to pass anything to the Bio Page since we do not need to fill default values for the BIO unlike Email, Name, Phone Number, etc.
  void _navigateToBioEditPage() async {
    final updatedBio = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBioPage()),
    );

    if (updatedBio != null) {
      setState(() {
        _bio = updatedBio;
      });
    }
  }

  //The rest of the build method focuses on the UI and will rely on the methods defined above for the Application's Logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Center(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          Center(
            child: GestureDetector(
              onTap: _navigateToProfilePictureViewPage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue, 
                        width: 6, 
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(_selectedImagePath) as ImageProvider<Object>,
                    )
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(), 
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 15), 
                        child: InkWell(
                          onTap: () async {
                            _splitName(); 
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NameEditPage(
                                      initialFirstName: _firstName,
                                      initialLastName: _lastName)), 
                            );
                            if (result != null && result is Map) {
                              setState(() {
                                _name = "${result['firstName']} ${result['lastName']}";
                              });
                            }
                          },
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.grey,
                          ), 
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 15),
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 150,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _phoneNumber,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(), 
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.sizeOf(context).width /
                                15), 
                        child: InkWell(
                          onTap: () async {
                            _navigateToPhoneNumberEditPage();
                          },
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15),
                  child: Divider(
                      color: Colors.grey, thickness: 1), 
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 150,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _email,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(), 
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.sizeOf(context).width / 15), 
                        child: InkWell(
                          onTap: () async {
                            _navigateToEmailEditPage();
                          },
                          child: Icon(Icons.navigate_next, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15),
                  child: Divider(
                      color: Colors.grey, thickness: 1), 
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What type of passenger are you?',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 150,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _bio,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                8.0), 
                        child: Padding(
                          padding: EdgeInsets.only(
                              left:
                                  8.0), 
                          child: InkWell(
                            onTap: () async {
                              _navigateToBioEditPage();
                            },
                            child:
                                Icon(Icons.navigate_next, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15),
                  child: Divider(
                      color: Colors.grey, thickness: 1), 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Shows current Profile Picture and allows the option of updating the profile picture.
class ProfilePictureViewPage extends StatefulWidget {
  final String currentImagePath;

  ProfilePictureViewPage({Key? key, required this.currentImagePath})
      : super(key: key);

  @override
  _ProfilePictureViewPageState createState() => _ProfilePictureViewPageState();
}

class _ProfilePictureViewPageState extends State<ProfilePictureViewPage> {
  void _navigateAndUpdatePicture() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePictureEditPage()),
    );

    if (result != null && result is String) {
      Navigator.pop(context, result); 
    }
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.5; 

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.currentImagePath), 
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: _navigateAndUpdatePicture,
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors
                      .white, 
                  fontSize:
                      16, 
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(
                  vertical:15, 
                  horizontal: 20,
                ),
                fixedSize: Size(imageSize, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Allows selection of a new profile picture.
class ProfilePictureEditPage extends StatefulWidget {
  @override
  _ProfilePictureEditPageState createState() => _ProfilePictureEditPageState();
}

class _ProfilePictureEditPageState extends State<ProfilePictureEditPage> {
  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    //List of Images that the User can choose from
    List<String> images = [
      'images/pic1.jpeg',
      'images/pic2.jpeg',
      'images/pic3.jpeg',
      'images/pic4.jpeg',
      'images/pic5.jpeg',
      'images/pic6.jpeg'
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Select the Cutest Picture")),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedImage = images[index];
              });
              Navigator.pop(context, _selectedImage);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(images[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}

// Allows editing of the user's name.
class NameEditPage extends StatefulWidget {
  final String initialFirstName;
  final String initialLastName;

  const NameEditPage(
      {Key? key, required this.initialFirstName, required this.initialLastName})
      : super(key: key);

  @override
  _NameEditPageState createState() => _NameEditPageState();
}

class _NameEditPageState extends State<NameEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  _NameEditPageState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.initialFirstName;
    _lastNameController.text = widget.initialLastName;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.pop(context, {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Text(
                "What's your name?",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your first name.';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your last name.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Allows editing of the user's phone number.
class PhoneNumberEditPage extends StatefulWidget {
  final String initialPhoneNumber;

  const PhoneNumberEditPage({Key? key, required this.initialPhoneNumber})
      : super(key: key);

  @override
  _PhoneNumberEditPageState createState() => _PhoneNumberEditPageState();
}

class _PhoneNumberEditPageState extends State<PhoneNumberEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController =
        TextEditingController(text: widget.initialPhoneNumber);
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, _phoneNumberController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Text(
                "What's your phone number?",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number.';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Allows editing of the user's email address.
class EmailEditPage extends StatefulWidget {
  final String initialEmail;

  const EmailEditPage({Key? key, required this.initialEmail}) : super(key: key);

  @override
  _EmailEditPageState createState() => _EmailEditPageState();
}

class _EmailEditPageState extends State<EmailEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, _emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Text(
                "What's your email?",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email.';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Allows editing of the user's BIO
class EditBioPage extends StatefulWidget {
  const EditBioPage({Key? key}) : super(key: key);

  @override
  _EditBioPageState createState() => _EditBioPageState();
}

class _EditBioPageState extends State<EditBioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, _bioController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Text(
                "What type of Passenger are you?",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: 'Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.',
                  hintMaxLines: 10,
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Please enter a bio.';
                  }
                  return null;
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
