String? validate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Harus diisi';
  }
  return null;
}
