FROM node:12-alpine as builder

WORKDIR /home/builder
ADD . .
RUN npm install && npm run build

FROM node:12-alpine
RUN apk update; apk upgrade;
ENV APP_HOME /home/app

# Copy resources
WORKDIR $APP_HOME
COPY --from=builder /home/builder/public/ $APP_HOME/

EXPOSE 5000
CMD ["npx", "serve", "-s", "$APP_HOME"]
