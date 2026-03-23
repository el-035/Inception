FROM debian

#COPY <host-path> <image-path> - this instruction tells the builder to copy files from the host and put them into the container image.

# Install the application dependencies
RUN apt-get update && apt-get install -y nginx openssl

#make directory for ssl certificate and generate it
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/cert.crt \
	-keyout /etc/nginx/ssl/cert.key \
	-subj "/C=AT/ST=Vienna/L=Vienna/O=42 Vienna/OU=efittant/CN=efittant.42.fr"


#copy configuration files 

EXPOSE 443

#CMD