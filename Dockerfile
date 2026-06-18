FROM 2fauth/2fauth:5.4.3

COPY patches/app/Http/Controllers/Auth/LoginController.php /srv/app/Http/Controllers/Auth/LoginController.php
COPY patches/app/Http/Requests/LoginRequest.php /srv/app/Http/Requests/LoginRequest.php
COPY patches/public/build/manifest.json /srv/public/build/manifest.json
COPY patches/public/build/assets/app-xpc20260618a.js /srv/public/build/assets/app-xpc20260618a.js
COPY patches/public/build/assets/Login-xpc20260618a.js /srv/public/build/assets/Login-xpc20260618a.js
COPY patches/public/build/assets/Form-xpc20260618a.js /srv/public/build/assets/Form-xpc20260618a.js
COPY patches/public/build/assets/webauthnService-xpc20260618a.js /srv/public/build/assets/webauthnService-xpc20260618a.js

