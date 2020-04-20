

import 'quote.dart';
import 'quote_card.dart';
import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
        home: QuoteList(),
    )
);

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  List<Quote> quotes = [
    Quote(text: 'Be yourself; everyone is already taken', author: 'awis'),
    Quote(text: 'I have nothing to declare except my genuies', author: 'awis'),
    Quote(text: 'The trutch is rarely pure and never simple', author: 'awis')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Waktu Solat Evo"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: quotes.map((quote) => QuoteCard(
            quote: quote,
            delete: () {
              setState(() {
                quotes.remove(quote);
              });
            }
        )).toList(),
      ),
    );
  }
}


