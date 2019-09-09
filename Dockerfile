FROM httpd:2.4 as builder
ARG MOD_AUTH_CAS_VERSION=v1.2
RUN apt update && apt install -y libapr1-dev libcurl4 libcurl4-openssl-dev libpcre3-dev libaprutil1-dev git dh-autoreconf libssl-dev
RUN mkdir -p /opt && git clone --branch $MOD_AUTH_CAS_VERSION https://github.com/apereo/mod_auth_cas.git /opt/mod_auth_cas
RUN cd /opt/mod_auth_cas && autoreconf -ivf && ./configure && make && make install

FROM httpd:2.4
COPY --from=builder /usr/local/apache2/modules/mod_auth_cas.so /usr/local/apache2/modules/mod_auth_cas.so 
