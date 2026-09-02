import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/core/ui/buttons.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/edit_profile/controller/edit_profile_controller.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/features/global_controller/auth/auth_controller.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({
    required this.user,
    super.key,
  });

  final AppUser user;

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  // Controllers and Key

  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  // final _phoneNumberController = TextEditingController();

  Future<void>? _pendingAddTodo;

  @override
  void initState() {
    // Fill
    _userNameController.text = widget.user.userName;
    // _phoneNumberController.text = widget.user.phoneNumber;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editProfileControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          // Snackbar
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(error.toString()),
          //   ),
          // );
          showToastAtTop(
            context,
            error.toString(),
            false,
          );
        },
        data: (data) {
          if (data != null) {
            // Snackbar
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Profile updated successfully'),
            //   ),
            // );

            showToastAtTop(
              context,
              'Profile updated successfully',
              true,
            );

            ref
                .read(authControllerProvider.notifier)
                .updateAuthUser(user: data);
          }
        },
      );
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // const SizedBox(height: 10),
              // Row(
              //   children: [
              //     const CircleAvatar(
              //       radius: 50,
              //       backgroundColor: Colors.pinkAccent,
              //       child: Text(
              //         'A',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 40,
              //           fontFamily: 'Gilroy',
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     ElevatedButton(
              //       onPressed: () {},
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //       ),
              //       child: const Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Text(
              //             'Change',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontFamily: 'Gilroy',
              //               fontSize: 14,
              //             ),
              //           ),
              //           SizedBox(width: 10),
              //           Icon(Icons.image, color: Colors.black),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _userNameController,
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'User name',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // const TextField(
              //   style: TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //     labelText: 'Phone number',
              //     labelStyle: TextStyle(
              //       color: Colors.white,
              //       fontFamily: 'Gilroy',
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.white),
              //     ),
              //   ),
              // ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: FutureBuilder(
                    future: _pendingAddTodo,
                    builder: (context, snapshot) {
                      return Primary1Button(
                        isLoading:
                            snapshot.connectionState == ConnectionState.waiting,
                        text: 'Save',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final future = ref
                                .read(editProfileControllerProvider.notifier)
                                .onSave(
                                  widget.user.copyWith(
                                    userName: _userNameController.text,
                                  ),
                                );

                            setState(() {
                              _pendingAddTodo = future;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: SizedBox(
              //     height: 40,
              //     width: 250,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         // Validate
              //         if (_formKey.currentState!.validate()) {
              //           ref.read(editProfileControllerProvider.notifier).onSave(
              //                 widget.user.copyWith(
              //                   userName: _userNameController.text,
              //                 ),
              //               );
              //         }
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //       ),
              //       child: const Padding(
              //         padding: EdgeInsets.symmetric(vertical: 5),
              //         child: Text(
              //           'Save',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
