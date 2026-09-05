import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckInBillDetails {
  const CheckInBillDetails({
    required this.billNumber,
    required this.billAmount,
  });

  final String billNumber;
  final double billAmount;
}

Future<CheckInBillDetails?> showCheckInBillDialog(
  BuildContext context, {
  required String userId,
}) {
  return showDialog<CheckInBillDetails>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _CheckInBillDialog(userId: userId),
  );
}

class _CheckInBillDialog extends StatefulWidget {
  const _CheckInBillDialog({required this.userId});

  final String userId;

  @override
  State<_CheckInBillDialog> createState() => _CheckInBillDialogState();
}

class _CheckInBillDialogState extends State<_CheckInBillDialog> {
  final _formKey = GlobalKey<FormState>();
  final _billNumberController = TextEditingController();
  final _billAmountController = TextEditingController();
  bool _isFormValid = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _billNumberController.dispose();
    _billAmountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_isSubmitting || !_isFormValid || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);
    Navigator.of(context).pop(
      CheckInBillDetails(
        billNumber: _billNumberController.text.trim(),
        billAmount: double.parse(_billAmountController.text),
      ),
    );
  }

  void _updateFormValidity(String _) {
    final amount = double.tryParse(_billAmountController.text);
    final isValid =
        _billNumberController.text.trim().isNotEmpty &&
        amount != null &&
        amount.isFinite &&
        amount > 0;
    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final abbreviatedUserId = widget.userId.length > 16
        ? '${widget.userId.substring(0, 16)}…'
        : widget.userId;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Complete check-in'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer: $abbreviatedUserId',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _billNumberController,
                autofocus: true,
                maxLength: 64,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Bill number',
                  hintText: 'Enter bill ID or receipt number',
                  prefixIcon: Icon(Icons.receipt_long_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bill number is required';
                  }
                  return null;
                },
                onChanged: _updateFormValidity,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _billAmountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) =>
                        RegExp(
                          r'^\d{0,12}(?:\.\d{0,2})?$',
                        ).hasMatch(newValue.text)
                        ? newValue
                        : oldValue,
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: 'Bill amount',
                  hintText: '0.00',
                  prefixIcon: Icon(Icons.payments_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final amount = double.tryParse(value ?? '');
                  if (amount == null || !amount.isFinite || amount <= 0) {
                    return 'Enter an amount greater than zero';
                  }
                  return null;
                },
                onChanged: _updateFormValidity,
                onFieldSubmitted: (_) => _submit(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isSubmitting || !_isFormValid ? null : _submit,
          child: const Text('Submit check-in'),
        ),
      ],
    );
  }
}
