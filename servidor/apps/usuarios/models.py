from django.db import models

class Usuario(models.Model):
    nombre = models.CharField(max_length=50)
    apellido = models.CharField(max_length=50)
    email = models.EmailField()
    telefono = models.CharField(max_length=15)
    fecha_nacimiento = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.nombre

class Tecnico(Usuario):
    especialidad = models.CharField(max_length=100)
    experiencia = models.IntegerField()

class Cliente(Usuario):
    direccion = models.CharField(max_length=255)