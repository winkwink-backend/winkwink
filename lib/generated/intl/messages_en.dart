// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(id) => "User ${id}";

  static String m1(name) => "Chat with ${name}";

  static String m2(id) => "User ${id}";

  static String m3(mb) =>
      "The visible image would require over ${mb}MB to contain the content.";

  static String m4(type, size) => "File: ${type} • ${size} bytes";

  static String m5(name) => "${name} accepted the invite";

  static String m6(name) => "${name} wants to exchange files with you.";

  static String m7(name) => "Invite from ${name}";

  static String m8(id) => "Message from user ${id}";

  static String m9(current, max) => "${current} MB / ${max} MB";

  static String m10(used, max) => "${used} MB / ${max} MB";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessButton": MessageLookupByLibrary.simpleMessage("Access"),
    "appTitle": MessageLookupByLibrary.simpleMessage("WinkWink"),
    "audioSecretSubtitle": MessageLookupByLibrary.simpleMessage(
      "Record a voice message to hide",
    ),
    "audioSecretTitle": MessageLookupByLibrary.simpleMessage(
      "Record secret audio",
    ),
    "backButton": MessageLookupByLibrary.simpleMessage("Back"),
    "cameraSecretSubtitle": MessageLookupByLibrary.simpleMessage(
      "Use the camera to capture a secret content",
    ),
    "cameraSecretTitle": MessageLookupByLibrary.simpleMessage(
      "Take secret photo",
    ),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
    "changeColor": MessageLookupByLibrary.simpleMessage("Change color"),
    "changeSecret": MessageLookupByLibrary.simpleMessage(
      "Do you want to change the secret?",
    ),
    "chatListEmpty": MessageLookupByLibrary.simpleMessage("No conversations"),
    "chatListFileReceived": MessageLookupByLibrary.simpleMessage(
      "📥 File received",
    ),
    "chatListFileSent": MessageLookupByLibrary.simpleMessage("📤 File sent"),
    "chatListTitle": MessageLookupByLibrary.simpleMessage("Chat"),
    "chatListUser": m0,
    "chatPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Write a message...",
    ),
    "chatWith": m1,
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "contactAddedMessage": MessageLookupByLibrary.simpleMessage(
      "has been added to your WinkWink contacts",
    ),
    "contactAddedTitle": MessageLookupByLibrary.simpleMessage("Contact added"),
    "contactDeleted": MessageLookupByLibrary.simpleMessage("Contact deleted"),
    "contactDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "The contact has been removed and you will no longer be able to send or receive files from this person.",
    ),
    "contactInviteSent": MessageLookupByLibrary.simpleMessage("Invite sent"),
    "contactUser": m2,
    "contactsButton": MessageLookupByLibrary.simpleMessage("Contacts"),
    "contactsTitle": MessageLookupByLibrary.simpleMessage("Contacts"),
    "decryptButton": MessageLookupByLibrary.simpleMessage("Decrypt Now"),
    "decryptButtonHome": MessageLookupByLibrary.simpleMessage("Decrypt"),
    "decryptDescription": MessageLookupByLibrary.simpleMessage(
      "Extract a hidden file",
    ),
    "decryptError": MessageLookupByLibrary.simpleMessage("Decryption Error"),
    "decryptMissingImage": MessageLookupByLibrary.simpleMessage(
      "Select an image to decrypt",
    ),
    "decryptPickImage": MessageLookupByLibrary.simpleMessage(
      "Choose encrypted image",
    ),
    "decryptReady": MessageLookupByLibrary.simpleMessage("File Decrypted"),
    "decryptReadyMessage": MessageLookupByLibrary.simpleMessage(
      "The hidden file has been successfully extracted",
    ),
    "decryptResult": MessageLookupByLibrary.simpleMessage("Decrypted result"),
    "decryptSuccess": MessageLookupByLibrary.simpleMessage(
      "Decryption completed",
    ),
    "decryptSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "The file has been successfully decrypted",
    ),
    "decryptTitle": MessageLookupByLibrary.simpleMessage("Decrypt File"),
    "decrypting": MessageLookupByLibrary.simpleMessage("Decrypting..."),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteButton": MessageLookupByLibrary.simpleMessage("Delete"),
    "emailAssociated": MessageLookupByLibrary.simpleMessage("Associated email"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email Address"),
    "encryptAndSend": MessageLookupByLibrary.simpleMessage("Encrypt and send"),
    "encryptButton": MessageLookupByLibrary.simpleMessage("Encrypt Now"),
    "encryptButtonHome": MessageLookupByLibrary.simpleMessage("Encrypt"),
    "encryptContactsButton": MessageLookupByLibrary.simpleMessage("Contacts"),
    "encryptDescription": MessageLookupByLibrary.simpleMessage(
      "Hide a file inside an image",
    ),
    "encryptError": MessageLookupByLibrary.simpleMessage("Encryption Error"),
    "encryptErrorGeneric": MessageLookupByLibrary.simpleMessage("Error"),
    "encryptErrorNoECC": MessageLookupByLibrary.simpleMessage(
      "ECC keys not found",
    ),
    "encryptErrorNoRecipients": MessageLookupByLibrary.simpleMessage(
      "No valid recipients",
    ),
    "encryptErrorUnsupported": MessageLookupByLibrary.simpleMessage(
      "Unsupported content type",
    ),
    "encryptHideAudio": MessageLookupByLibrary.simpleMessage("Hide audio"),
    "encryptHideCamera": MessageLookupByLibrary.simpleMessage("Camera"),
    "encryptHideImage": MessageLookupByLibrary.simpleMessage("Hide image"),
    "encryptHideSandwich": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "encryptHideText": MessageLookupByLibrary.simpleMessage("Hide text"),
    "encryptImageTooLarge": m3,
    "encryptMissingSelection": MessageLookupByLibrary.simpleMessage(
      "Select a file to encrypt",
    ),
    "encryptNoContactsAvailable": MessageLookupByLibrary.simpleMessage(
      "No contacts available",
    ),
    "encryptPickVisibleImage": MessageLookupByLibrary.simpleMessage("Image"),
    "encryptPreparing": MessageLookupByLibrary.simpleMessage("Preparing…"),
    "encryptPreviewCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "encryptPreviewCapacity": MessageLookupByLibrary.simpleMessage(
      "Image capacity",
    ),
    "encryptPreviewPayloadSize": MessageLookupByLibrary.simpleMessage(
      "Content size",
    ),
    "encryptPreviewProceed": MessageLookupByLibrary.simpleMessage("Proceed"),
    "encryptPreviewRecipients": MessageLookupByLibrary.simpleMessage(
      "Recipients",
    ),
    "encryptPreviewSecret": MessageLookupByLibrary.simpleMessage(
      "Hidden content",
    ),
    "encryptPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Encryption summary",
    ),
    "encryptPreviewVisibleImage": MessageLookupByLibrary.simpleMessage(
      "Visible image",
    ),
    "encryptProgressComputingKeys": MessageLookupByLibrary.simpleMessage(
      "Computing keys…",
    ),
    "encryptProgressEmbedding": MessageLookupByLibrary.simpleMessage(
      "Embedding content…",
    ),
    "encryptProgressEncrypting": MessageLookupByLibrary.simpleMessage(
      "Encrypting…",
    ),
    "encryptProgressPreparingImage": MessageLookupByLibrary.simpleMessage(
      "Preparing image…",
    ),
    "encryptReady": MessageLookupByLibrary.simpleMessage("File Ready"),
    "encryptReadyMessage": MessageLookupByLibrary.simpleMessage(
      "Your file has been successfully encrypted",
    ),
    "encryptSecretReady": MessageLookupByLibrary.simpleMessage(
      "Hidden content ready ✔",
    ),
    "encryptSelectRecipients": MessageLookupByLibrary.simpleMessage("contacts"),
    "encryptSelectRecipientsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Choose who you want to share your secret files with",
    ),
    "encryptSelectRecipientsTitle": MessageLookupByLibrary.simpleMessage(
      "Select the contacts you want to send a secret file to",
    ),
    "encryptSelectSecret": MessageLookupByLibrary.simpleMessage(
      "Select the secret to encrypt",
    ),
    "encryptSelectedContent": MessageLookupByLibrary.simpleMessage(
      "Selected content",
    ),
    "encryptTakePhoto": MessageLookupByLibrary.simpleMessage("Take photo"),
    "encryptTitle": MessageLookupByLibrary.simpleMessage("Encrypt File"),
    "encryptVisibleImageTitle": MessageLookupByLibrary.simpleMessage(
      "Choose image visible to everyone",
    ),
    "encryptWhatToHide": MessageLookupByLibrary.simpleMessage(
      "What do you want to hide?",
    ),
    "encrypting": MessageLookupByLibrary.simpleMessage("Encrypting..."),
    "errorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "faqButton": MessageLookupByLibrary.simpleMessage("FAQ"),
    "faqContent": MessageLookupByLibrary.simpleMessage(
      "WinkWink uses steganography to hide your files...",
    ),
    "faqNoResults": MessageLookupByLibrary.simpleMessage("No answers found."),
    "faqSearchHint": MessageLookupByLibrary.simpleMessage("Ask a question..."),
    "faqTitle": MessageLookupByLibrary.simpleMessage("FAQ & Help"),
    "fileLabel": MessageLookupByLibrary.simpleMessage("File"),
    "fileTypeLabel": MessageLookupByLibrary.simpleMessage("Type"),
    "firstNameLabel": MessageLookupByLibrary.simpleMessage("First Name"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "forwardButton": MessageLookupByLibrary.simpleMessage("Forward"),
    "galleryButton": MessageLookupByLibrary.simpleMessage("Gallery"),
    "galleryEmptyPlaceholder": MessageLookupByLibrary.simpleMessage(
      "No files found",
    ),
    "galleryTitle": MessageLookupByLibrary.simpleMessage("Secure Gallery"),
    "generateIdButton": MessageLookupByLibrary.simpleMessage("Generate ID"),
    "giveQr": MessageLookupByLibrary.simpleMessage("Send QR to"),
    "goToContacts": MessageLookupByLibrary.simpleMessage("Open Contacts"),
    "goToEncrypt": MessageLookupByLibrary.simpleMessage("Open Encrypt"),
    "goToPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Password Recovery",
    ),
    "goToScanQr": MessageLookupByLibrary.simpleMessage("Open Scan QR"),
    "goToSendQr": MessageLookupByLibrary.simpleMessage("Open Send QR"),
    "goToVideoWW": MessageLookupByLibrary.simpleMessage("Open VideoWW"),
    "hideImageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Select the secret image to hide",
    ),
    "hideImageTitle": MessageLookupByLibrary.simpleMessage("Hide image"),
    "homeGalleryTooltip": MessageLookupByLibrary.simpleMessage("WinkGallery"),
    "homeSettingsTooltip": MessageLookupByLibrary.simpleMessage("Settings"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage("Secrets"),
    "inboxAccept": MessageLookupByLibrary.simpleMessage("Accept"),
    "inboxContactAdded": MessageLookupByLibrary.simpleMessage("Contact added"),
    "inboxErrorNoKey": MessageLookupByLibrary.simpleMessage(
      "Error: public key not found",
    ),
    "inboxFileRequestSubtitle": m4,
    "inboxFileRequestTitle": MessageLookupByLibrary.simpleMessage(
      "File request",
    ),
    "inboxInviteAcceptSubtitle": MessageLookupByLibrary.simpleMessage(
      "You can now exchange files securely",
    ),
    "inboxInviteAcceptTitle": m5,
    "inboxInviteDialogMessage": m6,
    "inboxInviteDialogTitle": MessageLookupByLibrary.simpleMessage("Invite"),
    "inboxInviteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Wants to exchange files with you",
    ),
    "inboxInviteTitle": m7,
    "inboxMessageSubtitle": MessageLookupByLibrary.simpleMessage("New message"),
    "inboxMessageTitle": m8,
    "inboxReject": MessageLookupByLibrary.simpleMessage("Reject"),
    "inboxTitle": MessageLookupByLibrary.simpleMessage("Notifications"),
    "internalQrData": MessageLookupByLibrary.simpleMessage("Internal Data"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Enter a valid email"),
    "invalidQr": MessageLookupByLibrary.simpleMessage("Invalid QR code"),
    "lastNameLabel": MessageLookupByLibrary.simpleMessage("Last Name"),
    "legalAcceptButton": MessageLookupByLibrary.simpleMessage(
      "Accept legal terms",
    ),
    "legalMustAccept": MessageLookupByLibrary.simpleMessage(
      "You must accept the legal terms before continuing",
    ),
    "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
    "loginDescription": MessageLookupByLibrary.simpleMessage(
      "Enter your details to begin.",
    ),
    "loginDescriptionShort": MessageLookupByLibrary.simpleMessage(
      "Let\'s create your ID",
    ),
    "loginIdGeneratedMessage": MessageLookupByLibrary.simpleMessage(
      "Your unique ID has been securely created.",
    ),
    "loginIdGeneratedTitle": MessageLookupByLibrary.simpleMessage(
      "ID Generated",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Welcome to WinkWink"),
    "noContactsMessage": MessageLookupByLibrary.simpleMessage(
      "No contacts available",
    ),
    "noKeysWarning": MessageLookupByLibrary.simpleMessage(
      "This contact does not have a public key yet",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "No notifications available",
    ),
    "noPasswordSaved": MessageLookupByLibrary.simpleMessage(
      "No password saved",
    ),
    "notificationGalleryFullMessage": MessageLookupByLibrary.simpleMessage(
      "Your WinkGallery has exceeded 1 GB. Open it to remove unwanted files.",
    ),
    "notificationGalleryFullTitle": MessageLookupByLibrary.simpleMessage(
      "WinkGallery full",
    ),
    "notificationGeneric": MessageLookupByLibrary.simpleMessage(
      "New notification",
    ),
    "notificationNewMessage": MessageLookupByLibrary.simpleMessage(
      "New message received",
    ),
    "notificationQrReceived": MessageLookupByLibrary.simpleMessage(
      "You received a QR",
    ),
    "notificationReceiveComplete": MessageLookupByLibrary.simpleMessage(
      "File received",
    ),
    "notificationSendComplete": MessageLookupByLibrary.simpleMessage(
      "Sending completed",
    ),
    "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
      "No notifications",
    ),
    "notificationsTitle": MessageLookupByLibrary.simpleMessage("Notifications"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "okButton": MessageLookupByLibrary.simpleMessage("OK"),
    "optionalPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "You can set a password for extra security",
    ),
    "optionalPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Optional Password",
    ),
    "p2pConnectionEstablished": MessageLookupByLibrary.simpleMessage(
      "Connection established",
    ),
    "p2pReceiving": MessageLookupByLibrary.simpleMessage("Receiving file…"),
    "p2pReceivingCompleted": MessageLookupByLibrary.simpleMessage(
      "File received successfully",
    ),
    "p2pReceivingError": MessageLookupByLibrary.simpleMessage(
      "Error receiving file",
    ),
    "p2pReceivingEstablished": MessageLookupByLibrary.simpleMessage(
      "Connection established",
    ),
    "p2pReceivingWaiting": MessageLookupByLibrary.simpleMessage(
      "Waiting for sender…",
    ),
    "p2pSavingFile": MessageLookupByLibrary.simpleMessage("Saving file…"),
    "p2pSending": MessageLookupByLibrary.simpleMessage("Sending file…"),
    "p2pSendingCompleted": MessageLookupByLibrary.simpleMessage(
      "File sent successfully",
    ),
    "p2pSendingError": MessageLookupByLibrary.simpleMessage(
      "Error sending file",
    ),
    "p2pSendingInProgress": MessageLookupByLibrary.simpleMessage("Sending…"),
    "p2pWaitingAnswer": MessageLookupByLibrary.simpleMessage(
      "Waiting for recipient…",
    ),
    "passepartoutButton": MessageLookupByLibrary.simpleMessage("Master Key"),
    "passepartoutPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Your master keys will appear here",
    ),
    "passepartoutTitle": MessageLookupByLibrary.simpleMessage("Master Key"),
    "passwordGateDescription": MessageLookupByLibrary.simpleMessage(
      "Enter the password to proceed",
    ),
    "passwordGateTitle": MessageLookupByLibrary.simpleMessage("Security Check"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLabelShort": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMustContain": MessageLookupByLibrary.simpleMessage(
      "The password must contain at least 8 characters",
    ),
    "passwordResetNewPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Save",
    ),
    "passwordResetNewPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Set a new password for your account.",
    ),
    "passwordResetNewPasswordError": MessageLookupByLibrary.simpleMessage(
      "Error saving password",
    ),
    "passwordResetNewPasswordHint": MessageLookupByLibrary.simpleMessage(
      "New password",
    ),
    "passwordResetNewPasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordResetNewPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "New password",
    ),
    "passwordResetRepeatPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Repeat password",
    ),
    "passwordResetRequestConnectionError": MessageLookupByLibrary.simpleMessage(
      "Connection error",
    ),
    "passwordResetRequestDescription": MessageLookupByLibrary.simpleMessage(
      "Enter your email to receive a verification code.",
    ),
    "passwordResetRequestEmailHint": MessageLookupByLibrary.simpleMessage(
      "Email",
    ),
    "passwordResetRequestError": MessageLookupByLibrary.simpleMessage(
      "Error sending the code",
    ),
    "passwordResetRequestSendButton": MessageLookupByLibrary.simpleMessage(
      "Send code",
    ),
    "passwordResetRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Password recovery",
    ),
    "passwordResetVerifyButton": MessageLookupByLibrary.simpleMessage("Verify"),
    "passwordResetVerifyCodeHint": MessageLookupByLibrary.simpleMessage(
      "OTP code",
    ),
    "passwordResetVerifyDescription": MessageLookupByLibrary.simpleMessage(
      "Enter the OTP code you received via email.",
    ),
    "passwordResetVerifyError": MessageLookupByLibrary.simpleMessage(
      "Invalid code",
    ),
    "passwordResetVerifyTitle": MessageLookupByLibrary.simpleMessage(
      "Verify code",
    ),
    "passwordSentTo": MessageLookupByLibrary.simpleMessage("Password sent to"),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password too short",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "profileCreatedFor": MessageLookupByLibrary.simpleMessage(
      "Profile created for",
    ),
    "qrImageError": MessageLookupByLibrary.simpleMessage(
      "Error generating QR image",
    ),
    "qrSentDirect": MessageLookupByLibrary.simpleMessage(
      "QR sent successfully",
    ),
    "recordButton": MessageLookupByLibrary.simpleMessage("Record"),
    "recoverPassword": MessageLookupByLibrary.simpleMessage("Recover password"),
    "recoverPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Recover password",
    ),
    "recoverPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "If you forgot your password, you can reset the app. All local data will be deleted.",
    ),
    "recoverPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Recover password",
    ),
    "requiredField": MessageLookupByLibrary.simpleMessage("Required field"),
    "resetAppButton": MessageLookupByLibrary.simpleMessage("Reset app"),
    "resetAppMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to reset WinkWink? All local data will be deleted.",
    ),
    "resetAppTitle": MessageLookupByLibrary.simpleMessage("Reset application"),
    "resetButton": MessageLookupByLibrary.simpleMessage("Reset"),
    "sandwichAddAudio": MessageLookupByLibrary.simpleMessage("Add Audio"),
    "sandwichAddCamera": MessageLookupByLibrary.simpleMessage(
      "Add Camera Photo",
    ),
    "sandwichAddImage": MessageLookupByLibrary.simpleMessage("Add Photo"),
    "sandwichAddText": MessageLookupByLibrary.simpleMessage("Add Text"),
    "sandwichCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "sandwichConfirm": MessageLookupByLibrary.simpleMessage("Confirm Sandwich"),
    "sandwichImportGallery": MessageLookupByLibrary.simpleMessage(
      "Import from gallery",
    ),
    "sandwichInsertText": MessageLookupByLibrary.simpleMessage("Insert text"),
    "sandwichItemAudio": MessageLookupByLibrary.simpleMessage("Audio"),
    "sandwichItemCamera": MessageLookupByLibrary.simpleMessage("Camera"),
    "sandwichItemImage": MessageLookupByLibrary.simpleMessage("Image"),
    "sandwichItemText": MessageLookupByLibrary.simpleMessage("Text"),
    "sandwichLimitExceeded": MessageLookupByLibrary.simpleMessage(
      "You exceeded the maximum capacity.",
    ),
    "sandwichOk": MessageLookupByLibrary.simpleMessage("OK"),
    "sandwichProgress": m9,
    "sandwichSubtitle": MessageLookupByLibrary.simpleMessage(
      "You can insert multiple files and reorder with drag & drop",
    ),
    "sandwichTitle": MessageLookupByLibrary.simpleMessage("Sandwich"),
    "scanFromCamera": MessageLookupByLibrary.simpleMessage("Scan from camera"),
    "scanFromGallery": MessageLookupByLibrary.simpleMessage(
      "Scan from gallery",
    ),
    "scanQrAdded": MessageLookupByLibrary.simpleMessage("Contact added"),
    "scanQrButton": MessageLookupByLibrary.simpleMessage("Scan QR"),
    "scanQrDescription": MessageLookupByLibrary.simpleMessage(
      "Scan a contact\'s QR",
    ),
    "scanQrInvalid": MessageLookupByLibrary.simpleMessage("Invalid QR code"),
    "scanQrPlaceholderMessage": MessageLookupByLibrary.simpleMessage(
      "Frame a WinkWink QR code",
    ),
    "scanQrPlaceholderTitle": MessageLookupByLibrary.simpleMessage("Scan QR"),
    "scanQrPresence": MessageLookupByLibrary.simpleMessage(
      "In‑person exchange",
    ),
    "scanQrPresenceSubtitle": MessageLookupByLibrary.simpleMessage(
      "If you are close to each other, scan the other user\'s QR to add them to your contacts.",
    ),
    "scanQrTitle": MessageLookupByLibrary.simpleMessage("Scan QR"),
    "scanQrUpdated": MessageLookupByLibrary.simpleMessage("Contact updated"),
    "searchContacts": MessageLookupByLibrary.simpleMessage(
      "Search contacts...",
    ),
    "selectContact": MessageLookupByLibrary.simpleMessage("Select a contact"),
    "sendButton": MessageLookupByLibrary.simpleMessage("Send"),
    "sendDirectButton": MessageLookupByLibrary.simpleMessage("Send directly"),
    "sendQrButton": MessageLookupByLibrary.simpleMessage("Send QR"),
    "sendQrContactsTitle": MessageLookupByLibrary.simpleMessage(
      "WinkWink Contacts",
    ),
    "sendQrDescription": MessageLookupByLibrary.simpleMessage(
      "Share this QR with your contacts",
    ),
    "sendQrNoContacts": MessageLookupByLibrary.simpleMessage(
      "No WinkWink contacts found",
    ),
    "sendQrSentTo": MessageLookupByLibrary.simpleMessage("QR sent to"),
    "sendQrTitle": MessageLookupByLibrary.simpleMessage("Send QR Code"),
    "settingsReceiveComplete": MessageLookupByLibrary.simpleMessage(
      "WinkWink sound when receiving is complete",
    ),
    "settingsReceiveCompleteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Plays a sound when a file has been fully received",
    ),
    "settingsReceiveOnlyWifi": MessageLookupByLibrary.simpleMessage(
      "Receive files only via Wi‑Fi",
    ),
    "settingsReceiveOnlyWifiSubtitle": MessageLookupByLibrary.simpleMessage(
      "Avoid using mobile data when receiving files",
    ),
    "settingsSendComplete": MessageLookupByLibrary.simpleMessage(
      "WinkWink sound when sending is complete",
    ),
    "settingsSendCompleteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Plays a sound when a file has been fully sent",
    ),
    "settingsSendOnlyWifi": MessageLookupByLibrary.simpleMessage(
      "Send files only via Wi‑Fi",
    ),
    "settingsSendOnlyWifiSubtitle": MessageLookupByLibrary.simpleMessage(
      "Avoid using mobile data when sending files",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsWingSound": MessageLookupByLibrary.simpleMessage(
      "Wing sound for new messages",
    ),
    "settingsWingSoundSubtitle": MessageLookupByLibrary.simpleMessage(
      "Plays a sound when a new message arrives",
    ),
    "shareQrMessage": MessageLookupByLibrary.simpleMessage(
      "To exchange secret files, use WinkWink.\nMy secure QR is in Documents.\nBye!",
    ),
    "shareQrSubject": MessageLookupByLibrary.simpleMessage("WinkWink Contact"),
    "startupLoading": MessageLookupByLibrary.simpleMessage(
      "Loading WinkWink...",
    ),
    "stopButton": MessageLookupByLibrary.simpleMessage("Stop"),
    "textSecretSubtitle": MessageLookupByLibrary.simpleMessage(
      "Write or paste the secret text",
    ),
    "textSecretTitle": MessageLookupByLibrary.simpleMessage("Hide text"),
    "videoTooLarge": MessageLookupByLibrary.simpleMessage(
      "The video exceeds 100MB. Choose a smaller one.",
    ),
    "videoWWAddAudio": MessageLookupByLibrary.simpleMessage("Audio"),
    "videoWWAddCamera": MessageLookupByLibrary.simpleMessage("Camera"),
    "videoWWAddImage": MessageLookupByLibrary.simpleMessage("Image"),
    "videoWWAddText": MessageLookupByLibrary.simpleMessage("Text"),
    "videoWWAddVideo": MessageLookupByLibrary.simpleMessage("Invisible video"),
    "videoWWDurationMessage": MessageLookupByLibrary.simpleMessage(
      "The video must be at least 30 seconds and at most 40 seconds.",
    ),
    "videoWWDurationTitle": MessageLookupByLibrary.simpleMessage(
      "Video duration",
    ),
    "videoWWErrorNoRecipients": MessageLookupByLibrary.simpleMessage(
      "Select at least one recipient",
    ),
    "videoWWErrorNoSecret": MessageLookupByLibrary.simpleMessage(
      "Select what you want to hide",
    ),
    "videoWWErrorNoVideo": MessageLookupByLibrary.simpleMessage(
      "Select the visible video first",
    ),
    "videoWWPickFromGallery": MessageLookupByLibrary.simpleMessage(
      "Open gallery",
    ),
    "videoWWRecord": MessageLookupByLibrary.simpleMessage("Record video"),
    "videoWWSandwichAddVideo": MessageLookupByLibrary.simpleMessage(
      "Add Video",
    ),
    "videoWWSandwichConfirm": MessageLookupByLibrary.simpleMessage(
      "Confirm invisible content",
    ),
    "videoWWSandwichExceeded": MessageLookupByLibrary.simpleMessage(
      "You exceeded the maximum capacity",
    ),
    "videoWWSandwichSpace": m10,
    "videoWWSandwichTitle": MessageLookupByLibrary.simpleMessage(
      "Invisible content",
    ),
    "videoWWSandwichWhatToHide": MessageLookupByLibrary.simpleMessage(
      "What do you want to hide?",
    ),
    "videoWWSecretReady": MessageLookupByLibrary.simpleMessage(
      "Invisible content ready!",
    ),
    "videoWWSecretSelected": MessageLookupByLibrary.simpleMessage(
      "Secret selected",
    ),
    "videoWWSelectedVideo": MessageLookupByLibrary.simpleMessage(
      "Selected video",
    ),
    "videoWWSpaceRemaining": MessageLookupByLibrary.simpleMessage(
      "Remaining space",
    ),
    "videoWWSpaceUsed": MessageLookupByLibrary.simpleMessage("Used space"),
    "videoWWTextCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "videoWWTextConfirm": MessageLookupByLibrary.simpleMessage("OK"),
    "videoWWTextInsert": MessageLookupByLibrary.simpleMessage("Insert text"),
    "videoWWTitle": MessageLookupByLibrary.simpleMessage("WinkWink Video"),
    "videoWWVisibleVideo": MessageLookupByLibrary.simpleMessage(
      "Visible video",
    ),
    "visible_image_button": MessageLookupByLibrary.simpleMessage(
      "Invisible image",
    ),
    "winkGalleryDeleteConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "This action cannot be undone.",
    ),
    "winkGalleryDeleteConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Delete this QR?",
    ),
    "winkGalleryDeleted": MessageLookupByLibrary.simpleMessage(
      "The QR has been deleted",
    ),
    "winkGalleryEmpty": MessageLookupByLibrary.simpleMessage(
      "Your WinkGallery is empty",
    ),
    "winkGalleryFullWarning": MessageLookupByLibrary.simpleMessage(
      "Your WinkGallery has exceeded 1 GB. Open it to remove unwanted files.",
    ),
    "winkGalleryTitle": MessageLookupByLibrary.simpleMessage("WinkGallery"),
    "winkGalleryUpdated": MessageLookupByLibrary.simpleMessage(
      "Contact updated successfully",
    ),
    "winkwinkSubtitle": MessageLookupByLibrary.simpleMessage(
      "Keeper of secrets",
    ),
    "wrongPassword": MessageLookupByLibrary.simpleMessage("Wrong password"),
  };
}
