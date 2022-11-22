user=$HOME;
devops=$user/devops;
base_dir=$devops/ruby-project;
config_dir=$devops/auto;
fe_dir=$base_dir/intern-fe-2022;
be_dir=$base_dir/intern-be-2022;

#stop current container
cd $base_dir
docker compose down
#handle file names 
cd $devops
count=`cat count.txt`
#backup old_file
if [ -d "$base_dir" ]; then
	sudo mv $base_dir $base_dir$count 
fi
#
cd $config_dir
# set-up for frontend
if [ -d "$fe_dir" ]; then
	sudo rm -r $fe_dir
fi
git clone --branch develop git@github.com:autuanthinh/intern-fe-2022.git $fe_dir
cp ./Dockerfile-fe $fe_dir/Dockerfile
rm $fe_dir/env/.env.development.js
cp ./.env.development.js $fe_dir/env/.env.development.js

#set-up for backend
if [ -d "$be_dir" ]; then
        sudo rm -r $be_dir
fi
git clone --branch devops git@github.com:autuanthinh/intern-be-2022.git $be_dir
cp ./Dockerfile-be $be_dir/Dockerfile

#config database.yml 
cp ./database.yml $be_dir/config
#docker-compose
cp ./docker-compose.yml $base_dir
#check project exist

#run
cd $base_dir	
docker compose up -d
