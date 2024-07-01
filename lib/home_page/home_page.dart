import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tax_calculator/home_page/tax_bloc.dart';
import 'package:tax_calculator/home_page/widget/custom_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController salaryController = TextEditingController();
    final TextEditingController taxController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          "Tax Calculator",
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: salaryController,
                labelText: "Enter your income salary",
              ),
              const SizedBox(height: 30),
              Card(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 120,
                      child: const Text("Tax"),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 70,
                      color: const Color(0x54CB8BEC),
                      child: TextField(
                        controller: taxController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tax %',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<TaxBloc, TaxState>(
                        builder: (context, state) {
                          if (state is TaxCalcualationInProgress) {
                            return CircularProgressIndicator();
                          } else if (state is TaxCalcualationSuccess) {
                            return Text(
                              ' ${state.taxAmount}',
                              style: TextStyle(fontSize: 20),
                            );
                          } else {
                            return Text(
                              ' 0.0',
                              style: TextStyle(fontSize: 20),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<TaxBloc, TaxState>(
                builder: (context, state) {
                  if (state is TaxCalcualationSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deducted Bill: ${state.taxAmount}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Total Salary: ${state.totalSalary}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  } else if (state is TaxCalculationFailure) {
                    return Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deducted Bill: 0.0",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Total Salary: 0.0",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  final double income = double.parse(salaryController.text);
                  final double taxRate = double.parse(taxController.text);
                  context.read<TaxBloc>().add(CalculateTaxEvent(income: income, taxRate: taxRate));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.purple[100],
                  ),
                  child: Center(
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
