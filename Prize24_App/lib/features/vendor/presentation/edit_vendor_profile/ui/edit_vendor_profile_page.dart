import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/core/ui/buttons.dart';
import 'package:prize24_app/core/ui/primary_text_field.dart';
import 'package:prize24_app/features/shop/domain/model/shop_model.dart';
import 'package:prize24_app/features/appuser_profile_view/presentation/edit_profile/controller/edit_profile_controller.dart';
import 'package:prize24_app/features/vendor/presentation/edit_vendor_profile/view_model/edit_shop_profile_controller.dart';

// todo: Diff bw User profile and Shop Profile
// We have single for both

class EditVendorProfilePage extends ConsumerStatefulWidget {
  const EditVendorProfilePage({
    required this.shop,
    super.key,
  });

  final ShopModel shop;

  @override
  ConsumerState<EditVendorProfilePage> createState() =>
      _EditShopProfilePageState();
}

class _EditShopProfilePageState extends ConsumerState<EditVendorProfilePage> {
  // Controllers and Key
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    // Fill
    _shopNameController.text = widget.shop.shopName;
    _phoneNumberController.text = widget.shop.shopPhone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      editShopProfileControllerProvider,
      (previous, next) {
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
              'Failed to update profile',
              false,
            );
          },
          data: (data) {
            if (data != null) {
              // Inject
              // ref
              //     .read(getMyShopControllerProvider.notifier)
              //     .injectShopDetails(data);

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
            }
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Gilroy',
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
              // Orginal
              // const TextField(
              //   style: TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //     labelText: 'Full name',
              //     labelStyle: TextStyle(
              //       color: Colors.white,
              //       fontFamily: 'Gilroy',
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.white),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.white),
              //     ),
              //   ),
              // ),
              PrimaryTextField(
                hint: 'Shop Name',
                controller: _shopNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your shop name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              PrimaryTextField(
                hint: 'Phone number',
                controller: _phoneNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),

              const Spacer(),
              SizedBox(
                width: 250,
                child: Primary1Button(
                  iconData: Icons.trending_neutral_sharp,
                  text: 'Save',
                  onPressed: () {
                    // Validate
                    // if (_formKey.currentState!.validate()) {
                    //   ref.read(editShopProfileControllerProvider.notifier).save(
                    //         shop: widget.shop.copyWith(
                    //           name: _shopNameController.text,
                    //           phoneNumber: _phoneNumberController.text,
                    //         ),
                    //       );
                    // }
                  },
                ),
              ),
              // 20
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
