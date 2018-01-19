#!/bin/bash

cat << EOF

(∩｀-´)⊃━☆ﾟ.*･｡ﾟ Jenkins -> Jira Magic : update fixVersions

EOF

if [ -z $user ]; then
    user="__JENKINS_USER__"
fi

if [ -z $password ]; then
    password="__JENKINS_USER_PASSWORD__"
fi

if [ -z "$tickets" ]; then
    echo "(⊙＿⊙') Error: No tickets numbers. Where I should update version?"
    exit 1
else
    tickets=($tickets)
fi

if [ -z $version ]; then
    echo "(⊙＿⊙') Error: No version. What should I put in the tickets?"
    exit 1
fi

jiraUrl="__JIRA_URL__"
date=`date +%d/%b/%y`
createNewVersion=$(curl -s -H "Content-Type: application/json" -X POST -d '{"description": "New is always better","name": "'$version'","userReleaseDate": "'$date'","project": "__YOUR_PROJECT__","archived": false,"released": true}' -u $user:$password $jiraUrl/version)

response=$(jq '.' <<< $createNewVersion)
versionId=$(jq '.id' <<< $response)

if [ -z $"$versionId" ] || [ "$versionId" == "null" ]; then
cat << EOF
Something went wrong. I didn't get version id. Instead I got this:
$response

(⊙＿⊙') Error.

EOF
    exit 1
fi

for key in "${!tickets[@]}"; do 
  echo "$key ${tickets[$key]}";
  updateJiraTicket=$(curl  -s -H "Content-Type: application/json" -X PUT -d '{"update":{"fixVersions":[{"add":{"id":'$versionId'}}]}}' -u $user:$password $url/issue/${tickets[$key]})
done

cat << EOF

⊹╰(⌣ʟ⌣)╯⊹ Done.

EOF
