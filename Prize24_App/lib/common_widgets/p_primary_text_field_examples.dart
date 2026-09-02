import 'package:flutter/material.dart';
import 'package:prize24_app/common_widgets/p_primary_text_field.dart';

/// Example screen demonstrating PPrimaryTextField widget
/// Shows both types (with/without icon) and all states
class PPrimaryTextFieldExamplesScreen extends StatefulWidget {
  const PPrimaryTextFieldExamplesScreen({super.key});

  @override
  State<PPrimaryTextFieldExamplesScreen> createState() =>
      _PPrimaryTextFieldExamplesScreenState();
}

class _PPrimaryTextFieldExamplesScreenState
    extends State<PPrimaryTextFieldExamplesScreen> {
  // Form keys for error state validation
  final _errorFormKey1 = GlobalKey<FormFieldState<String>>();
  final _errorFormKey2 = GlobalKey<FormFieldState<String>>();

  // Controllers for different states
  final _defaultController = TextEditingController();
  final _disabledController = TextEditingController();
  final _filledController = TextEditingController(text: 'Mobbin');
  final _typingController = TextEditingController();
  final _errorController = TextEditingController(text: 'invalid@email');
  final _passwordController = TextEditingController(text: 'XXXXXXXXXX');

  // Controllers with icon
  final _defaultWithIconController = TextEditingController();
  final _disabledWithIconController = TextEditingController();
  final _filledWithIconController = TextEditingController(text: 'Mobbin');
  final _typingWithIconController = TextEditingController();
  final _errorWithIconController = TextEditingController(text: 'invalid@email');
  final _passwordWithIconController = TextEditingController(text: 'XXXXXXXXXX');

  bool _obscurePassword = true;
  bool _obscurePasswordWithIcon = true;

  @override
  void initState() {
    super.initState();
    // Trigger validation on error fields after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _errorFormKey1.currentState?.validate();
      _errorFormKey2.currentState?.validate();
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    _defaultController.dispose();
    _disabledController.dispose();
    _filledController.dispose();
    _typingController.dispose();
    _errorController.dispose();
    _passwordController.dispose();
    _defaultWithIconController.dispose();
    _disabledWithIconController.dispose();
    _filledWithIconController.dispose();
    _typingWithIconController.dispose();
    _errorWithIconController.dispose();
    _passwordWithIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPrimaryTextField Examples'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Type=No Icon
            Text(
              'Type=No Icon',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),

            // State: Default
            _buildStateLabel('State: Default'),
            PPrimaryTextField(
              controller: _defaultController,
              labelText: 'Legal first name',
            ),
            const SizedBox(height: 24),

            // State: Disabled
            _buildStateLabel('State: Disabled'),
            PPrimaryTextField(
              controller: _disabledController,
              labelText: 'Legal first name',
              enabled: false,
            ),
            const SizedBox(height: 24),

            // State: Filled
            _buildStateLabel('State: Filled'),
            PPrimaryTextField(
              controller: _filledController,
              labelText: 'Search for Address',
            ),
            const SizedBox(height: 24),

            // State: Typing (focused)
            _buildStateLabel('State: Typing'),
            PPrimaryTextField(
              controller: _typingController,
              labelText: 'Legal first name',
              autofocus: false,
            ),
            const SizedBox(height: 24),

            // State: Error
            _buildStateLabel('State: Error'),
            PPrimaryTextField(
              key: _errorFormKey1,
              controller: _errorController,
              labelText: 'Input your email',
              keyboardType: TextInputType.emailAddress,
              validator: (_) => 'Your email is not found!',
            ),
            const SizedBox(height: 24),

            // State: Password
            _buildStateLabel('State: Password'),
            PPrimaryTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),

            const Divider(height: 40),

            // Section: Type=With Icon
            Text(
              'Type=With Icon',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),

            // State: Default with icon
            _buildStateLabel('State: Default'),
            PPrimaryTextField(
              controller: _defaultWithIconController,
              labelText: 'Legal first name',
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 24),

            // State: Disabled with icon
            _buildStateLabel('State: Disabled'),
            PPrimaryTextField(
              controller: _disabledWithIconController,
              labelText: 'Legal first name',
              prefixIcon: const Icon(Icons.person_outline),
              enabled: false,
            ),
            const SizedBox(height: 24),

            // State: Filled with icon
            _buildStateLabel('State: Filled'),
            PPrimaryTextField(
              controller: _filledWithIconController,
              labelText: 'Search for Address',
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: 24),

            // State: Typing with icon
            _buildStateLabel('State: Typing'),
            PPrimaryTextField(
              controller: _typingWithIconController,
              labelText: 'Legal first name',
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 24),

            // State: Error with icon
            _buildStateLabel('State: Error'),
            PPrimaryTextField(
              key: _errorFormKey2,
              controller: _errorWithIconController,
              labelText: 'Input your email',
              prefixIcon: const Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              validator: (_) => 'Your email is not found!',
            ),
            const SizedBox(height: 24),

            // State: Password with icon
            _buildStateLabel('State: Password with Icon'),
            PPrimaryTextField(
              controller: _passwordWithIconController,
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              obscureText: _obscurePasswordWithIcon,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePasswordWithIcon
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePasswordWithIcon = !_obscurePasswordWithIcon;
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStateLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
