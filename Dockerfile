FROM node:12-alpine as builder

WORKDIR /home/builder
ADD . .
RUN npm install && npm run build

FROM node:12-alpine

EXPOSE 5000

# Copy resources
COPY --from=builder /home/builder/public /app

CMD ["npx", "serve", "-s", "/app"]