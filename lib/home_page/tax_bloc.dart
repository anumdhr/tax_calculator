import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tax_event.dart';
part 'tax_state.dart';


class TaxBloc extends Bloc<TaxEvent, TaxState> {
  TaxBloc() : super(TaxInitial()) {
    on<CalculateTaxEvent>((event, emit) {
      emit(TaxCalcualationInProgress());

      try {
        final double taxAmount = (event.income * event.taxRate) / 100;
        final double totalSalary = event.income - taxAmount;
        emit(TaxCalcualationSuccess(taxAmount, totalSalary));
      } catch (error) {
        emit(TaxCalculationFailure("Invalid input values"));
      }
    });
  }
}



