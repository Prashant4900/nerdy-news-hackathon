from django.db import models
from django.utils.html import format_html

from wordpress.models import PublisherModel

ROUND_HTML = '<a href={} target="_blank"><img src="{}" width="50" height="50" style="border-radius: 50%" "/></a>'
HTML = '<a href={} target="_blank"><img src="{}" width="25%"/></a>'

LINK_HTML = '<a href={} target="_blank">View</a>'


# Create your models here.
class NewsModel(models.Model):
    news_id = models.IntegerField(blank=False, null=False)
    title = models.CharField(max_length=300, blank=False, null=False)
    description = models.TextField(blank=True, null=False)
    source = models.URLField(blank=False, null=False)
    thumbnail = models.URLField(blank=True, null=False)
    published_at = models.DateTimeField(blank=False, null=False)
    views = models.IntegerField(default=0)
    publisher = models.ForeignKey(
        PublisherModel,
        on_delete=models.CASCADE,
        blank=False,
        null=False,
        help_text="Select publisher for this news",
        verbose_name="Publisher",
    )

    class Meta:
        verbose_name_plural = "News"
        verbose_name = "News"
        db_table = "news"
        ordering = ("-published_at",)

    def __str__(self):
        return self.title

    def __repr__(self):
        return f"<News: {self.title} - {self.published_at}>"

    def get_absolute_url(self):
        return f"/news/{self.news_id}"

    def thumbnail_preview(self):
        return format_html(HTML.format(self.thumbnail, self.thumbnail))

    thumbnail_preview.short_description = "Thumbnail Preview"

    def round_thumbnail_preview(self):
        return format_html(ROUND_HTML.format(self.thumbnail, self.thumbnail))

    round_thumbnail_preview.short_description = "Thumbnail Preview"

    def get_title(self):
        return format_html(self.title)

    get_title.short_description = "Title"

    def get_description(self):
        return format_html(self.description)

    get_description.short_description = "Description"

    def get_source(self):
        return format_html(LINK_HTML.format(self.source))



class CategoriesModel(models.Model):
    name = models.CharField(max_length=100, blank=False, null=False)
    parent = models.ForeignKey(
        "self",
        on_delete=models.CASCADE,
        blank=True,
        null=True,
        help_text="Select parent category for this category",
        verbose_name="Parent Category",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = "Categories"
        verbose_name = "Category"
        db_table = "categories"
        ordering = ("name",)

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"<Category: {self.name}>"
