FROM alpine:3

ENV MYSQL_HOST=127.0.0.1          \
    MYSQL_PORT=3306               \
    MYSQL_USER=ss                 \
    MYSQL_PASS=pass               \
    MYSQL_DB=sspanel              \
    TRANSFER=1.0                  \
    ENABLE_PORT=no                \
    DNS_1=1.1.1.1                 \
    DNS_2=8.8.8.8                 \
    SINGLEPORT=518                
RUN apk --no-cache add \
			libsodium-dev	\
			python3-dev	\
			libintl       && \
    apk --no-cache add --virtual .build-deps 	\
			tar		\
			py3-pip		\
			gettext		&&  \
    ln -s /usr/bin/python3 /usr/bin/python   && \
    ln -s /usr/bin/pip3    /usr/bin/pip      && \	
    cp  /usr/bin/envsubst  /usr/local/bin/  	 && \
    pip install --upgrade pip        	    	 && \
    pip install cymysql && touch /etc/hosts.deny && \
    apk del --purge .build-deps 

ADD . /root/shadowsocksr

WORKDIR /root/shadowsocksr

CMD envsubst < mysql.json > usermysql.json   && \
    envsubst < config.json > user-config.json && \
    chmod +x ./writeconfig.sh                 && \
    ./writeconfig.sh                          && \
    echo -e "${DNS_1}\n${DNS_2}\n" > dns.conf  && \
    python server.py
