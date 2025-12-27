String decryptData(String? obfuscated) {
  if (obfuscated == null || obfuscated.isEmpty) return "";
  String original = "";
  for (int i = 0; i < obfuscated.length; i += 3) {
    original += obfuscated[i];
  }
  return original;
}
