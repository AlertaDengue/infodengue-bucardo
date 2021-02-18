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

# Install Bucardo:
RUN cd /tmp \
&& wget http://bucardo.org/downloads/Bucardo-5.4.1.tar.gz \
&& tar xvfz Bucardo-5.4.1.tar.gz \
&& mv Bucardo-5.4.1/ /Bucardo \
&& cd /Bucardo \
&& perl Makefile.PL \
&& apt install make \
&& make \
&& make install

ADD docker/.bucardorc $HOME/.bucardorc 
ADD docker/postgres_setup/00-bucardo_roles.sql /docker-entrypoint-initdb.d/
