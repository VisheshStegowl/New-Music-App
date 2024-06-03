import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

RxBool isRadioPlay = false.obs;

enum BottomDisplay { radio, song, video, none }

extension NameInitials on String {
  ///Geting Initials String for Contect Name Avatar
  String getInitials() {
    List<String> nameParts = this.split(' ');
    if (nameParts.length < 2) {
      if (nameParts.isNotEmpty && nameParts != '') {
        String firstInitial = nameParts[0][0].capitalize ?? '';
        String secondInitial = nameParts[0][1].isNotEmpty
            ? nameParts[0][1].capitalize ?? ''
            : nameParts[0][0].capitalize ?? '';
        return '$firstInitial$secondInitial';
      } else {
        return '';
      }
    }
    String firstInitial = nameParts[0][0].capitalize ?? '';
    String secondInitial = nameParts[1][0].capitalize ?? '';

    return '$firstInitial$secondInitial';
  }
}

String durationToStringTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Here you can define your custom phone number format logic
    // For simplicity, let's assume the format is ###-###-####

    if (newValue.text.length > 12) {
      // Prevents entering more than 10 digits
      return oldValue;
    }

    var newText = newValue.text;

    if (newValue.text.length >= 4 && !newValue.text.contains('-')) {
      // Add hyphen after 3rd digit
      newText =
          newText.substring(0, 3) + '-' + newText.substring(3, newText.length);
    }
    if (newValue.text.length >= 8 &&
        !newValue.text.substring(4).contains('-')) {
      // Add hyphen after 7th digit
      newText =
          newText.substring(0, 7) + '-' + newText.substring(7, newText.length);
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
