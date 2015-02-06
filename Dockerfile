FROM miiton/ubuntu:14.10
MAINTAINER miiton

# Install packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    nginx
ADD supervisord_nginx.conf /etc/supervisor/conf.d/nginx.conf
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.org
RUN echo "daemon off;" > /etc/nginx/nginx.conf
RUN cat /etc/nginx/nginx.conf.org >> /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/sites-enabled
RUN ln -s /opt/proxy/conf /etc/nginx/sites-enabled

EXPOSE 80 443
ENTRYPOINT ["/usr/bin/supervisord"]
