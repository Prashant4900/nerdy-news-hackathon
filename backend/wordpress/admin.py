from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import PublisherModel


# Register your models here.
@admin.register(PublisherModel)
class PublisherAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    list_display = ('name', 'round_icon_preview', 'created_at', 'updated_at')
    search_fields = ('name', 'domain')
    readonly_fields = ('round_icon_preview', 'icon_preview', 'created_at',
                       'updated_at', 'id')
    list_filter = ('created_at', 'updated_at')
    fieldsets = (
        (None, {
            'fields': ('id', 'name', 'domain', 'icon')
        }),
        ('Icon Preview', {
            'fields': ('round_icon_preview', 'icon_preview')
        }),
        ('Date', {
            'fields': ('created_at', 'updated_at')
        }),
    )
    list_per_page = 10
    save_on_top = True
