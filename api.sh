#!/bin/bash

echo "API testing...."

# Function to handle API keys
handle_api_key() {
  api_key_type=$1
  API_TOKEN=$2
  case "$api_key_type" in
    "amplitude api key")
      echo "Handling Amplitude API Keys..."
      curl -u API_Key:$API_TOKEN 'https://amplitude.com/api/2/export?start=20200201T05:00:00&end=20210203T20:00:00' >> amplitude.zip
      ;;
    "asana access token")
      echo "Handling Asana Access token..."
      curl -H "Authorization: Bearer $API_TOKEN" https://app.asana.com/api/1.0/users/me
      ;;
    "bazaarvoice passkey")
      echo "Handling Bazaarvoice Passkey..."
      curl "https://which-cpv-api.bazaarvoice.com/clientInfo?conversationspasskey=$API_TOKEN" --insecure 
      ;;
    "bing maps api key")
      echo "Handling Bing Maps API Key..."
      curl -G "https://dev.virtualearth.net/REST/v1/Locations" \
      --data-urlencode "CountryRegion=US" \
      --data-urlencode "adminDistrict=WA" \
      --data-urlencode "locality=Somewhere" \
      --data-urlencode "postalCode=98001" \
      --data-urlencode "addressLine=100 Main St." \
      --data-urlencode "key=$API_TOKEN"
      ;;
    "bit.ly access token")
      echo "Handling Bit.ly Access token..."
      curl -X POST "https://api-ssl.bitly.com/v4/shorten" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      -d '{"long_url": "https://www.google.com"}'
      ;;
    "buildkite access token")
      echo "Handling Buildkite Access token..."
      curl -H "Authorization: Bearer $API_TOKEN" \
      https://api.buildkite.com/v2/user
      ;;
    "buttercms api key")
      echo "Handling ButterCMS API Key..."
      curl -X GET "https://api.buttercms.com/v2/posts/?auth_token=$API_TOKEN";
      ;;
    "calendly api key")
      echo "Handling Calendly API Key..."
      echo "Get user information"
      curl -X GET "https://api.calendly.com/users/me" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json"
      ;;
    "circleci access token")
      echo "Handling CircleCI Access Token..."
      curl "https://circleci.com/api/v1.1/me?circle-token=$API_TOKEN"
      ;;
    "cloudflare api key")
      echo "Handling Cloudflare API key..."
      curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
      -H "Authorization: Bearer $API_TOKEN"
      echo -e "\n\nGet zones listed(if permission is granted)"
      curl -X GET "https://api.cloudflare.com/client/v4/zones" \
     -H "Authorization: Bearer $API_TOKEN"
      echo -e "\n\nGet user information(if permission is granted)"
      curl -X GET "https://api.cloudflare.com/client/v4/user" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json"
     echo -e "\n\nGet Key information(if permission is granted)"
     curl -X GET "https://api.cloudflare.com/client/v4/user/tokens" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json"
      ;;
    "delighted api key")
      echo "Handling Delighted API key..."
      echo -e "\nMetrics":
      curl https://api.delighted.com/v1/metrics.json \
      -H "Content-Type: application/json" \
      -u $API_TOKEN:
      echo -e "\n\nCustomer information:"
      curl https://api.delighted.com/v1/people.json \
      -H "Content-Type: application/json" \
      -u $API_TOKEN:
      ;;
    "deviant art access token")
      echo "Handling Deviant Art Access Token..."
      curl https://www.deviantart.com/api/v1/oauth2/placebo -d access_token=$API_TOKEN
      ;;
    "dropbox api")
      echo "Handling Dropbox API..."
      curl -X POST https://api.dropboxapi.com/2/users/get_current_account --header "Authorization: Bearer $API_TOKEN"
      ;;
    "facebook access token")
      echo "Handling Facebook Access Token..."
      curl "https://graph.facebook.com/v8.0/me?access_token=$API_TOKEN"
      ;;
    "firebase cloud messaging")
      echo "Handling Firebase Cloud Messaging (FCM)..."
      curl -s -X POST --header "Authorization: key=$API_TOKEN" --header "Content-Type:application/json" 'https://fcm.googleapis.com/fcm/send' -d "{\"registration_ids\":[\"1\"]}"
      ;;
    "gitlab personal access token")
      echo "Handling Gitlab personal access token..."
      curl --header "PRIVATE-TOKEN: $API_TOKEN" https://gitlab.com/api/v4/user
      ;;
    "gitlab runner registration token")
      echo "Handling GitLab runner registration token..."
      ;;
    "google maps api key")
      echo "Handling Google Maps API key..."
      echo -e "\nstatic maps:"
      curl "https://maps.googleapis.com/maps/api/staticmap?center=45%2C10&zoom=7&size=400x400&key=$API_TOKEN"
      echo -e "\n\nStreetview:"
      curl "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=40.720032,-73.988354&fov=90&heading=235&pitch=10&key=$API_TOKEN"
      echo -e "\n\nEmbed:"
      curl "https://www.google.com/maps/embed/v1/place?q=place_id:ChIJyX7muQw8tokR2Vf5WBBk1iQ&key=$API_TOKEN"
      echo -e "\n\Directions:"
      curl "https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood4&key=$API_TOKEN"
      echo -e "\n\nGeocode:"
      curl "https://maps.googleapis.com/maps/api/geocode/json?latlng=40,30&key=$API_TOKEN"
      echo -e "\n\nDistance Matrix:"
      curl "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.659569%2C-73.933783%7C40.729029%2C-73.851524%7C40.6860072%2C-73.6334271%7C40.598566%2C-73.7527626%7C40.659569%2C-73.933783%7C40.729029%2C-73.851524%7C40.6860072%2C-73.6334271%7C40.598566%2C-73.7527626&key=$API_TOKEN"
      echo -e "\n\nFind Place from text:"
      curl "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=$API_TOKEN"
      echo -e "\n\nAutocomplete:"
      curl "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Bingh&types=%28cities%29&key=$API_TOKEN"
      echo -e "\n\nElevation:"
      curl "https://maps.googleapis.com/maps/api/elevation/json?locations=39.7391536,-104.9847034&key=$API_TOKEN"
      echo -e "\n\nTimezone:"
      curl "https://maps.googleapis.com/maps/api/timezone/json?location=39.6034810,-119.6822510&timestamp=1331161200&key=$API_TOKEN"
      echo -e "\n\nRoads:"
      curl "https://roads.googleapis.com/v1/nearestRoads?points=60.170880,24.942795|60.170879,24.942796|60.170877,24.942796&key=$API_TOKEN"
      echo -e "\n\nGeolocate:"
      curl "https://www.googleapis.com/geolocation/v1/geolocate?key=$API_TOKEN"
      ;;
    "heroku api key")
      echo "Handling Heroku API key..."
      curl -X POST https://api.heroku.com/apps -H "Accept: application/vnd.heroku+json; version=3" -H "Authorization: Bearer $API_TOKEN"
      ;;
    "hubspot private app api key")
      echo "Handling HubSpot API key..."
      curl -H "Authorization: Bearer $API_TOKEN" "https://api.hubapi.com/integrations/v1/me"
      echo -e "\n\nGet all owners:"
      curl -H "Authorization: Bearer $API_TOKEN" "https://api.hubapi.com/owners/v2/owners"
      ;;
    "infura api key")
      echo "Handling Infura API key..."
      echo -e "\n\nGet block number:"
      curl "https://mainnet.infura.io/v3/$API_TOKEN" \
      -X POST \
      -H "Content-Type: application/json" \
      -d '{
        "jsonrpc": "2.0",
        "method": "eth_blockNumber",
        "params": [],
        "id": 1
      }'
      ;;
    "instagram graph api")
      echo "Handling Instagram Graph API..."
      curl -i -X GET "https://graph.facebook.com/v8.0/me/accounts?access_token=$API_TOKEN"
      ;;
    "iterable api key")
      echo "Handling Iterable API Key..."
      curl -H "Api_Key: $API_TOKEN" https://api.iterable.com/api/export/data.json?dataTypeName=emailSend&range=Today&onlyFields=List.empty
      ;;
    "jumpcloud api key")
      echo "Handling JumpCloud API Key..."
      echo -e "\n\nGet all systems:"
      curl -H "x-api-key: $API_TOKEN" "https://console.jumpcloud.com/api/systems"
      echo -e "\n\nGet all system users:"
      curl -H "x-api-key: $API_TOKEN" "https://console.jumpcloud.com/api/systemusers"
      echo -e "\n\nGet all applications:"
      curl -H "x-api-key: $API_TOKEN" "https://console.jumpcloud.com/api/applications"
      ;;
    "lokalise api key")
      echo "Handling Lokalise API Key..."
      echo -e "\nGet all projects:"
      curl --request GET \
      --url https://api.lokalise.com/api2/projects/ \
      --header "x-api-token: $API_TOKEN"
      echo -e "\n\nGet teams info:"
      curl --request GET \
      --url https://api.lokalise.com/api2/teams \
      --header "x-api-token: $API_TOKEN"
      ;;
    "loqate api key")
      echo "Handling Loqate API Key..."
      curl "http://api.addressy.com/Capture/Interactive/Find/v1.00/json3.ws?Key=$API_TOKEN&Countries=US,CA&Language=en&Limit=5&Text=BHAR"
      ;;
    "mailgun private key")
      echo "Handling MailGun Private Key..."
      curl --user "api:$API_TOKEN" "https://api.mailgun.net/v3/domains"
      curl --user "api:$API_TOKEN" "https://api.eu.mailgun.net/v3/domains"
      ;;
    "mapbox api key")
      echo "Handling Mapbox API key..."
      echo -e "\n\nCheck validity of token:"
      curl "https://api.mapbox.com/tokens/v2?access_token=$API_TOKEN"
      ;;
    "microsoft teams webhook")
      echo "Handling Microsoft Teams Webhook..."
      curl -H "Content-Type:application/json" -d "{"text":""}" "$API_TOKEN"
      ;;
    "new relic personal api key")
      echo "Handling New Relic Personal API Key (NerdGraph)..."
      curl -X POST https://api.newrelic.com/graphql \
      -H "Content-Type: application/json" \
      -H "API-Key: $API_TOKEN" \
      -d '{ "query":  "{ requestContext { userId apiKey } }" }'
      ;;
    "new relic rest api")
      echo "Handling New Relic REST API..."
      curl -X GET "https://api.newrelic.com/v2/applications.json" \
      -H "X-Api-Key: $API_TOKEN" -i
      echo -e "\n\nGet all users(only possible if it is admin's API key):"
      curl -X GET \
      -H "Api-Key: $API_TOKEN" \
      -H "Content-Type: application/json" \
      "https://api.newrelic.com/v2/users.json"
      ;;
    "npm token")
      echo "Handling NPM token..."
      curl -H "Authorization: Bearer $API_TOKEN" https://registry.npmjs.org/-/whoami
      ;;
    "opsgenie api key")
      echo "Handling OpsGenie API Key..."
      curl https://api.opsgenie.com/v2/alerts -H "Authorization: GenieKey $API_TOKEN"
      ;;
    "ors api key")
      echo "Handling ors api key..."
      curl -X GET "https://api.openrouteservice.org/geocode/search?text=Heidelberg" \
      -H "Authorization: $API_TOKEN"
      ;;
    "pagerduty api token")
      echo "Handling Pagerduty API token..."
      curl -H "Accept: application/vnd.pagerduty+json;version=2" -H "Authorization: Token token=$API_TOKEN" -X GET "https://api.pagerduty.com/schedules"
      ;;
    "pivotaltracker api token")
      echo "Handling PivotalTracker API Token..."
      curl -X GET -H "X-TrackerToken: $API_TOKEN" "https://www.pivotaltracker.com/services/v5/me?fields=%3Adefault"
      ;;
    "sendgrid api token")
      echo "Handling SendGrid API Token..."
      curl -X "GET" "https://api.sendgrid.com/v3/scopes" -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json"
      echo -e "\n\nGet all recipients:"
      curl --request GET \
      --url https://api.sendgrid.com/v3/contactdb/recipients \
      --header "Authorization: Bearer $API_TOKEN"
      echo -e "\n\nGet user details:"
      curl --request GET \
      --url https://api.sendgrid.com/v3/user/account \
      --header "Authorization: Bearer $API_TOKEN"
      ;;
    "shodan.io")
      echo "Handling Shodan.io..."
      echo -e "\nGet account information:"
      curl "https://api.shodan.io/api-info?key=$API_TOKEN"
      ;;
    "slack api token")
      echo "Handling Slack API token..."
      curl -sX POST "https://slack.com/api/auth.test" -H "Accept: application/json; charset=utf-8" -H "Authorization: Bearer $API_TOKEN"
      ;;
    "slack webhook")
      echo "Handling Slack Webhook..."
      curl -s -X POST -H "Content-type: application/json" -d '{"text":"Hello, this is a test message"}' "$API_TOKEN"
      ;;
    "sonarcloud")
      echo "Handling Sonarcloud..."
      curl -H "Authorization: Bearer $API_TOKEN" "https://sonarcloud.io/api/users/search"
      ;;
    "spotify access token")
      echo "Handling Spotify Access Token..."
      curl -H "Authorization: Bearer $API_TOKEN" https://api.spotify.com/v1/me
      ;;
    "square")
      echo "Handling Square..."
      curl -X GET "https://connect.squareup.com/v2/locations" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json"
      ;;
    "stripe live token")
      echo "Handling Stripe Live Token..."
      curl https://api.stripe.com/v1/charges -u $API_TOKEN:
      ;;
    "telegram bot api token")
      echo "Handling Telegram Bot API Token..."
      curl "https://api.telegram.org/bot$API_TOKEN/getMe" \
      ;;
    "travis ci api token")
      echo "Handling Travis CI API token..."
      curl -H "Travis-API-Version: 3" -H "Authorization: token $API_TOKEN" https://api.travis-ci.com/user
      ;;
    "twitter bearer token")
      echo "Handling Twitter Bearer token..."
      curl --request GET --url https://api.twitter.com/1.1/account_activity/all/subscriptions/count.json --header "authorization: Bearer $API_TOKEN"
      curl -X GET "https://api.twitter.com/2/tweets?ids=1" \
      -H "Authorization: Bearer $API_TOKEN"
      ;;
    "visual studio app center api token")
      echo "Handling Visual Studio App Center API Token..."
      curl -sX GET  "https://api.appcenter.ms/v0.1/apps" \
      -H "Content-Type: application/json" \
      -H "X-Api-Token: $API_TOKEN"
      ;;
    "wakatime api key")
      echo "Handling WakaTime API Key..."
      curl "https://wakatime.com/api/v1/users/current?api_key=$API_TOKEN"
      ;;
    "weglot api key")
      echo "Handling WeGlot Api Key..."
      curl -X POST \
        "https://api.weglot.com/translate?api_key=$API_TOKEN" \
        -H 'Content-Type: application/json' \
        -d '{  
        "l_from":"en",
        "l_to":"fr",
        "request_url":"https://www.website.com/",
        "words":[  
            {"w":"This is a blue car", "t": 1},
            {"w":"This is a black car", "t": 1}
        ]
      }'
      ;;
    "youtube api key")
      echo "Handling YouTube API Key..."
      curl -iLk "https://www.googleapis.com/youtube/v3/activities?part=contentDetails&maxResults=25&channelId=UC-lHJZR3Gqxm24_Vd_AJ5Yw&key=$API_TOKEN"
      ;;
    "zapier webhook token")
      echo "Handling Zapier Webhook Token..."
      curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"name":"streaak"}' "$API_TOKEN"
      ;;
    *)
      echo "API key type NOT FOUND"
      ;;
  esac
}

# Check if the number of arguments is valid
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <api_key_type> <api_key>"
  exit 1
fi

api_key_type=$1
API_TOKEN=$2
handle_api_key "$api_key_type" "$API_TOKEN"
