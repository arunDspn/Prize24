import 'package:equatable/equatable.dart';

class PricePoolModel extends Equatable {
  const PricePoolModel({
    required this.prizeName,
    required this.prizeDescription,
  });

  final String prizeName;
  final String prizeDescription;

  @override
  List<Object?> get props => [prizeName, prizeDescription];
}
