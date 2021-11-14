from django.db import models

# Create your models here.
class Category(models.Model):
  
  def sub_categories_default():
    return {"subs":"[]"}
  
  cat_table_name = models.CharField("tableName", max_length=50, blank=False, null=False)
  category_name = models.CharField("name", max_length=100, blank=False, unique=True, null=False)
  sub_categories = models.JSONField("subCategories", default=sub_categories_default(), null=False)

  

  def __str__(self) -> str:
      return self.category_name;

  def __init__(self, *args):
      super(Category, self).__init__(*args)
        