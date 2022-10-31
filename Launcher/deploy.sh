#!/bin/bash
SRC_REPO=https://github.com/wnervhq/bootcamp-final-challenge
SRC_DIR=bootcamp-final-challenge/deployment

##format for text
pRed=$(tput setaf 1)
pGreen=$(tput setaf 2)
pNormal=$(tput sgr0)

docker_uninstall(){
    sudo apt-get remove docker docker-engine docker.io containerd runc
}

docker_validate(){
    if [ -x "$(command -v docker)" ]; then
    echo "${pRed}docker instalado${pNormal}"
    echo "${pRed}proximamente Update docker n_n${pNormal}"
    # command
    else
        echo "${pGreen}Install docker${pNormal}"
        docker_install
    fi

    if [ -x "$(command -v docker-compose)" ]; then
        echo "${pRed}docker-compose instalado${pNormal}"
        echo "${pRed}proximamente Update docker-compose n_n${pNormal}"
        # command
    else
        echo "${pGreen}Install docker-compose${pNormal}"
        docker-compose_install
    fi
}

docker_install(){
    echo "${pGreen}init System${pNormal}"
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo apt-get install -y git jq curl

    echo "${pGreen}docker version${pNormal}"
    docker --version

    echo "${pGreen}Finish docker install${pNormal}"
}

docker-compose_install(){
    # Install Docker Compose on Ubuntu
    echo "${pGreen}Install Docker Compose on Ubuntu${pNormal}"
    DC_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/docker/compose/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
    sudo curl -L "https://github.com/docker/compose/releases/download/$DC_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    echo "${pGreen}docker-compose version${pNormal}"
    docker-compose --version

    echo "${pGreen}Finish docker-compose install${pNormal}"
}

#validando instalacion de docker y docker-compose
docker_validate

# Clone REPO
echo "${pGreen}Clone REPO${pNormal}"
rm -Rf temp
mkdir temp
cd temp
git clone ${SRC_REPO}
cd ${SRC_DIR}

##Launch endpoints and reverse proxy
echo "${pGreen}Launch endpoints and reverse proxy${pNormal}"
sudo docker-compose up --build -d

# List docker
echo "${pGreen}List docker ps${pNormal}"
sudo docker ps

# rm -rf temp/
cd
echo "${pRed}delete temp${pNormal}"
rm -rf temp/
echo "${pGreen}finish${pNormal}"