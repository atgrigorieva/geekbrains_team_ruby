#!/bin/bash
# sudo chmod -R 777 ./pgdata
# if ! test -d "./pgdata/pg_commit_ts"; then
#   mkdir -p ./pgdata/pg_commit_ts/
# fi
# if ! test -d "./pgdata/pg_tblspc"; then
#   mkdir -p ./pgdata/pg_tblspc/
# fi
# if ! test -d "./pgdata/pg_replslot"; then
#   mkdir -p ./pgdata/pg_replslot/
# fi
# if ! test -d "./pgdata/pg_twophase"; then
#   mkdir -p ./pgdata/pg_twophase/
# fi
# if ! test -d "./pgdata/pg_stat_tmp/"; then
#   mkdir -p ./pgdata/pg_stat_tmp/
#   touch ./pgdata/pg_stat_tmp/global.tmp
# fi
# if ! test -d "./pgdata/pggrep john /etc/passwd_snapshots/"; then
#   mkdir -p ./pgdata/pg_snapshots/
# fi
# if ! test -d "./pgdata/pg_logical/snapshots/"; then
#   mkdir -p ./pgdata/pg_logical/snapshots/
# fi
# if ! test -d "./pgdata/pg_logical/mappings/"; then
#   mkdir -p ./pgdata/pg_logical/mappings/
# fi
case $1 in
  start)
    echo -e "\033[1;30m\033[46m SERVER STARTING \033[0m"
    docker-compose up --build
    docker exec -it parking_server chmod -R 777 .
    ;;
  daemon)
    echo -e "\033[1;32m\033[46m SERVER STARTING AS DAEMON\033[0m"
    docker-compose up -d --build
    ;;
  help)
    echo -e `cat description_server.txt`
    ;;
  rails)
    case $2 in
      c)
        docker exec -it parking_server rails c
        docker exec -it parking_server chmod -R 777 .
        ;;
      *)
        shift
        docker exec -it parking_server rails $@
        docker exec -it parking_server chmod -R 777 .
        ;;
    esac
    ;;
  seed)
    docker exec -it parking_server rails db:seed
    ;;
  migrate)
    # проверяем наличие базы и  если её не существует, создаем
    # если существует проводим миграции
    docker exec -it parking_server rails db:exists && docker exec -it parking_server rails db:migrate || docker exec -it parking_server rails db:setup
    ;;
  recreate_db)
    docker exec -it parking_server rails db:setup && docker exec -it parking_server rails db:setup
    ;;
  bash)
    case $2 in
      c)
        docker exec -it parking_server /bin/bash
        docker exec -it parking_server chmod -R 777 .
        ;;
      *)
        shift
        docker exec -it parking_server /bin/bash $@
        docker exec -it parking_server chmod -R 777 .
        ;;
    esac
    ;;
  psql)
    docker exec -it parking_database psql
    ;;
  stop)
    docker stop parking_database
    docker stop parking_server
    ;;
  bundle)
    shift
    docker exec -it parking_server bundle $@
    ;;
  yarn)
    shift
    docker exec -it parking_server yarn $@
    ;;
  rspec)
    shift
    if [ -z $1 ]; then
      RAILS_ENV=test
      docker exec -it parking_server rake db:exists && rake db:migrate || rake db:setup
      docker exec -it parking_server rspec
    else
      docker exec -it parking_server rspec $@
    fi
    ;;
  *)
    echo -e "\033[m\033[41m Dont' known command \033[0m"
    echo -e "\033[m\033[41m Use ./serverUp.sh start \033[0m"
    echo -e "\033[m\033[41m For start server \033[0m"
    ;;
esac