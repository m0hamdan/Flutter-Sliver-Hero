import 'package:flutter/material.dart';

import 'orderitem.dart';

var id;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  final List<OrderItem> _items = <OrderItem>[
    new OrderItem(1, 'Mixed Grill', 'Platter', 1, 30.0, 'mixedgrill.jpg'),
    new OrderItem(
        2, 'Grilled Chicken', 'Sandwich', 2, 10.0, 'chickensandwich.jpg'),
    new OrderItem(3, 'Fresh Orange Juice', 'Drink', 3, 8.0, 'orangejuice.jpg'),
    new OrderItem(4, 'Fresh Apple Juice', 'Drink', 1, 8.0, 'applejuice.jpg'),
  ];

  static final TextStyle _boldStyle =
      new TextStyle(fontWeight: FontWeight.bold);
  static final TextStyle _greyStyle = new TextStyle(color: Colors.grey);

  final ddlValues = <int>[1, 2, 3, 4];
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new CustomScrollView(
        scrollDirection: Axis.vertical, 
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,  
            flexibleSpace: new FlexibleSpaceBar( 
              title: const Text("Order Summary"), 
              background: new Image.asset("images/restaurant.jpg",
                  fit: BoxFit.cover),
            ),
          ),
          new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              sliver: new SliverFixedExtentList(
                itemExtent: 172.0,
                delegate: new SliverChildBuilderDelegate(
                    (builder, index) => _buildListItem(_items[index]),
                    childCount: _items.length),
              )),
          new SliverToBoxAdapter(
              child: new Container(
            alignment: Alignment.center,
            height: 50.0,
            color: const Color(0xffe04d25),
            child: new InkWell(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Check out',
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Hero(
                      tag: "basket",
                      child: new Icon(
                        Icons.shopping_basket,
                        color: Colors.black,
                        size: 24.0,
                      ))
                ],
              ),
              onTap: () {},
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildListItem(OrderItem itm) {
    return new Card(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            child: _buildColumn1(itm),
            flex: 1,
          ),
          new Flexible(child: _buildColumn2(itm), flex: 3),
        ],
      ),
    );
  }

  Widget _buildColumn1(OrderItem itm) {
    return new Column(
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
            child: new InkWell(
              child: new Hero(
                child: new Image.asset(
                  'images/${itm.icon}',
                  width: 100.0,
                  height: 100.0,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
                tag: itm.id,
              ),
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return new Material(
                          color: Colors.black38,
                          child: new Container(
                            padding: const EdgeInsets.all(30.0),
                            child: new InkWell(
                              child: new Hero(
                                child: new Image.asset(
                                  'images/${itm.icon}',
                                  width: 300.0,
                                  height: 300.0,
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                ),
                                tag: itm.id,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                    }));
              },
            ))
      ],
    );
  }

  Widget _buildColumn2(OrderItem itm) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: new Text(
            itm.item,
            style: _boldStyle,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Text(itm.category),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                "Quantity",
                style: _greyStyle,
              ),
              new SizedBox(
                width: 20.0,
              ),
              new DropdownButton<int>(
                items: ddlValues.map((f) {
                  return new DropdownMenuItem<int>(
                    value: f,
                    child: new Text(f.toString()),
                  );
                }).toList(),
                value: itm.qty,
                onChanged: (int newVal) {
                  itm.qty = newVal;
                  this.setState(() {});
                },
              )
            ],
          ),
        ),
        _buildBottomRow(itm.price, itm.qty),
      ],
    );
  }

  Widget _buildBottomRow(double itemPrice, int qty) {
    return new Container(
        margin: const EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              flex: 1,
              child: new Text(
                "Item Price",
                style: _greyStyle,
              ),
            ),
            //  new SizedBox(width: 5.0,),
            new Flexible(
                flex: 1,
                child: new Text(
                  itemPrice.toStringAsPrecision(2),
                  style: _boldStyle,
                )),
            // new SizedBox(width: 10.0,),
            new Flexible(
              flex: 1,
              child: new Text(
                "Total",
                style: _greyStyle,
              ),
            ),
            new SizedBox(
              width: 5.0,
            ),
            new Flexible(
                flex: 1,
                child: new Text(
                  (qty * itemPrice).toString(),
                  style: _boldStyle,
                ))
          ],
        ));
  }
}
