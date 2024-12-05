import 'package:all_service/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (){
              ref.watch( providerBrightness.notifier ).state = !ref.watch( providerBrightness.notifier ).state;
            },
            icon: Icon( 
              (ref.watch( providerBrightness )) ? Icons.wb_sunny : Icons.nightlight_sharp,
              color: (ref.watch( providerBrightness )) ? Colors.yellow[700] : Colors.white,
            )
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Foto de presentación de la app
              SizedBox(
                width: size.width,
                height: size.height * 0.45,
                child: const RiveAnimation.asset(
                  'assets/rive/animation.riv',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox( height: 30 ),
              //* Saludo.
              Text(
                "¡Hola!",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  )
                ),
              ),
              //* Indicaciones
              Text(
                "Crea una cuenta y si ya tenes una, creala",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    letterSpacing: 0
                  )
                ),
              ),
              const SizedBox( height: 15 ),
              //* Iniciar Sesión - Boton
              FilledButton(
                onPressed: (){
                  context.push('/login');
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 50))
                ),
                child: Text("Iniciar Sesión", style: GoogleFonts.lato(
                  textStyle: const TextStyle( fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 2 )
                ),)
              ),
              const SizedBox( height: 40 ),
              //* Registrarse - Boton
              FilledButton(
                onPressed: (){
                  context.push('/register');
                },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: theme.primary))),
                  minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 50))
                ),
                child: Text("Registrate", style: GoogleFonts.lato(
                  textStyle: TextStyle( fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 2, color: theme.primary )
                ),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}