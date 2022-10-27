#build stage###########################
FROM node:14.16.1 as builder

WORKDIR /app 
COPY ["package.json","tsconfig.json" , "./"]

USER 0
RUN npm install

COPY server/. .

RUN npm run build

#run stage###############################
FROM node:14.16.1-slim

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

USER node

COPY --from=builder /app /app

WORKDIR /app

EXPOSE 3000
CMD ["npm" , "start"]