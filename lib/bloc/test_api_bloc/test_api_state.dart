import 'package:broadway_bmi_cal/restful-api/api_test_model.dart';

abstract class TestApiState {}

class TestApiInitial extends TestApiState {}

class TestApiLoading extends TestApiState {}

class TestAPiError extends TestApiState {}

class Success extends TestApiState {
  List<TestApiResponse> data;
  Success(this.data);
}
