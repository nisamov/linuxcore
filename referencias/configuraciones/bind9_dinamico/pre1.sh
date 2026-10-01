tsig-keygen -a hmac-sha256 ddns-key | sudo tee /etc/bind/ddns.key
sudo chown root:bind /etc/bind/ddns.key
sudo chmod 640 /etc/bind/ddns.key