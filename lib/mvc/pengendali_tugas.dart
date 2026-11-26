import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class PengendaliTugas {
  PengendaliTugas(this._repo);

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
    if (_galat != null) return false;
    _repo.tambah(input.trim());
    return true;
  }

  void ubahStatus(int id) => _repo.ubahStatus(id);

  void ubahFilter(bool aktif) {
    _hanyaBelumSelesai = aktif;
  }
}
