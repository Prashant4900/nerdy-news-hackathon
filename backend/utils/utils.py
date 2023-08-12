import requests
from bs4 import BeautifulSoup


def get_favicon_url(domain_url):
    response = requests.get(domain_url)
    soup = BeautifulSoup(response.text, 'html.parser')
    # Find the link tag with rel="shortcut icon"
    link_tag = soup.find('link', rel='icon')

    return link_tag['href'].split('?')[0]


def get_plain_text(html_text):
    result = BeautifulSoup(html_text, "html.parser")
    return result.get_text()


def get_media_url(MEDIA_URL, media_id):
    response = requests.get(MEDIA_URL + str(media_id))
    data = response.json()
    return data["source_url"]