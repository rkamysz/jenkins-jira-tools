@NonCPS
def getTickets() {
    def tickets = []
    def arr = currentBuild.rawBuild.getChangeSets()
    for (int i=0; i < arr.size(); i++) {
      def msg = arr[i].getMsg();
      def ticketNumber = sh (
        script: "echo ${msg} | sed 's/.*\\(__PROJECT_KEY__-[0-9]\\{1,10\\}\\).*/\\1/'",
        returnStdout: true
        )
        tickets.push(ticketNumber);
    }
  return tickets.join(" ");
}

def getVersion = sh (
 script: `jq '. | [.name, .version] | join("@")' < package.json`,
 returnStdout: true
)

//... 

stage ("Update version in Jira tickets") {
  def version = getVersion().trim(); //output: some-awesome-package@x.x.x
  def tickets = getTickets().trim(); //output: XXXX-1234 XXXX-5678 XXXX-91011 
  sh "version=${version} tickets=${tickets} updateJiraFixVersions.sh"
}
