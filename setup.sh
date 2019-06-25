
{ 
  echo "USER_ID=$(id -u "${USER}")"
  echo "GROUP_ID=$(id -g "${USER}")"
  echo "HOME_SIM=/home/sim"
  echo "CURRENT_DIRECTORY=$(pwd)"
} > .env

echo "environment file created!"

mkdir -p videos && mkdir -p data && mkdir -p playground

echo "Directories for videos and data created"