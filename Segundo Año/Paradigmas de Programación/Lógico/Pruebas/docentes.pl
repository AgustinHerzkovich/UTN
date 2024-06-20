viveEn(tefi, lanus).
viveEn(gise, lanus).
viveEn(alf, lanus).
viveEn(dodain, liniers).
docente(alf).
docente(tefi).
docente(gise).
docente(dodain).

afortunadoConjuncion(Persona):-docente(Persona), viveEn(Persona, lanus).

afortunadoDisyuncion(Persona):-docente(Persona).
afortunadoDisyuncion(Persona):-viveEn(Persona, lanus).