mkdir -p appHomeBanking
echo "<html><body><h1>Bienvenido al Home Banking</h1></body></html>" > appHomeBanking/index.html
echo "<html><body><h1>Contacto</h1></body></html>" > appHomeBanking/contacto.html
vim dockerfile
#COPIAMOS LO SIGUIENTE 
FROM nginx:latest
COPY /appHomeBanking /usr/share/nginx/html
#INGRESO Y PUSHEADA DE IMAGEN
docker login -u ffranezequiel
docker build -t ffranezequiel/2parcial-ayso:v1.0 .
docker image list
docker push ffranezequiel/2parcial-ayso:v1.0
docker run -d -p 80:80 ffranezequiel/2parcial-ayso:v1.0
docker container ls
http://192.168.56.8:80/index.html
http://192.168.56.8:80/contacto.html


#imagen en docker hub: ffranezequiel/2parcial-ayso:v1.0


