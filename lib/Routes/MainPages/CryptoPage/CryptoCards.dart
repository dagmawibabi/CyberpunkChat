import 'package:flutter/material.dart';
import 'package:socialmedia/Routes/UIElements/DentContainer.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class CryptoCards extends StatelessWidget {
  const CryptoCards({
    Key key,
    @required this.cryptoImage,
    @required this.cryptoIconColor,
    @required this.cryptoName,
    @required this.cryptoAbrv,
    @required this.cryptoPrice,
    @required this.cryptoMarketRate,
  }) : super(key: key);

  final String cryptoImage;
  final Color cryptoIconColor;
  final String cryptoName;
  final String cryptoAbrv;
  final dynamic cryptoPrice;
  final dynamic cryptoMarketRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Stack(
        children: [
          CustomPaint(
            painter: DentContainer(
              394.0,
              70.0,
              12.0,
              10.0,
              Colors.grey[300],
              PaintingStyle.fill,
            ),
          ),
          CustomPaint(
            painter: DentContainer(
              394.0,
              70.0,
              12.0,
              10.0,
              Colors.black,
              PaintingStyle.stroke,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Image.network(
                        cryptoImage,
                        width: 40.0,
                        height: 40.0,
                      ),
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180.0,
                            child: Text(
                              cryptoName.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: DesignElements.tirtiaryFont,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            cryptoAbrv.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                              fontFamily: DesignElements.tirtiaryFont,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        cryptoPrice.toString() + "\$",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: DesignElements.secondaryFont,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        cryptoMarketRate.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: DesignElements.secondaryFont,
                          color:
                              cryptoMarketRate.toString().substring(0, 1) == "-"
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                    ],
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
