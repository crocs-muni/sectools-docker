FROM python:3

WORKDIR /booltest

COPY . /booltest
RUN pip3 install --upgrade --find-links=. .

CMD "booltest -h"