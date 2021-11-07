from django.urls import path, include
from .views import UpdateAdminPassword


urlpatterns = [
path('updatePass/', UpdateAdminPassword.as_view()),
]