# build stage
FROM node:alpine as build
WORKDIR /app
COPY package.json ./
RUN npm install --silent
COPY . ./
RUN npm run build

# serve assets
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]