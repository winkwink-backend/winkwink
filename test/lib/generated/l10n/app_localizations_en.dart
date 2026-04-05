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
  String get loginTitle => 'Benvenuto in WinkWink';

  @override
  String get loginDescription => 'Inserisci i tuoi dati per iniziare.';

  @override
  String get requiredField => 'Campo obbligatorio';

  @override
  String get loginIdGeneratedTitle => 'ID Generato';

  @override
  String get loginIdGeneratedMessage =>
      'Il tuo ID univoco è stato creato in modo sicuro.';

  @override
  String get firstNameLabel => 'Nome';

  @override
  String get lastNameLabel => 'Cognome';

  @override
  String get phoneLabel => 'Numero di Telefono';

  @override
  String get emailLabel => 'Indirizzo Email';

  @override
  String get invalidEmail => 'Inserisci un\'email valida';

  @override
  String get optionalPasswordTitle => 'Password Opzionale';

  @override
  String get optionalPasswordSubtitle =>
      'Puoi impostare una password per maggiore sicurezza';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMustContain =>
      'La password deve contenere almeno 8 caratteri';

  @override
  String get passwordTooShort => 'Password troppo corta';

  @override
  String get confirmPasswordLabel => 'Conferma Password';

  @override
  String get passwordsDontMatch => 'Le password non corrispondono';

  @override
  String get generateIdButton => 'Genera ID';

  @override
  String get profileCreatedFor => 'Profilo creato per';

  @override
  String get loginButton => 'Accedi';

  @override
  String get sendQrTitle => 'Invia Codice QR';

  @override
  String get sendQrDescription => 'Condividi questo QR con i tuoi contatti';

  @override
  String get sendQrButton => 'Invia QR';

  @override
  String get scanQrTitle => 'Scansiona QR';

  @override
  String get scanQrDescription => 'Scansiona il QR di un contatto';

  @override
  String get scanQrButton => 'Scansiona QR';

  @override
  String get encryptTitle => 'Cripta File';

  @override
  String get encryptDescription => 'Nascondi un file dentro un\'immagine';

  @override
  String get encryptButton => 'Cripta Ora';

  @override
  String get encryptError => 'Errore Criptazione';

  @override
  String get encryptReady => 'File Pronto';

  @override
  String get encryptReadyMessage => 'Il tuo file è stato criptato con successo';

  @override
  String get decryptTitle => 'Decripta File';

  @override
  String get decryptDescription => 'Estrai un file nascosto';

  @override
  String get decryptButton => 'Decripta Ora';

  @override
  String get decryptError => 'Errore Decriptazione';

  @override
  String get decryptReady => 'File Decriptato';

  @override
  String get decryptReadyMessage =>
      'Il file nascosto è stato estratto con successo';

  @override
  String get encryptButtonHome => 'Cripta';

  @override
  String get decryptButtonHome => 'Decripta';

  @override
  String get galleryTitle => 'Galleria Sicura';

  @override
  String get galleryButton => 'Galleria';

  @override
  String get contactsTitle => 'Contatti';

  @override
  String get contactsButton => 'Contatti';

  @override
  String get searchContacts => 'Cerca contatti...';

  @override
  String get giveQr => 'Invia QR a';

  @override
  String get passepartoutTitle => 'Passepartout';

  @override
  String get passepartoutButton => 'Passepartout';

  @override
  String get faqTitle => 'FAQ & Aiuto';

  @override
  String get faqButton => 'FAQ';

  @override
  String get faqContent =>
      'WinkWink usa la steganografia per nascondere i tuoi file...';

  @override
  String get errorTitle => 'Errore';

  @override
  String get okButton => 'OK';

  @override
  String get invalidQr => 'Codice QR non valido';

  @override
  String get qrImageError => 'Errore nella generazione dell\'immagine QR';

  @override
  String get shareQrMessage => 'Ecco il mio QR di contatto sicuro';

  @override
  String get shareQrSubject => 'Contatto WinkWink';

  @override
  String get internalQrData => 'Dati Interni';

  @override
  String get forwardButton => 'Inoltra';

  @override
  String get encryptMissingSelection => 'Seleziona un file da criptare';

  @override
  String get encryptPickVisible => 'Scegli immagine visibile';

  @override
  String get encryptVisibleSelected => 'Immagine visibile selezionata';

  @override
  String get encryptChooseHidden => 'Scegli contenuto nascosto';

  @override
  String get encryptHideImage => 'Nascondi immagine';

  @override
  String get encryptHideText => 'Nascondi testo';

  @override
  String get encryptHideAudio => 'Nascondi audio';

  @override
  String get galleryEmptyPlaceholder => 'Nessun file trovato';

  @override
  String get fileLabel => 'File';

  @override
  String get fileTypeLabel => 'Tipo';

  @override
  String get scanQrPlaceholderTitle => 'Scansiona QR';

  @override
  String get scanQrPlaceholderMessage => 'Inquadra un codice QR di WinkWink';

  @override
  String get passepartoutPlaceholder => 'Le tue chiavi master appariranno qui';

  @override
  String get noPasswordSaved => 'Nessuna password salvata';

  @override
  String get wrongPassword => 'Password errata';

  @override
  String get passwordGateTitle => 'Controllo di Sicurezza';

  @override
  String get passwordGateDescription => 'Inserisci la password per procedere';

  @override
  String get passwordLabelShort => 'Password';

  @override
  String get accessButton => 'Accedi';

  @override
  String get startupLoading => 'Caricamento WinkWink...';

  @override
  String get encrypt_title => 'Cripta';

  @override
  String get encrypt_subtitle =>
      'Qui crei la tua immagine criptata che puoi inviare. Apri una immagine dalla tua galleria che sarà visibile a tutti. Clicca su OK e segui le istruzioni.';

  @override
  String get visible_image_button => 'Immagine Visibile';

  @override
  String get visible_image_subtitle => 'Scegli la foto visibile';

  @override
  String get choose_hidden_prompt => 'Scegli cosa vuoi nascondere';

  @override
  String get hide_image => 'Nascondi immagine';

  @override
  String get hide_text => 'Nascondi un messaggio';

  @override
  String get take_photo => 'Scatta foto';

  @override
  String get hide_audio => 'Nascondi un audio';

  @override
  String get ok_button => 'OK';

  @override
  String get encryptMissingHiddenImage =>
      'Seleziona l\'immagine da nascondere.';

  @override
  String get encryptSelectRecipients => 'Seleziona i destinatari';

  @override
  String get encryptMissingRecipients => 'Seleziona almeno un destinatario.';

  @override
  String get encryptHiddenImageSelected => 'Immagine nascosta selezionata';

  @override
  String get decryptMissingImage => 'Seleziona un\'immagine da decriptare';

  @override
  String get decryptSuccess => 'Decriptazione completata';

  @override
  String get decryptSuccessMessage =>
      'Il file è stato decriptato correttamente';

  @override
  String get decryptPickImage => 'Scegli immagine criptata';

  @override
  String get decryptResult => 'Risultato decriptato';
}
