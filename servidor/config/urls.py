from django.contrib import admin
from django.urls import path
from apps.usuarios.views import UsuarioViewSet
from rest_framework.routers import DefaultRouter
from django.urls import include

router = DefaultRouter()
router.register(r'usuarios', UsuarioViewSet)


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    
]
