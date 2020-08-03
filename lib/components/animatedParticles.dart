import 'dart:math';

import 'package:flame/particle.dart';
import 'package:flame/particles/accelerated_particle.dart';
import 'package:flame/particles/circle_particle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Random rnd = Random();
Particle acceleratedParticles() {
  return Particle.generate(
    count: 10,
    generator: (i) => AcceleratedParticle(
      speed: Offset(rnd.nextDouble() * 600 - 300, -rnd.nextDouble() * 600) * .2,
      acceleration: const Offset(0, 500),
      child: CircleParticle(
        radius: rnd.nextInt(6) * 1.0,
        paint: Paint()..color = Colors.yellow,
      ),
    ),
  );
}
