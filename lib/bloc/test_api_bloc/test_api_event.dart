abstract class TestApiEvent {}

class GetAllData extends TestApiEvent {}

class AddData extends TestApiEvent {
  String name;
  int year;
  double price;
  String cpuModel;
  String hardDiskSize;
  AddData(this.name, this.year, this.price, this.cpuModel, this.hardDiskSize);
}

class UpdateData extends TestApiEvent {
  String id;
  String name;
  int year;
  double price;
  String cpuModel;
  String hardDiskSize;
  UpdateData(
    this.id,
    this.name,
    this.year,
    this.price,
    this.cpuModel,
    this.hardDiskSize,
  );
}

class DeleteData extends TestApiEvent {
  String id;
  DeleteData(this.id);
}
