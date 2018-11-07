# build stage
FROM node:alpine as build
WORKDIR /app
COPY client/package.json ./
RUN npm install --silent
COPY client/. ./
RUN npm run build

# serve assets
FROM node:alpine
WORKDIR /app
COPY --from=build /app/build /app/build
COPY package.json /app
RUN npm install --silent --production
COPY server.js /app
EXPOSE 5000
CMD ["npm", "run", "prod"]