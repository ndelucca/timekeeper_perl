echo "Installing dependencies..."

sudo apt-get install sqlite3

sudo cpanm DBI
sudo cpanm DBD::SQLite
