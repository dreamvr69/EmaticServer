Backend: Ruby on Rails 5

Frontend: Ember.js 2.8

Database: MongoDB

Для того, чтобы запустить сервер необходимо:

1) Установить Ruby on Rails

2) Установить MonogDB на компьютер https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/ (Установка на Ubuntu)

https://stackoverflow.com/questions/7948789/mongodb-mongod-complains-that-there-is-no-data-db-folder (Ошибка, которая может возникнуть)

3) Запустить сервер mongo командой 
```ruby
mongod
```

4) При запуске может возникать проблема addr *already in use* (https://stackoverflow.com/questions/6478113/unable-to-start-mongodb-local-server). Решение в ответе к посту: sudo killall -15 mongod 

5) Запустить рельсовый сервер из корня проекта
```ruby
rails s
```
6) При установке гемов могут возникнуть ошибки, вот ссылки на решение некоторых:
https://stackoverflow.com/questions/40154671/error-installing-nio4r

Для запуска frontend-сервера необходимо
1) Установить npm

2) Установить nvm

3) Установить nodejs версии 4.2.6

3) https://www.emberjs.com/

4) Перейти в папку frontend

5) ember build

6) Если возникают проблемы вне описаных, то выполнить действия из https://team-melbourne-rgsoc2015.github.io/ember-node-handlebars-broccoli/

