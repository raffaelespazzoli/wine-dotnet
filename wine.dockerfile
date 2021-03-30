# based on https://alesnosek.com/blog/2015/07/04/running-wine-within-docker/
# wouldn't ubuntu be better as a base image?

FROM ubuntu
#RUN dpkg --add-architecture i386
#RUN apt-get update

# Install prerequisites
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        cabextract \
        git \
        gosu \
        gpg-agent \
        p7zip \
        pulseaudio \
        pulseaudio-utils \
        software-properties-common \
        tzdata \
        unzip \
        wget \
        winbind \
        xvfb \
        zenity \
    && rm -rf /var/lib/apt/lists/*

# Install wine
ARG WINE_BRANCH="stable"
RUN wget -nv -O- https://dl.winehq.org/wine-builds/winehq.key | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - \
    && apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2) main" \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --install-recommends winehq-${WINE_BRANCH} \
    && rm -rf /var/lib/apt/lists/*

# Install winetricks
RUN wget -nv -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/bin/winetricks


#RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --assume-yes wine wine32 wine64 winetricks wget curl libwine libwine:i386 fonts-wine ttf-mscorefonts-installer winbind unrar cabextract p7zip unzip wget zenity ca-certificates xvfb
ENV WINE32=/wine32
ENV WINE64=/wine64
ENV DISPLAY :0
RUN mkdir -p ${WINE32}
RUN mkdir -p ${WINE64}
RUN WINEPREFIX=${WINE32} WINEARCH=win32 wine wineboot
RUN WINEPREFIX=${WINE64} WINEARCH=win64 wine64 wineboot
#VOLUME /usr/share/wine/gecko
#RUN mkdir -p /usr/share/wine/gecko
#ADD http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi /usr/share/wine/gecko/
#ADD http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi /usr/share/wine/gecko/
#RUN WINEPREFIX=${WINE32} WINEARCH=win32 wine msiexec /i /usr/share/wine/gecko/wine-gecko-2.47.1-x86.msi
#RUN WINEPREFIX=${WINE64} WINEARCH=win64 wine64 msiexec /i /usr/share/wine/gecko/wine_gecko-2.47.1-x86_64.msi
#ADD https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/local/bin/winetricks
#RUN chmod +x /usr/local/bin/winetricks
