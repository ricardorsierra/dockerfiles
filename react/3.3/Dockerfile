FROM node:12.10.0

WORKDIR /usr/app

COPY package*.json ./

# RUN npm install -qy
RUN npm ci -qy

RUN npm install react-scripts@3.3.1 -g --silent

# Adicionando `/app/node_modules/.bin` para o $PATH
ENV PATH /app/node_modules/.bin:$PATH

COPY . .

EXPOSE 3000

CMD ["npm", "start"]