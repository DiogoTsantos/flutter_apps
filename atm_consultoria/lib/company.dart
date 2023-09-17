import 'package:atm_consultoria/template_screen.dart';
import 'package:flutter/material.dart';

class Company extends StatelessWidget {
  const Company({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      screen: 'empresa',
      label: 'Empresa',
      labelColor: Colors.orange,
      child: const Text('orem ipsum dolor sit amet, consectetur adipiscing elit. Donec dignissim quis felis ut dapibus. Nullam id nisl a ex rutrum efficitur eget ut lectus. Quisque nec lacinia ante. Duis eu dapibus nisi, sed gravida ante. Cras imperdiet dui at metus vulputate, sit amet lobortis tortor finibus. Sed fringilla aliquet lacus, nec iaculis metus cursus a. Cras felis ipsum, euismod vitae risus id, vehicula efficitur dui. Vestibulum finibus mi gravida erat molestie, a egestas felis porttitor. Maecenas suscipit, massa eget pulvinar ultrices, nunc sem congue felis, a sollicitudin lacus nulla at eros. Etiam neque sapien, molestie vel ultrices id, elementum at nunc. Cras ornare ipsum eget libero posuere porttitor. Praesent dignissim purus in est efficitur, eget semper odio blandit. Etiam nulla augue, faucibus non rhoncus sed, tincidunt in turpis. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.')
    );
  }
}