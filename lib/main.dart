import 'package:flutter/material.dart';
import 'package:icon_showcase_animation_part/color_palette.dart';
import 'package:icon_showcase_animation_part/fade_page_route.dart';
import 'package:icon_showcase_animation_part/icon_data.dart';
import 'package:icon_showcase_animation_part/detail_page.dart';
import 'package:icon_showcase_animation_part/title_hero_flight.dart';
import 'package:icon_showcase_animation_part/view_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icon Showcase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Icon Showcase'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.grey90,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            widget.title,
            style: TextStyle(color: ColorPalette.grey10),
          ),
          leading: IconButton(
            icon: Hero(
              tag: 'menuarrow',
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                progress: _animationController,
                color: ColorPalette.grey10,
              ),
            ),
            onPressed: () {},
          ),
        ),
        body: ListView.builder(
          itemCount: iconList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              _animationController.forward(from: 0.0);
              bool returnVal =
                  await Navigator.of(context).push(FadePageRoute(
                      builder: (context) => DetailPage(
                            iconData: iconList[index],
                          )));
              if (returnVal) {
                _animationController.reverse(from: 1.0);
              }
            },
            child: Stack(children: <Widget>[
              Hero(
                tag: iconList[index].title,
                child: Card(
                    color: ColorPalette.grey10,
                    margin: EdgeInsets.all(10),
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ListTile(
                        leading: Icon(
                          iconList[index].icon,
                          size: 45.0,
                          color: Colors.transparent,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: ListTile(
                    title: Hero(
                      tag: 'title${iconList[index].title}',
                      flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                      ) {
                        return DestinationTitle(
                          viewState: flightDirection == HeroFlightDirection.push
                              ? ViewState.enlarge
                              : ViewState.shrink,
                          smallFontSize: 20.0,
                          largeFontSize: 60.0,
                          title: iconList[index].title,
                          isOverflow: true,
                        );
                      },
                      child: DestinationTitle(
                        title: iconList[index].title,
                        color: Colors.black87,
                        viewState: ViewState.shrunk,
                        smallFontSize: 20.0,
                        largeFontSize: 60.0,
                      ),
                    ),
                    leading: Hero(
                      tag: 'icon${iconList[index].title}',
                      child: Icon(
                        iconList[index].icon,
                        size: 45.0,
                        color: ColorPalette.grey60,
                      ),
                    )),
              ),
            ]),
          ),
        ));
  }
}
