import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/market_price.dart';

class MarketPricesScreen extends StatefulWidget {
  final String state;
  final String crop;
  final String raw_crop;

  const MarketPricesScreen({
    Key? key,
    required this.state,
    required this.crop,
    required this.raw_crop,
  }) : super(key: key);

  @override
  State<MarketPricesScreen> createState() => _MarketPricesScreenState();
}

class _MarketPricesScreenState extends State<MarketPricesScreen> {
  List<MarketPrice> prices = [];
  bool isLoading = true;
  String? selectedDistrict;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchPrices();
  }

  Future<void> fetchPrices() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final url = 'https://real-time-market-prices-production.up.railway.app/'
          '${widget.state.toLowerCase()}/${widget.crop.toLowerCase()}';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          prices = data.map((json) => MarketPrice.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load prices');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'ధరల సమాచారం లోడ్ చేయడంలో లోపం';
      });
    }
  }

  List<String> getUniqueDistricts() {
    return prices.map((e) => e.district).toSet().toList()..sort();
  }

  List<MarketPrice> getFilteredPrices() {
    if (selectedDistrict == null) return prices;
    return prices.where((price) => price.district == selectedDistrict).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ప్రస్తుత ${widget.raw_crop} మార్కెట్ ధరలు',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,)

        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchPrices,
          ),
        ],
      ),
      body: Column(
        children: [
          if (!isLoading && errorMessage.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.green[50],
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text('జిల్లాను ఎంచుకోండి'),
                value: selectedDistrict,
                items: [null, ...getUniqueDistricts()].map((String? district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district ?? 'అన్ని జిల్లాలు'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDistrict = newValue;
                  });
                },
              ),
            ),
          ],
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchPrices,
              child: Text('మళ్ళీ ప్రయత్నించండి'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      );
    }

    final filteredPrices = getFilteredPrices();
    if (filteredPrices.isEmpty) {
      return Center(
        child: Text('ధరలు అందుబాటులో లేవు'),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchPrices,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        itemCount: filteredPrices.length,
        itemBuilder: (context, index) {
          return MarketPriceCard(price: filteredPrices[index]);
        },
      ),
    );
  }
}

class MarketPriceCard extends StatelessWidget {
  final MarketPrice price;

  const MarketPriceCard({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    price.market,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
                Text(
                  price.district,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (price.variety.isNotEmpty)
              Text(
                'రకం: ${price.variety}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PriceColumn(
                  label: 'కనిష్ట ధర',
                  price: price.minPrice,
                  color: Colors.orange,
                ),
                PriceColumn(
                  label: 'సగటు ధర',
                  price: price.avgPrice,
                  color: Colors.green,
                ),
                PriceColumn(
                  label: 'గరిష్ట ధర',
                  price: price.maxPrice,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PriceColumn extends StatelessWidget {
  final String label;
  final String price;
  final Color color;

  const PriceColumn({
    Key? key,
    required this.label,
    required this.price,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.currency_rupee, color: color, size: 16),
            Text(
              price.replaceAll(RegExp(r'[^\d.,]'), ''),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


