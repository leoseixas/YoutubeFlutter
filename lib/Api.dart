import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyC2vzZ_WpUOt8jdgZ9KZQKk_a2E_W7GwzU";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api{

  Future<List<Video>> pesquisar(String pesquisa)async {
    http.Response response = await http.get(
        URL_BASE + "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"
    );

    if (response.statusCode == 200) {

      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList( );

      return videos;

      /*for(var video in dadosJson["items"]){
        print("Resultado: " + video.toString());
      }*/

      //print("resultado: " + dadosJson["items"].toString());

    }else{

    }
  }
}
