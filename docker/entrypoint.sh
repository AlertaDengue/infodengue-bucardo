# bucardo install
bucardo install --batch 

# start bucardo
bucardo start

# add servidores
bucardo add dbdatabase hetzner dbhost=172.24.0.2 dbport=25432 dbname=dengue dbuser=dengueadmin dbpass=aldengue
bucardo add dbdatabase fgv dbhost=172.24.0.3 dbport=35432 dbname=dengue dbuser=dengueadmin dbpass=aldengue

# add banco de dados
bucardo add table % db=hetzner
bucardo add table % db=fgv

# add tabelas
bucardo add all tables --herd=hetzner_fgv db=hetzner
bucardo add all tables --herd=fgv_hetzner db=fgv

# add sync
bucardo add sync sync_hetznerTofgv relgroup=hetzner_fgv db=hetzner,fgv
bucardo add sync sync_fgvTohetzner relgroup=fgv_hetzner db=fgv,hetzner
