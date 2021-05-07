docker volume create chia-db
docker build -t clx/chia-farmer farmer/
docker build -t clx/chia-plotter plotter/

./farmer/run.sh
# ./plotter/run.sh
nohup bash plotter/run.sh 4 &