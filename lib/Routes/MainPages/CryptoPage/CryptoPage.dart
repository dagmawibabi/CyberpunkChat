import 'dart:math';
import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoCards.dart';
import 'package:socialmedia/Routes/MainPages/CryptoPage/CryptoServices.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

void main() {
  runApp(CryptoPage());
}

class CryptoPage extends StatefulWidget {
  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  bool isLoading = true;
  List cryptosPriceData = [];
  void getCryptoPrices() async {
    cryptosPriceData = [];
    CryptoServices cs = CryptoServices();
    await cs.getPrices();
    for (var i = 0; i < 100; i++) {
      cryptosPriceData.add(cs.allCryptoPriceDataList[i]);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCryptoPrices();
  }

  @override
  Widget build(BuildContext context) {
    void detailCryptoView(context, crypto) {
      void showCryptoIcon(context, crypto) {
        //Navigator.of(context).pop();
        Navigator.pushNamed(
          context,
          "cryptoIconViewer",
          arguments: {
            "name": crypto["name"],
            "image": crypto["image"],
          },
        );
      }

      showModalBottomSheet(
          backgroundColor: Colors.lightGreenAccent,
          barrierColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => showCryptoIcon(context, crypto),
                      child: Image.network(
                        crypto["image"],
                        width: 90.0,
                        height: 90.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.greenAccent,
                      ),
                      padding: EdgeInsets.all(10.0),
                      height: 360.0,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              CryptoDetailCard(
                                  title: "Name", value: crypto["name"]),
                              CryptoDetailCard(
                                  title: "Symbol", value: crypto["symbol"]),
                              CryptoDetailCard(
                                  title: "Current Price",
                                  value: crypto["current_price"].toString()),
                              CryptoDetailCard(
                                  title: "Market Cap Rank",
                                  value: crypto["market_cap_rank"].toString()),
                              CryptoDetailCard(
                                  title: "Market Cap",
                                  value: crypto["market_cap"].toString()),
                              CryptoDetailCard(
                                  title: "High (24hr)",
                                  value: crypto["high_24h"].toString()),
                              CryptoDetailCard(
                                  title: "Low (24hr)",
                                  value: crypto["low_24h"].toString()),
                              CryptoDetailCard(
                                  title: "Price Change (24hr)",
                                  value: crypto["price_change_24h"].toString()),
                              CryptoDetailCard(
                                  title: "Price Change (24hr)(%)",
                                  value: crypto["price_change_percentage_24h"]
                                      .toString()),
                              CryptoDetailCard(
                                  title: "Total Supply",
                                  value: crypto["total_supply"].toString()),
                              CryptoDetailCard(
                                  title: "Currency", value: "\$USD"),
                              CryptoDetailCard(
                                  title: "Last Updated",
                                  value: crypto["last_updated"].toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: DesignElements.scaffoldBG,
      appBar: AppBar(
        backgroundColor: DesignElements.appBarBG,
        automaticallyImplyLeading: false,
        title: Text(
          "CRYPTOCURRENCY",
          style: TextStyle(
            color: DesignElements.appBarTitle,
            fontSize: DesignElements.appBarTitleFontSize,
            fontFamily: DesignElements.mainFont,
            letterSpacing: DesignElements.appBarTitleLetterSpacing,
          ),
        ),
        actions: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: DesignElements.grey,
              ),
              onPressed: () {
                isLoading = true;
                setState(() {});
                getCryptoPrices();
              },
            ),
          ),
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: cryptosPriceData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    index == 0 ? SizedBox(height: 4.0) : Container(),
                    InkWell(
                      onTap: () =>
                          detailCryptoView(context, cryptosPriceData[index]),
                      child: CryptoCards(
                        cryptoImage: cryptosPriceData[index]["image"],
                        cryptoIconColor: Colors.red,
                        cryptoName: cryptosPriceData[index]["name"],
                        cryptoAbrv: cryptosPriceData[index]["symbol"],
                        cryptoPrice: cryptosPriceData[index]["current_price"],
                        cryptoMarketRate: cryptosPriceData[index]
                            ["price_change_percentage_24h"],
                      ),
                    ),
                    index == cryptosPriceData.length - 1
                        ? SizedBox(height: 100.0)
                        : Container(),
                  ],
                );
              },
            ),
    );
  }
}

class CryptoDetailCard extends StatelessWidget {
  const CryptoDetailCard({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Stack(
        children: [
          CustomPaint(
            painter: DentContainer(
              364.0,
              40.0,
              12.0,
              10.0,
              Colors.grey[850],
              PaintingStyle.fill,
            ),
          ),
          CustomPaint(
            painter: DentContainer(
              364.0,
              40.0,
              12.0,
              10.0,
              Colors.black,
              PaintingStyle.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontFamily: DesignElements.tirtiaryFont,
                  ),
                ),
                Text(
                  value.toString(),
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontFamily: DesignElements.secondaryFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
