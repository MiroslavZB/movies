const String appName = 'Movies';
// Borders
const double smallBorderRadius = 8;
const double bigBorderRadius = 16;

// Icons
const double smallIconSize = 20;
const double mediumIconSize = 30;
const double largeIconSize = 40;

// Headers Sizes
const double sizeH1 = 26.0;
const double sizeH2 = 24.0;
const double sizeH3 = 22.0;
const double sizeH4 = 18.0;
const double sizeH5 = 16.0;
const double sizeH6 = 14.0;
const double sizeH7 = 12.0;
const double sizeH8 = 10.0;
const double sizeH9 = 8.0;

// Date format
const List<String> monthsText = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

String formatDateTimeA(DateTime dateTime) {
  return '${dateTime.year} ${monthsText[dateTime.month]} ${dateTime.day}';
}
