from django.contrib import admin
from .models import NewsModel, CategoriesModel

from django_admin_listfilter_dropdown import filters

# Register your models here.

from django.utils.translation import gettext_lazy as _


class CategoryFilter(admin.SimpleListFilter):
    title = _('Category')
    parameter_name = 'category'

    def lookups(self, request, model_admin):
        categories = CategoriesModel.objects.all()
        return [(category.name, category.name) for category in categories]

    def queryset(self, request, queryset):
        category_name = self.value()
        if category_name:
            description_queryset = queryset.filter(description__icontains=category_name)
            source_queryset = queryset.filter(source__icontains=category_name)
            title_queryset = queryset.filter(source__icontains=category_name)
            # publisher_queryset = queryset.filter(publisher__icontains=category_name)
            queryset = description_queryset | source_queryset | title_queryset
        return queryset


@admin.register(NewsModel)
class NewsAdmin(admin.ModelAdmin):
    list_display = (
        "title",
        "round_thumbnail_preview",
        "publisher",
        "views",
        "get_source",
    )
    search_fields = (
        # "title",
        # "description",
        "source",
        # "thumbnail",
        # "views",
        # "publisher__name",
        # "published_at",
    )
    readonly_fields = (
        "thumbnail_preview",
        "round_thumbnail_preview",
        "get_source",
        "news_id",
        "get_title",
        "get_description",
        "id",
        "views",
        "published_at",
    )
    list_filter = (
        ("publisher", filters.RelatedDropdownFilter),
        "published_at",
        CategoryFilter,
    )

    fieldsets = (
        (
            None,
            {
                "fields": (
                    "id",
                    "title",
                    "description",
                    "source",
                    "thumbnail",
                    "publisher",
                    "published_at",
                    "views",
                )
            },
        ),
        (
            "News Preview",
            {
                "fields": (
                    'news_id',
                    "get_title",
                    "get_description",
                    "thumbnail_preview",
                    "get_source",
                ),
            },
        ),
    )
    list_per_page = 10
    save_on_top = True


@admin.register(CategoriesModel)
class CategoriesAdmin(admin.ModelAdmin):
    list_display = ("name", "parent", "created_at", "updated_at")
    search_fields = ("name", "created_at", "updated_at")
    readonly_fields = (
        "created_at",
        "updated_at",
        "id",
    )
    list_filter = ("created_at", "updated_at")
    fieldsets = (
        (None, {"fields": ("id", "name", "parent")}),
        ("Date", {"fields": ("created_at", "updated_at")}),
    )
    list_per_page = 10
    save_on_top = True
