import 'dart:convert';

import 'package:countryapi/model/country.dart';
import 'package:countryapi/screens/detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  Future<List<Country>> getDataList() async {
    const url = 'https://countriesnow.space/api/v0.1/countries/flag/images';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      var jsonArray = jsonData['data'];
      List<Country> countries = [];
      for (var countryArray in jsonArray) {
        Country country = Country.fromMap(countryArray);
        countries.add(country);
      }

      return countries;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text('country List Screen'),
        ),
        body: FutureBuilder<List<Country>>(
          future: getDataList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<Country> countries = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    Country country = countries[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return DetailScreen(index: index,country: country,);
                          },));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.deepPurple,
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                flex: 3,
                                child: Container(
                                    width: 400,
                                    height: 100,
                                    margin: const EdgeInsets.all(15),
                                    child: SvgPicture.network(
                                      country.flag,
                                      fit: BoxFit.cover,
                                      placeholderBuilder: (context) {
                                        if (index == 0) {
                                          return Image.network(
                                              'https://preview.redd.it/gnf3ubv5yph71.png?width=960&crop=smart&auto=webp&s=4028116a74de3f87b093c2e0d9452054d8653602');
                                        } else if (index == 7) {
                                          return Image.network(
                                              'https://cdn.britannica.com/69/5869-004-7D75CD05/Flag-Argentina.jpg');
                                        } else if (index == 17) {
                                          return Image.network(
                                              'https://cdn.britannica.com/01/6401-004-FAEACB4E/Flag-Belarus.jpg');
                                        } else if (index == 26) {
                                          return Image.network(
                                              'https://cdn.britannica.com/47/6847-004-7D668BB0/Flag-Brazil.jpg');
                                        } else if (index == 54) {
                                          return Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_the_Dominican_Republic.svg/255px-Flag_of_the_Dominican_Republic.svg.png');
                                        } else if (index == 63) {
                                          return Image.network(
                                              'https://www.flagsonline.it/uploads/2016-6-6/420-272/finland.jpg');
                                        } else if (index == 94) {
                                          return Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Flag_of_Iran.svg/255px-Flag_of_Iran.svg.png');
                                        } else if (index == 117) {
                                          return Image.network(
                                              'https://ak.picdn.net/shutterstock/videos/6453824/thumb/1.jpg');
                                        } else if (index == 139) {
                                          return Image.network(
                                              'https://previews.123rf.com/images/fckncg/fckncg1704/fckncg170401536/76765254-ge%C3%AFsoleerde-nepal-vlag-golven-op-witte-achtergrond-hoge-resolutie.jpg');
                                        } else if (index == 183) {
                                          return Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/400px-Flag_of_South_Africa.svg.png');
                                        } else if (index == 184) {
                                          return Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Flag_of_South_Georgia_and_the_South_Sandwich_Islands.svg/255px-Flag_of_South_Georgia_and_the_South_Sandwich_Islands.svg.png');
                                        } else if (index == 186) {
                                          return Image.network(
                                              'https://t3.ftcdn.net/jpg/00/11/33/92/360_F_11339263_w1h64PjSWJOLjnijaohR8rrGTB38o4Rb.webp');
                                        } else if (index == 204) {
                                          return Image.network(
                                              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Flag_of_the_Governor_of_the_Turks_and_Caicos_Islands.svg/800px-Flag_of_the_Governor_of_the_Turks_and_Caicos_Islands.svg.png');
                                        } else {
                                          return const Center(
                                              child: CircularProgressIndicator());
                                        }
                                      },
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    country.name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
