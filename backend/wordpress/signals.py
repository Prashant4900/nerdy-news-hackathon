from django.db.models.signals import post_save
from django.dispatch import receiver

from .models import PublisherModel
from utils.utils import get_favicon_url


@receiver(post_save, sender=PublisherModel)
def insert_favicon(sender, instance, **kwargs):
    if instance.icon:
        print("Icon already exists")
    else:
        instance.icon = get_favicon_url(instance.domain)
        instance.save()
