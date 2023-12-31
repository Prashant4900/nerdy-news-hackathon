# Generated by Django 4.2.2 on 2023-06-20 20:22

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        ("wordpress", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="NewsModel",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("news_id", models.IntegerField()),
                ("title", models.CharField(max_length=300)),
                ("description", models.TextField(blank=True)),
                ("source", models.URLField()),
                ("thumbnail", models.URLField(blank=True)),
                ("published_at", models.DateTimeField()),
                ("views", models.IntegerField(default=0)),
                (
                    "publisher",
                    models.ForeignKey(
                        help_text="Select publisher for this news",
                        on_delete=django.db.models.deletion.CASCADE,
                        to="wordpress.publishermodel",
                        verbose_name="Publisher",
                    ),
                ),
            ],
            options={
                "verbose_name": "News",
                "verbose_name_plural": "News",
                "db_table": "news",
                "ordering": ("-published_at",),
            },
        ),
    ]
