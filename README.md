# Approachable Geek Profile Page

## Description
This project is a Flutter-based mobile application that allows users to edit their profile information, including name, phone number, email, and bio.

## Features
- The User will have the ability to edit their Name, Phone Number, Email, Profile Picture.
- I have not hardcoded any sizes, i.e., I used "Mediaquery.of(context)" for sizes in order to have it responsive no matter the device.

## Validation
- **Name:** Each field checks if the input is empty. If it is, a validation error message ("Please enter your first name." or "Please enter your last name.") is displayed.
- **Phone Number:** The field checks if the input is empty. If it is, a validation message ("Please enter your phone number.") is shown.
- **Email:** The field checks if the input is empty and if it matches a basic email pattern (\S+@\S+\.\S+). If it fails, appropriate validation messages ("Please enter your email." or "Please enter a valid email address.") are displayed.
- **Bio:** The field checks if the input is empty. If it is, a validation message ("Please enter a bio.") is shown.
- **Profile Picture:** N/A, we have predefined set of images.

## Installation/Setup
```bash
git clone https://github.com/Matthew-Kao/ApproachableGeek.git
cd ApproachableGeek
flutter pub get
flutter run
```

**Note:** Please make sure to also download the JPEG images in the images folder since those are the images that the User will choose from in order to update their Profile Picture.


## Dependencies
- **image_picker:** ^0.8.4+4
- **cupertino_icons:** ^1.0.2

### Difficulties Faced

During the development of this project, I faced a significant challenge when it came to enabling users to update their profile pictures. The main issue stemmed from the fact that the emulator environment didn't come with any preloaded images, leaving users without any options for selecting their profile pictures. To work around this limitation, I decided to predownload a set of images that users could choose from when updating their profiles. While this approach is practical and user-friendly, it's worth noting that some users may prefer the option to select an image directly from their device's photo gallery or take a new photo using their device's camera for a more personalized touch. In the future, I'd aim to implement additional image selection options to cater to different user preferences and provide a smoother and more versatile experience for profile picture updates.

## Hours Dedicated
+/- 8 Hours
