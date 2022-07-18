import 'package:flutter/material.dart';

class Bnavigator extends StatefulWidget {
  const Bnavigator({Key? key}) : super(key: key);

  @override
  State<Bnavigator> createState() => _BnavigatorState();
}

class _BnavigatorState extends State<Bnavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.lightBlue,
      iconSize: 40.0,
      selectedFontSize: 19.0,
      unselectedFontSize: 15.0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.report_gmailerrorred), label: 'Reporte'),
        BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined), label: 'Edúcate'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Configuraciones'),
      ],
    );
  }
}
