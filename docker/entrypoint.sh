# install
bucardo install --batch 

# start
bucardo start

# add servidores
bucardo add dbdatabase hetzner dbhost=$HOST_HETZNER dbport=$PORT_HETZNER dbname=$DB_HETZNER dbuser=$USER_HETZNER dbpass=$PASS_HETZNER
bucardo add dbdatabase fgv dbhost=$HOST_FGV dbport=$PORT_FGV dbname=$DB_FGV dbuser=$USER_FGV dbpass=$PASS_FGV

# add banco de dados
bucardo add table % db=hetzner
bucardo add table % db=fgv

# add tabelas
bucardo add all tables --herd=hetzner_fgv db=hetzner
bucardo add all tables --herd=fgv_hetzner db=fgv

# add sync
bucardo add sync sync_hetznerTofgv relgroup=hetzner_fgv db=hetzner,fgv
bucardo add sync sync_fgvTohetzner relgroup=fgv_hetzner db=fgv,hetzner

# status
bucardo status all