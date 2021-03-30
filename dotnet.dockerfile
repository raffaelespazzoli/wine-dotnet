FROM scottyhardy/docker-wine:latest
ENV WINE32=/wine32
RUN mkdir -p ${WINE32}
RUN WINEPREFIX=${WINE32} WINEARCH=win32 winetricks win7
RUN WINEPREFIX=${WINE32} WINEARCH=win32 wine wineboot --init
RUN WINEPREFIX=${WINE32} WINEARCH=win32 winetricks -q --force dotnet461 corefonts 

#VOLUME /downloads
#ADD https://download.visualstudio.microsoft.com/download/pr/2892493e-df43-409e-af68-8b14aa75c029/53156c889fc08f01b7ed8d7135badede/dotnet-sdk-5.0.100-win-x64.exe /downloads/dotnet-sdk.exe
#RUN WINEPREFIX=${WINE64} WINEARCH=win64 wine64 /downloads/dotnet-sdk.exe /q
