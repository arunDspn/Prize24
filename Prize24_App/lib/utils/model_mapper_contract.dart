abstract class ModelMapperContract<DomainModel, DtoModel> {
  DomainModel fromDto(DtoModel dto);
  DtoModel toDto(DomainModel domainModel);
}

abstract class ModelMapper<DomainModel, DtoModel>
    implements ModelMapperContract<DomainModel, DtoModel> {
  @override
  DomainModel fromDto(DtoModel dto);

  @override
  DtoModel toDto(DomainModel domainModel);
}

abstract class ModelMapperWithId<DomainModel, DtoModel>
    implements ModelMapperContract<DomainModel, DtoModel> {
  @override
  DomainModel fromDto(DtoModel dto);

  @override
  DtoModel toDto(DomainModel domainModel);

  String getId(DomainModel domainModel);
}
