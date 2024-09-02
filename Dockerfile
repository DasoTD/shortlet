# Use the official Node.js image from the Docker Hub
FROM node:22-alpine3.19

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 9792

# Command to run the application
CMD ["npm", "start"]
