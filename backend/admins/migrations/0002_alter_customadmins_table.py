# Generated by Django 4.2.2 on 2023-06-20 19:59

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("admins", "0001_initial"),
    ]

    operations = [
        migrations.AlterModelTable(
            name="customadmins",
            table="admins",
        ),
    ]