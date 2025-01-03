from django.contrib import admin
from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from .models import Usuario, Tecnico, Cliente

admin.site.register(Usuario)
admin.site.register(Tecnico)
admin.site.register(Cliente)

# Crear grupos y permisos
tecnico_group, created = Group.objects.get_or_create(name='Tecnicos')
cliente_group, created = Group.objects.get_or_create(name='Clientes')

# Asignar permisos a los grupos
content_type = ContentType.objects.get_for_model(Usuario)
permiso_tecnico = Permission.objects.create(
    codename='can_view_tecnico_dashboard',
    name='Can view tecnico dashboard',
    content_type=content_type,
)
permiso_cliente = Permission.objects.create(
    codename='can_view_cliente_dashboard',
    name='Can view cliente dashboard',
    content_type=content_type,
)

tecnico_group.permissions.add(permiso_tecnico)
cliente_group.permissions.add(permiso_cliente)