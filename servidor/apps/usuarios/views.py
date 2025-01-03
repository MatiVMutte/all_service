from django.contrib.auth.decorators import login_required, permission_required
from django.shortcuts import render
from django.contrib.auth.models import Group
from rest_framework import viewsets
from .models import Usuario, Tecnico, Cliente
from .serializers import UsuarioSerializer, TecnicoSerializer, ClienteSerializer

class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer

    def perform_create(self, serializer):
        usuario = serializer.save()
        self.asignar_grupo(usuario, 'usuario')

    def asignar_grupo(self, usuario, tipo):
        if tipo == 'tecnico':
            grupo = Group.objects.get(name='Tecnicos')
        elif tipo == 'cliente':
            grupo = Group.objects.get(name='Clientes')
        usuario.groups.add(grupo)

class TecnicoViewSet(viewsets.ModelViewSet):
    queryset = Tecnico.objects.all()
    serializer_class = TecnicoSerializer

    def perform_create(self, serializer):
        tecnico = serializer.save()
        self.asignar_grupo(tecnico, 'tecnico')

    def asignar_grupo(self, usuario, tipo):
        grupo = Group.objects.get(name='Tecnicos')
        usuario.groups.add(grupo)

class ClienteViewSet(viewsets.ModelViewSet):
    queryset = Cliente.objects.all()
    serializer_class = ClienteSerializer

    def perform_create(self, serializer):
        cliente = serializer.save()
        self.asignar_grupo(cliente, 'cliente')

    def asignar_grupo(self, usuario, tipo):
        grupo = Group.objects.get(name='Clientes')
        usuario.groups.add(grupo)


@login_required
def dashboard(request):
    if request.user.has_perm('usuarios.can_view_tecnico_dashboard'):
        context = {"message": "Bienvenido al dashboard de técnicos"}
    elif request.user.has_perm('usuarios.can_view_cliente_dashboard'):
        context = {"message": "Bienvenido al dashboard de clientes"}
    else:
        context = {"message": "No tienes permisos para ver este contenido"}
    return render(request, 'usuarios/dashboard.html', context)