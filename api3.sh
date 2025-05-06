if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <api_key> <api_key_secret> <tenant_id>"
  exit 1
fi

api_token=$1
api_key_secret=$2
tenant_id=$3

echo "Handling Microsoft Azure Tenant..."
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "client_id=$api_token&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret=$api_key_secret&grant_type=client_credentials" "https://login.microsoftonline.com/$tenant_id/oauth2/v2.0/token"
