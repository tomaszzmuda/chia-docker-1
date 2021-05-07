echo RUN FARMER
./farmer/run.sh
# ./plotter/run.sh
echo WAITING
sleep 5s
echo RUN PLOTTER
nohup bash plotter/run.sh 4 &