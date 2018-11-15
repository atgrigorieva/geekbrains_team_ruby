FROM ubuntu:14.04
# install nginx
RUN apt-get update -y
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
RUN rm -rf /etc/nginx/nginx/conf.d/*
ADD ./nginx.conf /etc/nginx/sites-available/parking.conf
WORKDIR /etc/nginx
CMD ["nginx"]