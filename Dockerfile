FROM kennethfan/centos7.7:v1
COPY nginx-1.16.1.tar.gz /usr/local/src/
RUN  cd /usr/local/src && \
		 tar -zvxf nginx-1.16.1.tar.gz && \
		 mkdir /var/log/nginx && \
		 mkdir -p /var/log/nginx && \
		 mkdir -p /var/temp/nginx && \
		 cd nginx-1.16.1 && \
		 ./configure --prefix=/usr/local/nginx --pid-path=/var/run/nginx/nginx.pid --lock-path=/var/lock/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_gzip_static_module --http-client-body-temp-path=/var/temp/nginx/client --http-proxy-temp-path=/var/temp/nginx/proxy --http-fastcgi-temp-path=/var/temp/nginx/fastcgi --http-uwsgi-temp-path=/var/temp/nginx/uwsgi --http-scgi-temp-path=/var/temp/nginx/scgi && \
		 make && make install && \
		 rm -rf /usr/local/src/nginx-1.16.1 && \
		 sed -i '$d' /usr/local/nginx/conf/nginx.conf && \
		 mkdir /usr/local/nginx/conf/servers && \
		 mkdir /usr/local/nginx/workspace && \
		 echo "    include servers/*.conf;" >> /usr/local/nginx/conf/nginx.conf && \
		 echo "}" >> /usr/local/nginx/conf/nginx.conf && \
		 cat /usr/local/nginx/conf/nginx.conf && \
		 /usr/local/nginx/sbin/nginx -t

EXPOSE 80
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
