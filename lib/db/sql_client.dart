// ignore_for_file: public_member_api_docs

import 'package:mysql_client/mysql_client.dart';

class SqlClient {
  factory SqlClient() {
    return _inst;
  }

  SqlClient._internal() {
    _connect();
  }

  static final SqlClient _inst = SqlClient._internal();

  MySQLConnection? _connection;

  Future<void> _connect() async {
    _connection = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'root',
      databaseName: 'nestworld',
      password: 'root',
      secure: false,
    );

    
      await _connection?.connect(
        timeoutMs: 1000,
      );
   
  }

  Future<IResultSet> execute(
    String query, {
    Map<String, dynamic>? params,
    bool iterable = false,
  }) async {
    if (_connection == null || _connection?.connected == false) {
      await _connect();
    }

    if (_connection?.connected == false) {
      throw Exception('Could not connect to the database');
    }
    return _connection!.execute(query, params, iterable);
  }
}
