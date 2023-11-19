import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/api_constants.dart';
import '../failure.dart';
import '../type_defs.dart';

// dio
final dioProvider = Provider((ref) => Dio());

// provider for api
final apiProvider = Provider((ref) => APIProvider(dio: ref.read(dioProvider)));

class APIProvider {
  final Dio _dio;
  APIProvider({required Dio dio}) : _dio = dio;

  // generating comic panel from input query
  FutureEither<Uint8List> generatePanel(
      String query, bool isDashtoonAPI) async {
    try {
      Uint8List uint8;
      if (isDashtoonAPI) {
        final res = await _dio.post(
          APIConstants.urlAPI,
          data: jsonEncode(<String, String>{
            'inputs': query,
          }),
          options: Options(
            responseType: ResponseType.bytes,
            receiveTimeout: const Duration(minutes: 10),
            headers: {
              'Accept': 'image/png',
              'Authorization': 'Bearer ${APIConstants.keyAPI}',
            },
            contentType: 'application/json',
          ),
        );
        uint8 = Uint8List.fromList(res.data);
      } else {
        // temporary huggingface api
        final res = await _dio.post(
          "https://api-inference.huggingface.co/models/ogkalu/Comic-Diffusion",
          data: jsonEncode(<String, String>{
            'inputs': query,
          }),
          options: Options(
            headers: {
              'Authorization': 'Bearer ***',
            },
            contentType: 'application/json',
            responseType: ResponseType.bytes,
          ),
        );
        uint8 = Uint8List.fromList(res.data);
      }
      return right(uint8);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
