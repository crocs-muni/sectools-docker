FROM ubuntu:22.04

WORKDIR /rtt

COPY . /rtt
RUN apt -y update;
RUN apt -y install ant gcc g++;
RUN apt -y install make libmysqlcppconn-dev
RUN apt -y install unzip wget;

RUN wget https://github.com/crocs-muni/rtt-statistical-batteries/archive/master.zip; unzip master.zip;
RUN cd rtt-statistical-batteries-master; sudo ./INSTALL; cd ..; make;

CMD ["./randomness-testing-toolkit"]
