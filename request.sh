#Test MySQL Access:
mysql -h 127.0.0.1 -P 3307 -u root -psecret

#Get GetJWT_Token: 
curl -X POST http://mp3converter.com/login -u your@email.com:Admin123

#Received Token:
Token

#Upload Video:
curl -X POST -F 'file=@./song.mp4' -H 'Authorization: Bearer {Token}' http://mp3converter.com/upload
