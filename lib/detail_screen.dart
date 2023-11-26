import 'package:flutter/material.dart';
import 'package:wisata_bandung/model/tourism_place.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(   //Safe area agar tidak menabrak notch
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Image.asset(place.imageAsset!),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const FavoriteButton()
                          ],
                        ),
                      )
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),   //edge insets berarti margin ke semua sisi
                  child: Text(
                    place.name!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Staatliches',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(height: 8.0,),
                          Text(
                            place.openDays!,
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(height: 8.0,),
                          Text(
                            place.openTime!,
                            style: informationTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.monetization_on_rounded),
                          const SizedBox(height: 8.0,),
                          Text(
                            place.ticketPrice!,
                            style: informationTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    place.description!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: place.imageUrls!.map((url){
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(url,)
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
        )
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        },
    );
  }
}

