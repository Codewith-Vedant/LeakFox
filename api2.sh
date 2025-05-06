#!/bin/bash

echo "API testing...."

# Function to handle API keys
handle_api_key() {
  api_key_type=$1
  api_token=$2
  api_key_secret=$3

  case "$api_key_type" in
    "abtasty api key")
      echo "Handling ABTasty API Key..."
      ;;
    "algolia api key")
      echo "Handling Algolia API Key..."
      curl --request GET \
      --url "https://$api_key_secret-1.algolianet.com/1/indexes/" \
      --header 'content-type: application/json' \
      --header "x-algolia-api-key: $api_token" \
      --header "x-algolia-application-id: $api_key_secret"
      ;;
    "aws access key id and secret")
      echo "Handling AWS Access Key ID and Secret..."
      AWS_ACCESS_KEY_ID=$api_token AWS_SECRET_ACCESS_KEY=$api_key_secret aws sts get-caller-identity
      ;;
    "azure application insights app id and api key")
      echo "Handling Azure Application Insights APP ID and API Key..."
      curl --request GET \
     -H "x-api-key: $api_token" \
     "https://api.applicationinsights.io/v1/apps/$api_key_secret/metrics/requests/count"
      ;;
    "branch.io key and secret")
      echo "Handling Branch.io Key and Secret..."
      curl "https://api2.branch.io/v1/app/$api_token?branch_secret=$api_key_secret"
      ;;
    "browserstack access key")
      echo "Handling BrowserStack Access Key..."
      curl -u "$api_key_secret:$api_token" https://api.browserstack.com/automate/plan.json
      ;;
    "contentful access token")
      echo "Handling Contentful Access Token..."
      curl -X GET \
      "https://cdn.contentful.com/spaces/$api_key_secret/entries" \
      -H "Authorization: Bearer $api_token"
      ;;
    "cypress record key")
      echo "Handling Cypress record key..."
      curl -i -s -k -X $'POST' \
    -H $'x-route-version: 4' -H $'x-os-name: darwin' -H $'x-cypress-version: 5.5.0' -H $'host: api.cypress.io' -H $'accept: application/json' -H $'content-type: application/json' -H $'Content-Length: 1433' -H $'Connection: close' \
    --data-binary $"{\"ci\":{\"params\":null,\"provider\":null},\"specs\":[\"cypress/integration/examples/actions.spec.js\",\"cypress/integration/examples/aliasing.spec.js\",\"cypress/integration/examples/assertions.spec.js\",\"cypress/integration/examples/connectors.spec.js\",\"cypress/integration/examples/cookies.spec.js\",\"cypress/integration/examples/cypress_api.spec.js\",\"cypress/integration/examples/files.spec.js\",\"cypress/integration/examples/local_storage.spec.js\",\"cypress/integration/examples/location.spec.js\",\"cypress/integration/examples/misc.spec.js\",\"cypress/integration/examples/navigation.spec.js\",\"cypress/integration/examples/network_requests.spec.js\",\"cypress/integration/examples/querying.spec.js\",\"cypress/integration/examples/spies_stubs_clocks.spec.js\",\"cypress/integration/examples/traversal.spec.js\",\"cypress/integration/examples/utilities.spec.js\",\"cypress/integration/examples/viewport.spec.js\",\"cypress/integration/examples/waiting.spec.js\",\"cypress/integration/examples/window.spec.js\"],\"commit\":{\"sha\":null,\"branch\":null,\"authorName\":null,\"authorEmail\":null,\"message\":null,\"remoteOrigin\":null,\"defaultBranch\":null},\"group\":null,\"platform\":{\"osCpus\":[],\"osName\":\"darwin\",\"osMemory\":{\"free\":1153744896,\"total\":17179869184},\"osVersion\":\"19.6.0\",\"browserName\":\"Electron\",\"browserVersion\":\"85.0.4183.121\"},\"parallel\":null,\"ciBuildId\":null,\"projectId\":\"$api_key_secret\",\"recordKey\":\"$api_token\",\"specPattern\":null,\"tags\":[\"\"]}" \
    $'https://api.cypress.io/runs'
      ;;
    "datadog api key")
      echo "Handling DataDog API key..."
      curl -X GET "https://api.datadoghq.com/api/v1/validate" \
      -H "Content-Type: application/json" \
      -H "DD-API-KEY: $api_token"
      echo -e "\n\n Get all dashboards:"
      ;;
    "deviant art secret")
      echo "Handling Deviant Art Secret..."
      curl https://www.deviantart.com/oauth2/token -d grant_type=client_credentials -d client_id=$api_token -d client_secret=$api_key_secret
      ;;
    "facebook appsecret")
      echo "Handling Facebook AppSecret..."
      curl "https://graph.facebook.com/oauth/access_token?client_id=$api_token&client_secret=$api_key_secret&redirect_uri=&grant_type=client_credentials"
      ;;
    "freshdesk api key")
      echo "Handling FreshDesk API Key..."
      curl -v -u $api_token:X -H "Content-Type: application/json" \
      "https://$api_key_secret/api/v2/tickets"
      ;;
    "github token")
      echo "Handling Github Token..."
      echo "Get user details:"
      curl -s -u "$api_key_secret:$api_token" https://api.github.com/user
      echo -e "\n\n Get scopes:"
      curl "https://api.github.com/rate_limit" -i -u "$api_key_secret:$api_token" | grep "X-OAuth-Scopes:"
      ;;
    "google recaptcha key")
      echo "Handling Google Recaptcha key..."
      curl -X POST "https://www.google.com/recaptcha/api/siteverify" \
      -d "secret=$api_token" \
      -d "response=$api_key_secret"
      ;;
    "grafana access token")
      echo "Handling Grafana Access Token..."
      curl -X GET https://$api_key_secret/api/auth/keys \
      -H "Authorization: Bearer $api_token" \
      -H "Content-Type: application/json"
      ;;
    "help scout oauth")
      echo "Handling Help Scout OAUTH..."
      curl -X POST https://api.helpscout.net/v2/oauth2/token \
      --data "grant_type=client_credentials" \
      --data "client_id=$api_token" \
      --data "client_secret=$api_key_secret"
      ;;
    "keen.io api key")
      echo "Handling Keen.io API Key..."
      echo "Get all events for read api key:"
      curl "https://api.keen.io/3.0/projects/$api_key_secret/events?api_key=$api_token"
      ;;
    "ipstack api key")
      echo "Handling Ipstack API Key..."
      curl "https://api.ipstack.com/$api_key_secret?access_key=$api_token"
      ;;
    "linkedin 0auth")
      echo "Handling LinkedIn 0Auth..."
      curl -X POST "https://www.linkedin.com/oauth/v2/accessToken" \
      -d "grant_type=client_credentials" \
      -d "client_id=$api_token" \
      -d "client_secret=$api_key_secret"
      ;;
    "mailchimp api key")
      echo "Handling MailChimp API Key..."
      curl --request GET --url "https://$api_key_secret.api.mailchimp.com/3.0/lists" --user "anystring:$api_token" --include
      ;;
    "paypal client id and secret key")
      echo "Handling Paypal client id and secret key..."
      curl -v https://api.sandbox.paypal.com/v1/oauth2/token \
      -H "Accept: application/json" \
      -H "Accept-Language: en_US" \
      -u "$api_token:$api_key_secret" \
      -d "grant_type=client_credentials"
      ;;
    "razorpay api key and secret key")
      echo "Handling Razorpay API key and secret key..."
      curl -u $api_token:$api_key_secret \
      https://api.razorpay.com/v1/payments
      ;;
    "salesforce api key")
      echo "Handling Salesforce API key..."
      curl -k https://$api_key_secret.salesforce.com/services/data/v20.0/ -H "Authorization: Bearer $api_token"
      ;;
    "saucelabs username and access key")
      echo "Handling SauceLabs Username and access Key..."
      curl -u $api_key_secret:$api_token https://saucelabs.com/rest/v1/users/$api_key_secret
      ;;
    "twilio account_sid and auth token")
      echo "Handling Twilio Account_sid and Auth token..."
      curl -X GET 'https://api.twilio.com/2010-04-01/Accounts.json' -u $api_key_secret:$api_token
      ;;
    "twitter api secret")
      echo "Handling Twitter API Secret..."
      curl -u "$api_token:$api_key_secret" --data 'grant_type=client_credentials' 'https://api.twitter.com/oauth2/token'
      ;;
    "wpengine api key")
      echo "Handling WPEngine API Key..."
      curl "https://api.wpengine.com/1.2/?method=site&account_name=$api_key_secret&wpe_apikey=$api_token"
      ;;
    "zendesk api key")
      echo "Handling Zendesk API key..."
      curl "https://$api_key_secret.zendesk.com/api/v2/users.json" -u "support@$api_key_secret.com/token:$api_token"
      ;;
    *)
      echo "API key type NOT FOUND"
      ;;
  esac
}

# Check if the number of arguments is valid
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <api_key_type> <api_key> <api_key_secret>"
  exit 1
fi

api_key_type=$1
api_token=$2
api_key_secret=$3

# Call the function with the provided arguments
handle_api_key "$api_key_type" "$api_token" "$api_key_secret"
