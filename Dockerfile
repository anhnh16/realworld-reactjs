# Stage 1 - the build process
FROM node:12.16.1-alpine as build-deps

WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
RUN ls -alh
RUN yarn build

# Stage 2 - the production environment
FROM nginx:latest
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
