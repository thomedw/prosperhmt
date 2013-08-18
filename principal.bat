git remote set-url origin git://github.com/thomedw/prosperhmt.git
git reset --hard
git pull
start javaw -Xmx512m -Dprospermobile.url=http://prospermobile.katalis.cloudbees.net/ -jar principal.jar
