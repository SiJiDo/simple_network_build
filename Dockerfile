FROM nickistre/centos-lamp

COPY yum.repos.d/ /etc/yum.repos.d/

COPY src/ /var/www/html/

RUN rpm --rebuilddb \
    && yum install -y bind \
    && sed -i 's/{ 127.0.0.1; };/{ any; };/g' /etc/named.conf \
    && sed -i 's/{ ::1; };/{ any; };/g' /etc/named.conf \
    && sed -i 's/{ localhost; };/{ any; };/g' /etc/named.conf \
    && echo -e '\nzone "test.edu.cn" IN {\n\ttype master;\n\tfile "ipv4.edu.zone";\n\tallow-update { none; };\n};' >> /etc/named.rfc1912.zones
	
COPY named/ /var/named/

RUN service named start \
    && rpm --rebuilddb \
    && yum install -y vsftpd \
    && useradd -d /var/ftp/ftp ftptest \
    && echo "hello ftp" > /var/ftp/ftp/1.txt \
    && chmod 777 /var/ftp/ftp/1.txt \
    && service vsftpd start 
