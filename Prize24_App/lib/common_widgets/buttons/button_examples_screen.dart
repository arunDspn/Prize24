import 'package:flutter/material.dart';
import 'package:prize24_app/common_widgets/buttons/buttons.dart';

/// Example screen demonstrating all button variations
class ButtonExamplesScreen extends StatefulWidget {
  const ButtonExamplesScreen({super.key});

  @override
  State<ButtonExamplesScreen> createState() => _ButtonExamplesScreenState();
}

class _ButtonExamplesScreenState extends State<ButtonExamplesScreen> {
  bool isLoading = false;

  void _handlePress(String buttonType) {
    setState(() => isLoading = true);

    // Simulate an async operation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$buttonType pressed!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary Buttons Section
            _buildSectionTitle('Primary Buttons (Filled)'),
            const SizedBox(height: 16),

            AppPrimaryButton(
              text: 'Add payment method',
              size: ButtonSize.large,
              onPressed: () => _handlePress('Large Primary'),
            ),
            const SizedBox(height: 12),

            AppPrimaryButton(
              text: 'Add payment method',
              size: ButtonSize.large,
              icon: Icons.credit_card,
              iconPosition: ButtonIconPosition.right,
              onPressed: () => _handlePress('Large Primary with Icon'),
            ),
            const SizedBox(height: 12),

            AppPrimaryButton(
              text: 'Add payment method',
              size: ButtonSize.medium,
              onPressed: () => _handlePress('Medium Primary'),
            ),
            const SizedBox(height: 12),

            AppPrimaryButton(
              text: 'Add',
              size: ButtonSize.small,
              icon: Icons.add,
              iconPosition: ButtonIconPosition.left,
              onPressed: () => _handlePress('Small Primary with Icon'),
            ),
            const SizedBox(height: 12),

            AppPrimaryButton(
              text: 'Loading...',
              size: ButtonSize.medium,
              isLoading: isLoading,
              onPressed: () => _handlePress('Loading Primary'),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Secondary Buttons Section
            _buildSectionTitle('Secondary Buttons (Outlined)'),
            const SizedBox(height: 16),

            AppSecondaryButton(
              text: 'Resend code',
              size: ButtonSize.large,
              onPressed: () => _handlePress('Large Secondary'),
            ),
            const SizedBox(height: 12),

            AppSecondaryButton(
              text: 'Resend code',
              size: ButtonSize.large,
              icon: Icons.refresh,
              iconPosition: ButtonIconPosition.right,
              onPressed: () => _handlePress('Large Secondary with Icon'),
            ),
            const SizedBox(height: 12),

            AppSecondaryButton(
              text: 'Add payment method',
              size: ButtonSize.medium,
              onPressed: () => _handlePress('Medium Secondary'),
            ),
            const SizedBox(height: 12),

            AppSecondaryButton(
              text: 'Add',
              size: ButtonSize.small,
              icon: Icons.add,
              iconPosition: ButtonIconPosition.left,
              onPressed: () => _handlePress('Small Secondary with Icon'),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Text Buttons Section
            _buildSectionTitle('Text Buttons (No Outline)'),
            const SizedBox(height: 16),

            AppTextButton(
              text: 'Add payment method',
              size: ButtonSize.large,
              onPressed: () => _handlePress('Large Text'),
            ),
            const SizedBox(height: 12),

            AppTextButton(
              text: 'Add payment method',
              size: ButtonSize.large,
              icon: Icons.credit_card,
              iconPosition: ButtonIconPosition.right,
              onPressed: () => _handlePress('Large Text with Icon'),
            ),
            const SizedBox(height: 12),

            AppTextButton(
              text: 'Resend code',
              size: ButtonSize.medium,
              onPressed: () => _handlePress('Medium Text'),
            ),
            const SizedBox(height: 12),

            AppTextButton(
              text: 'Add',
              size: ButtonSize.small,
              icon: Icons.add,
              iconPosition: ButtonIconPosition.right,
              onPressed: () => _handlePress('Small Text with Icon'),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Disabled Buttons Section
            _buildSectionTitle('Disabled States'),
            const SizedBox(height: 16),

            AppPrimaryButton(
              text: 'Disabled Primary',
              size: ButtonSize.medium,
              onPressed: null,
            ),
            const SizedBox(height: 12),

            AppSecondaryButton(
              text: 'Disabled Secondary',
              size: ButtonSize.medium,
              onPressed: null,
            ),
            const SizedBox(height: 12),

            AppTextButton(
              text: 'Disabled Text',
              size: ButtonSize.medium,
              onPressed: null,
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Custom Width Section
            _buildSectionTitle('Custom Widths'),
            const SizedBox(height: 16),

            AppPrimaryButton(
              text: 'Full Width',
              width: double.infinity,
              size: ButtonSize.medium,
              onPressed: () => _handlePress('Full Width'),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    text: 'Cancel',
                    size: ButtonSize.medium,
                    onPressed: () => _handlePress('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryButton(
                    text: 'Confirm',
                    size: ButtonSize.medium,
                    onPressed: () => _handlePress('Confirm'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Icon Positions Section
            _buildSectionTitle('Icon Positions'),
            const SizedBox(height: 16),

            AppPrimaryButton(
              text: 'Icon Left',
              icon: Icons.arrow_back,
              iconPosition: ButtonIconPosition.left,
              size: ButtonSize.medium,
              onPressed: () => _handlePress('Icon Left'),
            ),
            const SizedBox(height: 12),

            AppPrimaryButton(
              text: 'Icon Right',
              icon: Icons.arrow_forward,
              iconPosition: ButtonIconPosition.right,
              size: ButtonSize.medium,
              onPressed: () => _handlePress('Icon Right'),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Gilroy',
      ),
    );
  }
}
