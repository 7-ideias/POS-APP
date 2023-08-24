import 'barra_individual.dart';

class BarData{
  final double domQuantia;
  final double segQuantia;
  final double terQuantia;
  final double quarQuantia;
  final double quinQuantia;
  final double sexQuantia;
  final double sabQuantia;
  BarData({
    required this.domQuantia,
    required this.segQuantia,
    required this.terQuantia,
    required this.quarQuantia,
    required this.quinQuantia,
    required this.sexQuantia,
    required this.sabQuantia,
});
  List<BarraIndividual> barraData = [];
  void initializeBarData(){
    barraData = [
      BarraIndividual(x: 0, y: domQuantia),
      BarraIndividual(x: 1, y: segQuantia),
      BarraIndividual(x: 2, y: terQuantia),
      BarraIndividual(x: 3, y: quarQuantia),
      BarraIndividual(x: 4, y: quinQuantia),
      BarraIndividual(x: 5, y: sexQuantia),
      BarraIndividual(x: 6, y: sabQuantia),
    ];
  }
}