## as builder will tag the entire build for using furthur
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install 

COPY . .

## it will create a folder /app/build
RUN npm run build 

FROM nginx

## to reduse the build layers, so we are copiing /app/build to nginx static default directory.
COPY --from=builder /app/build /usr/share/nginx/html

