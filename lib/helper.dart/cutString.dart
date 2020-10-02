/*
as there is no specific title for images
descriptions and tags used instead. and they can be ong
*/
String cutString(String original, {String delim = r'\.'}) {
  int wordsNum = original.split(" ").length;

  if (wordsNum < 7) {
    return original;
  }

  RegExp exp = new RegExp(r"^(.+)" + delim);
  String match = exp.stringMatch(original);

  if (match != null) {
    match = match.toString();

    if (match.split(" ").length < 7) {
      match = match.substring(0, match.length - 2);
      return match;
    }
  }
  String newDelim;
  switch (delim) {
    case r'\.':
      newDelim = r'\:';
      break;
    case r'\.':
      newDelim = r'\?';
      break;
    case r'\?':
      newDelim = r'\!';
      break;
    case r'\!':
      newDelim = r'\:';
      break;
    case r'\:':
      newDelim = r'\;';
      break;
    case r'\;':
      newDelim = r'\,';
      break;
    default:
      return original.split(' ').sublist(0, 7).join(" ") + '...';
  }

  return cutString(original, delim: newDelim);
}
