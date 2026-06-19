FROM 2fauth/2fauth:5.4.3

COPY patches/app/Http/Controllers/Auth/LoginController.php /srv/app/Http/Controllers/Auth/LoginController.php
COPY patches/app/Http/Requests/LoginRequest.php /srv/app/Http/Requests/LoginRequest.php
COPY patches/public/build/assets/Login-5FbYhqqZ.js /srv/public/build/assets/Login-5FbYhqqZ.js
