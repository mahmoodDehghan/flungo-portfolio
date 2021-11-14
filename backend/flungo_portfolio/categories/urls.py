from rest_framework import routers
from .views import CategoryViewSet

app_name = 'categories'
router = routers.SimpleRouter()
router.register(r'categories',CategoryViewSet)
urlpatterns = router.urls