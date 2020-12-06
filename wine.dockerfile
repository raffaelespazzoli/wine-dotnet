# based on https://alesnosek.com/blog/2015/07/04/running-wine-within-docker/
# wouldn't ubuntu be better as a base image?

FROM debian
RUN dpkg --add-architecture i386
RUN apt-get update
# wasn't able to install unrar and winetricks. Also gecko is not installed anymore, not sure why.
RUN apt-get install --no-install-recommends --assume-yes wine wine32 wine64 wget curl libwine libwine:i386 fonts-wine wine-binfmt cabextract p7zip unzip wget zenity ca-certificates
#VOLUME /usr/share/wine/gecko
#RUN mkdir /usr/share/wine/gecko
#ADD http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi /usr/share/wine/gecko/
#ADD http://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86_64.msi /usr/share/wine/gecko/
ENV WINE32=/wine32
ENV WINE64=/wine64
ENV DISPLAY :0
RUN mkdir ${WINE32}
RUN mkdir ${WINE64}
RUN WINEPREFIX=${WINE32} WINEARCH=win32 wine wineboot
RUN WINEPREFIX=${WINE64} WINEARCH=win64 wine64 wineboot
ADD https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/local/bin/winetricks
RUN chmod +x /usr/local/bin/winetricks
