# BASE IMAGE with an alias #
FROM node:14.2.0-alpine3.11 as build
WORKDIR /app

RUN npm install -g @angular/cli

COPY ./package.json .
RUN npm install
COPY . .
RUN ng build

# BASE IMAGE Nginx
FROM nginx as runtime
COPY --from=build /app/dist/lazyLoading /usr/share/nginx/html