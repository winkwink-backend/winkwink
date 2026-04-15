// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winkwink/generated/intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `WinkWink`
  String get appTitle {
    return Intl.message('WinkWink', name: 'appTitle', desc: '', args: []);
  }

  /// `Welcome to WinkWink`
  String get loginTitle {
    return Intl.message(
      'Welcome to WinkWink',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details to get started.`
  String get loginDescription {
    return Intl.message(
      'Enter your details to get started.',
      name: 'loginDescription',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get requiredField {
    return Intl.message(
      'Required field',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `ID Generated`
  String get loginIdGeneratedTitle {
    return Intl.message(
      'ID Generated',
      name: 'loginIdGeneratedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your unique ID has been securely created.`
  String get loginIdGeneratedMessage {
    return Intl.message(
      'Your unique ID has been securely created.',
      name: 'loginIdGeneratedMessage',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstNameLabel {
    return Intl.message(
      'First Name',
      name: 'firstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastNameLabel {
    return Intl.message('Last Name', name: 'lastNameLabel', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneLabel {
    return Intl.message('Phone Number', name: 'phoneLabel', desc: '', args: []);
  }

  /// `Email Address`
  String get emailLabel {
    return Intl.message(
      'Email Address',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Optional Password`
  String get optionalPasswordTitle {
    return Intl.message(
      'Optional Password',
      name: 'optionalPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can set a password for extra security`
  String get optionalPasswordSubtitle {
    return Intl.message(
      'You can set a password for extra security',
      name: 'optionalPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Password must contain at least 8 characters`
  String get passwordMustContain {
    return Intl.message(
      'Password must contain at least 8 characters',
      name: 'passwordMustContain',
      desc: '',
      args: [],
    );
  }

  /// `Password too short`
  String get passwordTooShort {
    return Intl.message(
      'Password too short',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDontMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Generate ID`
  String get generateIdButton {
    return Intl.message(
      'Generate ID',
      name: 'generateIdButton',
      desc: '',
      args: [],
    );
  }

  /// `Profile created for`
  String get profileCreatedFor {
    return Intl.message(
      'Profile created for',
      name: 'profileCreatedFor',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Send QR Code`
  String get sendQrTitle {
    return Intl.message(
      'Send QR Code',
      name: 'sendQrTitle',
      desc: '',
      args: [],
    );
  }

  /// `Share this QR with your contacts`
  String get sendQrDescription {
    return Intl.message(
      'Share this QR with your contacts',
      name: 'sendQrDescription',
      desc: '',
      args: [],
    );
  }

  /// `Send QR`
  String get sendQrButton {
    return Intl.message('Send QR', name: 'sendQrButton', desc: '', args: []);
  }

  /// `Scan QR`
  String get scanQrTitle {
    return Intl.message('Scan QR', name: 'scanQrTitle', desc: '', args: []);
  }

  /// `Scan a contact's QR`
  String get scanQrDescription {
    return Intl.message(
      'Scan a contact\'s QR',
      name: 'scanQrDescription',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get scanQrButton {
    return Intl.message('Scan QR', name: 'scanQrButton', desc: '', args: []);
  }

  /// `Encrypt File`
  String get encryptTitle {
    return Intl.message(
      'Encrypt File',
      name: 'encryptTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hide a file inside an image`
  String get encryptDescription {
    return Intl.message(
      'Hide a file inside an image',
      name: 'encryptDescription',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt Now`
  String get encryptButton {
    return Intl.message(
      'Encrypt Now',
      name: 'encryptButton',
      desc: '',
      args: [],
    );
  }

  /// `Encryption Error`
  String get encryptError {
    return Intl.message(
      'Encryption Error',
      name: 'encryptError',
      desc: '',
      args: [],
    );
  }

  /// `File Ready`
  String get encryptReady {
    return Intl.message('File Ready', name: 'encryptReady', desc: '', args: []);
  }

  /// `Your file has been successfully encrypted`
  String get encryptReadyMessage {
    return Intl.message(
      'Your file has been successfully encrypted',
      name: 'encryptReadyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Decrypt File`
  String get decryptTitle {
    return Intl.message(
      'Decrypt File',
      name: 'decryptTitle',
      desc: '',
      args: [],
    );
  }

  /// `Extract a hidden file`
  String get decryptDescription {
    return Intl.message(
      'Extract a hidden file',
      name: 'decryptDescription',
      desc: '',
      args: [],
    );
  }

  /// `Decrypt Now`
  String get decryptButton {
    return Intl.message(
      'Decrypt Now',
      name: 'decryptButton',
      desc: '',
      args: [],
    );
  }

  /// `Decryption Error`
  String get decryptError {
    return Intl.message(
      'Decryption Error',
      name: 'decryptError',
      desc: '',
      args: [],
    );
  }

  /// `File Decrypted`
  String get decryptReady {
    return Intl.message(
      'File Decrypted',
      name: 'decryptReady',
      desc: '',
      args: [],
    );
  }

  /// `The hidden file has been successfully extracted`
  String get decryptReadyMessage {
    return Intl.message(
      'The hidden file has been successfully extracted',
      name: 'decryptReadyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt`
  String get encryptButtonHome {
    return Intl.message(
      'Encrypt',
      name: 'encryptButtonHome',
      desc: '',
      args: [],
    );
  }

  /// `Decrypt`
  String get decryptButtonHome {
    return Intl.message(
      'Decrypt',
      name: 'decryptButtonHome',
      desc: '',
      args: [],
    );
  }

  /// `Secure Gallery`
  String get galleryTitle {
    return Intl.message(
      'Secure Gallery',
      name: 'galleryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get galleryButton {
    return Intl.message('Gallery', name: 'galleryButton', desc: '', args: []);
  }

  /// `Contacts`
  String get contactsTitle {
    return Intl.message('Contacts', name: 'contactsTitle', desc: '', args: []);
  }

  /// `Contacts`
  String get contactsButton {
    return Intl.message('Contacts', name: 'contactsButton', desc: '', args: []);
  }

  /// `Search contacts...`
  String get searchContacts {
    return Intl.message(
      'Search contacts...',
      name: 'searchContacts',
      desc: '',
      args: [],
    );
  }

  /// `Send QR to`
  String get giveQr {
    return Intl.message('Send QR to', name: 'giveQr', desc: '', args: []);
  }

  /// `Master Key`
  String get passepartoutTitle {
    return Intl.message(
      'Master Key',
      name: 'passepartoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Master Key`
  String get passepartoutButton {
    return Intl.message(
      'Master Key',
      name: 'passepartoutButton',
      desc: '',
      args: [],
    );
  }

  /// `FAQ & Help`
  String get faqTitle {
    return Intl.message('FAQ & Help', name: 'faqTitle', desc: '', args: []);
  }

  /// `FAQ`
  String get faqButton {
    return Intl.message('FAQ', name: 'faqButton', desc: '', args: []);
  }

  /// `WinkWink uses steganography to hide your files...`
  String get faqContent {
    return Intl.message(
      'WinkWink uses steganography to hide your files...',
      name: 'faqContent',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message('Error', name: 'errorTitle', desc: '', args: []);
  }

  /// `OK`
  String get okButton {
    return Intl.message('OK', name: 'okButton', desc: '', args: []);
  }

  /// `Invalid QR code`
  String get invalidQr {
    return Intl.message(
      'Invalid QR code',
      name: 'invalidQr',
      desc: '',
      args: [],
    );
  }

  /// `Error generating QR image`
  String get qrImageError {
    return Intl.message(
      'Error generating QR image',
      name: 'qrImageError',
      desc: '',
      args: [],
    );
  }

  /// `Here is my secure WinkWink contact QR`
  String get shareQrMessage {
    return Intl.message(
      'Here is my secure WinkWink contact QR',
      name: 'shareQrMessage',
      desc: '',
      args: [],
    );
  }

  /// `WinkWink Contact`
  String get shareQrSubject {
    return Intl.message(
      'WinkWink Contact',
      name: 'shareQrSubject',
      desc: '',
      args: [],
    );
  }

  /// `Internal Data`
  String get internalQrData {
    return Intl.message(
      'Internal Data',
      name: 'internalQrData',
      desc: '',
      args: [],
    );
  }

  /// `Forward`
  String get forwardButton {
    return Intl.message('Forward', name: 'forwardButton', desc: '', args: []);
  }

  /// `Select a file to encrypt`
  String get encryptMissingSelection {
    return Intl.message(
      'Select a file to encrypt',
      name: 'encryptMissingSelection',
      desc: '',
      args: [],
    );
  }

  /// `No files found`
  String get galleryEmptyPlaceholder {
    return Intl.message(
      'No files found',
      name: 'galleryEmptyPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get fileLabel {
    return Intl.message('File', name: 'fileLabel', desc: '', args: []);
  }

  /// `Type`
  String get fileTypeLabel {
    return Intl.message('Type', name: 'fileTypeLabel', desc: '', args: []);
  }

  /// `Scan QR`
  String get scanQrPlaceholderTitle {
    return Intl.message(
      'Scan QR',
      name: 'scanQrPlaceholderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Point at a WinkWink QR code`
  String get scanQrPlaceholderMessage {
    return Intl.message(
      'Point at a WinkWink QR code',
      name: 'scanQrPlaceholderMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your master keys will appear here`
  String get passepartoutPlaceholder {
    return Intl.message(
      'Your master keys will appear here',
      name: 'passepartoutPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `No password saved`
  String get noPasswordSaved {
    return Intl.message(
      'No password saved',
      name: 'noPasswordSaved',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get wrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Security Check`
  String get passwordGateTitle {
    return Intl.message(
      'Security Check',
      name: 'passwordGateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to continue`
  String get passwordGateDescription {
    return Intl.message(
      'Enter your password to continue',
      name: 'passwordGateDescription',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabelShort {
    return Intl.message(
      'Password',
      name: 'passwordLabelShort',
      desc: '',
      args: [],
    );
  }

  /// `Access`
  String get accessButton {
    return Intl.message('Access', name: 'accessButton', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Loading WinkWink...`
  String get startupLoading {
    return Intl.message(
      'Loading WinkWink...',
      name: 'startupLoading',
      desc: '',
      args: [],
    );
  }

  /// `Keeper of secrets`
  String get winkwinkSubtitle {
    return Intl.message(
      'Keeper of secrets',
      name: 'winkwinkSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Change color`
  String get changeColor {
    return Intl.message(
      'Change color',
      name: 'changeColor',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get backButton {
    return Intl.message('Back', name: 'backButton', desc: '', args: []);
  }

  /// `The video exceeds 100MB. Choose a smaller one.`
  String get videoTooLarge {
    return Intl.message(
      'The video exceeds 100MB. Choose a smaller one.',
      name: 'videoTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to change the secret?`
  String get changeSecret {
    return Intl.message(
      'Do you want to change the secret?',
      name: 'changeSecret',
      desc: '',
      args: [],
    );
  }

  /// `Choose who you want to share your secret files with`
  String get encryptSelectRecipientsSubtitle {
    return Intl.message(
      'Choose who you want to share your secret files with',
      name: 'encryptSelectRecipientsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Select the contacts you want to send your secret file to`
  String get encryptSelectRecipientsTitle {
    return Intl.message(
      'Select the contacts you want to send your secret file to',
      name: 'encryptSelectRecipientsTitle',
      desc: '',
      args: [],
    );
  }

  /// `contacts`
  String get encryptSelectRecipients {
    return Intl.message(
      'contacts',
      name: 'encryptSelectRecipients',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get encryptContactsButton {
    return Intl.message(
      'Contacts',
      name: 'encryptContactsButton',
      desc: '',
      args: [],
    );
  }

  /// `Choose the visible image`
  String get encryptVisibleImageTitle {
    return Intl.message(
      'Choose the visible image',
      name: 'encryptVisibleImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Visible Image`
  String get encryptPickVisibleImage {
    return Intl.message(
      'Visible Image',
      name: 'encryptPickVisibleImage',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to hide?`
  String get encryptWhatToHide {
    return Intl.message(
      'What do you want to hide?',
      name: 'encryptWhatToHide',
      desc: '',
      args: [],
    );
  }

  /// `Hide Image`
  String get encryptHideImage {
    return Intl.message(
      'Hide Image',
      name: 'encryptHideImage',
      desc: '',
      args: [],
    );
  }

  /// `Hide Text`
  String get encryptHideText {
    return Intl.message(
      'Hide Text',
      name: 'encryptHideText',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get encryptHideCamera {
    return Intl.message(
      'Camera',
      name: 'encryptHideCamera',
      desc: '',
      args: [],
    );
  }

  /// `Hide Audio`
  String get encryptHideAudio {
    return Intl.message(
      'Hide Audio',
      name: 'encryptHideAudio',
      desc: '',
      args: [],
    );
  }

  /// `Sandwich`
  String get encryptHideSandwich {
    return Intl.message(
      'Sandwich',
      name: 'encryptHideSandwich',
      desc: '',
      args: [],
    );
  }

  /// `Selected Content`
  String get encryptSelectedContent {
    return Intl.message(
      'Selected Content',
      name: 'encryptSelectedContent',
      desc: '',
      args: [],
    );
  }

  /// `Hidden content ready ✔`
  String get encryptSecretReady {
    return Intl.message(
      'Hidden content ready ✔',
      name: 'encryptSecretReady',
      desc: '',
      args: [],
    );
  }

  /// `Encrypting...`
  String get encrypting {
    return Intl.message(
      'Encrypting...',
      name: 'encrypting',
      desc: '',
      args: [],
    );
  }

  /// `Invisible Image`
  String get visible_image_button {
    return Intl.message(
      'Invisible Image',
      name: 'visible_image_button',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get encryptTakePhoto {
    return Intl.message(
      'Take Photo',
      name: 'encryptTakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Hide Image`
  String get hideImageTitle {
    return Intl.message(
      'Hide Image',
      name: 'hideImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select the secret image to hide`
  String get hideImageSubtitle {
    return Intl.message(
      'Select the secret image to hide',
      name: 'hideImageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Hide Text`
  String get textSecretTitle {
    return Intl.message(
      'Hide Text',
      name: 'textSecretTitle',
      desc: '',
      args: [],
    );
  }

  /// `Write or paste the secret text`
  String get textSecretSubtitle {
    return Intl.message(
      'Write or paste the secret text',
      name: 'textSecretSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Capture Secret Photo`
  String get cameraSecretTitle {
    return Intl.message(
      'Capture Secret Photo',
      name: 'cameraSecretTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use the camera to capture a secret image`
  String get cameraSecretSubtitle {
    return Intl.message(
      'Use the camera to capture a secret image',
      name: 'cameraSecretSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Record Secret Audio`
  String get audioSecretTitle {
    return Intl.message(
      'Record Secret Audio',
      name: 'audioSecretTitle',
      desc: '',
      args: [],
    );
  }

  /// `Record a voice message to hide`
  String get audioSecretSubtitle {
    return Intl.message(
      'Record a voice message to hide',
      name: 'audioSecretSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Record`
  String get recordButton {
    return Intl.message('Record', name: 'recordButton', desc: '', args: []);
  }

  /// `Stop`
  String get stopButton {
    return Intl.message('Stop', name: 'stopButton', desc: '', args: []);
  }

  /// `Choose encrypted image`
  String get decryptPickImage {
    return Intl.message(
      'Choose encrypted image',
      name: 'decryptPickImage',
      desc: '',
      args: [],
    );
  }

  /// `Decrypted result`
  String get decryptResult {
    return Intl.message(
      'Decrypted result',
      name: 'decryptResult',
      desc: '',
      args: [],
    );
  }

  /// `Select an image to decrypt`
  String get decryptMissingImage {
    return Intl.message(
      'Select an image to decrypt',
      name: 'decryptMissingImage',
      desc: '',
      args: [],
    );
  }

  /// `Decryption complete`
  String get decryptSuccess {
    return Intl.message(
      'Decryption complete',
      name: 'decryptSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The file has been successfully decrypted`
  String get decryptSuccessMessage {
    return Intl.message(
      'The file has been successfully decrypted',
      name: 'decryptSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Decrypting...`
  String get decrypting {
    return Intl.message(
      'Decrypting...',
      name: 'decrypting',
      desc: '',
      args: [],
    );
  }

  /// `Password sent to`
  String get passwordSentTo {
    return Intl.message(
      'Password sent to',
      name: 'passwordSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get recoverPassword {
    return Intl.message(
      'Recover password',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Associated email`
  String get emailAssociated {
    return Intl.message(
      'Associated email',
      name: 'emailAssociated',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendButton {
    return Intl.message('Send', name: 'sendButton', desc: '', args: []);
  }

  /// `Sandwich`
  String get sandwichTitle {
    return Intl.message('Sandwich', name: 'sandwichTitle', desc: '', args: []);
  }

  /// `Add Photo`
  String get sandwichAddImage {
    return Intl.message(
      'Add Photo',
      name: 'sandwichAddImage',
      desc: '',
      args: [],
    );
  }

  /// `Add Camera Photo`
  String get sandwichAddCamera {
    return Intl.message(
      'Add Camera Photo',
      name: 'sandwichAddCamera',
      desc: '',
      args: [],
    );
  }

  /// `Add Text`
  String get sandwichAddText {
    return Intl.message(
      'Add Text',
      name: 'sandwichAddText',
      desc: '',
      args: [],
    );
  }

  /// `Add Audio`
  String get sandwichAddAudio {
    return Intl.message(
      'Add Audio',
      name: 'sandwichAddAudio',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Sandwich`
  String get sandwichConfirm {
    return Intl.message(
      'Confirm Sandwich',
      name: 'sandwichConfirm',
      desc: '',
      args: [],
    );
  }

  /// `You exceeded the maximum capacity.`
  String get sandwichLimitExceeded {
    return Intl.message(
      'You exceeded the maximum capacity.',
      name: 'sandwichLimitExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Insert text`
  String get sandwichInsertText {
    return Intl.message(
      'Insert text',
      name: 'sandwichInsertText',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get sandwichCancel {
    return Intl.message('Cancel', name: 'sandwichCancel', desc: '', args: []);
  }

  /// `OK`
  String get sandwichOk {
    return Intl.message('OK', name: 'sandwichOk', desc: '', args: []);
  }

  /// `Image`
  String get sandwichItemImage {
    return Intl.message('Image', name: 'sandwichItemImage', desc: '', args: []);
  }

  /// `Camera`
  String get sandwichItemCamera {
    return Intl.message(
      'Camera',
      name: 'sandwichItemCamera',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get sandwichItemText {
    return Intl.message('Text', name: 'sandwichItemText', desc: '', args: []);
  }

  /// `Audio`
  String get sandwichItemAudio {
    return Intl.message('Audio', name: 'sandwichItemAudio', desc: '', args: []);
  }

  /// `{current} MB / {max} MB`
  String sandwichProgress(Object current, Object max) {
    return Intl.message(
      '$current MB / $max MB',
      name: 'sandwichProgress',
      desc: '',
      args: [current, max],
    );
  }

  /// `You can insert multiple files. You cannot exceed the limit. You can reorder items with drag & drop.`
  String get sandwichSubtitle {
    return Intl.message(
      'You can insert multiple files. You cannot exceed the limit. You can reorder items with drag & drop.',
      name: 'sandwichSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Import from gallery`
  String get sandwichImportGallery {
    return Intl.message(
      'Import from gallery',
      name: 'sandwichImportGallery',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get recoverPasswordTitle {
    return Intl.message(
      'Recover password',
      name: 'recoverPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you forgot your password, you can reset the app and start over. All local data (profile, keys, contacts, QR) will be deleted.`
  String get recoverPasswordDescription {
    return Intl.message(
      'If you forgot your password, you can reset the app and start over. All local data (profile, keys, contacts, QR) will be deleted.',
      name: 'recoverPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get recoverPasswordButton {
    return Intl.message(
      'Recover password',
      name: 'recoverPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset application`
  String get resetAppTitle {
    return Intl.message(
      'Reset application',
      name: 'resetAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to reset WinkWink? All local data will be deleted and you will need to create a new profile.`
  String get resetAppMessage {
    return Intl.message(
      'Are you sure you want to reset WinkWink? All local data will be deleted and you will need to create a new profile.',
      name: 'resetAppMessage',
      desc: '',
      args: [],
    );
  }

  /// `Reset app`
  String get resetAppButton {
    return Intl.message(
      'Reset app',
      name: 'resetAppButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get resetButton {
    return Intl.message('Reset', name: 'resetButton', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton', desc: '', args: []);
  }

  /// `Select the secret to encrypt`
  String get encryptSelectSecret {
    return Intl.message(
      'Select the secret to encrypt',
      name: 'encryptSelectSecret',
      desc: '',
      args: [],
    );
  }

  /// `Scan from gallery`
  String get scanFromGallery {
    return Intl.message(
      'Scan from gallery',
      name: 'scanFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Scan from camera`
  String get scanFromCamera {
    return Intl.message(
      'Scan from camera',
      name: 'scanFromCamera',
      desc: '',
      args: [],
    );
  }

  /// `WinkWink Video`
  String get videoWWTitle {
    return Intl.message(
      'WinkWink Video',
      name: 'videoWWTitle',
      desc: '',
      args: [],
    );
  }

  /// `Invisible Content`
  String get videoWWSandwichTitle {
    return Intl.message(
      'Invisible Content',
      name: 'videoWWSandwichTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm invisible content`
  String get videoWWSandwichConfirm {
    return Intl.message(
      'Confirm invisible content',
      name: 'videoWWSandwichConfirm',
      desc: '',
      args: [],
    );
  }

  /// `You exceeded the maximum capacity`
  String get videoWWSandwichExceeded {
    return Intl.message(
      'You exceeded the maximum capacity',
      name: 'videoWWSandwichExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Space used`
  String get videoWWSpaceUsed {
    return Intl.message(
      'Space used',
      name: 'videoWWSpaceUsed',
      desc: '',
      args: [],
    );
  }

  /// `Space remaining`
  String get videoWWSpaceRemaining {
    return Intl.message(
      'Space remaining',
      name: 'videoWWSpaceRemaining',
      desc: '',
      args: [],
    );
  }

  /// `Invisible Video`
  String get videoWWAddVideo {
    return Intl.message(
      'Invisible Video',
      name: 'videoWWAddVideo',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get videoWWAddImage {
    return Intl.message('Image', name: 'videoWWAddImage', desc: '', args: []);
  }

  /// `Text`
  String get videoWWAddText {
    return Intl.message('Text', name: 'videoWWAddText', desc: '', args: []);
  }

  /// `Audio`
  String get videoWWAddAudio {
    return Intl.message('Audio', name: 'videoWWAddAudio', desc: '', args: []);
  }

  /// `Camera`
  String get videoWWAddCamera {
    return Intl.message('Camera', name: 'videoWWAddCamera', desc: '', args: []);
  }

  /// `Insert text`
  String get videoWWTextInsert {
    return Intl.message(
      'Insert text',
      name: 'videoWWTextInsert',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get videoWWTextConfirm {
    return Intl.message('OK', name: 'videoWWTextConfirm', desc: '', args: []);
  }

  /// `Cancel`
  String get videoWWTextCancel {
    return Intl.message(
      'Cancel',
      name: 'videoWWTextCancel',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to hide?`
  String get videoWWSandwichWhatToHide {
    return Intl.message(
      'What do you want to hide?',
      name: 'videoWWSandwichWhatToHide',
      desc: '',
      args: [],
    );
  }

  /// `Add Video`
  String get videoWWSandwichAddVideo {
    return Intl.message(
      'Add Video',
      name: 'videoWWSandwichAddVideo',
      desc: '',
      args: [],
    );
  }

  /// `{used} MB / {max} MB`
  String videoWWSandwichSpace(Object used, Object max) {
    return Intl.message(
      '$used MB / $max MB',
      name: 'videoWWSandwichSpace',
      desc: '',
      args: [used, max],
    );
  }

  /// `Password recovery`
  String get passwordResetRequestTitle {
    return Intl.message(
      'Password recovery',
      name: 'passwordResetRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to receive a verification code.`
  String get passwordResetRequestDescription {
    return Intl.message(
      'Enter your email to receive a verification code.',
      name: 'passwordResetRequestDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get passwordResetRequestEmailHint {
    return Intl.message(
      'Email',
      name: 'passwordResetRequestEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get passwordResetRequestSendButton {
    return Intl.message(
      'Send code',
      name: 'passwordResetRequestSendButton',
      desc: '',
      args: [],
    );
  }

  /// `Error sending code`
  String get passwordResetRequestError {
    return Intl.message(
      'Error sending code',
      name: 'passwordResetRequestError',
      desc: '',
      args: [],
    );
  }

  /// `Connection error`
  String get passwordResetRequestConnectionError {
    return Intl.message(
      'Connection error',
      name: 'passwordResetRequestConnectionError',
      desc: '',
      args: [],
    );
  }

  /// `Verify code`
  String get passwordResetVerifyTitle {
    return Intl.message(
      'Verify code',
      name: 'passwordResetVerifyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code you received via email.`
  String get passwordResetVerifyDescription {
    return Intl.message(
      'Enter the OTP code you received via email.',
      name: 'passwordResetVerifyDescription',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code`
  String get passwordResetVerifyCodeHint {
    return Intl.message(
      'OTP Code',
      name: 'passwordResetVerifyCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get passwordResetVerifyButton {
    return Intl.message(
      'Verify',
      name: 'passwordResetVerifyButton',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get passwordResetVerifyError {
    return Intl.message(
      'Invalid code',
      name: 'passwordResetVerifyError',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get passwordResetNewPasswordTitle {
    return Intl.message(
      'New password',
      name: 'passwordResetNewPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password for your account.`
  String get passwordResetNewPasswordDescription {
    return Intl.message(
      'Set a new password for your account.',
      name: 'passwordResetNewPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get passwordResetNewPasswordHint {
    return Intl.message(
      'New password',
      name: 'passwordResetNewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get passwordResetRepeatPasswordHint {
    return Intl.message(
      'Repeat password',
      name: 'passwordResetRepeatPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get passwordResetNewPasswordButton {
    return Intl.message(
      'Save',
      name: 'passwordResetNewPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordResetNewPasswordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordResetNewPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Error saving password`
  String get passwordResetNewPasswordError {
    return Intl.message(
      'Error saving password',
      name: 'passwordResetNewPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Ask a question...`
  String get faqSearchHint {
    return Intl.message(
      'Ask a question...',
      name: 'faqSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `No answers found.`
  String get faqNoResults {
    return Intl.message(
      'No answers found.',
      name: 'faqNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Open Encrypt`
  String get goToEncrypt {
    return Intl.message(
      'Open Encrypt',
      name: 'goToEncrypt',
      desc: '',
      args: [],
    );
  }

  /// `Open Send QR`
  String get goToSendQr {
    return Intl.message('Open Send QR', name: 'goToSendQr', desc: '', args: []);
  }

  /// `Open Scan QR`
  String get goToScanQr {
    return Intl.message('Open Scan QR', name: 'goToScanQr', desc: '', args: []);
  }

  /// `Open Contacts`
  String get goToContacts {
    return Intl.message(
      'Open Contacts',
      name: 'goToContacts',
      desc: '',
      args: [],
    );
  }

  /// `Open VideoWW`
  String get goToVideoWW {
    return Intl.message(
      'Open VideoWW',
      name: 'goToVideoWW',
      desc: '',
      args: [],
    );
  }

  /// `Password Recovery`
  String get goToPasswordReset {
    return Intl.message(
      'Password Recovery',
      name: 'goToPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get inboxTitle {
    return Intl.message(
      'Notifications',
      name: 'inboxTitle',
      desc: '',
      args: [],
    );
  }

  /// `No notifications available`
  String get noNotifications {
    return Intl.message(
      'No notifications available',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `You received a QR`
  String get notificationQrReceived {
    return Intl.message(
      'You received a QR',
      name: 'notificationQrReceived',
      desc: '',
      args: [],
    );
  }

  /// `New notification`
  String get notificationGeneric {
    return Intl.message(
      'New notification',
      name: 'notificationGeneric',
      desc: '',
      args: [],
    );
  }

  /// `No contacts available`
  String get noContactsMessage {
    return Intl.message(
      'No contacts available',
      name: 'noContactsMessage',
      desc: '',
      args: [],
    );
  }

  /// `This contact does not have a public key yet`
  String get noKeysWarning {
    return Intl.message(
      'This contact does not have a public key yet',
      name: 'noKeysWarning',
      desc: '',
      args: [],
    );
  }

  /// `Select a contact`
  String get selectContact {
    return Intl.message(
      'Select a contact',
      name: 'selectContact',
      desc: '',
      args: [],
    );
  }

  /// `QR sent successfully`
  String get qrSentDirect {
    return Intl.message(
      'QR sent successfully',
      name: 'qrSentDirect',
      desc: '',
      args: [],
    );
  }

  /// `Send directly`
  String get sendDirectButton {
    return Intl.message(
      'Send directly',
      name: 'sendDirectButton',
      desc: '',
      args: [],
    );
  }

  /// `Sending file…`
  String get p2pSending {
    return Intl.message(
      'Sending file…',
      name: 'p2pSending',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the recipient…`
  String get p2pWaitingAnswer {
    return Intl.message(
      'Waiting for the recipient…',
      name: 'p2pWaitingAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Connection established`
  String get p2pConnectionEstablished {
    return Intl.message(
      'Connection established',
      name: 'p2pConnectionEstablished',
      desc: '',
      args: [],
    );
  }

  /// `Sending in progress…`
  String get p2pSendingInProgress {
    return Intl.message(
      'Sending in progress…',
      name: 'p2pSendingInProgress',
      desc: '',
      args: [],
    );
  }

  /// `File sent successfully`
  String get p2pSendingCompleted {
    return Intl.message(
      'File sent successfully',
      name: 'p2pSendingCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Error while sending file`
  String get p2pSendingError {
    return Intl.message(
      'Error while sending file',
      name: 'p2pSendingError',
      desc: '',
      args: [],
    );
  }

  /// `Receiving file…`
  String get p2pReceiving {
    return Intl.message(
      'Receiving file…',
      name: 'p2pReceiving',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the sender…`
  String get p2pReceivingWaiting {
    return Intl.message(
      'Waiting for the sender…',
      name: 'p2pReceivingWaiting',
      desc: '',
      args: [],
    );
  }

  /// `Connection established`
  String get p2pReceivingEstablished {
    return Intl.message(
      'Connection established',
      name: 'p2pReceivingEstablished',
      desc: '',
      args: [],
    );
  }

  /// `Saving file…`
  String get p2pSavingFile {
    return Intl.message(
      'Saving file…',
      name: 'p2pSavingFile',
      desc: '',
      args: [],
    );
  }

  /// `File received successfully`
  String get p2pReceivingCompleted {
    return Intl.message(
      'File received successfully',
      name: 'p2pReceivingCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Error while receiving file`
  String get p2pReceivingError {
    return Intl.message(
      'Error while receiving file',
      name: 'p2pReceivingError',
      desc: '',
      args: [],
    );
  }

  /// `Invite from {name}`
  String inboxInviteTitle(Object name) {
    return Intl.message(
      'Invite from $name',
      name: 'inboxInviteTitle',
      desc: '',
      args: [name],
    );
  }

  /// `Wants to exchange files with you`
  String get inboxInviteSubtitle {
    return Intl.message(
      'Wants to exchange files with you',
      name: 'inboxInviteSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{name} accepted your invite`
  String inboxInviteAcceptTitle(Object name) {
    return Intl.message(
      '$name accepted your invite',
      name: 'inboxInviteAcceptTitle',
      desc: '',
      args: [name],
    );
  }

  /// `You can now exchange files securely`
  String get inboxInviteAcceptSubtitle {
    return Intl.message(
      'You can now exchange files securely',
      name: 'inboxInviteAcceptSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Message from user {id}`
  String inboxMessageTitle(Object id) {
    return Intl.message(
      'Message from user $id',
      name: 'inboxMessageTitle',
      desc: '',
      args: [id],
    );
  }

  /// `New message`
  String get inboxMessageSubtitle {
    return Intl.message(
      'New message',
      name: 'inboxMessageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `File transfer request`
  String get inboxFileRequestTitle {
    return Intl.message(
      'File transfer request',
      name: 'inboxFileRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `File: {type} • {size} bytes`
  String inboxFileRequestSubtitle(Object type, Object size) {
    return Intl.message(
      'File: $type • $size bytes',
      name: 'inboxFileRequestSubtitle',
      desc: '',
      args: [type, size],
    );
  }

  /// `Error: public key not found`
  String get inboxErrorNoKey {
    return Intl.message(
      'Error: public key not found',
      name: 'inboxErrorNoKey',
      desc: '',
      args: [],
    );
  }

  /// `Contact added`
  String get inboxContactAdded {
    return Intl.message(
      'Contact added',
      name: 'inboxContactAdded',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get inboxReject {
    return Intl.message('Reject', name: 'inboxReject', desc: '', args: []);
  }

  /// `Accept`
  String get inboxAccept {
    return Intl.message('Accept', name: 'inboxAccept', desc: '', args: []);
  }

  /// `Invitation`
  String get inboxInviteDialogTitle {
    return Intl.message(
      'Invitation',
      name: 'inboxInviteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `{name} wants to exchange files with you.`
  String inboxInviteDialogMessage(Object name) {
    return Intl.message(
      '$name wants to exchange files with you.',
      name: 'inboxInviteDialogMessage',
      desc: '',
      args: [name],
    );
  }

  /// `Chat with {name}`
  String chatWith(Object name) {
    return Intl.message(
      'Chat with $name',
      name: 'chatWith',
      desc: '',
      args: [name],
    );
  }

  /// `Write a message...`
  String get chatPlaceholder {
    return Intl.message(
      'Write a message...',
      name: 'chatPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chatListTitle {
    return Intl.message('Chats', name: 'chatListTitle', desc: '', args: []);
  }

  /// `No conversations`
  String get chatListEmpty {
    return Intl.message(
      'No conversations',
      name: 'chatListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `User {id}`
  String chatListUser(Object id) {
    return Intl.message('User $id', name: 'chatListUser', desc: '', args: [id]);
  }

  /// `📤 File sent`
  String get chatListFileSent {
    return Intl.message(
      '📤 File sent',
      name: 'chatListFileSent',
      desc: '',
      args: [],
    );
  }

  /// `📁 File received`
  String get chatListFileReceived {
    return Intl.message(
      '📁 File received',
      name: 'chatListFileReceived',
      desc: '',
      args: [],
    );
  }

  /// `Invite sent`
  String get contactInviteSent {
    return Intl.message(
      'Invite sent',
      name: 'contactInviteSent',
      desc: '',
      args: [],
    );
  }

  /// `User {id}`
  String contactUser(Object id) {
    return Intl.message('User $id', name: 'contactUser', desc: '', args: [id]);
  }

  /// `ECC keys not found`
  String get encryptErrorNoECC {
    return Intl.message(
      'ECC keys not found',
      name: 'encryptErrorNoECC',
      desc: '',
      args: [],
    );
  }

  /// `No valid recipients`
  String get encryptErrorNoRecipients {
    return Intl.message(
      'No valid recipients',
      name: 'encryptErrorNoRecipients',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported content type`
  String get encryptErrorUnsupported {
    return Intl.message(
      'Unsupported content type',
      name: 'encryptErrorUnsupported',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get encryptErrorGeneric {
    return Intl.message(
      'Error',
      name: 'encryptErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Preparing…`
  String get encryptPreparing {
    return Intl.message(
      'Preparing…',
      name: 'encryptPreparing',
      desc: '',
      args: [],
    );
  }

  /// `The visible image would require more than {mb}MB to contain the payload.`
  String encryptImageTooLarge(Object mb) {
    return Intl.message(
      'The visible image would require more than ${mb}MB to contain the payload.',
      name: 'encryptImageTooLarge',
      desc: '',
      args: [mb],
    );
  }

  /// `Encryption summary`
  String get encryptPreviewTitle {
    return Intl.message(
      'Encryption summary',
      name: 'encryptPreviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Visible image`
  String get encryptPreviewVisibleImage {
    return Intl.message(
      'Visible image',
      name: 'encryptPreviewVisibleImage',
      desc: '',
      args: [],
    );
  }

  /// `Hidden content`
  String get encryptPreviewSecret {
    return Intl.message(
      'Hidden content',
      name: 'encryptPreviewSecret',
      desc: '',
      args: [],
    );
  }

  /// `Recipients`
  String get encryptPreviewRecipients {
    return Intl.message(
      'Recipients',
      name: 'encryptPreviewRecipients',
      desc: '',
      args: [],
    );
  }

  /// `Payload size`
  String get encryptPreviewPayloadSize {
    return Intl.message(
      'Payload size',
      name: 'encryptPreviewPayloadSize',
      desc: '',
      args: [],
    );
  }

  /// `Image capacity`
  String get encryptPreviewCapacity {
    return Intl.message(
      'Image capacity',
      name: 'encryptPreviewCapacity',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get encryptPreviewProceed {
    return Intl.message(
      'Proceed',
      name: 'encryptPreviewProceed',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get encryptPreviewCancel {
    return Intl.message(
      'Cancel',
      name: 'encryptPreviewCancel',
      desc: '',
      args: [],
    );
  }

  /// `Encrypting…`
  String get encryptProgressEncrypting {
    return Intl.message(
      'Encrypting…',
      name: 'encryptProgressEncrypting',
      desc: '',
      args: [],
    );
  }

  /// `Preparing image…`
  String get encryptProgressPreparingImage {
    return Intl.message(
      'Preparing image…',
      name: 'encryptProgressPreparingImage',
      desc: '',
      args: [],
    );
  }

  /// `Computing keys…`
  String get encryptProgressComputingKeys {
    return Intl.message(
      'Computing keys…',
      name: 'encryptProgressComputingKeys',
      desc: '',
      args: [],
    );
  }

  /// `Embedding content…`
  String get encryptProgressEmbedding {
    return Intl.message(
      'Embedding content…',
      name: 'encryptProgressEmbedding',
      desc: '',
      args: [],
    );
  }

  /// `Invisible content ready!`
  String get videoWWSecretReady {
    return Intl.message(
      'Invisible content ready!',
      name: 'videoWWSecretReady',
      desc: '',
      args: [],
    );
  }

  /// `Visible video`
  String get videoWWVisibleVideo {
    return Intl.message(
      'Visible video',
      name: 'videoWWVisibleVideo',
      desc: '',
      args: [],
    );
  }

  /// `Video duration`
  String get videoWWDurationTitle {
    return Intl.message(
      'Video duration',
      name: 'videoWWDurationTitle',
      desc: '',
      args: [],
    );
  }

  /// `The video must be at least 30 seconds and at most 40 seconds long.`
  String get videoWWDurationMessage {
    return Intl.message(
      'The video must be at least 30 seconds and at most 40 seconds long.',
      name: 'videoWWDurationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Record video`
  String get videoWWRecord {
    return Intl.message(
      'Record video',
      name: 'videoWWRecord',
      desc: '',
      args: [],
    );
  }

  /// `Open gallery`
  String get videoWWPickFromGallery {
    return Intl.message(
      'Open gallery',
      name: 'videoWWPickFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Selected video`
  String get videoWWSelectedVideo {
    return Intl.message(
      'Selected video',
      name: 'videoWWSelectedVideo',
      desc: '',
      args: [],
    );
  }

  /// `Invisible content selected`
  String get videoWWSecretSelected {
    return Intl.message(
      'Invisible content selected',
      name: 'videoWWSecretSelected',
      desc: '',
      args: [],
    );
  }

  /// `Select the visible video first`
  String get videoWWErrorNoVideo {
    return Intl.message(
      'Select the visible video first',
      name: 'videoWWErrorNoVideo',
      desc: '',
      args: [],
    );
  }

  /// `Select what you want to hide`
  String get videoWWErrorNoSecret {
    return Intl.message(
      'Select what you want to hide',
      name: 'videoWWErrorNoSecret',
      desc: '',
      args: [],
    );
  }

  /// `Select at least one recipient`
  String get videoWWErrorNoRecipients {
    return Intl.message(
      'Select at least one recipient',
      name: 'videoWWErrorNoRecipients',
      desc: '',
      args: [],
    );
  }

  /// `Encrypt and send`
  String get encryptAndSend {
    return Intl.message(
      'Encrypt and send',
      name: 'encryptAndSend',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
