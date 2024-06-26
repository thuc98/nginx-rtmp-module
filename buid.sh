#!/bin/sh
set -eo nounset                              # Treat unset variables as an error
NGINX_VERSION=1.26.0
BASE_DOWNLOAD_URI=http://nginx.org/download
#NGINX_VERSION=`curl -L "$BASE_DOWNLOAD_URI" |
#   grep -oP 'href="nginx-\K[0-9]+\.[0-9]+\.[0-9]+' |
#   sort -t. -rn -k1,1 -k2,2 -k3,3 | head -1`
#NGINX_URI="$BASE_DOWNLOAD_URI/nginx-$NGINX_VERSION.tar.gz"
#echo $NGINX_URI
#if [ ! -x "`which curl 2>/dev/null`" ];then
#        echo "Need to install curl."
#        exit 2
#fi
 
rm -rf /tmp/builddir/nginx-$NGINX_VERSION
mkdir -p /tmp/builddir/nginx-$NGINX_VERSION
cp -r . /tmp/builddir/nginx-$NGINX_VERSION/nginx-rtmp-module
cd /tmp/builddir
#rm -rf nginx
#curl $NGINX_URI > kaltura-nginx-$NGINX_VERSION.tar.gz
cp '/Users/macbook/nginx-1.26.0.tar.gz'  kaltura-nginx-$NGINX_VERSION.tar.gz
tar zxf kaltura-nginx-$NGINX_VERSION.tar.gz

mv nginx-$NGINX_VERSION nginx
cd nginx

FFMPEG_VERSION=4.2.2
LD_LIBRARY_PATH=/opt/kaltura/ffmpeg-$FFMPEG_VERSION/lib
LIBRARY_PATH=/opt/kaltura/ffmpeg-$FFMPEG_VERSION/lib
C_INCLUDE_PATH=/opt/kaltura/ffmpeg-$FFMPEG_VERSION/include
export LD_LIBRARY_PATH LIBRARY_PATH C_INCLUDE_PATH

./configure \
        --add-module=./nginx-rtmp-module \
        --prefix=/etc/nginx \
        --sbin-path=/tmp/builddir/bin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/log/nginx/error.log \
        --http-log-path=/var/log/log/nginx/access.log \
        --pid-path=/var/log/run/nginx.pid \
        --lock-path=/var/log/run/nginx.lock \
        --http-client-body-temp-path=/var/log/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/log/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/log/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/log/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/log/cache/nginx/scgi_temp \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-ipv6 \
        --with-debug \
        --with-threads \
        $*
make -j $(nproc)
#   --with-file-aio \
#   --with-cc-opt="-O3 -mpopcnt" \