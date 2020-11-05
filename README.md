# README

Я не использовал базу данных и Active Job, вместо этого написал puma плагин который в фоне вызывает сервис отслеживания изменения курса. Плагин можно найти в папке lib/puma/plugin/

Код обновления курса ищите в app/services. Интегральный тест test/integration/main_flow_test.rb

Админка реализована на vuejs. Для оформления задействован bootstrap. Коммуникация между клиентом и сервером налажена при помощи Action Cable

Для развертывания понадобится yarn:
```npm install yarn```

Далее по шагам:
```
git clone git@github.com:kiri2lov/quotz.git
cd quotz
bundle install
yarn install
rake test && foreman start
```
