import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Updated by Muntasir Hossen [muntasirhossen1704089@gmail.com] on 15 October, 2025.

class AppUtils {
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String formatBalanceWithCommas(double? balance) {
    if (balance == null) return '--';
    String balanceString = balance.toStringAsFixed(2);
    String formatted = '';

    // Iterate from end of string to start
    for (int i = balanceString.length; i > 0; i--) {
      // Add each character to the front of new string
      formatted = balanceString[i - 1] + formatted;

      // Calculate position from right
      int fromRight = balanceString.length - i + 1;

      // Add comma after every 2 digits before last 6 digits
      if (fromRight > 6 && (fromRight - 6) % 2 == 0 && i > 1) {
        formatted = ',$formatted';
      }

      // Add comma after 3 digits from right (before last 6)
      if (fromRight == 6 && i > 1) {
        formatted = ',$formatted';
      }
    }
    return formatted;
  }

  static String hideBalance(double balance) {
    String balanceString = balance.toStringAsFixed(2);
    return balanceString.replaceAll(RegExp(r'[0-9.]'), '*');
  }

  // static bool featureNeedsBank(String? featureCode) {
  //   if (featureCode == null || featureCode.isEmpty) {
  //     return false;
  //   }
  //   return featureCode == FeatureCode.customerToBank.code ||
  //       featureCode == FeatureCode.agentAddMoneyFromBank.code ||
  //       featureCode == FeatureCode.distributorAddMoneyFromBank.code ||
  //       featureCode == FeatureCode.addMoneyToCustomer.code;
  // }

  static String maskAccountNumber(String? accountNo) {
    if (accountNo == null || accountNo.isEmpty) {
      return '--';
    }
    if (accountNo.length <= 4) {
      return accountNo; // Not enough characters to mask
    }
    String maskedSection = '*' * (accountNo.length - 4);
    return '${accountNo.substring(0, 2)}$maskedSection${accountNo.substring(accountNo.length - 2, accountNo.length)}';
  }

  static String getAppEnv(String baseUrl) {
    if (baseUrl.contains('RELEASE')) {
      return 'LIVE';
    } else if (baseUrl.contains('STAGING')) {
      return 'STAGE';
    } else if (baseUrl.contains('DEV')) {
      return 'DEV';
    } else {
      return 'UNKNOWN';
    }
  }

  static String getAppBuildType(bool isDebug) {
    if (isDebug) {
      return 'DEBUG';
    } else {
      return 'RELEASE';
    }
  }

  static double getAmountFromString(String amount) {
    if (amount.isEmpty) return 0.00;
    return double.parse(amount.replaceAll('৳', ''));
  }

  static String getValidContactNo(String walletNumber) {
    // Remove all non-numeric characters, including spaces, hyphens, and special characters
    walletNumber = walletNumber.replaceAll(RegExp(r'\[^0-9]'), '');

    // Remove the country code prefix '+88' or '88' if present
    if (walletNumber.startsWith('88')) {
      walletNumber = walletNumber.substring(2);
    }

    // Check if the number starts with '01' and has exactly 11 digits
    if (!walletNumber.startsWith('01') || walletNumber.length != 11) {
      return '';
    }

    return walletNumber;
  }

  static String getMobileNoWithCountryCode(String phoneNumber) {
    // Remove all non-numeric characters
    if (phoneNumber.startsWith('+880 ') && phoneNumber.contains('-')) {
      // Remove +880, space, and hyphen: +880 1833-184047 -> 01833184047
      String updatedPhoneNo = phoneNumber
          .replaceFirst('+880 ', '0')
          .replaceAll('-', '');

      return updatedPhoneNo;
    }
    // Handle +880 with space prefix
    else if (phoneNumber.startsWith('+880 ')) {
      final String updatedPhoneNo = phoneNumber.replaceFirst('+880 ', '0');
      return updatedPhoneNo;
    }
    // Handle +880 without space (14 characters total)
    else if (phoneNumber.startsWith('+880') && phoneNumber.length == 14) {
      final String updatedPhoneNo = phoneNumber.replaceFirst('+880', '0');
      return updatedPhoneNo;
    }
    // Handle +880 followed by hyphenated number without space
    else if (phoneNumber.startsWith('+880') && phoneNumber.contains('-')) {
      // Remove +880 and hyphen: +8801833-184047 -> 01833184047
      String updatedPhoneNo = phoneNumber
          .replaceFirst('+880', '0')
          .replaceAll('-', '');

      return updatedPhoneNo;
    } else if (phoneNumber.startsWith('880') && phoneNumber.contains('-')) {
      // Remove 880 and hyphen: 8801833-184047 -> 01833184047
      String updatedPhoneNo = phoneNumber
          .replaceFirst('880', '0')
          .replaceAll('-', '');

      return updatedPhoneNo;
    } else if (phoneNumber.startsWith('880 ')) {
      // Remove 880 and hyphen: 880 1833184047 -> 01833184047
      String updatedPhoneNo = phoneNumber.replaceFirst('880 ', '0');

      return updatedPhoneNo;
    } else if (phoneNumber.startsWith('880')) {
      // Remove 880 and hyphen: 880 1833184047 -> 01833184047
      String updatedPhoneNo = phoneNumber.replaceFirst('880', '0');

      return updatedPhoneNo;
    }
    // Remove hyphen: 01833-184047 -> 01833184047
    phoneNumber = phoneNumber.replaceAll('-', '');
    // Remove spaces: 01833 184047 -> 01833184047
    phoneNumber = phoneNumber.replaceAll(' ', '');
    // Remove plus sign: +01833184047 -> 01833184047
    phoneNumber = phoneNumber.replaceAll('+', '');
    // Remove parentheses: 018(33)184047 -> 01833184047
    phoneNumber = phoneNumber.replaceAll('(', '');
    phoneNumber = phoneNumber.replaceAll(')', '');

    return phoneNumber;
  }

  static String generateRandomUuid() {
    const int length = 36;
    const String chars = '0123456789abcdefghijklmnopqrstuvwxyz';
    final Random random = Random();

    return List.generate(length, (index) {
      if ([8, 13, 18, 23].contains(index)) {
        return '-'; // Add dashes at the specific positions for UUID format
      } else {
        return chars[random.nextInt(chars.length)];
      }
    }).join();
  }

  static Future<String?> cropImageToCircleAtCenter(String sourcePath) async {
    try {
      // Read the image file
      final File imageFile = File(sourcePath);
      final Uint8List imageBytes = await imageFile.readAsBytes();

      // Decode the image
      final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image originalImage = frameInfo.image;

      // Get original dimensions
      final double originalWidth = originalImage.width.toDouble();
      final double originalHeight = originalImage.height.toDouble();

      // Use the smaller dimension as the diameter for the circle
      final double diameter = originalWidth < originalHeight
          ? originalWidth
          : originalHeight;

      // Calculate center position of the original image
      final double centerX = originalWidth / 2;
      final double centerY = originalHeight / 2;
      final double radius = diameter / 2;

      // Create a picture recorder for the circular crop
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);

      // Create a circular clipping path
      final Path circlePath = Path()
        ..addOval(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        );
      canvas.clipPath(circlePath);

      // Draw the image centered in the circle
      // Source rect: circular area from center of original image
      final Rect srcRect = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: diameter,
        height: diameter,
      );

      // Destination rect: full canvas
      final Rect dstRect = Rect.fromLTWH(0, 0, diameter, diameter);

      canvas.drawImageRect(originalImage, srcRect, dstRect, Paint());

      // Convert to image
      final ui.Picture picture = recorder.endRecording();
      final ui.Image croppedImage = await picture.toImage(
        diameter.toInt(),
        diameter.toInt(),
      );

      // Convert to PNG bytes
      final ByteData? byteData = await croppedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the cropped image
      final String croppedPath = sourcePath.replaceAll('.jpg', '_cropped.png');
      final File croppedFile = File(croppedPath);
      await croppedFile.writeAsBytes(pngBytes);

      // Clean up
      originalImage.dispose();
      croppedImage.dispose();

      return croppedPath;
    } catch (e) {
      debugPrint("Error cropping image: $e");
      return null;
    }
  }
}
