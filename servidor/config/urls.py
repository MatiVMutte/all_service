from django.contrib import admin
from django.urls import path
from apps.usuarios.views import UsuarioViewSet, TecnicoViewSet, ClienteViewSet, dashboard
from rest_framework.routers import DefaultRouter
from django.urls import include

router = DefaultRouter()
router.register(r'usuarios', UsuarioViewSet)
router.register(r'tecnicos', TecnicoViewSet)
router.register(r'clientes', ClienteViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('dashboard/', dashboard, name='dashboard'),
]
