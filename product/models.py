from django.db import models
from django.contrib.auth.models import User

class Category(models.Model):
    name_category = models.CharField(max_length=100)

    def __str__(self):
        return self.name_category


class Product(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name='products')
    image = models.ImageField(upload_to='products/')

    def __str__(self):
        return self.name


class Review(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='reviews')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    text = models.TextField()
    rating = models.PositiveSmallIntegerField(default=5)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.product.name} ({self.rating}/5)"


class Question(models.Model):
    name = models.CharField("Как вас зовут", max_length=255)
    phone = models.CharField("Контактный телефон", max_length=20)
    message = models.TextField("Ваше сообщение")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} - {self.phone}"

    class Meta:
        verbose_name = "Вопрос"
        verbose_name_plural = "Вопросы"
