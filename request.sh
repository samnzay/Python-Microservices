#Test MySQL Access:
mysql -h 127.0.0.1 -P 3307 -u root -psecret

#Get GetJWT_Token: 
curl -X POST http://mp3converter.com/login -u samnzay@gmail.com:Admin123

#Received Token:
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNhbW56YXlAZ21haWwuY29tIiwiZXhwIjoxNjgwMjUzNjAyLCJpYXQiOjE2ODAxNjcyMDIsImFkbWluIjp0cnVlfQ.S82kkCboZnzWFdUjuxasEhoXEDTQ_prtHU8AIrrh9yk

#Upload Video:
curl -X POST -F 'file=@./song.mp4' -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNhbW56YXlAZ21haWwuY29tIiwiZXhwIjoxNjgwMjUzNjAyLCJpYXQiOjE2ODAxNjcyMDIsImFkbWluIjp0cnVlfQ.S82kkCboZnzWFdUjuxasEhoXEDTQ_prtHU8AIrrh9yk' http://mp3converter.com/upload