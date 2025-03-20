# Use an official Node.js runtime as a parent image
FROM node:14.17.0 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (if applicable)
# RUN npm run build

# Use a smaller base image for the final image
FROM node:14.17.0-slim

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app .

# Expose the application's port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]