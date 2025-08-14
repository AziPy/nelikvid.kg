from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProductViewSet, ReviewListCreateView, QuestionViewSet

router = DefaultRouter()
router.register(r'products', ProductViewSet, basename='product')
router.register(r'questions', QuestionViewSet, basename='question')

urlpatterns = [
    path('', include(router.urls)),
    path('products/<int:product_id>/reviews/', ReviewListCreateView.as_view(), name='product-reviews'),
]
