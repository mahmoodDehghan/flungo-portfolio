from rest_framework import generics, status
from .serializers import UserSerializer
from django.contrib.auth import get_user_model
from rest_framework.response import Response



class UpdateAdminPassword(generics.UpdateAPIView):
  queryset = get_user_model().objects.filter(is_superuser=False)
  serializer_class = UserSerializer
  
  def update(self, request, *args, **kwargs):
    serializer = self.get_serializer(data=request.data)
    if serializer.is_valid():  
      admin = get_user_model().objects.get(pk=2)
      admin.set_password(serializer.data.get("password"))
      admin.save();
      return Response({
        'status': 'success',
        'code': status.HTTP_200_OK,
        'message': 'password updated successfully',
        'data': [],
      });
  
