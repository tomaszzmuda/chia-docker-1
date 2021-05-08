FROM python:3.7

RUN pip install --extra-index-url https://hosted.chia.net/simple/ chia-blockchain==1.1.4 miniupnpc==2.1
RUN pip install --force-reinstall git+https://github.com/ericaltendorf/plotman@main
RUN plotman config generate

COPY keyfile init.sh /root/

EXPOSE 8444

CMD bash /root/init.sh
