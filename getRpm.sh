#!/bin/bash

#---------------------------------------------
#command option
#---------------------------------------------

TOPDIR=$(cd $(dirname "$0") && pwd)
source $TOPDIR/localrc

function usage() {
    echo "./downrepo [-f the file path of your Centos.iso]"
    exit 0
}

while [ $# -gt 0 ]; do
  case "$1" in
    --help) usage;;
    -f|--file) shift; ISO_FILE_PATH=$1;;
    *) shift ;;
  esac
done

#---------------------------------------------
#check the iso.file is existed
#---------------------------------------------

if [ ! -f $ISO_FILE_PATH ]|| [ ! $ISO_FILE_PATH ]; then
echo "no ios file found ! --help for help"
exit
fi
#--------------------------------------------
#init the ios file path to mount
#--------------------------------------------

#TEMP=`mktemp`
TEMP=/usr/local/wgc2/centos; rm -rfv $TEMP >/dev/null; mkdir -p $TEMP;
#---------------------------------------------
#mount the iso in temp file
#---------------------------------------------

mount -t iso9660 -o loop $ISO_FILE_PATH $TEMP/

#---------------------------------------------
#get rpms_file name and cp to local_package from iso
#--------------------------------------------
TEMP_RPMFILES=$TOPDIR/rpm_files
cat << EOF >$TEMP_RPMFILES
apr-1.3.9-5.el6_2.x86_64.rpm
apr-util-1.3.9-3.el6_0.1.x86_64.rpm
apr-util-ldap-1.3.9-3.el6_0.1.x86_64.rpm
augeas-libs-1.0.0-5.el6.x86_64.rpm
boost-system-1.41.0-18.el6.x86_64.rpm
boost-thread-1.41.0-18.el6.x86_64.rpm
celt051-0.5.1.3-0.el6.x86_64.rpm
cloog-ppl-0.15.7-1.2.el6.x86_64.rpm
compat-readline5-5.2-17.1.el6.x86_64.rpm
cpp-4.4.7-4.el6.x86_64.rpm
createrepo-0.9.9-18.el6.noarch.rpm
cyrus-sasl-md5-2.1.23-13.el6_3.1.x86_64.rpm
deltarpm-3.5-0.5.20090913git.el6.x86_64.rpm
dnsmasq-2.48-13.el6.x86_64.rpm
ebtables-2.0.9-6.el6.x86_64.rpm
expect-5.44.1.15-5.el6_4.x86_64.rpm
fuse-libs-2.8.3-4.el6.x86_64.rpm
gcc-4.4.7-4.el6.x86_64.rpm
gcc-c++-4.4.7-4.el6.x86_64.rpm
gd-2.0.35-11.el6.x86_64.rpm
git-1.7.1-3.el6_4.1.x86_64.rpm
gnutls-utils-2.8.5-10.el6_4.2.x86_64.rpm
gpxe-roms-qemu-0.9.7-6.10.el6.noarch.rpm
graphviz-2.26.0-10.el6.x86_64.rpm
httpd-2.2.15-29.el6.centos.x86_64.rpm
httpd-tools-2.2.15-29.el6.centos.x86_64.rpm
iscsi-initiator-utils-6.2.0.873-10.el6.x86_64.rpm
keyutils-libs-devel-1.4-4.el6.x86_64.rpm
krb5-devel-1.10.3-10.el6_4.6.x86_64.rpm
libcom_err-devel-1.41.12-18.el6.x86_64.rpm
libgcrypt-devel-1.4.5-11.el6_4.x86_64.rpm
libgpg-error-devel-1.7-4.el6.x86_64.rpm
libicu-4.2.1-9.1.el6_2.x86_64.rpm
libselinux-devel-2.0.94-5.3.el6_4.1.x86_64.rpm
libsepol-devel-2.0.41-4.el6.x86_64.rpm
libstdc++-devel-4.4.7-4.el6.x86_64.rpm
libtool-ltdl-2.2.6-15.5.el6.x86_64.rpm
libXaw-1.0.11-2.el6.x86_64.rpm
libxml2-devel-2.7.6-14.el6.x86_64.rpm
libXmu-1.1.1-2.el6.x86_64.rpm
libXpm-3.5.10-2.el6.x86_64.rpm
libxslt-devel-1.1.26-2.el6_3.1.x86_64.rpm
lzop-1.02-0.9.rc1.el6.x86_64.rpm
memcached-1.4.4-3.el6.x86_64.rpm
mod_wsgi-3.2-3.el6.x86_64.rpm
mpfr-2.4.1-6.el6.x86_64.rpm
MySQL-python-1.2.3-0.3.c1.1.el6.x86_64.rpm
nc-1.84-22.el6.x86_64.rpm
netcf-libs-0.1.9-4.el6.x86_64.rpm
openssl-devel-1.0.1e-15.el6.x86_64.rpm
perl-DBD-MySQL-4.013-3.el6.x86_64.rpm
perl-Error-0.17015-4.el6.noarch.rpm
perl-Git-1.7.1-3.el6_4.1.noarch.rpm
ppl-0.10.2-11.el6.x86_64.rpm
PyPAM-0.5.0-12.el6.x86_64.rpm
python-babel-0.9.4-5.1.el6.noarch.rpm
python-decorator-3.0.1-3.1.el6.noarch.rpm
python-deltarpm-3.5-0.5.20090913git.el6.x86_64.rpm
python-devel-2.6.6-51.el6.x86_64.rpm
python-imaging-1.1.6-19.el6.x86_64.rpm
python-markupsafe-0.9.2-4.el6.x86_64.rpm
python-memcached-1.43-6.el6.noarch.rpm
python-paste-1.7.4-2.el6.noarch.rpm
python-pygments-1.1.1-1.el6.noarch.rpm
python-routes-1.10.3-2.el6.noarch.rpm
python-setuptools-0.6.10-3.el6.noarch.rpm
python-simplejson-2.0.9-3.1.el6.x86_64.rpm
python-suds-0.4.1-3.el6.noarch.rpm
python-tempita-0.4-2.el6.noarch.rpm
radvd-1.6-1.el6.x86_64.rpm
redhat-rpm-config-9.0.3-42.el6.centos.noarch.rpm
rpm-build-4.8.0-37.el6.x86_64.rpm
seabios-0.6.1.2-28.el6.x86_64.rpm
sgabios-bin-0-0.3.20110621svn.el6.noarch.rpm
sqlite-devel-3.6.20-1.el6.x86_64.rpm
tcl-8.5.7-6.el6.x86_64.rpm
tk-8.5.7-5.el6.x86_64.rpm
tree-1.5.3-2.el6.x86_64.rpm
unixODBC-2.2.14-12.el6_3.x86_64.rpm
usbredir-0.5.1-1.el6.x86_64.rpm
vgabios-0.6b-3.7.el6.noarch.rpm
xfsprogs-3.1.1-14.el6.x86_64.rpm
yajl-1.0.7-3.el6.x86_64.rpm
zlib-devel-1.2.3-29.el6.x86_64.rpm
EOF

mkdir -p vsm_repos
cat $TEMP_RPMFILES | while read line
do
    echo ${TEMP}/Packages/${line}
    cp -rf ${TEMP}/Packages/${line} $TOPDIR/vsm_repos
done
#------------------------------------------------
#rm temp file and umount the ISO file
#------------------------------------------------
umount $TEMP/
rm -rf $TEMP
rm -f $TEMP_RPMFILES

