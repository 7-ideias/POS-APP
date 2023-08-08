import 'package:shared_preferences/shared_preferences.dart';
class LocalStorageService {
  static Future<void> salvarInformacoes(String chave, String valor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(chave, valor);
  }
  static Future<String> obterInformacoes(String chave) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(chave) ?? '';
  }
  static Future<void> removerInformacoes(String chave) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(chave);
  }
}

/*

await LocalStorage.salvarInformacoes('nome', 'João');
final nome = await LocalStorage.obterInformacoes('nome');
print(nome); // Saída: João
await LocalStorage.removerInformacoes('nome');

 */