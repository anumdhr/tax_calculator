part of 'tax_bloc.dart';

@immutable
abstract class TaxState extends Equatable {
  const TaxState();
  @override
  List<Object> get props => [];
}

 class TaxInitial extends TaxState {}

class TaxCalcualationInProgress extends TaxState {}

class TaxCalcualationSuccess extends TaxState {
  final double taxAmount;
  final double totalSalary;

  TaxCalcualationSuccess( this.taxAmount, this.totalSalary);

  @override
  List<Object> get props => [taxAmount, totalSalary];
}

class TaxCalculationFailure extends TaxState {
  final String errorMessage;

  const TaxCalculationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}