# Nerdy News

Unveiling Nerdy News: Your Gateway to Geekdom's Latest Wonders! 🚀📱

Get ready for a whirlwind tour through the realms of Anime, Movies & TV Shows, Comics, Video Games, and Pop Culture - introducing Nerdy News! 🎮🎬📺

Immerse yourself in a universe where everything nerdy converges into one sleek app. From anime releases to blockbuster sneak peeks, comic sagas, gaming revelations, and the hottest pop culture scoops, Nerdy News is your front-row ticket to it all.

## Features

- 📅 **Instant Updates**: Stay informed 24/7 with real-time news delivery.
- 🌌 **All-in-One Hub**: Curated content catering to all your geeky passions.
- 📖 **Reader Mode**: Enjoy distraction-free reading with our immersive reader mode.
- 📸 **Share as Images**: Easily share your favorite news as captivating images.
- 🎮 **Retro Game Fun**: Embark on nostalgic journeys with a collection of retro games.
- 💾 **Save Your Articles**: Create a library of your preferred articles for convenient access.

## Built with

- **Frontend**: Flutter for a seamless and dynamic user experience.
- **Backend**: Django for robust server-side functionality.
- **Database & Authentication**: Powered by Supabase, offering a reliable backend-as-a-service solution.

## Getting Started

### Prerequisites

- Flutter: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Django: [Installation Guide](https://docs.djangoproject.com/en/stable/intro/install/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Prashant4900/nerdy-news/
   cd nerdy-news
   ```

2. **Backend Setup:** Navigate to the backend folder and set up your Django environment.

    ```bash
    cd backend
    # Create a virtual environment (optional but recommended)
    python -m venv venv
    source venv/bin/activate
    # Install dependencies
    pip install -r requirements.txt
    ```

    Configure the environment variable in .env.
    ```bash
    DJANGO_SECRET_KEY="******"
    DJANGO_DEBUG="True"

    DATABASE_URL="postgresql://postgres:<password>@<host-url>:5432/postgres"

    COMPRESS_ENABLED="True"

    SENTRY_DSN="******"
    SENTRY_ENVIRONMENT="development"

    SENDINBLUE_API_KEY="******"
    SENDINBLUE_API_URL="https://api.brevo.com/v3/"
    ``` 

    Configure the database settings in settings.py. Apply migrations and start the server:

    ```bash
    python manage.py makemigrations
    python manage.py migrate
    python manage.py runserver
    ```

3. **Frontend Setup:** Navigate to the frontend folder and install dependencies.

    ```bash
    cd mobile
    flutter pub get
    ```

    Configure the environment variable in development.env.

    ```bash
    BASE_URL='<supabase-base-url>'

    PUBLIC_KEY='******'

    SECRET_KEY='******'

    ANDROID_CLIENT_ID='******'

    IOS_CLIENT_ID='******'

    PUBLISHER_TABLE = "publishers";

    NEWS_TABLE = "news";
    ```

    Run the app on an emulator or device:
    ```bash
    flutter run
    ```

4. **Supabase Integration:** Set up your Supabase account and configure the backend to connect.

5. **Explore and Enjoy:** Open the Nerdy News app and start exploring geek culture updates!

## Demo

Check out our [demo](https://www.youtube.com/watch?v=Tr10YKppJzk) to see Nerdy News in action! Experience the thrill of being in the geek culture loop with just a few taps.

## Admin

Url: https://nerdy-news-admin.onrender.com/admin/
Email: admin@gmail.com
Password: Dummy@123


## How to Contribute

We welcome contributions to make Nerdy News even better! If you have ideas for new features, bug fixes, or improvements, feel free to submit a pull request.


## Join Us

Join us at the hackathon to witness Nerdy News' magic firsthand. Step into a world where every tap opens a gateway to excitement, learning, and endless inspiration. Embrace your inner geek with Nerdy News, because staying informed has never been this exhilarating! 🤖🔍📡 #NerdyNewsApp

Stay nerdy, stay updated! 🚀🌟📚
