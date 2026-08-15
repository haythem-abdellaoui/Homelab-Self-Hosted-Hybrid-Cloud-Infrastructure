# ---- Stage 1 : installation des dépendances ----
FROM node:20-alpine AS deps
WORKDIR /app

# Copie des manifestes
COPY package.json package-lock.json ./
COPY backend/package.json ./backend/

# Installation des dépendances de prod
RUN npm ci --omit=dev --workspace=backend --ignore-scripts \
    && npm cache clean --force

# ---- Stage 2 : image finale minimale ----
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Création de l'utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copie de TOUT le dossier de travail (incluant tous les node_modules) avec les bons droits
COPY --from=deps --chown=appuser:appgroup /app ./
COPY --chown=appuser:appgroup backend/ ./backend/

WORKDIR /app/backend

# Passage sur l'utilisateur sécurisé
USER appuser

EXPOSE 3001

CMD ["node", "index.js"]