from datetime import datetime, timedelta

import requests
from django.http import JsonResponse

from utils.utils import get_media_url, get_plain_text
from wordpress.models import PublisherModel
from .models import NewsModel


def abc():
    before = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    after = (datetime.now() - timedelta(hours=24, seconds=1)).strftime(
        "%Y-%m-%dT%H:%M:%S"
    )

    return f"before={before}&after={after}&per_page=100"


# Create your views here.
def insert_news(request, domain):
    global response
    URL = f"https://{domain}/wp-json/wp/v2/posts?{abc()}&_fields=id,title,excerpt,link,date,categories," \
          f"featured_media&per_page=100"
    MEDIA_URL = f"https://{domain}/wp-json/wp/v2/media/"

    try:
        response = requests.get(URL)
        is_publisher_exists = PublisherModel.objects.filter(domain=f'https://{domain}/').exists()
        status_code = response.status_code
        data = response.json()
        # print(data)
        if status_code == 200 and is_publisher_exists:

            for news in data:
                media_id = news["featured_media"]
                thumbnail = get_media_url(MEDIA_URL, media_id)

                news_id = news["id"]
                title = get_plain_text(news["title"]["rendered"])
                description = get_plain_text(news["excerpt"]["rendered"])
                source = news["link"]
                published_at = datetime.strptime(news["date"], "%Y-%m-%dT%H:%M:%S")

                publisher = PublisherModel.objects.get(domain=f'https://{domain}/')

                is_news_exist = NewsModel.objects.filter(news_id=news_id).filter().exists()

                if is_news_exist:
                    news = NewsModel.objects.get(news_id=news_id)
                    news.title = title
                    news.description = description
                    news.thumbnail = thumbnail
                    news.source = source
                    news.published_at = published_at
                    news.publisher = publisher
                else:
                    news = NewsModel.objects.create(
                        news_id=news_id,
                        title=title,
                        description=description,
                        thumbnail=thumbnail,
                        source=source,
                        published_at=published_at,
                        publisher=publisher,
                    )
                news.save()

            return JsonResponse(
                {"status": "success", "message": "News inserted successfully", "url": URL, "data": data, })

        elif status_code == 200 and not is_publisher_exists:
            response.status_code = 400
            return JsonResponse({"status": "error", "message": "Publisher does not exist", "data": None, })
        else:
            response.status_code = 400
            return JsonResponse({"status": "error", "message": "Something went wrong", "data": None, })

    except Exception as e:
        response.status_code = 500
        return JsonResponse({"status": "error", "message": str(e), "data": None})
