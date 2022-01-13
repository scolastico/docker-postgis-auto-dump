# docker-postgis-auto-dump
Docker [`postgis/postgis:13-master`](https://github.com/postgis/docker-postgis) container with automatic dump creation and loading.

### Usage
Simply mount the directory `/dump`. On shutdown the database will be dump'd to `database-dump.sql`. If on start the `/var/lib/postgresql/data` directory is empty/not mounted the database will be recreated based of the `/dump/database-dump.sql` file (if it exists).

### Example
```yaml
version: '3'
services:
  database:
    container_name: database
    image: ghcr.io/scolastico/docker-postgis-auto-dump:main
    volumes:
      - ./:/dump/
# If needed the 'normal database' mode can be activated by uncommenting the next line
#      - ./database:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: 'user'
      POSTGRES_PASSWORD: 'password'
      POSTGRES_DB: 'database'
```
