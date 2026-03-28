FROM debian:12

# Install the application dependencies
RUN apt-get update && apt-get install -y nginx openssl

#make directory for ssl certificate and generate it
#-x509: Output a self-signed certificate instead of a CSR.
#-nodes: Does not prompt for pasword (Does not protect the private key with a password)
#-keyout: Specify the output file for the private key.
#-out: Specify the output file (CSR or certificate).
#-subj: Set the subject name without interactive prompts.
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/cert.crt \
	-keyout /etc/nginx/ssl/cert.key \
	-subj "/C=AT/ST=Vienna/L=Vienna/O=42 Vienna/OU=student/CN=efittant.42.fr"

#copy server configuration file into default conf file 
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

#CMD
#-g lets you pass global directive (aka override conf at runtime)
#deamon off: makes program runs on foreground (otherwise main process would exit)
CMD ["nginx", "-g", "daemon off;"]