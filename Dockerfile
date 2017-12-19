FROM centos:6.9

# |               | Version         | NOTE                                                          |
# |---------------|-----------------|---------------------------------------------------------------|
# | OS            | Cent OS 6.*     |                                                               |
# | npm           | 1.3.6           |                                                               |
# | pip           | 9.0.*           |                                                               |
# | Apache Httpd  | ~~2.2.*~~       |                                                               |
# | Nginx         | 1.10.*          |                                                               |
# | PHP-FPM       |                 |                                                               |
# | MySQL         |                 |                                                               |
# | Memcached     | 1.4.*           |                                                               |
# | Redis         |                 |                                                               |
# | PHP           | 7.1.*           |                                                               |
# | Python        | 2.7.*           | 3 以上だと supervisor が未対応                                |
# | Fabric        |                 |                                                               |
# | Apache Solr   | 5.5.*           |                                                               |
# | supervisor    | 3.3.*           |                                                               |

RUN \
yum update -y && \
yum install -y epel-release && \
yum update -y epel-release && \
rpm -ivh http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/el/releases/6/Everything/x86_64/os/puias-release-6-2.R.noarch.rpm && \
rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi && \
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
yum update -y remi-release && \
yum install -y which man wget vi vim git lsof screen tar ntp file zip sudo passwd rsyslog unzip tree mysql patch jq && \
yum install -y openssh-server openssh-clients autossh sendmail postfix crontabs gcc && \
yum install -y libevent-devel gettext-devel libmcrypt-devel mcrypt libyaml-devel && \
yum install -y nginx && \
yum install -y memcached-devel && \
yum install -y python27-devel python27-tools python27-setuptools python27-pip && \
pip2.7 install --upgrade pip && \
pip install urllib3 awscli virtualenv boto supervisor && \
yum install -y php71-php-devel php71-php && \
ln -s /usr/bin/php71 /usr/bin/php && \
yum install -y \
  php71-php-mbstring \
  php71-php-pdo \
  php71-php-cli \
  php71-php-mysqlnd \
  php71-php-xml \
  php71-php-opcache \
  php71-php-gd \
  php71-php-gmp \
  php71-php-mcrypt \
  php71-php-json \
  php71-php-phpiredis \
  php71-php-pecl-mysql \
  php71-php-pecl-apcu-devel \
  php71-php-pecl-memcache \
  php71-php-pecl-memcached \
  php71-php-pecl-msgpack-devel \
  php71-php-pecl-redis \
  php71-php-pecl-imagick \
  php71-php-pecl-zip \
  php71-php-fpm && \
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
yum install -y nodejs npm && \
npm install --global jshint eslint bower gulp && \
npm cache clear && \
mkdir -p /root/.ssh && \
/usr/bin/ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N '' && \
/usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N '' && \
mkdir -p /var/run/sshd && \
chmod 755 /var/run/sshd && \
yum clean all

CMD ["/usr/bin/supervisord"]
