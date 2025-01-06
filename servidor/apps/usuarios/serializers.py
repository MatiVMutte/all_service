from rest_framework import serializers
from .models import Usuario, Tecnico, Cliente

class UsuarioSerializer(serializers.ModelSerializer):
    role = serializers.CharField(write_only=True)

    class Meta:
        model = Usuario
        fields = ['id', 'username', 'password', 'role']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        role = validated_data.pop('role')
        user = Usuario.objects.create_user(**validated_data)
        return user

# class TecnicoSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Tecnico
#         fields = '__all__'

# class ClienteSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Cliente
#         fields = '__all__'