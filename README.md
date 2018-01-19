# jenkins-jira-tools

As a developer, when I release new version of my awesome program -from master branch- I would like to have magically update "fix Versions" in all related jira tickets.

## To achieve that:
1. Make sure you have "jq" (https://stedolan.github.io/jq/) installed on your slave
2. Make sure you have "updateJiraFixVersions.sh" script on your slave
3. Use the code from Jenkinsfile
4. Adapt the code -Jenkinsfile and bash script- to your needs. Set jenkins user, jira url, tickets scheme etc.

## Usage (Jenkinsfile)
`def version = getVersion().trim();
 def tickets = getTickets().trim();
 sh "version=${version} tickets=${tickets} updateJiraFixVersions.sh"
`

## Todo:
Node?
