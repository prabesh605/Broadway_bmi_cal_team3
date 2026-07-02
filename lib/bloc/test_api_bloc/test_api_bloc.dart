import 'package:broadway_bmi_cal/bloc/test_api_bloc/test_api_event.dart';
import 'package:broadway_bmi_cal/bloc/test_api_bloc/test_api_state.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';
import 'package:broadway_bmi_cal/restful-api/api_test_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestApiBloc extends Bloc<TestApiEvent, TestApiState> {
  ApiTestServices apiTestServices = ApiTestServices();
  List<TestApiResponse> data = [];
  TestApiBloc() : super(TestApiInitial()) {
    on<GetAllData>((event, emit) async {
      emit(TestApiLoading());
      data = await apiTestServices.getAllData();
      emit(Success(data));
    });
    on<AddData>((event, emit) async {
      emit(TestApiLoading());
      bool result = await apiTestServices.addData(
        event.name,
        event.year,
        event.price,
        event.cpuModel,
        event.hardDiskSize,
      );
      if (result) {
        data = await apiTestServices.getAllData();
        emit(Success(data));
      } else {
        emit(TestAPiError());
      }
    });
    on<UpdateData>((event, emit) async {
      emit(TestApiLoading());
      bool result = await apiTestServices.updateDataApi(
        event.id,
        event.name,
        event.year,
        event.price,
        event.cpuModel,
        event.hardDiskSize,
      );
      if (result) {
        data = await apiTestServices.getAllData();
        emit(Success(data));
      } else {
        emit(TestAPiError());
      }
    });
    on<DeleteData>((event, emit) async {
      emit(TestApiLoading());
      await apiTestServices.deleteData(event.id);
      data = await apiTestServices.getAllData();
      emit(Success(data));
    });
  }
}
