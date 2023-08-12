from django.db import models
from django.utils.html import format_html

ROUND_HTML = '<a href={} target="_blank"><img src="{}" width="30" height="30" style="border-radius: 50%" "/></a>'
HTML = '<a href={} target="_blank"><img src="{}" width="25%"/></a>'

LINK_HTML = '<a href={} target="_blank">View</a>'


# Create your models here.
class PublisherModel(models.Model):
    name = models.CharField(max_length=100, blank=False, null=False, unique=True)
    domain = models.CharField(max_length=70, blank=False, null=False, unique=True)
    icon = models.URLField(blank=True, null=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = "Publishers"
        verbose_name = "Publisher"
        db_table = "publishers"
        ordering = ("name",)

    def round_icon_preview(self):
        return format_html(ROUND_HTML.format(self.icon, self.icon))

    round_icon_preview.short_description = "Icon Preview"

    def icon_preview(self):
        return format_html(HTML.format(self.icon, self.icon))

    icon_preview.short_description = "Icon Preview"

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"<Publisher: {self.name} - {self.domain}>"
