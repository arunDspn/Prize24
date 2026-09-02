import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/common_widgets/buttons/app_primary_button.dart';
import 'package:prize24_app/common_widgets/p_primary_text_field.dart';
import 'package:prize24_app/common_widgets/show_toast.dart';
import 'package:prize24_app/core/constants.dart';
import 'package:prize24_app/features/campaign/domain/models/campaign_model.dart';
import 'package:prize24_app/features/clubs/domain/models/club_entity.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/create_club/ui/components/campaign_selection_list/campaign_selecter_list_modal.dart';
import 'package:prize24_app/features/clubs/presentation/vendor/create_club/view_model/create_club_controller.dart';

class CreateClubPage extends ConsumerStatefulWidget {
  const CreateClubPage({super.key});

  @override
  ConsumerState<CreateClubPage> createState() => _CreateClubPageState();
}

class _CreateClubPageState extends ConsumerState<CreateClubPage> {
  // Text controllers
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _clubDescriptionController =
      TextEditingController();
  final TextEditingController _giftCycleDayController = TextEditingController();
  final TextEditingController _multiplierDayValuesController =
      TextEditingController();

  // Selected Campaign
  CampaignModel? _selectedCampaign;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  bool get _isFormValid {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    _clubDescriptionController.dispose();
    _giftCycleDayController.dispose();
    _multiplierDayValuesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      createClubControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            if (data != null) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('Club created successfully!'),
              //     backgroundColor: Colors.green,
              //   ),
              // );
              showToastAtTop(
                context,
                'Club created successfully!',
                true,
              );
              Navigator.of(context).pop(); // Go back after successful creation
            }
          },
          error: (error, stackTrace) {
            showToastAtTop(
              context,
              'Error creating club',
              false,
            );
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Club'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PPrimaryTextField(
                controller: _clubNameController,
                labelText: 'Club Name',
                hintText: 'Enter club name',
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a club name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              PPrimaryTextField(
                controller: _clubDescriptionController,
                labelText: 'Club Description',
                hintText: 'Enter club description',
                maxLines: 4,
                minLines: 3,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value != null && value.length > 200) {
                    return 'Description cannot exceed 200 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              PPrimaryTextField(
                controller: _giftCycleDayController,
                labelText: 'Gift Cycle Day',
                hintText: 'Enter gift cycle day',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gift cycle day';
                  }
                  final day = int.tryParse(value);
                  if (day == null || day < 1 || day > 31) {
                    return 'Please enter a valid day (1-31)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              PPrimaryTextField(
                controller: _multiplierDayValuesController,
                labelText: 'Multiplier Day Values',
                hintText: 'Enter multiplier day values',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter multiplier day values';
                  }
                  final multiplier = int.tryParse(value);
                  if (multiplier == null || multiplier < 1) {
                    return 'Please enter a valid multiplier (greater than 0)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Campaign Selector
              _buildCampaignSelector(),
              const Spacer(),
              AppPrimaryButton(
                text: 'Create Club',
                onPressed: _isFormValid && _selectedCampaign != null
                    ? () {
                        final clubEntity = ClubEntity(
                          name: _clubNameController.text.trim(),
                          description: _clubDescriptionController.text.trim(),
                          giftDay: int.parse(_giftCycleDayController.text),
                          attachedCampaignId: _selectedCampaign!.id!,
                          multipierStreakDaysRequired:
                              int.parse(_multiplierDayValuesController.text),
                        );

                        ref
                            .read(createClubControllerProvider.notifier)
                            .createClub(
                              clubEntity,
                            );
                      }
                    : null,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Campaign',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            // TODO: Open campaign selection modal
            final result = await CampaignSelecterListModal.show(context);
            if (result != null) {
              setState(() {
                _selectedCampaign = result;
              });
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: _selectedCampaign == null
                    ? Colors.grey.shade300
                    : Theme.of(context).primaryColor.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _selectedCampaign == null
                  ? _buildEmptyState()
                  : _buildSelectedState(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Row(
      children: [
        Icon(
          Icons.campaign_outlined,
          color: Colors.grey.shade400,
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Please select a campaign',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade400,
          size: 16,
        ),
      ],
    );
  }

  Widget _buildSelectedState() {
    final campaign = _selectedCampaign!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          campaign.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildVisibilityChip(campaign.visibility),
                    ],
                  ),
                  if (campaign.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      campaign.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                setState(() {
                  _selectedCampaign = null;
                });
              },
              tooltip: 'Clear selection',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVisibilityChip(CampaignVisibility visibility) {
    final Color chipColor;
    final String label;

    switch (visibility) {
      case CampaignVisibility.public:
        chipColor = Colors.green;
        label = 'Public';
        break;
      case CampaignVisibility.private:
        chipColor = Colors.orange;
        label = 'Private';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: chipColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
