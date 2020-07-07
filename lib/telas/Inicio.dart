import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String pesquisa;
  Inicio(this.pesquisa);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa){

    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  void initState() {
    super.initState();
    print("chamado 1 - initState");

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 - didChange");
  }

  @override
  void didUpdateWidget(Inicio oldWidget) {
    print("chamado 2 - didUpDate");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    print("chamado 4 - Dispose");

  }

  @override
  Widget build(BuildContext context) {
    print("chamado 3 - buld");

    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.pesquisa),
        // ignore: missing_return
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.hasData){
                
                return ListView.separated(
                    itemBuilder: (context, index){
                      List<Video> videos = snapshot.data;
                      Video video = videos[index];
                      return GestureDetector(
                        onTap: (){
                          FlutterYoutube.playYoutubeVideoById(
                              apiKey: CHAVE_YOUTUBE_API,
                              videoId: video.id,
                            autoPlay: true,
                            fullScreen: true,
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(video.imagem)
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(video.titulo),
                              subtitle: Text(video.canal),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    itemCount: snapshot.data.length
                );
                
              }else{
                    return Center(
                      child: Text("Nenhu dado a ser exibido"),
                    );
              }
              break;
            }
        },
    );
  }
}
