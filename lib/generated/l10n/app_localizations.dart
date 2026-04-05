import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'WinkWink'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to WinkWink'**
  String get loginTitle;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your details to begin.'**
  String get loginDescription;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredField;

  /// No description provided for @loginIdGeneratedTitle.
  ///
  /// In en, this message translates to:
  /// **'ID Generated'**
  String get loginIdGeneratedTitle;

  /// No description provided for @loginIdGeneratedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your unique ID has been securely created.'**
  String get loginIdGeneratedMessage;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailLabel;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get invalidEmail;

  /// No description provided for @optionalPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Optional Password'**
  String get optionalPasswordTitle;

  /// No description provided for @optionalPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can set a password for extra security'**
  String get optionalPasswordSubtitle;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordMustContain.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters'**
  String get passwordMustContain;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password too short'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDontMatch;

  /// No description provided for @generateIdButton.
  ///
  /// In en, this message translates to:
  /// **'Generate ID'**
  String get generateIdButton;

  /// No description provided for @profileCreatedFor.
  ///
  /// In en, this message translates to:
  /// **'Profile created for'**
  String get profileCreatedFor;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @sendQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Send QR Code'**
  String get sendQrTitle;

  /// No description provided for @sendQrDescription.
  ///
  /// In en, this message translates to:
  /// **'Share this QR with your contacts'**
  String get sendQrDescription;

  /// No description provided for @sendQrButton.
  ///
  /// In en, this message translates to:
  /// **'Send QR'**
  String get sendQrButton;

  /// No description provided for @scanQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQrTitle;

  /// No description provided for @scanQrDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan a contact\'s QR code'**
  String get scanQrDescription;

  /// No description provided for @scanQrButton.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQrButton;

  /// No description provided for @encryptTitle.
  ///
  /// In en, this message translates to:
  /// **'Encrypt File'**
  String get encryptTitle;

  /// No description provided for @encryptDescription.
  ///
  /// In en, this message translates to:
  /// **'Hide a file inside an image'**
  String get encryptDescription;

  /// No description provided for @encryptButton.
  ///
  /// In en, this message translates to:
  /// **'Encrypt Now'**
  String get encryptButton;

  /// No description provided for @encryptError.
  ///
  /// In en, this message translates to:
  /// **'Encryption Error'**
  String get encryptError;

  /// No description provided for @encryptReady.
  ///
  /// In en, this message translates to:
  /// **'File Ready'**
  String get encryptReady;

  /// No description provided for @encryptReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your file has been successfully encrypted'**
  String get encryptReadyMessage;

  /// No description provided for @decryptTitle.
  ///
  /// In en, this message translates to:
  /// **'Decrypt File'**
  String get decryptTitle;

  /// No description provided for @decryptDescription.
  ///
  /// In en, this message translates to:
  /// **'Extract a hidden file'**
  String get decryptDescription;

  /// No description provided for @decryptButton.
  ///
  /// In en, this message translates to:
  /// **'Decrypt Now'**
  String get decryptButton;

  /// No description provided for @decryptError.
  ///
  /// In en, this message translates to:
  /// **'Decryption Error'**
  String get decryptError;

  /// No description provided for @decryptReady.
  ///
  /// In en, this message translates to:
  /// **'File Decrypted'**
  String get decryptReady;

  /// No description provided for @decryptReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'The hidden file has been successfully extracted'**
  String get decryptReadyMessage;

  /// No description provided for @encryptButtonHome.
  ///
  /// In en, this message translates to:
  /// **'Encrypt'**
  String get encryptButtonHome;

  /// No description provided for @decryptButtonHome.
  ///
  /// In en, this message translates to:
  /// **'Decrypt'**
  String get decryptButtonHome;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Secure Gallery'**
  String get galleryTitle;

  /// No description provided for @galleryButton.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryButton;

  /// No description provided for @contactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsTitle;

  /// No description provided for @contactsButton.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsButton;

  /// No description provided for @searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Search contacts...'**
  String get searchContacts;

  /// No description provided for @giveQr.
  ///
  /// In en, this message translates to:
  /// **'Send QR to'**
  String get giveQr;

  /// No description provided for @passepartoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Master Key'**
  String get passepartoutTitle;

  /// No description provided for @passepartoutButton.
  ///
  /// In en, this message translates to:
  /// **'Master Key'**
  String get passepartoutButton;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ & Help'**
  String get faqTitle;

  /// No description provided for @faqButton.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqButton;

  /// No description provided for @faqContent.
  ///
  /// In en, this message translates to:
  /// **'WinkWink uses steganography to hide your files...'**
  String get faqContent;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @invalidQr.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR code'**
  String get invalidQr;

  /// No description provided for @qrImageError.
  ///
  /// In en, this message translates to:
  /// **'Error generating QR image'**
  String get qrImageError;

  /// No description provided for @shareQrMessage.
  ///
  /// In en, this message translates to:
  /// **'Here is my secure contact QR'**
  String get shareQrMessage;

  /// No description provided for @shareQrSubject.
  ///
  /// In en, this message translates to:
  /// **'WinkWink Contact'**
  String get shareQrSubject;

  /// No description provided for @internalQrData.
  ///
  /// In en, this message translates to:
  /// **'Internal Data'**
  String get internalQrData;

  /// No description provided for @forwardButton.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get forwardButton;

  /// No description provided for @encryptMissingSelection.
  ///
  /// In en, this message translates to:
  /// **'Select a file to encrypt'**
  String get encryptMissingSelection;

  /// No description provided for @encryptPickVisible.
  ///
  /// In en, this message translates to:
  /// **'Choose visible image'**
  String get encryptPickVisible;

  /// No description provided for @encryptVisibleSelected.
  ///
  /// In en, this message translates to:
  /// **'Visible image selected'**
  String get encryptVisibleSelected;

  /// No description provided for @encryptChooseHidden.
  ///
  /// In en, this message translates to:
  /// **'Choose hidden content'**
  String get encryptChooseHidden;

  /// No description provided for @encryptHideImage.
  ///
  /// In en, this message translates to:
  /// **'Hide image'**
  String get encryptHideImage;

  /// No description provided for @encryptHideText.
  ///
  /// In en, this message translates to:
  /// **'Hide text'**
  String get encryptHideText;

  /// No description provided for @encryptHideAudio.
  ///
  /// In en, this message translates to:
  /// **'Hide audio'**
  String get encryptHideAudio;

  /// No description provided for @galleryEmptyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'No files found'**
  String get galleryEmptyPlaceholder;

  /// No description provided for @fileLabel.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get fileLabel;

  /// No description provided for @fileTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get fileTypeLabel;

  /// No description provided for @scanQrPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQrPlaceholderTitle;

  /// No description provided for @scanQrPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Point at a WinkWink QR code'**
  String get scanQrPlaceholderMessage;

  /// No description provided for @passepartoutPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Your master keys will appear here'**
  String get passepartoutPlaceholder;

  /// No description provided for @noPasswordSaved.
  ///
  /// In en, this message translates to:
  /// **'No password saved'**
  String get noPasswordSaved;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @passwordGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Security Check'**
  String get passwordGateTitle;

  /// No description provided for @passwordGateDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your password to continue'**
  String get passwordGateDescription;

  /// No description provided for @passwordLabelShort.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabelShort;

  /// No description provided for @accessButton.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get accessButton;

  /// No description provided for @startupLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading WinkWink...'**
  String get startupLoading;

  /// No description provided for @encrypt_title.
  ///
  /// In en, this message translates to:
  /// **'Encrypt'**
  String get encrypt_title;

  /// No description provided for @encrypt_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your encrypted image to send. Choose a visible image from your gallery, press OK and follow the instructions.'**
  String get encrypt_subtitle;

  /// No description provided for @visible_image_button.
  ///
  /// In en, this message translates to:
  /// **'Visible Image'**
  String get visible_image_button;

  /// No description provided for @visible_image_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the visible photo'**
  String get visible_image_subtitle;

  /// No description provided for @choose_hidden_prompt.
  ///
  /// In en, this message translates to:
  /// **'Choose what you want to hide'**
  String get choose_hidden_prompt;

  /// No description provided for @hide_image.
  ///
  /// In en, this message translates to:
  /// **'Hide image'**
  String get hide_image;

  /// No description provided for @hide_text.
  ///
  /// In en, this message translates to:
  /// **'Hide a message'**
  String get hide_text;

  /// No description provided for @take_photo.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get take_photo;

  /// No description provided for @hide_audio.
  ///
  /// In en, this message translates to:
  /// **'Hide audio'**
  String get hide_audio;

  /// No description provided for @ok_button.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok_button;

  /// No description provided for @encryptMissingHiddenImage.
  ///
  /// In en, this message translates to:
  /// **'Select the image to hide.'**
  String get encryptMissingHiddenImage;

  /// No description provided for @encryptSelectRecipients.
  ///
  /// In en, this message translates to:
  /// **'Select recipients'**
  String get encryptSelectRecipients;

  /// No description provided for @encryptMissingRecipients.
  ///
  /// In en, this message translates to:
  /// **'Select at least one recipient.'**
  String get encryptMissingRecipients;

  /// No description provided for @encryptHiddenImageSelected.
  ///
  /// In en, this message translates to:
  /// **'Hidden image selected'**
  String get encryptHiddenImageSelected;

  /// No description provided for @decryptMissingImage.
  ///
  /// In en, this message translates to:
  /// **'Select an image to decrypt'**
  String get decryptMissingImage;

  /// No description provided for @decryptSuccess.
  ///
  /// In en, this message translates to:
  /// **'Decryption completed'**
  String get decryptSuccess;

  /// No description provided for @decryptSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'The file has been successfully decrypted'**
  String get decryptSuccessMessage;

  /// No description provided for @decryptPickImage.
  ///
  /// In en, this message translates to:
  /// **'Choose encrypted image'**
  String get decryptPickImage;

  /// No description provided for @decryptResult.
  ///
  /// In en, this message translates to:
  /// **'Decrypted result'**
  String get decryptResult;

  /// No description provided for @passwordSentTo.
  ///
  /// In en, this message translates to:
  /// **'Password sent to'**
  String get passwordSentTo;

  /// No description provided for @recoverPassword.
  ///
  /// In en, this message translates to:
  /// **'Recover password'**
  String get recoverPassword;

  /// No description provided for @emailAssociated.
  ///
  /// In en, this message translates to:
  /// **'Associated email'**
  String get emailAssociated;

  /// No description provided for @sendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendButton;

  /// No description provided for @winkwinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keeper of secrets'**
  String get winkwinkSubtitle;

  /// No description provided for @changeColor.
  ///
  /// In en, this message translates to:
  /// **'Change color'**
  String get changeColor;

  /// No description provided for @encryptTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get encryptTakePhoto;

  /// No description provided for @encryptEnterText.
  ///
  /// In en, this message translates to:
  /// **'Enter the text to hide'**
  String get encryptEnterText;

  /// No description provided for @encryptSelectRecipientsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the contacts you want to send a secret file to'**
  String get encryptSelectRecipientsSubtitle;

  /// No description provided for @encrypting.
  ///
  /// In en, this message translates to:
  /// **'Encrypting...'**
  String get encrypting;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @hideImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Hide image'**
  String get hideImageTitle;

  /// No description provided for @hideImageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the secret image to hide'**
  String get hideImageSubtitle;

  /// No description provided for @textSecretTitle.
  ///
  /// In en, this message translates to:
  /// **'Hide text'**
  String get textSecretTitle;

  /// No description provided for @textSecretSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Write or paste the secret text'**
  String get textSecretSubtitle;

  /// No description provided for @cameraSecretTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture secret photo'**
  String get cameraSecretTitle;

  /// No description provided for @cameraSecretSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the camera to capture secret content'**
  String get cameraSecretSubtitle;

  /// No description provided for @audioSecretTitle.
  ///
  /// In en, this message translates to:
  /// **'Record secret audio'**
  String get audioSecretTitle;

  /// No description provided for @audioSecretSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Record a voice message to hide'**
  String get audioSecretSubtitle;

  /// No description provided for @videoSecretTitle.
  ///
  /// In en, this message translates to:
  /// **'Record secret video'**
  String get videoSecretTitle;

  /// No description provided for @videoSecretSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Record a video to hide'**
  String get videoSecretSubtitle;

  /// No description provided for @recordButton.
  ///
  /// In en, this message translates to:
  /// **'record'**
  String get recordButton;

  /// No description provided for @stopButton.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopButton;

  /// No description provided for @videoTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The video exceeds 100MB. Please choose a smaller one.'**
  String get videoTooLarge;

  /// No description provided for @changeSecret.
  ///
  /// In en, this message translates to:
  /// **'Do you want to change the secret?'**
  String get changeSecret;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
