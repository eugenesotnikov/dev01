#!/bin/bash
#
encore_name="teampreactumru_encore_1"
encore_state=`docker inspect $encore_name | grep "Running"`
encore_state=${encore_state:12}
php_name="teampreactumru_php_1"

# Обновится с гита
# git stash
# git pull

# Проверка на то,что контейнер с encore не запущен
echo "Собираем фронт"
if [[ "$encore_state" == '"Running": false,' ]]
then
# Запуск контейнера для сборки фронта 
#    docker start $encore_name
    docker-compose up -d encore
else
    echo "True"
fi

# Чистка кеша в конейнере с php 
echo "Чистим кеш php"
docker exec -u www-data -it $php_name bash -c "bin/console cache:clear --no-warmup -e prod"
