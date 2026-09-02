import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/configs/assets.dart';
import 'package:prize24_app/core/ui/buttons.dart';
import 'package:prize24_app/core/ui/primary_text_field.dart';

class PopAuthShellPage extends StatefulWidget {
  const PopAuthShellPage({super.key});

  @override
  State<PopAuthShellPage> createState() => _PopAuthShellPageState();
}

class _PopAuthShellPageState extends State<PopAuthShellPage> {
  bool _signINOption = true;
  bool _emailVerificationRequired = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _emailVerificationRequired
            ? const EmailVerificationRequired()
            : Column(
                children: [
                  // 20
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.p24LogoIcon,
                        height: 60,
                        width: 60,
                      ),
                      const Text(
                        'Price24',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Become a Vendor & \n Elevate Your Business!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // const Text(
                  //   'Create coupons, run draws, and\n manage your audience with ease!',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // _buildImage(
                  //   Assets.vendor,
                  //   height: 150,
                  //   padding: const EdgeInsets.only(left: 30, top: 30),
                  // ),

                  // const SizedBox(height: 50),

                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // 20
                  const SizedBox(height: 10),

                  if (_signINOption)
                    _EmailAuthSection(
                      onEmailNotVerified: () {
                        setState(() {
                          _emailVerificationRequired = true;
                        });
                      },
                    )
                  else
                    const _RegiserSection(),

                  if (_signINOption)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _signINOption = false;
                            });
                          },
                          child: const Text(
                            'Register Now',
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _signINOption = true;
                            });
                          },
                          child: const Text(
                            'Sign In',
                          ),
                        ),
                      ],
                    ),

                  // SizedBox(
                  //   width: size.width * 0.75,
                  //   child: Secondary1Button(
                  //     text: 'Sign Up',
                  //     onPressed: () {
                  //       context.push(AppRoutes.signup);
                  //     },
                  //   ),
                  // ),

                  const SizedBox(height: 30),
                ],
              ),
      ),
    );
  }

  // Widget _buildText(
  //   String text, {
  //   double fontSize = 14,
  //   FontWeight fontWeight = FontWeight.normal,
  //   Color color = Colors.white,
  // }) {
  //   return Text(
  //     text,
  //     textAlign: TextAlign.center,
  //     style: TextStyle(
  //       color: color,
  //       fontSize: fontSize,
  //       fontWeight: fontWeight,
  //       fontFamily: 'Gilroy',
  //     ),
  //   );
  // }

  // Widget _buildImage(
  //   String assetPath, {
  //   double height = 100,
  //   EdgeInsets padding = EdgeInsets.zero,
  // }) {
  //   return Padding(
  //     padding: padding,
  //     child: Image.asset(
  //       assetPath,
  //       height: height,
  //     ),
  //   );
  // }
}

class EmailVerificationRequired extends ConsumerWidget {
  const EmailVerificationRequired({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    // ref.listen(
    //   recheckAuthForVerificationControllerProvider,
    //   (_, next) {
    //     next.whenOrNull(
    //       data: (data) {
    //         if (data != null) {
    //           // check whether email is verified
    //           if (!data.isVerified) {
    //             // Show verification required message
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               const SnackBar(
    //                 content:
    //                     Text('Email not verified. Please verify your email.'),
    //               ),
    //             );
    //           } else {
    //             // Navigate to home page or any other page
    //             ref
    //                 .read(authControllerProvider.notifier)
    //                 .authStateChanged(data);
    //             Navigator.pop(context);
    //           }
    //         }
    //       },
    //     );
    //   },
    // );

    return Container(
      // height: 200,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Please verify your email to continue.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: size.width * 0.75,
            child: Primary1Button(
              text: 'Resend Verification Email',
              onPressed: () {
                // Logic to resend verification email
                // ref
                //     .read(emailSigninControllerProvider.notifier)
                //     .resendVerificationEmail();
              },
            ),
          ),
          // 30
          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.75,
            child: Primary1Button(
              text: 'Check the status Again',
              onPressed: () {
                // Logic to resend verification email
                // ref
                //     .read(emailSigninControllerProvider.notifier)
                //     .resendVerificationEmail();

                // ref
                //     .read(recheckAuthForVerificationControllerProvider.notifier)
                //     .recheckAuthForVerification();
              },
            ),
          ),

          // 100
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

//todo: Duplicate
class _EmailAuthSection extends ConsumerStatefulWidget {
  const _EmailAuthSection({
    required this.onEmailNotVerified,
  });

  final void Function() onEmailNotVerified;

  @override
  ConsumerState<_EmailAuthSection> createState() => _EmailAuthSectionState();
}

class _EmailAuthSectionState extends ConsumerState<_EmailAuthSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ref.listen(
    // emailSigninControllerProvider,
    // (_, next) {
    //   next.whenOrNull(
    //     data: (data) {
    //       ref.read(authControllerProvider.notifier).authStateChanged(data);
    //       if (data != null && data is AuthenticatedUser) {
    //         // check whether email is verified
    //         if (!data.isVerified) {
    //           widget.onEmailNotVerified();
    //         } else {
    //           // Navigate to home page or any other page
    //           // ref
    //           //     .read(authControllerProvider.notifier)
    //           //     .authStateChanged(data);
    //           Navigator.pop(context);
    //         }
    //         // // Snackbar
    //         // ScaffoldMessenger.of(context).showSnackBar(
    //         //   const SnackBar(
    //         //     content: Text('Welcome to Price24!'),
    //         //   ),
    //         // );

    //         // // Navigator.pop(context)
    //         // Navigator.pop(context);
    //       }
    //     },
    //   );
    // },
    // );
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryTextField(
              hint: 'email ID',
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              hint: 'password',
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: Primary1Button(
                text: 'Sign In',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ref
                    //     .read(emailSigninControllerProvider.notifier)
                    //     .emailSignIn(
                    //       email: _emailController.text,
                    //       password: _passwordController.text,
                    //     );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegiserSection extends ConsumerStatefulWidget {
  const _RegiserSection();

  @override
  ConsumerState<_RegiserSection> createState() => _RegisterAuthSectionState();
}

class _RegisterAuthSectionState extends ConsumerState<_RegiserSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // User name
            PrimaryTextField(
              hint: 'user name',
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            PrimaryTextField(
              hint: 'email ID',
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            PrimaryTextField(
              hint: 'password',
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            // confirm password
            // const SizedBox(height: 10),
            // PrimaryTextField(
            //   hint: 'confirm password',
            //   controller: _confirmPasswordController,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter your password';
            //     }
            //     return null;
            //   },
            // ),

            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: Primary1Button(
                text: 'Sign Up',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ref
                    //     .read(registerAccountControllerProvider.notifier)
                    //     .registerAccount(
                    //       userName: _nameController.text,
                    //       email: _emailController.text,
                    //       password: _passwordController.text,
                    //     );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
