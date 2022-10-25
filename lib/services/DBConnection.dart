import 'package:postgres/postgres.dart';

class DBConnection {
  final connection = PostgreSQLConnection(
    'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
    5432,
    'proyecto_gpi',
    username: 'kevin_eli',
    password: 'GPIProj3ct.',
  );
}
