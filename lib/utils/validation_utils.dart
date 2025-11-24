// import 'package:easy_localization/easy_localization.dart';
// import 'package:fast_contacts/fast_contacts.dart';
// import 'package:bracepl/constants/app_constants.dart';
// import 'package:bracepl/core/flavor/flavors.dart';

// class ValidationUtils {
//   static bool isPhoneNoValid(String? phoneNo) {
//     if (phoneNo == null || phoneNo.isEmpty) return false;
//     final regExp = F.dummyNumberEnabled
//         ? RegExp("(?:\\+88|88)?(01[2-9]\\d{8})")
//         : RegExp("(?:\\+88|88)?(01[3-9]\\d{8})");
//     return regExp.hasMatch(phoneNo);
//   }

//   static String? validateMobile(String? typedNumber) {
//     if (typedNumber == null || typedNumber.isEmpty) {
//       return 'mobile_no_req'.tr();
//     }
//     String pattern = F.dummyNumberEnabled
//         ? "(?:\\+88|88)?(01[2-9]\\d{8})"
//         : "(?:\\+88|88)?(01[3-9]\\d{8})";
//     RegExp regExp = RegExp(pattern);
//     if (!regExp.hasMatch(typedNumber)) {
//       return 'invalid_mobile_no'.tr();
//     }
//     return null;
//   }

//   static bool checkMobile(String? typedNumber) {
//     if (typedNumber == null || typedNumber.isEmpty) {
//       return false;
//     }
//     String pattern = F.dummyNumberEnabled
//         ? "(?:\\+88|88)?(01[2-9]\\d{8})"
//         : "(?:\\+88|88)?(01[3-9]\\d{8})";
//     RegExp regExp = RegExp(pattern);
//     if (!regExp.hasMatch(typedNumber)) {
//       return true;
//     }
//     return false;
//   }

//   static List<Contact> getValidContacts(List<Contact> contacts) {
//     List<Contact> validContacts = [];
//     for (var element in contacts) {
//       validContacts.add(element);
//     }
//     return validContacts;
//   }

//   static String? commonTextValidation(value) {
//     if (value == null) {
//       return "input_field_is_empty".tr();
//     }
//     return null;
//   }

//   static String? commonPinValidator(pin) {
//     if (pin == null || pin.isEmpty) {
//       return 'pin_req'.tr();
//     }

//     final pinRegExp = RegExp(
//       r'^\d{' + AppConstants.pinLength.toString() + r'}$',
//     );
//     if (!pinRegExp.hasMatch(pin)) {
//       return 'request_valid_pin'.tr();
//     }
//     return null;
//   }

//   static bool isPinPartOfPhone(String? phoneNumber, String? pin) {
//     return phoneNumber?.contains(pin ?? '') ?? false;
//   }

//   static bool isSequenceNumber(String pin) {
//     if (pin.length != AppConstants.pinLength) return false;

//     // Check for ascending sequences
//     for (int i = 0; i <= 10 - AppConstants.pinLength; i++) {
//       String sequence = '';
//       for (int j = 0; j < AppConstants.pinLength; j++) {
//         sequence += (i + j).toString();
//       }
//       if (pin == sequence) return true;
//     }

//     // Check for descending sequences
//     for (int i = 9; i >= AppConstants.pinLength - 1; i--) {
//       String sequence = '';
//       for (int j = 0; j < AppConstants.pinLength; j++) {
//         sequence += (i - j).toString();
//       }
//       if (pin == sequence) return true;
//     }

//     return false;
//   }

//   static bool isConsecutive(String pin) {
//     final consecutiveRegex = RegExp(
//       r'(\d)\1{' + (AppConstants.pinLength - 1).toString() + r',}',
//     );
//     return consecutiveRegex.hasMatch(pin);
//   }

//   static String? commonPinNewValidator({String? phoneNo, String? pin}) {
//     if (pin == null || pin.isEmpty) {
//       return 'pin_req'.tr();
//     }

//     final pinRegExp = RegExp(
//       r'^\d{' + AppConstants.pinLength.toString() + r'}$',
//     );
//     if (!pinRegExp.hasMatch(pin)) {
//       return 'request_valid_pin'.tr();
//     }

//     if (phoneNo != null && isPinPartOfPhone(phoneNo, pin)) {
//       return "pin_number_cant_be_part_of_phone_number".tr();
//     }

//     if (isSequenceNumber(pin)) {
//       return "pin_number_cant_be_sequence_numbers".tr();
//     }

//     if (isConsecutive(pin)) {
//       return "pin_number_cant_be_consecutive_numbers".tr();
//     }

//     return null;
//   }

//   static bool anyPhoneNumberValid(Set<String> phoneNumbers) {
//     for (var number in phoneNumbers) {
//       if (isPhoneNoValid(number)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
