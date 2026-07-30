import 'package:dio/dio.dart';
import 'package:reparaciones_moka/features/tecnicos/data/models/user_model.dart';
import 'package:reparaciones_moka/features/tecnicos/domain/entities/user.dart';

class UsersService {
  final Dio dio;

  UsersService(this.dio);

  Future<List<User>> getAll()async{
    final response = await dio.get('/users/');
    return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
  }
}