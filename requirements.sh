echo "Installing dependencies..."

sudo apt-get install sqlite3

sudo cpanm DBI
sudo cpanm DBD::SQLite
sudo cpanm Time::Piece
sudo cpanm Text::TabularDisplay
