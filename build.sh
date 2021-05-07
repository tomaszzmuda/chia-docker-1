docker volume create chia-db
docker build -t clx/chia-farmer farmer/
docker build -t clx/chia-plotter plotter/