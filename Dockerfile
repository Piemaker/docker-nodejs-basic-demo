# Note that docker treats commands as layers; so each step you write 
# is done after the other in order to cache such layers and prevent any redundant work

# this will make an environmemt specifically for node
# 1- Layer 1
FROM node:12

# this is will cd into the app directory, any subsequent commands will happen relative to this directory
# 2- Layer 2
WORKDIR /app

# this will copy the package.json file to the current working directory 
# since the workdir has been changed to /app so it will happen in /app
# a small difference between docker and normal application is that you 
# get your source code then you install the packages, here we install the 
# packages first because we want to cache them and avoid their installiton
# on every source code change
# 3- Layer 3
COPY package*.json ./

# 4- Layer 4
RUN npm install

# this will copy all the files from the current directory to the curernt
# docker directory, however, this will create a problem because the node_modules
# folder is redundant so we have to make a dockerignore file
# 5- Layer 5
COPY . .

# this is the same as the node application port
# 6- Layer 1=6
ENV PORT=8080

# 7- Layer 7
EXPOSE 8080

# docker can have only one command; this will run the applicaiton
# 8- Layer 8
CMD [ "npm", "start" ]


# to build use:
# docker build -t docker101tutorial .

# to run use (notice you have to use port forwording -p in order for the container to be mapped to a current port):
# docker run -p 8080:8080  sha256:0f7920f4de5f04482483a78b000fdf9c59712addded35231dd840d7df47d60e0

# containers will continue to run even after closing the terminal
# close them by using the desktop app
