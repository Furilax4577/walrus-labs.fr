# Étape 1 : Build de l'application Angular
FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration=production

# Étape 2 : Servir l'application avec Nginx
FROM nginx:latest
COPY --from=build /app/dist/walrus-labs.fr/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
