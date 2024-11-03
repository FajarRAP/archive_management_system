String? validate(String? value) {
  if (value!.isEmpty) {
    return 'Harus diisi';
  }
  return null;
}
