from django.urls import path

from .views import insert_news

urlpatterns = [
    path("insert/<str:domain>", insert_news, name="fetch_news"),
]