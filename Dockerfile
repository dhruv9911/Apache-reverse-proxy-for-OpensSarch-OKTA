FROM amazonlinux:latest
RUN yum update -y
RUN yum install httpd
RUN yum install mod_ssl
RUN yum install mod_auth_openidc
COPY vhost.conf /etc/httpd/conf.d
COPY openidc.conf /etc/httpd/conf.d
COPY selfsign.crt /etc/pki/tls/certs/selfsign.crt
COPY selfsign.key /etc/pki/tls/private/selfsign.key
COPY index.html /var/www/html/index.html
RUN touch /var/log/httpd/access.log
RUN touch /var/log/httpd/error.log
RUN ln -sf /dev/stderr /var/log/httpd/error.log
RUN ln -sf /dev/stdout /var/log/httpd/access.log
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80