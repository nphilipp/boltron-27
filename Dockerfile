FROM fedora-modular-container-base-27_modular-20171031.n.1.x86_64:latest

MAINTAINER "James Antill <james.antill@redhat.com>"

ENV LANG=en_US.utf8 LC_ALL=en_US.UTF-8

# RUN microdnf install -y dnf glibc-langpack-en && microdnf clean all

ADD _copr_mhatina-dnf.repo /etc/yum.repos.d

ADD fedora.repo /etc/yum.repos.d

# Need latest DNF
ADD .bashrc /root
ADD image-data /
# RUN touch /USING_COPR
# RUN dnf distro-sync -y dnf python3-dnf dnf-conf && dnf clean all
# RUN dnf distro-sync -y && dnf clean all
# RUN dnf downgrade dnf-2.6.5-1.git.101.22c5c22.fc27 -y && dnf clean all

# ----------------------
# HACK
# RUN sed -i 's!metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-modular-server-bikeshed&arch=$basearch!metalink=https://mirrors.fedoraproject.org/metalink?repo=modular-bikeshed-server\&arch=$basearch!' /etc/yum.repos.d/fedora-modular-server-bikeshed.repo
# ----------------------
RUN dnf install -y glibc-langpack-en && dnf clean all


# RUN echo "enabled=true" >> /etc/yum.repos.d/fedora.repo
# RUN dnf remove -y vim-minimal && dnf install --allowerasing --rpm -y \
# vim-enhanced \
# nano \
# findutils \
# openssh-clients \
# man-pages \
# wget \
# tar \
# bzip2 \
# xz \
# which \
# less \
# createrepo \
# PyYAML \
 # && dnf clean all
# RUN echo "enabled=false" >> /etc/yum.repos.d/fedora.repo

# # This Requires the MBS Go binary (along with createrepo/PyYAML above) ...
# RUN mkdir -p /LOCAL/all
# RUN createrepo /LOCAL/all
# ADD m2c.py /
# ADD local.repo /etc/yum.repos.d
# ADD mbs-cli /
# ADD LOCAL.sh /
# # ...end of MBS


# # For module defaults
# ADD fedmod-comps-modmd.repo /etc/yum.repos.d
# RUN dnf install -y fedora-modular-defaults-server && dnf clean all
# RUN dnf install -y --enablerepo=fedora lsof rsync && dnf clean all

# RUN mkdir /etc/dnf/modules.defaults.d

# ADD http://modularity.fedorainfracloud.org/modularity/hack-fedora-f27-mods/all.repo /etc/yum.repos.d
# ADD http://modularity.fedorainfracloud.org/modularity/hack-fedora-f27-mods/all.defaults /etc/dnf/modules.defaults.d

# ADD REFRESH-REPOS.sh /
# ADD DEMO-PREP.sh /
# ADD CACHE-DEMO.sh /
# ADD CLEAN-MODULES.sh /

# ADD mod-hack.repo /etc/yum.repos.d

# ADD bikeshed.repo /etc/yum.repos.d
# ADD base-27.defaults /etc/dnf/modules.defaults.d
# ADD fedora-26-modular.repo /etc/yum.repos.d

ADD latest-Fedora-Modular-27.COMPOSE_ID /
# ADD https://kojipkgs.fedoraproject.org/compose/latest-Fedora-Modular-Bikeshed/COMPOSE_ID /latest-Fedora-Modular-Bikeshed.COMPOSE_ID

ADD list-modules-py3.py /
ADD in-modules-py3.py /

# RUN /in-modules-py3.py

# For debugging... (disabled by default)
# ADD rawhide.repo /etc/yum.repos.d

#hacking in older version of nodejs to demonstrate updates
#RUN dnf -y module enable nodejs-f26 && \
#    sed -i 's/version =/version =20170212165050/g' /etc/dnf/modules.d/nodejs.module && \
#    sed -i 's/profiles =/profiles =default/g' /etc/dnf/modules.d/nodejs.module && \
#    dnf -y install --rpm https://ttomecek.fedorapeople.org/modular-nodejs-6-10-2/nodejs-6.10.2-3.module_52f77d55.x86_64.rpm && \
#    dnf -y install --rpm https://ttomecek.fedorapeople.org/modular-nodejs-6-10-2/npm-3.10.10-1.6.10.2.3.module_52f77d55.x86_64.rpm

# RUN sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/fedora-modular-server-bikeshed.repo
# ADD http://modularity.fedorainfracloud.org/modularity/hack-fedora-f27-mods/bikey-mcbikeshed-2017-10-25.1.repo /etc/yum.repos.d
# RUN dnf distro-sync -y && dnf clean all


CMD ['/bin/bash']
