import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio_app/app/components/background_image_builder_ui.dart';
import 'package:portfolio_app/app/routes/app_routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver, RouteAware {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animations = List.generate(6, (index) {
      return Tween<Offset>(
        begin: const Offset(-1.5, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.12,
            0.12 + index * 0.12,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeObserver = Get.find<RouteObserver<PageRoute>>();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    final routeObserver = Get.find<RouteObserver<PageRoute>>();
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundImageBuilder(
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: SlideTransition(
                      position: _animations[0],
                      child: _buildProfileImage(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: _animations[1],
                          child: _buildText("LUIZ EDUARDO POZZA", 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: _animations[2],
                          child: _buildText("Desenvolvedor Mobile", 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SlideTransition(
                    position: _animations[2],
                    child: _buildButton("Currículo", () async {
                      await Get.toNamed(AppRoutes.CURRICULO);
                      setState(() {});
                    }),
                  ),
                  SizedBox(height: 3),
                  SlideTransition(
                    position: _animations[3],
                    child: _buildButton("Projetos", () async {
                      await Get.toNamed(AppRoutes.PROJETOS);
                      setState(() {});
                    }),
                  ),
                  SizedBox(height: 3),
                  SlideTransition(
                    position: _animations[4],
                    child: _buildButton("GitHub", () async {
                      await Get.toNamed(AppRoutes.GITHUB);
                      setState(() {});
                    }),
                  ),
                  SizedBox(height: 3),
                  SlideTransition(
                    position: _animations[5],
                    child: _buildButton("Orçamentos", () async {
                      await Get.toNamed(AppRoutes.ORCAMENTOS);
                      setState(() {});
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2,
                      ),
                      left: BorderSide(color: Colors.lightBlueAccent, width: 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu_book_rounded),
                        onPressed: () {},
                        iconSize: 30,
                        color: Colors.white,
                        splashColor: Colors.blueAccent,
                        highlightColor: Colors.lightBlueAccent,
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.whatsapp),
                        onPressed: () {},
                        iconSize: 30,
                        color: Colors.white,
                        splashColor: Colors.blueAccent,
                        highlightColor: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2,
                        ),
                        right: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () {},
                          iconSize: 30,
                          color: Colors.white,
                          splashColor: Colors.blueAccent,
                          highlightColor: Colors.lightBlueAccent,
                        ),

                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.linkedinIn),
                          onPressed: () {},
                          iconSize: 30,
                          color: Colors.white,
                          splashColor: Colors.blueAccent,
                          highlightColor: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      maxRadius: 80,
      minRadius: 80,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, style: BorderStyle.none),
        ),
        child: Image.asset('assets/images/perfil1.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildText(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.white, fontSize: fontSize)),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback? onPressed) {
    return SizedBox(
      width: 180,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.lightBlueAccent,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
