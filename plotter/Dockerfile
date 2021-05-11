FROM python:3.7

RUN pip install --extra-index-url https://hosted.chia.net/simple/ chia-blockchain==1.1.4 miniupnpc==2.1

COPY keyfile init.sh /root/
COPY plotman.yaml /root/.config/plotman/

RUN chia init
RUN chia keys add -f /root/keyfile && \
    rm /root/keyfile && \
    chia plots add -d /dst

RUN mkdir -p /home/chia/chia/logs
RUN chmod +x /home/chia/chia/logs
RUN pip install --force-reinstall git+https://github.com/ericaltendorf/plotman@main

CMD bash /root/init.sh
