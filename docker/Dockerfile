FROM mdillon/postgis:9.6


RUN apt-get -qq update --yes \
    && apt-get -qq install --yes --no-install-recommends \
    build-essential debconf git make wget\
    ca-certificates locales gnupg2 sudo vim \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update --yes \
&& apt-get -qq install --yes libdbix-safe-perl libdbd-pg-perl libboolean-perl postgresql-plperl-9.6

RUN mkdir -p /var/log/bucardo /var/run/bucardo \
&& chown -R postgres:postgres /var/log/bucardo /var/run/bucardo

ADD docker/postgres_setup/* /docker-entrypoint-initdb.d/

RUN mkdir /Bucardo
ADD docker/script.sh /Bucardo

WORKDIR /Bucardo

EXPOSE 25432
