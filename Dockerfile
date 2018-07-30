############################## STAGE 1: Build ##############################
# We label our stage as 'builder'
FROM angular-cli as angular-builder
WORKDIR /ng-app
COPY package.json package.json
RUN npm install
COPY . .
RUN ng build --prod --build-optimizer

# ############################## STAGE 2: Setup ##############################
FROM microsoft/iis:10.0.14393.206
COPY --from=angular-builder /ng-app/dist /ng-app
SHELL ["powershell"]
RUN Remove-WebSite -Name 'Default Web Site'
RUN New-Website -Name 'tour-or-heros' -Port 80 \
    -PhysicalPath 'c:\ng-app' -ApplicationPool '.NET v4.5'

EXPOSE 80

# docker build -t tour-of-heros:1 .




# COPY package.json ./
# RUN npm set progress=false && npm config set depth 0 && npm cache clean --force


# ## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
# RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app
# WORKDIR /ng-app
# COPY . .

# ## Build the angular app in production mode and store the artifacts in dist folder
# RUN $(npm bin)/ng build --prod


# ############################## STAGE 2: Setup ##############################
# FROM nginx:1.15.1-alpine

# ## Copy our default nginx config
# COPY nginx/default.conf /etc/nginx/conf.d/

# ## Remove default nginx website
# RUN rm -rf /usr/share/nginx/html/*

# ## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
# COPY --from=builder /ng-app/dist /usr/share/nginx/html
# CMD ["nginx", "-g", "daemon off;"]






# FROM johnpapa/angular-cli as angular-built
# Using the above image allows us toskip the angular-cli install
# FROM node:8.9-alpine as angular-built
# WORKDIR /usr/src/app
# RUN npm i -g @angular/cli
# COPY package.json package.json
# RUN npm install --silent
# COPY . .
# RUN ng build --prod --build-optimizer

# FROM nginx:alpine
# LABEL author="John Papa"
# COPY --from=angular-built /usr/src/app/dist /usr/share/nginx/html
# EXPOSE 80 443
# CMD [ "nginx", "-g", "daemon off;" ]