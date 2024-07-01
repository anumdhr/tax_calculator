part of 'tax_bloc.dart';

@immutable
abstract class TaxEvent extends Equatable {
  const TaxEvent();
  @override
  List<Object> get props => [];
}
class CalculateTaxEvent extends TaxEvent {
  final double income;
  final double taxRate;
  const CalculateTaxEvent({required this.income, required this.taxRate});

  @override
  List<Object> get props => [income, taxRate];
}
