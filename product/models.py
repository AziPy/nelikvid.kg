from django.db import models

class Category(models.TextChoices):
    POPULAR = 'popular', 'Популярные товары'
    WOMEN = 'women', 'Женщинам'
    MEN = 'men', 'Мужчинам'
    KIDS = 'kids', 'Детям'
    SOON = 'soon', 'Скоро'

class Product(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.CharField(max_length=20, choices=Category.choices)
    image = models.ImageField(upload_to='products/')

    def __str__(self):
        return self.name
