// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'WinkWink';

  @override
  String get loginTitle => 'Welcome to WinkWink';

  @override
  String get loginDescription => 'Enter your details to begin.';

  @override
  String get requiredField => 'Required field';

  @override
  String get loginIdGeneratedTitle => 'ID Generated';

  @override
  String get loginIdGeneratedMessage =>
      'Your unique ID has been securely created.';

  @override
  String get firstNameLabel => 'First Name';

  @override
  String get lastNameLabel => 'Last Name';

  @override
  String get phoneLabel => 'Phone Number';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get optionalPasswordTitle => 'Optional Password';

  @override
  String get optionalPasswordSubtitle =>
      'You can set a password for extra security';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMustContain =>
      'Password must contain at least 8 characters';

  @override
  String get passwordTooShort => 'Password too short';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get passwordsDontMatch => 'Passwords do not match';

  @override
  String get generateIdButton => 'Generate ID';

  @override
  String get profileCreatedFor => 'Profile created for';

  @override
  String get loginButton => 'Login';

  @override
  String get sendQrTitle => 'Send QR Code';

  @override
  String get sendQrDescription => 'Share this QR with your contacts';

  @override
  String get sendQrButton => 'Send QR';

  @override
  String get scanQrTitle => 'Scan QR';

  @override
  String get scanQrDescription => 'Scan a contact\'s QR code';

  @override
  String get scanQrButton => 'Scan QR';

  @override
  String get encryptTitle => 'Encrypt File';

  @override
  String get encryptDescription => 'Hide a file inside an image';

  @override
  String get encryptButton => 'Encrypt Now';

  @override
  String get encryptError => 'Encryption Error';

  @override
  String get encryptReady => 'File Ready';

  @override
  String get encryptReadyMessage => 'Your file has been successfully encrypted';

  @override
  String get decryptTitle => 'Decrypt File';

  @override
  String get decryptDescription => 'Extract a hidden file';

  @override
  String get decryptButton => 'Decrypt Now';

  @override
  String get decryptError => 'Decryption Error';

  @override
  String get decryptReady => 'File Decrypted';

  @override
  String get decryptReadyMessage =>
      'The hidden file has been successfully extracted';

  @override
  String get encryptButtonHome => 'Encrypt';

  @override
  String get decryptButtonHome => 'Decrypt';

  @override
  String get galleryTitle => 'Secure Gallery';

  @override
  String get galleryButton => 'Gallery';

  @override
  String get contactsTitle => 'Contacts';

  @override
  String get contactsButton => 'Contacts';

  @override
  String get searchContacts => 'Search contacts...';

  @override
  String get giveQr => 'Send QR to';

  @override
  String get passepartoutTitle => 'Master Key';

  @override
  String get passepartoutButton => 'Master Key';

  @override
  String get faqTitle => 'FAQ & Help';

  @override
  String get faqButton => 'FAQ';

  @override
  String get faqContent => 'WinkWink uses steganography to hide your files...';

  @override
  String get errorTitle => 'Error';

  @override
  String get okButton => 'OK';

  @override
  String get invalidQr => 'Invalid QR code';

  @override
  String get qrImageError => 'Error generating QR image';

  @override
  String get shareQrMessage => 'Here is my secure contact QR';

  @override
  String get shareQrSubject => 'WinkWink Contact';

  @override
  String get internalQrData => 'Internal Data';

  @override
  String get forwardButton => 'Forward';

  @override
  String get encryptMissingSelection => 'Select a file to encrypt';

  @override
  String get encryptPickVisible => 'Choose visible image';

  @override
  String get encryptVisibleSelected => 'Visible image selected';

  @override
  String get encryptChooseHidden => 'Choose hidden content';

  @override
  String get encryptHideImage => 'Hide image';

  @override
  String get encryptHideText => 'Hide text';

  @override
  String get encryptHideAudio => 'Hide audio';

  @override
  String get galleryEmptyPlaceholder => 'No files found';

  @override
  String get fileLabel => 'File';

  @override
  String get fileTypeLabel => 'Type';

  @override
  String get scanQrPlaceholderTitle => 'Scan QR';

  @override
  String get scanQrPlaceholderMessage => 'Point at a WinkWink QR code';

  @override
  String get passepartoutPlaceholder => 'Your master keys will appear here';

  @override
  String get noPasswordSaved => 'No password saved';

  @override
  String get wrongPassword => 'Wrong password';

  @override
  String get passwordGateTitle => 'Security Check';

  @override
  String get passwordGateDescription => 'Enter your password to continue';

  @override
  String get passwordLabelShort => 'Password';

  @override
  String get accessButton => 'Access';

  @override
  String get startupLoading => 'Loading WinkWink...';

  @override
  String get encrypt_title => 'Encrypt';

  @override
  String get encrypt_subtitle =>
      'Create your encrypted image to send. Choose a visible image from your gallery, press OK and follow the instructions.';

  @override
  String get visible_image_button => 'Visible Image';

  @override
  String get visible_image_subtitle => 'Choose the visible photo';

  @override
  String get choose_hidden_prompt => 'Choose what you want to hide';

  @override
  String get hide_image => 'Hide image';

  @override
  String get hide_text => 'Hide a message';

  @override
  String get take_photo => 'Take photo';

  @override
  String get hide_audio => 'Hide audio';

  @override
  String get ok_button => 'OK';

  @override
  String get encryptMissingHiddenImage => 'Select the image to hide.';

  @override
  String get encryptSelectRecipients => 'Select recipients';

  @override
  String get encryptMissingRecipients => 'Select at least one recipient.';

  @override
  String get encryptHiddenImageSelected => 'Hidden image selected';

  @override
  String get decryptMissingImage => 'Select an image to decrypt';

  @override
  String get decryptSuccess => 'Decryption completed';

  @override
  String get decryptSuccessMessage =>
      'The file has been successfully decrypted';

  @override
  String get decryptPickImage => 'Choose encrypted image';

  @override
  String get decryptResult => 'Decrypted result';

  @override
  String get passwordSentTo => 'Password sent to';

  @override
  String get recoverPassword => 'Recover password';

  @override
  String get emailAssociated => 'Associated email';

  @override
  String get sendButton => 'Send';

  @override
  String get winkwinkSubtitle => 'Keeper of secrets';

  @override
  String get changeColor => 'Change color';

  @override
  String get encryptTakePhoto => 'Take a photo';

  @override
  String get encryptEnterText => 'Enter the text to hide';

  @override
  String get encryptSelectRecipientsSubtitle =>
      'Choose the contacts you want to send a secret file to';

  @override
  String get encrypting => 'Encrypting...';

  @override
  String get backButton => 'Back';

  @override
  String get hideImageTitle => 'Hide image';

  @override
  String get hideImageSubtitle => 'Select the secret image to hide';

  @override
  String get textSecretTitle => 'Hide text';

  @override
  String get textSecretSubtitle => 'Write or paste the secret text';

  @override
  String get cameraSecretTitle => 'Capture secret photo';

  @override
  String get cameraSecretSubtitle => 'Use the camera to capture secret content';

  @override
  String get audioSecretTitle => 'Record secret audio';

  @override
  String get audioSecretSubtitle => 'Record a voice message to hide';

  @override
  String get videoSecretTitle => 'Record secret video';

  @override
  String get videoSecretSubtitle => 'Record a video to hide';

  @override
  String get recordButton => 'record';

  @override
  String get stopButton => 'Stop';

  @override
  String get videoTooLarge =>
      'The video exceeds 100MB. Please choose a smaller one.';

  @override
  String get changeSecret => 'Do you want to change the secret?';
}
