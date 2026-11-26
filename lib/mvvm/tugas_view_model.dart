import 'package:flutter/foundation.dart';

import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class TugasViewModel extends ChangeNotifier {
  TugasViewModel(this._repo);

  final RepositoriTugas _repo;
  String? _galat;
  bool _hanyaBelumSelesai = false;

  List<Tugas> get daftar =>
      _hanyaBelumSelesai
          ? List.unmodifiable(_repo.daftar.where((tugas) => !tugas.selesai))
          : _repo.daftar;

  int get totalTugas => _repo.daftar.length;
  int get jumlahSelesai => _repo.daftar.where((tugas) => tugas.selesai).length;
  String? get galat => _galat;
  bool get hanyaBelumSelesai => _hanyaBelumSelesai;

  bool tambah(String input) {
    _galat = validasiJudul(input);
    final berhasil = _galat == null;
    if (berhasil) _repo.tambah(input.trim());
    notifyListeners();
    return berhasil;
  }

  void ubahStatus(int id) {
    _repo.ubahStatus(id);
    notifyListeners();
  }

  void ubahFilter(bool aktif) {
    _hanyaBelumSelesai = aktif;
    notifyListeners();
  }
}
