import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFF121212);
const Color kSecondaryColor = Color(0xFF55585A);
const Color kWhiteColor = Colors.white;

const double kHeadingFontSize = 28;
const double kSubheadingFontSize = 18;
const double kParagraphFontSize = 16;

final TextStyle textPrimary = TextStyle(
  fontFamily: 'Charter',
  color: kPrimaryColor,
  fontSize: kParagraphFontSize,
);

final TextStyle textSecondary = textPrimary.copyWith(
  color: kSecondaryColor,
);

final TextStyle textPrimaryWhite = textPrimary.copyWith(
  color: kWhiteColor,
);

final TextStyle textHeadingPrimary = GoogleFonts.gentiumBasic(
  fontSize: kHeadingFontSize,
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
);

final TextStyle textHeadingWhite = textPrimaryWhite.copyWith(
  fontSize: kHeadingFontSize,
  fontWeight: FontWeight.bold,
);
