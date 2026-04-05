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
  /// **'Benvenuto in WinkWink'**
  String get loginTitle;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Inserisci i tuoi dati per iniziare.'**
  String get loginDescription;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Campo obbligatorio'**
  String get requiredField;

  /// No description provided for @loginIdGeneratedTitle.
  ///
  /// In en, this message translates to:
  /// **'ID Generato'**
  String get loginIdGeneratedTitle;

  /// No description provided for @loginIdGeneratedMessage.
  ///
  /// In en, this message translates to:
  /// **'Il tuo ID univoco è stato creato in modo sicuro.'**
  String get loginIdGeneratedMessage;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Nome'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Cognome'**
  String get lastNameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Numero di Telefono'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Indirizzo Email'**
  String get emailLabel;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Inserisci un\'email valida'**
  String get invalidEmail;

  /// No description provided for @optionalPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Opzionale'**
  String get optionalPasswordTitle;

  /// No description provided for @optionalPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Puoi impostare una password per maggiore sicurezza'**
  String get optionalPasswordSubtitle;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordMustContain.
  ///
  /// In en, this message translates to:
  /// **'La password deve contenere almeno 8 caratteri'**
  String get passwordMustContain;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password troppo corta'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Conferma Password'**
  String get confirmPasswordLabel;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Le password non corrispondono'**
  String get passwordsDontMatch;

  /// No description provided for @generateIdButton.
  ///
  /// In en, this message translates to:
  /// **'Genera ID'**
  String get generateIdButton;

  /// No description provided for @profileCreatedFor.
  ///
  /// In en, this message translates to:
  /// **'Profilo creato per'**
  String get profileCreatedFor;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Accedi'**
  String get loginButton;

  /// No description provided for @sendQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Invia Codice QR'**
  String get sendQrTitle;

  /// No description provided for @sendQrDescription.
  ///
  /// In en, this message translates to:
  /// **'Condividi questo QR con i tuoi contatti'**
  String get sendQrDescription;

  /// No description provided for @sendQrButton.
  ///
  /// In en, this message translates to:
  /// **'Invia QR'**
  String get sendQrButton;

  /// No description provided for @scanQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Scansiona QR'**
  String get scanQrTitle;

  /// No description provided for @scanQrDescription.
  ///
  /// In en, this message translates to:
  /// **'Scansiona il QR di un contatto'**
  String get scanQrDescription;

  /// No description provided for @scanQrButton.
  ///
  /// In en, this message translates to:
  /// **'Scansiona QR'**
  String get scanQrButton;

  /// No description provided for @encryptTitle.
  ///
  /// In en, this message translates to:
  /// **'Cripta File'**
  String get encryptTitle;

  /// No description provided for @encryptDescription.
  ///
  /// In en, this message translates to:
  /// **'Nascondi un file dentro un\'immagine'**
  String get encryptDescription;

  /// No description provided for @encryptButton.
  ///
  /// In en, this message translates to:
  /// **'Cripta Ora'**
  String get encryptButton;

  /// No description provided for @encryptError.
  ///
  /// In en, this message translates to:
  /// **'Errore Criptazione'**
  String get encryptError;

  /// No description provided for @encryptReady.
  ///
  /// In en, this message translates to:
  /// **'File Pronto'**
  String get encryptReady;

  /// No description provided for @encryptReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Il tuo file è stato criptato con successo'**
  String get encryptReadyMessage;

  /// No description provided for @decryptTitle.
  ///
  /// In en, this message translates to:
  /// **'Decripta File'**
  String get decryptTitle;

  /// No description provided for @decryptDescription.
  ///
  /// In en, this message translates to:
  /// **'Estrai un file nascosto'**
  String get decryptDescription;

  /// No description provided for @decryptButton.
  ///
  /// In en, this message translates to:
  /// **'Decripta Ora'**
  String get decryptButton;

  /// No description provided for @decryptError.
  ///
  /// In en, this message translates to:
  /// **'Errore Decriptazione'**
  String get decryptError;

  /// No description provided for @decryptReady.
  ///
  /// In en, this message translates to:
  /// **'File Decriptato'**
  String get decryptReady;

  /// No description provided for @decryptReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Il file nascosto è stato estratto con successo'**
  String get decryptReadyMessage;

  /// No description provided for @encryptButtonHome.
  ///
  /// In en, this message translates to:
  /// **'Cripta'**
  String get encryptButtonHome;

  /// No description provided for @decryptButtonHome.
  ///
  /// In en, this message translates to:
  /// **'Decripta'**
  String get decryptButtonHome;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Galleria Sicura'**
  String get galleryTitle;

  /// No description provided for @galleryButton.
  ///
  /// In en, this message translates to:
  /// **'Galleria'**
  String get galleryButton;

  /// No description provided for @contactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contatti'**
  String get contactsTitle;

  /// No description provided for @contactsButton.
  ///
  /// In en, this message translates to:
  /// **'Contatti'**
  String get contactsButton;

  /// No description provided for @searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Cerca contatti...'**
  String get searchContacts;

  /// No description provided for @giveQr.
  ///
  /// In en, this message translates to:
  /// **'Invia QR a'**
  String get giveQr;

  /// No description provided for @passepartoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Passepartout'**
  String get passepartoutTitle;

  /// No description provided for @passepartoutButton.
  ///
  /// In en, this message translates to:
  /// **'Passepartout'**
  String get passepartoutButton;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ & Aiuto'**
  String get faqTitle;

  /// No description provided for @faqButton.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqButton;

  /// No description provided for @faqContent.
  ///
  /// In en, this message translates to:
  /// **'WinkWink usa la steganografia per nascondere i tuoi file...'**
  String get faqContent;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Errore'**
  String get errorTitle;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @invalidQr.
  ///
  /// In en, this message translates to:
  /// **'Codice QR non valido'**
  String get invalidQr;

  /// No description provided for @qrImageError.
  ///
  /// In en, this message translates to:
  /// **'Errore nella generazione dell\'immagine QR'**
  String get qrImageError;

  /// No description provided for @shareQrMessage.
  ///
  /// In en, this message translates to:
  /// **'Ecco il mio QR di contatto sicuro'**
  String get shareQrMessage;

  /// No description provided for @shareQrSubject.
  ///
  /// In en, this message translates to:
  /// **'Contatto WinkWink'**
  String get shareQrSubject;

  /// No description provided for @internalQrData.
  ///
  /// In en, this message translates to:
  /// **'Dati Interni'**
  String get internalQrData;

  /// No description provided for @forwardButton.
  ///
  /// In en, this message translates to:
  /// **'Inoltra'**
  String get forwardButton;

  /// No description provided for @encryptMissingSelection.
  ///
  /// In en, this message translates to:
  /// **'Seleziona un file da criptare'**
  String get encryptMissingSelection;

  /// No description provided for @encryptPickVisible.
  ///
  /// In en, this message translates to:
  /// **'Scegli immagine visibile'**
  String get encryptPickVisible;

  /// No description provided for @encryptVisibleSelected.
  ///
  /// In en, this message translates to:
  /// **'Immagine visibile selezionata'**
  String get encryptVisibleSelected;

  /// No description provided for @encryptChooseHidden.
  ///
  /// In en, this message translates to:
  /// **'Scegli contenuto nascosto'**
  String get encryptChooseHidden;

  /// No description provided for @encryptHideImage.
  ///
  /// In en, this message translates to:
  /// **'Nascondi immagine'**
  String get encryptHideImage;

  /// No description provided for @encryptHideText.
  ///
  /// In en, this message translates to:
  /// **'Nascondi testo'**
  String get encryptHideText;

  /// No description provided for @encryptHideAudio.
  ///
  /// In en, this message translates to:
  /// **'Nascondi audio'**
  String get encryptHideAudio;

  /// No description provided for @galleryEmptyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Nessun file trovato'**
  String get galleryEmptyPlaceholder;

  /// No description provided for @fileLabel.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get fileLabel;

  /// No description provided for @fileTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Tipo'**
  String get fileTypeLabel;

  /// No description provided for @scanQrPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Scansiona QR'**
  String get scanQrPlaceholderTitle;

  /// No description provided for @scanQrPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Inquadra un codice QR di WinkWink'**
  String get scanQrPlaceholderMessage;

  /// No description provided for @passepartoutPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Le tue chiavi master appariranno qui'**
  String get passepartoutPlaceholder;

  /// No description provided for @noPasswordSaved.
  ///
  /// In en, this message translates to:
  /// **'Nessuna password salvata'**
  String get noPasswordSaved;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Password errata'**
  String get wrongPassword;

  /// No description provided for @passwordGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Controllo di Sicurezza'**
  String get passwordGateTitle;

  /// No description provided for @passwordGateDescription.
  ///
  /// In en, this message translates to:
  /// **'Inserisci la password per procedere'**
  String get passwordGateDescription;

  /// No description provided for @passwordLabelShort.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabelShort;

  /// No description provided for @accessButton.
  ///
  /// In en, this message translates to:
  /// **'Accedi'**
  String get accessButton;

  /// No description provided for @startupLoading.
  ///
  /// In en, this message translates to:
  /// **'Caricamento WinkWink...'**
  String get startupLoading;

  /// No description provided for @encrypt_title.
  ///
  /// In en, this message translates to:
  /// **'Cripta'**
  String get encrypt_title;

  /// No description provided for @encrypt_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Qui crei la tua immagine criptata che puoi inviare. Apri una immagine dalla tua galleria che sarà visibile a tutti. Clicca su OK e segui le istruzioni.'**
  String get encrypt_subtitle;

  /// No description provided for @visible_image_button.
  ///
  /// In en, this message translates to:
  /// **'Immagine Visibile'**
  String get visible_image_button;

  /// No description provided for @visible_image_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Scegli la foto visibile'**
  String get visible_image_subtitle;

  /// No description provided for @choose_hidden_prompt.
  ///
  /// In en, this message translates to:
  /// **'Scegli cosa vuoi nascondere'**
  String get choose_hidden_prompt;

  /// No description provided for @hide_image.
  ///
  /// In en, this message translates to:
  /// **'Nascondi immagine'**
  String get hide_image;

  /// No description provided for @hide_text.
  ///
  /// In en, this message translates to:
  /// **'Nascondi un messaggio'**
  String get hide_text;

  /// No description provided for @take_photo.
  ///
  /// In en, this message translates to:
  /// **'Scatta foto'**
  String get take_photo;

  /// No description provided for @hide_audio.
  ///
  /// In en, this message translates to:
  /// **'Nascondi un audio'**
  String get hide_audio;

  /// No description provided for @ok_button.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok_button;

  /// No description provided for @encryptMissingHiddenImage.
  ///
  /// In en, this message translates to:
  /// **'Seleziona l\'immagine da nascondere.'**
  String get encryptMissingHiddenImage;

  /// No description provided for @encryptSelectRecipients.
  ///
  /// In en, this message translates to:
  /// **'Seleziona i destinatari'**
  String get encryptSelectRecipients;

  /// No description provided for @encryptMissingRecipients.
  ///
  /// In en, this message translates to:
  /// **'Seleziona almeno un destinatario.'**
  String get encryptMissingRecipients;

  /// No description provided for @encryptHiddenImageSelected.
  ///
  /// In en, this message translates to:
  /// **'Immagine nascosta selezionata'**
  String get encryptHiddenImageSelected;

  /// No description provided for @decryptMissingImage.
  ///
  /// In en, this message translates to:
  /// **'Seleziona un\'immagine da decriptare'**
  String get decryptMissingImage;

  /// No description provided for @decryptSuccess.
  ///
  /// In en, this message translates to:
  /// **'Decriptazione completata'**
  String get decryptSuccess;

  /// No description provided for @decryptSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Il file è stato decriptato correttamente'**
  String get decryptSuccessMessage;

  /// No description provided for @decryptPickImage.
  ///
  /// In en, this message translates to:
  /// **'Scegli immagine criptata'**
  String get decryptPickImage;

  /// No description provided for @decryptResult.
  ///
  /// In en, this message translates to:
  /// **'Risultato decriptato'**
  String get decryptResult;
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
