from django.contrib import admin
from .models import CUser

# Register your models here.
class UserAdmin(admin.ModelAdmin):
  pass

admin.site.register(CUser,UserAdmin)