# Creating a Node server where node can be distilled for use in another server following this tutorial:
# https://stefanscherer.github.io/how-to-build-nodejs-nanoserver-image/
# Updated dockerfile found at: 
# https://github.com/StefanScherer/dockerfiles-windows/blob/master/nodejs-node-8897/node/Dockerfile
# Build Command: docker build -t node:8.11.3 .

FROM microsoft/windowsservercore:10.0.14393.2068

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV chocolateyUseWindowsCompression false

RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN choco install -y nodejs -version 8.11.3
RUN choco install -y git -params "/GitAndUnixToolsOnPath"
RUN npm install --global --production windows-build-tools

# RUN git clone https://github.com/nodejs/node.git
# RUN cd node ; git pull ; \
#     $env:PATH += ';C:\Users\ContainerAdministrator\.windows-build-tools\python27' ; \
#     .\vcbuild.bat test nosign