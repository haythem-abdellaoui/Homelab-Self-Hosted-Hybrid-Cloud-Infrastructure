# --- ÉTAPE 1 : Build du Frontend ---
FROM node:20-alpine AS builder
WORKDIR /app

# Copie des manifests de la racine ET des sous-dossiers
COPY package*.json ./
COPY frontend/package*.json ./frontend/
COPY backend/package*.json ./backend/

# Installation des dépendances via workspaces
RUN npm ci

# Copie du reste du code
COPY . .

# Build ciblé sur le workspace frontend
RUN npm run build -w frontend

# --- ÉTAPE 2 : Serveur Nginx ---
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

# Copie des fichiers générés par Vite depuis le dossier frontend/dist
COPY --from=builder /app/frontend/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]