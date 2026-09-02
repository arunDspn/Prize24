import 'package:prize24_app/features/authentication/data/dto/app_user_dto.dart';
import 'package:prize24_app/features/authentication/domain/model/app_user.dart';
import 'package:prize24_app/utils/model_mapper_contract.dart';

// class AuthModelMapper implements ModelMapperContract<AppUser, AppUserDto> {
//   @override
//   AppUser fromDto(AppUserDto dto) {
//     if (dto is GuestUserDto) {
//       return GuestUser();
//     } else if (dto is AuthenticatedUserDto) {
//       return AuthenticatedUser(
//         userId: dto.userId,
//         userEmail: dto.userEmail,
//         userName: dto.userName,
//         userAvatar: dto.userAvatar ?? '',
//         isVendor: dto.isVendor,
//       );
//     } else {
//       throw Exception('Unknown AppUserDto type');
//     }
//   }

//   @override
//   AppUserDto toDto(AppUser domainModel) {
//     if (domainModel is GuestUser) {
//       return GuestUserDto();
//     } else if (domainModel is AuthenticatedUser) {
//       return AuthenticatedUserDto(
//         userId: domainModel.userId,
//         userEmail: domainModel.userEmail,
//         userName: domainModel.userName,
//         userAvatar: domainModel.userAvatar,
//         isVendor: domainModel.isVendor,
//       );
//     } else {
//       throw Exception('Unknown AppUser type');
//     }
//   }
// }
