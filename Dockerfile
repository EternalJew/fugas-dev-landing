# build environment
FROM node:12.2.0-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json
RUN npm install --silent
RUN npm config set unsafe-perm true
COPY . /app
RUN npm run build

# production environment
FROM steebchen/nginx-spa:stable
COPY --from=build /app/public /app
EXPOSE 80
CMD ["nginx"]