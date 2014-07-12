del /f .git/index.lock
git remote set-url origin git://github.com/thomedw/prosperhmt.git
git reset --hard
git pull
start javaw -Xmx900m -Dprospermobile.url=http://prospermobile.katalis.cloudbees.net/ -jar principal.jar
