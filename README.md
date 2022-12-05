# Sandbox Rails Deadlock

```shell-session
$ docker compose up
$ docker compose exec web bash
```

```shell-session
# rails db:create
# ridgepole -c config/database.yml -f db/Schemafile --apply
# rails db:seed
# rails runner "Relationship.bulk_insert(number_of_threads: 2)"
# rails runner "Relationship.bulk_insert(number_of_threads: 3)"
```
