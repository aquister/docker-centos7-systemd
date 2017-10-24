FROM centos:centos7

ENV container docker
ENV TERM xterm
ENV LANG en_US.UTF-8
ENV PATH "${PATH}:/opt/puppetlabs/bin"

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update

RUN yum -y install epel-release
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install cmake clang clang-devel llvm-devel openssl-devel
RUN yum -y install dbus-x11 glew-devel gperf json-c-devel lsof lzip bc texinfo xz-devel
RUN yum -y install valgrind valgrind-devel valgrind.i686
RUN yum -y install libXcomposite libXrender.i686 glib2.i686 glibc-devel.i686
RUN yum -y install libSM.i686 libcurl-devel libpcap libpcap-devel libpng12.i686 libpng12.x86_64
RUN yum -y install fontconfig-devel.i686 fontconfig-devel.x86_64
RUN yum -y install mesa-libEGL-devel mesa-libGL-devel.i686 mesa-libGLU-devel.i686
RUN yum -y install python-devel python-lxml python-nose python-pip python-requests
RUN yum -y install python34-devel python34-pip
RUN yum -y install perl-Digest-SHA perl-Switch
RUN yum -y install ImageMagick SDL-devel GitPython
RUN yum -y install wget which vim

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
