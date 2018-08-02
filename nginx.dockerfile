############################## STAGE 1: Build ##############################
FROM node:latest as angular-builder
WORKDIR /ng-app
COPY package.json package.json
RUN npm install
COPY . .
RUN npm run build -- --prod

################################ STAGE 2: Serve ##############################
FROM nginx:alpine
LABEL author="Joseph Hoyal"
COPY --from=angular-builder /ng-app/dist/angular-tour-of-heroes/ /usr/share/nginx/html
COPY ./nginx/default.conf /etc/nginx/conf.d/
CMD [ "nginx", "-g", "daemon off;" ]

# docker build -t nginx-angular .
# docker run -d -p 8080:80 nginx-angular




