import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/extensions/num_extension.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/bloc/index.dart';
import 'package:payora/core/shared/widgets/appbar/index.dart';
import 'package:payora/features/send_money/domain/entities/transaction.dart';
import 'package:payora/features/send_money/presentation/bloc/send_money_bloc.dart';
import 'package:payora/features/send_money/presentation/widgets/transaction_result_bottom_sheet.dart';

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final smBloc = context.read<SendMoneyBloc>();
    final balanceBloc = context.read<BalanceBloc>();

    return BlocBuilder<BalanceBloc, BalanceState>(
      builder: (context, balanceState) {
        final currentBalance = balanceBloc.states<BalanceCurrent>()!;

        return BlocListener<SendMoneyBloc, SendMoneyState>(
          listener: (context, state) {
            // Listen for SendMoneyStatus changes
            final statusState = smBloc.states<SendMoneyStatus>();
            if (statusState != null && statusState.success != null) {
              _showTransactionResultBottomSheet(
                context,
                statusState.success!,
                smBloc.states<SendMoneyTransactionList>()?.transactions.first,
                statusState.message,
              );

              // Clear form and deduct balance on successful transaction
              if (statusState.success == true) {
                final transaction = smBloc
                    .states<SendMoneyTransactionList>()
                    ?.transactions
                    .first;
                if (transaction != null) {
                  // Deduct amount from balance
                  balanceBloc.add(
                    BalanceDeductEvent(amount: transaction.amount),
                  );
                }
                smBloc.add(const SendMoneyClearForm());
              }

              // Reset status after showing the bottom sheet
              smBloc.add(const SendMoneyResetStatus());
            }

            // Listen for form clear event
            if (state is SendMoneyFormCleared) {
              formKey.currentState?.reset();
            }
          },
          child: Scaffold(
            appBar: AppbarWidget(
              title: context.l10n.walletActionsItemSendMoney,
              icon: const Icon(Icons.send),
              showIcon: false,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                key: formKey,
                child: Container(
                  width: context.appSize.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Balance display card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.appColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: context.appColors.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                fontSize: 14,
                                color: context.appColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₱ ${currentBalance.balance.withComma}',
                              style: TextStyle(
                                fontSize: 24,
                                color: context.appColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      FormBuilderTextField(
                        name: 'recipient',
                        decoration: InputDecoration(
                          labelText: 'Recipient',
                          hintText: '09012345678',
                          prefixIcon: Icon(
                            Icons.person,
                            color: context.appColors.primary,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.minLength(11),
                          FormBuilderValidators.maxLength(11),
                          (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                !value.startsWith('09')) {
                              return 'Phone number must start with 09';
                            }
                            return null;
                          },
                        ]),
                      ),
                      const SizedBox(height: 32),
                      FormBuilderTextField(
                        name: 'amount',
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter amount',
                          helperText:
                              'Maximum: ₱ ${currentBalance.balance.withComma}',
                          prefixIcon: Icon(
                            Icons.money,
                            color: context.appColors.primary,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.min(1),
                          (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value.startsWith('0')) {
                              return 'Amount cannot start with 0';
                            }
                            // Check against current balance
                            if (value != null && value.isNotEmpty) {
                              final amount = double.tryParse(value);
                              if (amount != null &&
                                  amount > currentBalance.balance) {
                                return 'Amount exceeds available balance';
                              }
                            }
                            return null;
                          },
                        ]),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            backgroundColor: context.appColors.primary,
                            foregroundColor: context.appColors.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Save form state
                              formKey.currentState!.save();
                              final values = formKey.currentState!.value;

                              // Extract values
                              final recipient = values['recipient'] as String;
                              final amount = values['amount'] as String;
                              final amountDouble = double.parse(amount);

                              // // Double check balance before proceeding
                              // if (!balanceBloc.hasSufficientFunds(
                              //   amountDouble,
                              // )) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text('Insufficient funds'),
                              //       backgroundColor: Colors.red,
                              //     ),
                              //   );
                              //   return;
                              // }

                              final time = DateFormat(
                                'h:mm a',
                              ).format(DateTime.now());

                              // Create transaction
                              final transaction = Transaction(
                                recipient: recipient,
                                amount: amountDouble,
                                time: time,
                              );

                              // Pass to bloc
                              smBloc.add(
                                SendMoneyExecuteTransaction(
                                  transaction: transaction,
                                  context: context,
                                ),
                              );
                            }
                          },
                          child: const Text('Send'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show transaction result bottom sheet
  void _showTransactionResultBottomSheet(
    BuildContext context,
    bool isSuccess,
    Transaction? transaction,
    String? message,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => TransactionResultBottomSheet(
        isSuccess: isSuccess,
        transaction: transaction,
        errorMessage: isSuccess
            ? null
            : (message ?? 'Transaction failed. Please try again.'),
      ),
    );
  }
}
