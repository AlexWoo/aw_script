#!/bin/bash

usage()
{
    echo "usage: $0 install [registry]"
    echo "usage: $0 uninstall [registry]"
    exit 1
}

# install
install_docker()
{
    echo "Install docker engine"
    yum update
    curl -fsSL https://get.docker.com/ | sh
    useradd -r docker -g docker
    systemctl enable docker.service
    systemctl start docker
    curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
}

install_registry()
{
    echo "unsupport install registry now"
}

install()
{
    install_docker
    if [ $2 == "registry" ];then
        install_registry
    fi
}

# uninstall
uninstall_docker()
{
    yum -y remove docker-engine.x86_64
    yum -y remove docker-engine-selinux.noarch
    rm -rf /var/lib/docker
    rm -f /usr/local/bin/docker-compose
}

uninstall()
{
    uninstall
}

if [ $# -lt 1 ];then
    usage
elif [ $1 == "install" ];then
    install
elif [ $1 == "uninstall" ];then
    uninstall
else
    usage
fi

