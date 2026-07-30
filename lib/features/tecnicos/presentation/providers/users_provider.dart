import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/providers/core_dependencies.dart';
import 'package:reparaciones_moka/features/tecnicos/domain/entities/user.dart';

class UsersState {
  final List<User> users;
  final bool isLoading;
  final String? error;

  const UsersState({this.users = const [], this.isLoading = false, this.error});

  UsersState copyWiht({List<User>? users, bool? isLoading, String? error}) {
    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UsersNotifier extends Notifier<UsersState> {
  @override
  UsersState build() {
    return const UsersState();
  }

  Future<void> loadUsers() async {
    try{
      state = state.copyWiht(
        isLoading: true,
        error: null
      );

      final useCase = ref.read(getUsersUseCaseProvider);

      final users = await useCase.execute();

      state = state.copyWiht(
        users: users,
        isLoading: false,
      );
    }catch(e){
      state = state.copyWiht(
        isLoading: false,
        error: e.toString()
      );
    }
  }
}

final usersProvider = NotifierProvider<UsersNotifier, UsersState>(
  UsersNotifier.new,
);
