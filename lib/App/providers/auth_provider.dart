import 'package:civic_reporter/App/data/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider.autoDispose((ref) => AuthRepository());
