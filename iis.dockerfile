############################## STAGE 1: Build ##############################
# We label our stage as 'builder'
FROM angular-cli as angular-builder
WORKDIR /ng-app
COPY package.json package.json
RUN npm install
COPY . .
RUN ng build --prod --build-optimizer

################################ STAGE 2: Setup ##############################
FROM microsoft/iis:10.0.14393.206
COPY --from=angular-builder /ng-app/dist /ng-app
SHELL ["powershell"]
RUN Remove-WebSite -Name 'Default Web Site'
RUN New-Website -Name 'tour-or-heros' -Port 80 \
    -PhysicalPath 'c:\ng-app' -ApplicationPool '.NET v4.5'

 EXPOSE 80

# docker build -t tour-of-heros:1 .