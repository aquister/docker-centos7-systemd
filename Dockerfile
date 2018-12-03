FROM centos:centos7

ENV container docker
ENV TERM xterm
ENV LANG en_US.UTF-8
ENV PATH "${PATH}:/opt/puppetlabs/bin"

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update

RUN yum -y install epel-release
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install cmake clang clang-devel llvm-devel openssl-devel \
  dbus-x11 glew-devel gperf json-c-devel lsof lzip bc texinfo xz-devel \
  valgrind valgrind-devel valgrind.i686 \
  libXcomposite libXrender.i686 glib2.i686 glibc-devel.i686 \
  libSM.i686 libcurl-devel libpcap libpcap-devel libpng12.i686 libpng12.x86_64 \
  fontconfig-devel.i686 fontconfig-devel.x86_64 \
  mesa-libEGL-devel mesa-libGL-devel.i686 mesa-libGLU-devel.i686 \
  python-devel python-lxml python-nose python-pip python-requests \
  python34-devel python34-pip perl-Digest-SHA perl-Switch \
  ImageMagick SDL-devel GitPython wget which vim lvm2

RUN pip install --upgrade pip
RUN pip3 install --upgrade pip

RUN yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]
