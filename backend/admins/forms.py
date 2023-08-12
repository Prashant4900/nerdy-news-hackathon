from django.contrib.auth.forms import UserCreationForm, UserChangeForm

from .models import CustomAdmins


class CustomUserCreationForm(UserCreationForm):

    class Meta:
        model = CustomAdmins
        fields = ("email",)


class CustomUserChangeForm(UserChangeForm):

    class Meta:
        model = CustomAdmins
        fields = ("email",)
