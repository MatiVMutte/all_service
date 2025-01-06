from django.contrib.auth.models import AbstractUser, Group
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver

class Usuario(AbstractUser):
    foto_perfil = models.ImageField(default='usuarios/usuario_defecto.jpg', upload_to='usuarios/', verbose_name='Foto de perfil')
    nombre = models.CharField(max_length=50)
    apellido = models.CharField(max_length=50)
    email = models.EmailField()
    telefono = models.CharField(max_length=15)
    fecha_nacimiento = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    groups = models.ManyToManyField(
        "auth.Group",
        related_name="usuarios",
        blank=True
    )
    
    user_permissions = models.ManyToManyField(
        "auth.Permission",
        related_name="usuarios_permisos",
        blank=True
    )

    class Meta:
        verbose_name = 'Usuario'
        verbose_name_plural = 'Usuarios'
        ordering = ['created_at']

    def __str__(self):
        return f"{self.nombre} {self.apellido}"

class Tecnico(models.Model):
    usuario = models.OneToOneField(Usuario, on_delete=models.CASCADE)
    # Otros campos específicos para el técnico

class Cliente(models.Model):
    usuario = models.OneToOneField(Usuario, on_delete=models.CASCADE)
    # Otros campos específicos para el cliente

# Señal para asignar un grupo automáticamente al usuario creado
@receiver(post_save, sender=Usuario)
def created_user(sender, instance, created, **kwargs):
    if created:
        group, _ = Group.objects.get_or_create(name='Usuarios')
        instance.groups.add(group)