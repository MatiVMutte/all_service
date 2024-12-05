import 'package:all_service/presentation/providers/auth/login_provider.dart';
import 'package:all_service/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends ConsumerWidget {
  static double bordeRedondeado = 75;

  const LogInScreen({
    super.key,
  });

  AppBar appBar(WidgetRef ref, bool modoClaro, BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)
        ),
        actions: [
          IconButton(
            onPressed: (){
              ref.watch( providerBrightness.notifier ).state = !modoClaro;
            },
            icon: Icon( 
              (ref.watch( providerBrightness )) ? Icons.wb_sunny : Icons.nightlight_sharp,
              color: (ref.watch( providerBrightness )) ? Colors.yellow[700] : Colors.white,
            )
          )
        ],
      );
  }
  Padding titulo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome,",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w200))),
            Text("Log In!",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
  Container logIn(Size size, ColorScheme theme, double bordeRedondeado) {
    return Container(
      // width: size.width,
      // height: size.height,
      decoration: BoxDecoration(
          color: theme.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bordeRedondeado),
              topRight: Radius.circular(bordeRedondeado)),
          boxShadow: (theme.brightness == Brightness.light)
              ? const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black54,
                  ),
                ]
              : []),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(child: _FormLogIn()),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    bool modoClaro = ref.watch( providerBrightness );

    return Scaffold(
      backgroundColor: (modoClaro) ? Colors.blue.shade500 : Colors.blue.shade900.withAlpha(200),
        appBar: appBar(ref, modoClaro, context),
        body: SizedBox(
          height: double.infinity,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* Titulo
              titulo(),

              SizedBox(height: size.height * 0.1),

              //* LogIn
              Expanded(child: logIn(size, theme, bordeRedondeado)),
            ],
          ),
        ));
  }
}

class _FormLogIn extends ConsumerWidget {
  _FormLogIn();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 65),
        //* Email - Campo
        TextFormField(
          controller: emailController,
          decoration: inputDecoration(
              "Ingrese su email", Icons.email_outlined, context),
        ),
        const SizedBox(height: 20),
        //* Contraseña - Campo
        TextFormField(
          controller: contrasenaController,
          decoration: inputDecoration(
              "Ingrese su contraseña", Icons.remove_red_eye_outlined, context),
        ),
        const SizedBox(height: 10),
        //* Olvidar la contraseña - Boton
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {},
              child: Text("Olvidaste la contraseña?",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          decorationColor: theme.primary,
                          decoration: TextDecoration.underline)))),
        ),
        const SizedBox(height: 20),
        //* Loguear - Boton
        FilledButton(
            onPressed: () {
              final provider = ref.read( providerLogin.notifier );

              provider.iniciarSesion(emailController.text, contrasenaController.text);

              if( ref.read( providerLogin ) ) {
                print("Correcto");
              }
            },
            style: ButtonStyle(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 50)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            child: Text("Iniciar Sesión",
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(fontSize: 20)))),
        const SizedBox(height: 30),
        //* O
        Text(
          "O",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: theme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 20)),
        ),
        const SizedBox(height: 30),
        //* Otras formas para iniciar sesion
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.supervised_user_circle, size: 45, color: theme.primary),
            const SizedBox(width: 20),
            Icon(Icons.supervised_user_circle, size: 45, color: theme.primary),
            const SizedBox(width: 20),
            Icon(Icons.supervised_user_circle, size: 45, color: theme.primary),
          ],
        )
      ],
    );
  }

  InputDecoration inputDecoration(
      String label, IconData icono, BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return InputDecoration(
      alignLabelWithHint: false,
      // labelText: label,
      label: Text(label),
      hintFadeDuration: const Duration(milliseconds: 250),
      prefixIcon: Icon(icono, color: theme.primary),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.primary)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.primary)),
    );
  }
}
