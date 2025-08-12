import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:payora/core/di/injection.dart';
import 'package:payora/core/extensions/index.dart';
import 'package:payora/core/keys/app_key.dart';
import 'package:payora/core/l10n/l10n.dart';
import 'package:payora/core/shared/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payora/features/transaction/index.dart';
import 'package:uuid/uuid.dart';

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final transactionBloc = context.read<TransactionBloc>();

    return BlocListener<TransactionBloc, TransactionState>(
      listener: (txnCtx, txnState) {
        final txnList = transactionBloc.states<TransactionList>()!;

        txnList.transactions.first;

        if (txnState is TransactionList) {
          _showTransactionResult(
            context: context,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) =>
            previous is AuthVerifiedUser || current is AuthVerifiedUser,
        builder: (abCtx, abState) {
          final aVerifiedUser = authBloc.states<AuthVerifiedUser>();
          final balance = aVerifiedUser?.user?.details.balance;

          return Scaffold(
            appBar: AppbarWidget(
              title: context.l10n.walletActionsItemSendMoney,
              icon: const Icon(Icons.send),
              showIcon: false,
            ),
            body: SingleChildScrollView(
              child: FormBuilder(
                key: AppKey.sendMoneyFormKey,
                child: Container(
                  width: context.appSize.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Balance display card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.appColors.primary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: context.appColors.primary.withValues(
                              alpha: 0.3,
                            ),
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
                              '₱ ${balance?.withComma}',
                              style: TextStyle(
                                fontSize: 24,
                                color: context.appColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
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
                        textInputAction: TextInputAction.next,
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
                          helperText: 'Maximum: ₱ ${balance?.withComma}',
                          prefixIcon: Icon(
                            Icons.money,
                            color: context.appColors.primary,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
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
                              if (amount != null && amount > (balance ?? 0)) {
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
                            final formState =
                                AppKey.sendMoneyFormKey.currentState;

                            // Dismiss keyboard and remove focus from fields
                            context.appFocusManager.primaryFocus?.unfocus();

                            if (formState != null &&
                                formState.saveAndValidate()) {
                              final values = formState.value;

                              // Set param values
                              final id = Random().nextInt(
                                Int32.MAX_VALUE.toInt(),
                              );
                              final transactionId = getIt<Uuid>().v4();
                              final sender =
                                  aVerifiedUser?.user?.details.mobile ?? '';
                              final recipient = values['recipient'] as String;
                              final amount = values['amount'] as String;
                              final timestamp = DateTime.now();

                              // Create transaction
                              final transaction = Transaction(
                                id: id,
                                transactionId: transactionId,
                                sender: sender,
                                recipient: recipient,
                                amount: double.parse(amount),
                                timestamp: timestamp,
                              );

                              transactionBloc.add(
                                TransactionSendMoney(
                                  transaction: transaction,
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
          );
        },
      ),
    );
  }

  void _showTransactionResult({
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const TransactionResultWidget(),
    );
  }
}
