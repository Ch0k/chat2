## Build Docker image

''' docker build -t chat2 . '''
''' docker buildx build --push --progress=plain \
  --platform linux/amd64 --platform linux/arm64 -t chat2 . '''
  
## Run Docker container

''' docker run  --network="host" -p 3000:3000 dimbo '''

## Docker Compose

''' docker-compose build '''
''' docker-compose run web bundle install '''
''' docker-compose run web yarn install '''
''' docker-compose run web rake db:create '''
''' docker-compose run web rake db:migrate '''
''' docker-compose up '''
''' docker-compose down '''
''' docker-compose run app rake db:migrate db:create '''