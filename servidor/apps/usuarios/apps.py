from django.apps import AppConfig
from django.db.models.signals import post_migrate

def create_default_groups(sender, **kwargs):
    from django.contrib.auth.models import Group, Permission
    from django.contrib.contenttypes.models import ContentType
    from .models import Usuario

    # Crear grupos
    tecnico_group, created = Group.objects.get_or_create(name='Tecnicos')
    cliente_group, created = Group.objects.get_or_create(name='Clientes')

    # Crear permisos
    content_type = ContentType.objects.get_for_model(Usuario)
    permiso_tecnico, created = Permission.objects.get_or_create(
        codename='can_view_tecnico_dashboard',
        name='Can view tecnico dashboard',
        content_type=content_type,
    )
    permiso_cliente, created = Permission.objects.get_or_create(
        codename='can_view_cliente_dashboard',
        name='Can view cliente dashboard',
        content_type=content_type,
    )

    # Asignar permisos a los grupos
    tecnico_group.permissions.add(permiso_tecnico)
    cliente_group.permissions.add(permiso_cliente)

class UsuariosConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.usuarios'
    
    def ready(self):
        post_migrate.connect(create_default_groups, sender=self)