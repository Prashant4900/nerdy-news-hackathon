from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomAdmins


class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomAdmins
    list_display = ("get_full_name", "email", "is_staff", "is_active",)
    list_filter = ("is_staff", "is_active", "groups", "date_joined", "last_login")
    fieldsets = (
        (None, {"fields": ("first_name", "last_name", "email", "password")}),
        ("Permissions", {"fields": ("is_staff", "is_active", "is_superuser", "groups", "user_permissions")}),
    )
    add_fieldsets = (
        (None, {
            "classes": ("wide",),
            "fields": (
                "first_name", "last_name",
                "email", "password1", "password2", "is_staff",
                "is_active", "is_superuser", "groups", "user_permissions"
            )}
        ),
    )
    search_fields = ("email",)
    ordering = ("email",)

    save_on_top = True


admin.site.register(CustomAdmins, CustomUserAdmin)
