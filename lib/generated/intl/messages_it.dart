// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'it';

  static String m0(id) => "Utente ${id}";

  static String m1(name) => "Chat con ${name}";

  static String m2(id) => "Utente ${id}";

  static String m3(mb) =>
      "L\'immagine visibile richiederebbe più di ${mb}MB per contenere il contenuto.";

  static String m4(type, size) => "File: ${type} • ${size} byte";

  static String m5(name) => "${name} ha accettato l\'invito";

  static String m6(name) => "${name} vuole scambiare file con te.";

  static String m7(name) => "Invito da ${name}";

  static String m8(id) => "Messaggio dall\'utente ${id}";

  static String m9(current, max) => "${current} MB / ${max} MB";

  static String m10(used, max) => "${used} MB / ${max} MB";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessButton": MessageLookupByLibrary.simpleMessage("Accedi"),
    "appTitle": MessageLookupByLibrary.simpleMessage("WinkWink"),
    "audioSecretSubtitle": MessageLookupByLibrary.simpleMessage(
      "Registra un messaggio vocale da nascondere",
    ),
    "audioSecretTitle": MessageLookupByLibrary.simpleMessage(
      "Registra audio segreto",
    ),
    "backButton": MessageLookupByLibrary.simpleMessage("Indietro"),
    "cameraSecretSubtitle": MessageLookupByLibrary.simpleMessage(
      "Usa la fotocamera per catturare un contenuto segreto",
    ),
    "cameraSecretTitle": MessageLookupByLibrary.simpleMessage(
      "Scatta foto segreta",
    ),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Annulla"),
    "changeColor": MessageLookupByLibrary.simpleMessage("Cambia colore"),
    "changeSecret": MessageLookupByLibrary.simpleMessage(
      "Vuoi cambiare il segreto?",
    ),
    "chatListEmpty": MessageLookupByLibrary.simpleMessage(
      "Nessuna conversazione",
    ),
    "chatListFileReceived": MessageLookupByLibrary.simpleMessage(
      "📥 File ricevuto",
    ),
    "chatListFileSent": MessageLookupByLibrary.simpleMessage("📤 File inviato"),
    "chatListTitle": MessageLookupByLibrary.simpleMessage("Chat"),
    "chatListUser": m0,
    "chatPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Scrivi un messaggio...",
    ),
    "chatWith": m1,
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Conferma password",
    ),
    "contactAddedMessage": MessageLookupByLibrary.simpleMessage(
      "è stato aggiunto ai tuoi contatti WinkWink",
    ),
    "contactAddedTitle": MessageLookupByLibrary.simpleMessage(
      "Contatto inserito",
    ),
    "contactDeleted": MessageLookupByLibrary.simpleMessage(
      "Contatto eliminato",
    ),
    "contactDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Il contatto è stato rimosso e non potrai più inviare o ricevere file da questa persona.",
    ),
    "contactInviteSent": MessageLookupByLibrary.simpleMessage("Invito inviato"),
    "contactUser": m2,
    "contactsButton": MessageLookupByLibrary.simpleMessage("Contatti"),
    "contactsTitle": MessageLookupByLibrary.simpleMessage("Contatti"),
    "decryptButton": MessageLookupByLibrary.simpleMessage("Decifra ora"),
    "decryptButtonHome": MessageLookupByLibrary.simpleMessage("Decifra"),
    "decryptDescription": MessageLookupByLibrary.simpleMessage(
      "Estrai un file nascosto",
    ),
    "decryptError": MessageLookupByLibrary.simpleMessage(
      "Errore di decifratura",
    ),
    "decryptMissingImage": MessageLookupByLibrary.simpleMessage(
      "Seleziona un\'immagine da decifrare",
    ),
    "decryptPickImage": MessageLookupByLibrary.simpleMessage(
      "Scegli immagine cifrata",
    ),
    "decryptReady": MessageLookupByLibrary.simpleMessage("File decifrato"),
    "decryptReadyMessage": MessageLookupByLibrary.simpleMessage(
      "Il file nascosto è stato estratto con successo",
    ),
    "decryptResult": MessageLookupByLibrary.simpleMessage(
      "Risultato decifrato",
    ),
    "decryptSuccess": MessageLookupByLibrary.simpleMessage(
      "Decifratura completata",
    ),
    "decryptSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Il file è stato decifrato con successo",
    ),
    "decryptTitle": MessageLookupByLibrary.simpleMessage("Decifra file"),
    "decrypting": MessageLookupByLibrary.simpleMessage(
      "Decifratura in corso...",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Elimina"),
    "deleteButton": MessageLookupByLibrary.simpleMessage("Elimina"),
    "emailAssociated": MessageLookupByLibrary.simpleMessage("Email associata"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Indirizzo email"),
    "encryptAndSend": MessageLookupByLibrary.simpleMessage("Cifra e invia"),
    "encryptButton": MessageLookupByLibrary.simpleMessage("Cifra ora"),
    "encryptButtonHome": MessageLookupByLibrary.simpleMessage("Cifra"),
    "encryptContactsButton": MessageLookupByLibrary.simpleMessage("Contatti"),
    "encryptDescription": MessageLookupByLibrary.simpleMessage(
      "Nascondi un file dentro un\'immagine",
    ),
    "encryptError": MessageLookupByLibrary.simpleMessage("Errore di cifratura"),
    "encryptErrorGeneric": MessageLookupByLibrary.simpleMessage("Errore"),
    "encryptErrorNoECC": MessageLookupByLibrary.simpleMessage(
      "Chiavi ECC non trovate",
    ),
    "encryptErrorNoRecipients": MessageLookupByLibrary.simpleMessage(
      "Nessun destinatario valido",
    ),
    "encryptErrorUnsupported": MessageLookupByLibrary.simpleMessage(
      "Tipo di contenuto non supportato",
    ),
    "encryptHideAudio": MessageLookupByLibrary.simpleMessage("Nascondi audio"),
    "encryptHideCamera": MessageLookupByLibrary.simpleMessage("Fotocamera"),
    "encryptHideImage": MessageLookupByLibrary.simpleMessage(
      "Nascondi immagine",
    ),
    "encryptHideSandwich": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "encryptHideText": MessageLookupByLibrary.simpleMessage("Nascondi testo"),
    "encryptImageTooLarge": m3,
    "encryptMissingSelection": MessageLookupByLibrary.simpleMessage(
      "Seleziona un file da cifrare",
    ),
    "encryptNoContactsAvailable": MessageLookupByLibrary.simpleMessage(
      "Nessun contatto disponibile",
    ),
    "encryptPickVisibleImage": MessageLookupByLibrary.simpleMessage("Immagine"),
    "encryptPreparing": MessageLookupByLibrary.simpleMessage("Preparazione…"),
    "encryptPreviewCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
    "encryptPreviewCapacity": MessageLookupByLibrary.simpleMessage(
      "Capacità immagine",
    ),
    "encryptPreviewPayloadSize": MessageLookupByLibrary.simpleMessage(
      "Dimensione contenuto",
    ),
    "encryptPreviewProceed": MessageLookupByLibrary.simpleMessage("Procedi"),
    "encryptPreviewRecipients": MessageLookupByLibrary.simpleMessage(
      "Destinatari",
    ),
    "encryptPreviewSecret": MessageLookupByLibrary.simpleMessage(
      "Contenuto nascosto",
    ),
    "encryptPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Riepilogo cifratura",
    ),
    "encryptPreviewVisibleImage": MessageLookupByLibrary.simpleMessage(
      "Immagine visibile",
    ),
    "encryptProgressComputingKeys": MessageLookupByLibrary.simpleMessage(
      "Calcolo chiavi…",
    ),
    "encryptProgressEmbedding": MessageLookupByLibrary.simpleMessage(
      "Incorporamento contenuto…",
    ),
    "encryptProgressEncrypting": MessageLookupByLibrary.simpleMessage(
      "Cifratura in corso…",
    ),
    "encryptProgressPreparingImage": MessageLookupByLibrary.simpleMessage(
      "Preparazione immagine…",
    ),
    "encryptReady": MessageLookupByLibrary.simpleMessage("File pronto"),
    "encryptReadyMessage": MessageLookupByLibrary.simpleMessage(
      "Il tuo file è stato cifrato con successo",
    ),
    "encryptSecretReady": MessageLookupByLibrary.simpleMessage(
      "Contenuto nascosto pronto ✔",
    ),
    "encryptSelectRecipients": MessageLookupByLibrary.simpleMessage("contatti"),
    "encryptSelectRecipientsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Scegli con chi vuoi condividere i tuoi file segreti",
    ),
    "encryptSelectRecipientsTitle": MessageLookupByLibrary.simpleMessage(
      "Seleziona i contatti a cui inviare un file segreto",
    ),
    "encryptSelectSecret": MessageLookupByLibrary.simpleMessage(
      "Seleziona il segreto da cifrare",
    ),
    "encryptSelectedContent": MessageLookupByLibrary.simpleMessage(
      "Contenuto selezionato",
    ),
    "encryptTakePhoto": MessageLookupByLibrary.simpleMessage("Scatta foto"),
    "encryptTitle": MessageLookupByLibrary.simpleMessage("Cifra file"),
    "encryptVisibleImageTitle": MessageLookupByLibrary.simpleMessage(
      "Scegli l\'immagine visibile a tutti",
    ),
    "encryptWhatToHide": MessageLookupByLibrary.simpleMessage(
      "Cosa vuoi nascondere?",
    ),
    "encrypting": MessageLookupByLibrary.simpleMessage("Cifratura in corso..."),
    "errorTitle": MessageLookupByLibrary.simpleMessage("Errore"),
    "faqButton": MessageLookupByLibrary.simpleMessage("FAQ"),
    "faqContent": MessageLookupByLibrary.simpleMessage(
      "WinkWink utilizza la steganografia per nascondere i tuoi file...",
    ),
    "faqNoResults": MessageLookupByLibrary.simpleMessage(
      "Nessuna risposta trovata.",
    ),
    "faqSearchHint": MessageLookupByLibrary.simpleMessage("Fai una domanda..."),
    "faqTitle": MessageLookupByLibrary.simpleMessage("FAQ e Aiuto"),
    "fileLabel": MessageLookupByLibrary.simpleMessage("File"),
    "fileTypeLabel": MessageLookupByLibrary.simpleMessage("Tipo"),
    "firstNameLabel": MessageLookupByLibrary.simpleMessage("Nome"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Password dimenticata?",
    ),
    "forwardButton": MessageLookupByLibrary.simpleMessage("Inoltra"),
    "galleryButton": MessageLookupByLibrary.simpleMessage("Galleria"),
    "galleryEmptyPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Nessun file trovato",
    ),
    "galleryTitle": MessageLookupByLibrary.simpleMessage("Galleria sicura"),
    "generateIdButton": MessageLookupByLibrary.simpleMessage("Genera ID"),
    "giveQr": MessageLookupByLibrary.simpleMessage("Invia QR a"),
    "goToContacts": MessageLookupByLibrary.simpleMessage("Apri Contatti"),
    "goToEncrypt": MessageLookupByLibrary.simpleMessage("Apri Cifratura"),
    "goToPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Recupero password",
    ),
    "goToScanQr": MessageLookupByLibrary.simpleMessage("Apri Scansiona QR"),
    "goToSendQr": MessageLookupByLibrary.simpleMessage("Apri Invia QR"),
    "goToVideoWW": MessageLookupByLibrary.simpleMessage("Apri VideoWW"),
    "hideImageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Seleziona l\'immagine segreta da nascondere",
    ),
    "hideImageTitle": MessageLookupByLibrary.simpleMessage("Nascondi immagine"),
    "homeGalleryTooltip": MessageLookupByLibrary.simpleMessage("WinkGallery"),
    "homeSettingsTooltip": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage("Segreti"),
    "inboxAccept": MessageLookupByLibrary.simpleMessage("Accetta"),
    "inboxContactAdded": MessageLookupByLibrary.simpleMessage(
      "Contatto aggiunto",
    ),
    "inboxErrorNoKey": MessageLookupByLibrary.simpleMessage(
      "Errore: chiave pubblica non trovata",
    ),
    "inboxFileRequestSubtitle": m4,
    "inboxFileRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Richiesta file",
    ),
    "inboxInviteAcceptSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ora potete scambiare file in modo sicuro",
    ),
    "inboxInviteAcceptTitle": m5,
    "inboxInviteDialogMessage": m6,
    "inboxInviteDialogTitle": MessageLookupByLibrary.simpleMessage("Invito"),
    "inboxInviteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vuole scambiare file con te",
    ),
    "inboxInviteTitle": m7,
    "inboxMessageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nuovo messaggio",
    ),
    "inboxMessageTitle": m8,
    "inboxReject": MessageLookupByLibrary.simpleMessage("Rifiuta"),
    "inboxTitle": MessageLookupByLibrary.simpleMessage("Notifiche"),
    "internalQrData": MessageLookupByLibrary.simpleMessage("Dati interni"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Inserisci un\'email valida",
    ),
    "invalidQr": MessageLookupByLibrary.simpleMessage("QR code non valido"),
    "lastNameLabel": MessageLookupByLibrary.simpleMessage("Cognome"),
    "legalAcceptButton": MessageLookupByLibrary.simpleMessage(
      "Accetta le note legali",
    ),
    "legalMustAccept": MessageLookupByLibrary.simpleMessage(
      "Devi accettare le note legali prima di procedere",
    ),
    "loginButton": MessageLookupByLibrary.simpleMessage("Accedi"),
    "loginDescription": MessageLookupByLibrary.simpleMessage(
      "Inserisci i tuoi dati per iniziare.",
    ),
    "loginDescriptionShort": MessageLookupByLibrary.simpleMessage(
      "Creiamo il tuo ID",
    ),
    "loginIdGeneratedMessage": MessageLookupByLibrary.simpleMessage(
      "Il tuo ID univoco è stato creato in modo sicuro.",
    ),
    "loginIdGeneratedTitle": MessageLookupByLibrary.simpleMessage(
      "ID generato",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Benvenuto in WinkWink"),
    "noContactsMessage": MessageLookupByLibrary.simpleMessage(
      "Nessun contatto disponibile",
    ),
    "noKeysWarning": MessageLookupByLibrary.simpleMessage(
      "Questo contatto non ha ancora una chiave pubblica",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "Nessuna notifica disponibile",
    ),
    "noPasswordSaved": MessageLookupByLibrary.simpleMessage(
      "Nessuna password salvata",
    ),
    "notificationGalleryFullMessage": MessageLookupByLibrary.simpleMessage(
      "La tua WinkGallery ha superato 1 GB. Aprila per rimuovere i file indesiderati.",
    ),
    "notificationGalleryFullTitle": MessageLookupByLibrary.simpleMessage(
      "WinkGallery piena",
    ),
    "notificationGeneric": MessageLookupByLibrary.simpleMessage(
      "Nuova notifica",
    ),
    "notificationNewMessage": MessageLookupByLibrary.simpleMessage(
      "Nuovo messaggio ricevuto",
    ),
    "notificationQrReceived": MessageLookupByLibrary.simpleMessage(
      "Hai ricevuto un QR",
    ),
    "notificationReceiveComplete": MessageLookupByLibrary.simpleMessage(
      "File ricevuto",
    ),
    "notificationSendComplete": MessageLookupByLibrary.simpleMessage(
      "Invio completato",
    ),
    "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
      "Nessuna notifica",
    ),
    "notificationsTitle": MessageLookupByLibrary.simpleMessage("Notifiche"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "okButton": MessageLookupByLibrary.simpleMessage("OK"),
    "optionalPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Puoi impostare una password per maggiore sicurezza",
    ),
    "optionalPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Password opzionale",
    ),
    "p2pConnectionEstablished": MessageLookupByLibrary.simpleMessage(
      "Connessione stabilita",
    ),
    "p2pReceiving": MessageLookupByLibrary.simpleMessage("Ricezione file…"),
    "p2pReceivingCompleted": MessageLookupByLibrary.simpleMessage(
      "File ricevuto con successo",
    ),
    "p2pReceivingError": MessageLookupByLibrary.simpleMessage(
      "Errore durante la ricezione del file",
    ),
    "p2pReceivingEstablished": MessageLookupByLibrary.simpleMessage(
      "Connessione stabilita",
    ),
    "p2pReceivingWaiting": MessageLookupByLibrary.simpleMessage(
      "In attesa del mittente…",
    ),
    "p2pSavingFile": MessageLookupByLibrary.simpleMessage("Salvataggio file…"),
    "p2pSending": MessageLookupByLibrary.simpleMessage("Invio file…"),
    "p2pSendingCompleted": MessageLookupByLibrary.simpleMessage(
      "File inviato con successo",
    ),
    "p2pSendingError": MessageLookupByLibrary.simpleMessage(
      "Errore durante l\'invio del file",
    ),
    "p2pSendingInProgress": MessageLookupByLibrary.simpleMessage(
      "Invio in corso…",
    ),
    "p2pWaitingAnswer": MessageLookupByLibrary.simpleMessage(
      "In attesa del destinatario…",
    ),
    "passepartoutButton": MessageLookupByLibrary.simpleMessage(
      "Chiave maestra",
    ),
    "passepartoutPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Le tue chiavi maestre appariranno qui",
    ),
    "passepartoutTitle": MessageLookupByLibrary.simpleMessage("Chiave maestra"),
    "passwordGateDescription": MessageLookupByLibrary.simpleMessage(
      "Inserisci la password per procedere",
    ),
    "passwordGateTitle": MessageLookupByLibrary.simpleMessage(
      "Controllo di sicurezza",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLabelShort": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMustContain": MessageLookupByLibrary.simpleMessage(
      "La password deve contenere almeno 8 caratteri",
    ),
    "passwordResetNewPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Salva",
    ),
    "passwordResetNewPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Imposta una nuova password per il tuo account.",
    ),
    "passwordResetNewPasswordError": MessageLookupByLibrary.simpleMessage(
      "Errore durante il salvataggio della password",
    ),
    "passwordResetNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Nuova password",
    ),
    "passwordResetNewPasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Le password non coincidono",
    ),
    "passwordResetNewPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Nuova password",
    ),
    "passwordResetRepeatPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Ripeti password",
    ),
    "passwordResetRequestConnectionError": MessageLookupByLibrary.simpleMessage(
      "Errore di connessione",
    ),
    "passwordResetRequestDescription": MessageLookupByLibrary.simpleMessage(
      "Inserisci la tua email per ricevere un codice di verifica.",
    ),
    "passwordResetRequestEmailHint": MessageLookupByLibrary.simpleMessage(
      "Email",
    ),
    "passwordResetRequestError": MessageLookupByLibrary.simpleMessage(
      "Errore durante l\'invio del codice",
    ),
    "passwordResetRequestSendButton": MessageLookupByLibrary.simpleMessage(
      "Invia codice",
    ),
    "passwordResetRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Recupero password",
    ),
    "passwordResetVerifyButton": MessageLookupByLibrary.simpleMessage(
      "Verifica",
    ),
    "passwordResetVerifyCodeHint": MessageLookupByLibrary.simpleMessage(
      "Codice OTP",
    ),
    "passwordResetVerifyDescription": MessageLookupByLibrary.simpleMessage(
      "Inserisci il codice OTP che hai ricevuto via email.",
    ),
    "passwordResetVerifyError": MessageLookupByLibrary.simpleMessage(
      "Codice non valido",
    ),
    "passwordResetVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "Verifica codice",
    ),
    "passwordSentTo": MessageLookupByLibrary.simpleMessage(
      "Password inviata a",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password troppo corta",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Le password non coincidono",
    ),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("Numero di telefono"),
    "profileCreatedFor": MessageLookupByLibrary.simpleMessage(
      "Profilo creato per",
    ),
    "qrImageError": MessageLookupByLibrary.simpleMessage(
      "Errore nella generazione dell\'immagine QR",
    ),
    "qrSentDirect": MessageLookupByLibrary.simpleMessage(
      "QR inviato con successo",
    ),
    "recordButton": MessageLookupByLibrary.simpleMessage("Registra"),
    "recoverPassword": MessageLookupByLibrary.simpleMessage(
      "Recupera password",
    ),
    "recoverPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Recupera password",
    ),
    "recoverPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Se hai dimenticato la password, puoi reimpostare l\'app. Tutti i dati locali verranno eliminati.",
    ),
    "recoverPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Recupera password",
    ),
    "requiredField": MessageLookupByLibrary.simpleMessage("Campo obbligatorio"),
    "resetAppButton": MessageLookupByLibrary.simpleMessage("Reimposta app"),
    "resetAppMessage": MessageLookupByLibrary.simpleMessage(
      "Sei sicuro di voler reimpostare WinkWink? Tutti i dati locali verranno eliminati.",
    ),
    "resetAppTitle": MessageLookupByLibrary.simpleMessage(
      "Reimposta applicazione",
    ),
    "resetButton": MessageLookupByLibrary.simpleMessage("Reimposta"),
    "sandwichAddAudio": MessageLookupByLibrary.simpleMessage("Aggiungi audio"),
    "sandwichAddCamera": MessageLookupByLibrary.simpleMessage(
      "Aggiungi foto da fotocamera",
    ),
    "sandwichAddImage": MessageLookupByLibrary.simpleMessage("Aggiungi foto"),
    "sandwichAddText": MessageLookupByLibrary.simpleMessage("Aggiungi testo"),
    "sandwichCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
    "sandwichConfirm": MessageLookupByLibrary.simpleMessage(
      "Conferma sandwich",
    ),
    "sandwichImportGallery": MessageLookupByLibrary.simpleMessage(
      "Importa dalla galleria",
    ),
    "sandwichInsertText": MessageLookupByLibrary.simpleMessage(
      "Inserisci testo",
    ),
    "sandwichItemAudio": MessageLookupByLibrary.simpleMessage("Audio"),
    "sandwichItemCamera": MessageLookupByLibrary.simpleMessage("Fotocamera"),
    "sandwichItemImage": MessageLookupByLibrary.simpleMessage("Immagine"),
    "sandwichItemText": MessageLookupByLibrary.simpleMessage("Testo"),
    "sandwichLimitExceeded": MessageLookupByLibrary.simpleMessage(
      "Hai superato la capacità massima.",
    ),
    "sandwichOk": MessageLookupByLibrary.simpleMessage("OK"),
    "sandwichProgress": m9,
    "sandwichSubtitle": MessageLookupByLibrary.simpleMessage(
      "Puoi inserire più file e riordinarli con il drag & drop",
    ),
    "sandwichTitle": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "scanFromCamera": MessageLookupByLibrary.simpleMessage(
      "Scansiona dalla fotocamera",
    ),
    "scanFromGallery": MessageLookupByLibrary.simpleMessage(
      "Scansiona dalla galleria",
    ),
    "scanQrAdded": MessageLookupByLibrary.simpleMessage("Contatto aggiunto"),
    "scanQrButton": MessageLookupByLibrary.simpleMessage("Scansiona QR"),
    "scanQrDescription": MessageLookupByLibrary.simpleMessage(
      "Scansiona il QR di un contatto",
    ),
    "scanQrInvalid": MessageLookupByLibrary.simpleMessage("QR code non valido"),
    "scanQrPlaceholderMessage": MessageLookupByLibrary.simpleMessage(
      "Inquadra un QR WinkWink",
    ),
    "scanQrPlaceholderTitle": MessageLookupByLibrary.simpleMessage(
      "Scansiona QR",
    ),
    "scanQrPresence": MessageLookupByLibrary.simpleMessage(
      "Scambio di persona",
    ),
    "scanQrPresenceSubtitle": MessageLookupByLibrary.simpleMessage(
      "Se siete vicini, scansiona il QR dell\'altro utente per aggiungerlo ai contatti.",
    ),
    "scanQrTitle": MessageLookupByLibrary.simpleMessage("Scansiona QR"),
    "scanQrUpdated": MessageLookupByLibrary.simpleMessage(
      "Contatto aggiornato",
    ),
    "searchContacts": MessageLookupByLibrary.simpleMessage("Cerca contatti..."),
    "selectContact": MessageLookupByLibrary.simpleMessage(
      "Seleziona un contatto",
    ),
    "sendButton": MessageLookupByLibrary.simpleMessage("Invia"),
    "sendDirectButton": MessageLookupByLibrary.simpleMessage(
      "Invia direttamente",
    ),
    "sendQrButton": MessageLookupByLibrary.simpleMessage("Invia QR"),
    "sendQrContactsTitle": MessageLookupByLibrary.simpleMessage(
      "Contatti WinkWink",
    ),
    "sendQrDescription": MessageLookupByLibrary.simpleMessage(
      "Condividi questo QR con i tuoi contatti",
    ),
    "sendQrNoContacts": MessageLookupByLibrary.simpleMessage(
      "Nessun contatto WinkWink trovato",
    ),
    "sendQrSentTo": MessageLookupByLibrary.simpleMessage("QR inviato a"),
    "sendQrTitle": MessageLookupByLibrary.simpleMessage("Invia QR Code"),
    "settingsReceiveComplete": MessageLookupByLibrary.simpleMessage(
      "Suono WinkWink a ricezione completata",
    ),
    "settingsReceiveCompleteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Riproduce un suono quando un file è stato ricevuto completamente",
    ),
    "settingsReceiveOnlyWifi": MessageLookupByLibrary.simpleMessage(
      "Ricevi file solo tramite WiFi",
    ),
    "settingsReceiveOnlyWifiSubtitle": MessageLookupByLibrary.simpleMessage(
      "Evita l\'uso dei dati mobili durante la ricezione",
    ),
    "settingsSendComplete": MessageLookupByLibrary.simpleMessage(
      "Suono WinkWink a invio completato",
    ),
    "settingsSendCompleteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Riproduce un suono quando un file è stato inviato completamente",
    ),
    "settingsSendOnlyWifi": MessageLookupByLibrary.simpleMessage(
      "Invia file solo tramite WiFi",
    ),
    "settingsSendOnlyWifiSubtitle": MessageLookupByLibrary.simpleMessage(
      "Evita l\'uso dei dati mobili durante l\'invio",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "settingsWingSound": MessageLookupByLibrary.simpleMessage(
      "Suono Wing per i nuovi messaggi",
    ),
    "settingsWingSoundSubtitle": MessageLookupByLibrary.simpleMessage(
      "Riproduce un suono quando arriva un nuovo messaggio",
    ),
    "shareQrMessage": MessageLookupByLibrary.simpleMessage(
      "Per scambiare file segreti, usa WinkWink.\nIl mio QR sicuro è in Documenti.\nCiao!",
    ),
    "shareQrSubject": MessageLookupByLibrary.simpleMessage("Contatto WinkWink"),
    "startupLoading": MessageLookupByLibrary.simpleMessage(
      "Caricamento di WinkWink...",
    ),
    "stopButton": MessageLookupByLibrary.simpleMessage("Stop"),
    "textSecretSubtitle": MessageLookupByLibrary.simpleMessage(
      "Scrivi o incolla il testo segreto",
    ),
    "textSecretTitle": MessageLookupByLibrary.simpleMessage("Nascondi testo"),
    "videoTooLarge": MessageLookupByLibrary.simpleMessage(
      "Il video supera i 100MB. Scegline uno più piccolo.",
    ),
    "videoWWAddAudio": MessageLookupByLibrary.simpleMessage("Audio"),
    "videoWWAddCamera": MessageLookupByLibrary.simpleMessage("Fotocamera"),
    "videoWWAddImage": MessageLookupByLibrary.simpleMessage("Immagine"),
    "videoWWAddText": MessageLookupByLibrary.simpleMessage("Testo"),
    "videoWWAddVideo": MessageLookupByLibrary.simpleMessage("Video invisibile"),
    "videoWWDurationMessage": MessageLookupByLibrary.simpleMessage(
      "Il video deve durare almeno 30 secondi e al massimo 40 secondi.",
    ),
    "videoWWDurationTitle": MessageLookupByLibrary.simpleMessage(
      "Durata video",
    ),
    "videoWWErrorNoRecipients": MessageLookupByLibrary.simpleMessage(
      "Seleziona almeno un destinatario",
    ),
    "videoWWErrorNoSecret": MessageLookupByLibrary.simpleMessage(
      "Seleziona cosa vuoi nascondere",
    ),
    "videoWWErrorNoVideo": MessageLookupByLibrary.simpleMessage(
      "Seleziona prima il video visibile",
    ),
    "videoWWPickFromGallery": MessageLookupByLibrary.simpleMessage(
      "Apri galleria",
    ),
    "videoWWRecord": MessageLookupByLibrary.simpleMessage("Registra video"),
    "videoWWSandwichAddVideo": MessageLookupByLibrary.simpleMessage(
      "Aggiungi video",
    ),
    "videoWWSandwichConfirm": MessageLookupByLibrary.simpleMessage(
      "Conferma contenuto invisibile",
    ),
    "videoWWSandwichExceeded": MessageLookupByLibrary.simpleMessage(
      "Hai superato la capacità massima",
    ),
    "videoWWSandwichSpace": m10,
    "videoWWSandwichTitle": MessageLookupByLibrary.simpleMessage(
      "Contenuto invisibile",
    ),
    "videoWWSandwichWhatToHide": MessageLookupByLibrary.simpleMessage(
      "Cosa vuoi nascondere?",
    ),
    "videoWWSecretReady": MessageLookupByLibrary.simpleMessage(
      "Contenuto invisibile pronto!",
    ),
    "videoWWSecretSelected": MessageLookupByLibrary.simpleMessage(
      "Segreto selezionato",
    ),
    "videoWWSelectedVideo": MessageLookupByLibrary.simpleMessage(
      "Video selezionato",
    ),
    "videoWWSpaceRemaining": MessageLookupByLibrary.simpleMessage(
      "Spazio rimanente",
    ),
    "videoWWSpaceUsed": MessageLookupByLibrary.simpleMessage(
      "Spazio utilizzato",
    ),
    "videoWWTextCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
    "videoWWTextConfirm": MessageLookupByLibrary.simpleMessage("OK"),
    "videoWWTextInsert": MessageLookupByLibrary.simpleMessage(
      "Inserisci testo",
    ),
    "videoWWTitle": MessageLookupByLibrary.simpleMessage("Video WinkWink"),
    "videoWWVisibleVideo": MessageLookupByLibrary.simpleMessage(
      "Video visibile",
    ),
    "visible_image_button": MessageLookupByLibrary.simpleMessage(
      "Immagine invisibile",
    ),
    "winkGalleryDeleteConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Questa azione non può essere annullata.",
    ),
    "winkGalleryDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Eliminare questo QR?",
    ),
    "winkGalleryDeleted": MessageLookupByLibrary.simpleMessage(
      "Il QR è stato eliminato",
    ),
    "winkGalleryEmpty": MessageLookupByLibrary.simpleMessage(
      "La tua WinkGallery è vuota",
    ),
    "winkGalleryFullWarning": MessageLookupByLibrary.simpleMessage(
      "La tua WinkGallery ha superato 1 GB. Aprila per rimuovere i file indesiderati.",
    ),
    "winkGalleryTitle": MessageLookupByLibrary.simpleMessage("WinkGallery"),
    "winkGalleryUpdated": MessageLookupByLibrary.simpleMessage(
      "Contatto aggiornato con successo",
    ),
    "winkwinkSubtitle": MessageLookupByLibrary.simpleMessage(
      "Custode di segreti",
    ),
    "wrongPassword": MessageLookupByLibrary.simpleMessage("Password errata"),
  };
}
