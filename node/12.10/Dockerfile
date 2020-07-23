FROM node:12.10.0-alpine

WORKDIR /usr/app

# COPY package*.json ./
RUN npm install -gqy nodemon
# # RUN npm install -qy
# RUN npm ci -qy


# Adicionando `/app/node_modules/.bin` para o $PATH
ENV PATH /app/node_modules/.bin:$PATH

COPY . .

EXPOSE 8080

CMD ["npm", "start"]