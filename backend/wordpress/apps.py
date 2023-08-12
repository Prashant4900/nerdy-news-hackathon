from django.apps import AppConfig


class WordpressConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "wordpress"

    def ready(self) -> None:
        import wordpress.signals
        return super().ready()
