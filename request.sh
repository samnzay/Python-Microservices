#Get GetToken: 
curl -X POST http://mp3converter.com/login -u samnzay@gmail.com:Admin123

#Token:
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNhbW56YXlAZ21haWwuY29tIiwiZXhwIjoxNjgwMjUzNjAyLCJpYXQiOjE2ODAxNjcyMDIsImFkbWluIjp0cnVlfQ.S82kkCboZnzWFdUjuxasEhoXEDTQ_prtHU8AIrrh9yk

#Upload Video:
curl -X POST -F 'file=@./song.mp4' -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InNhbW56YXlAZ21haWwuY29tIiwiZXhwIjoxNjgwMjUzNjAyLCJpYXQiOjE2ODAxNjcyMDIsImFkbWluIjp0cnVlfQ.S82kkCboZnzWFdUjuxasEhoXEDTQ_prtHU8AIrrh9yk' http://mp3converter.com/upload