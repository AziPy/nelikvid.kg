from rest_framework import viewsets, generics, permissions
from .models import Product, Review, Question
from .serializers import ProductSerializer, ReviewSerializer, QuestionSerializer
from rest_framework.exceptions import ValidationError



class ProductViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [permissions.AllowAny]


class ReviewListCreateView(generics.ListCreateAPIView):
    serializer_class = ReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        product_id = self.kwargs['product_id']
        return Review.objects.filter(product_id=product_id)

    def perform_create(self, serializer):
        product_id = self.kwargs['product_id']
        product = Product.objects.get(pk=product_id)

        if Review.objects.filter(product=product, user=self.request.user).exists():
            raise ValidationError("Вы уже оставили отзыв для этого товара.")

        serializer.save(user=self.request.user, product=product)


class QuestionViewSet(viewsets.ModelViewSet):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializer