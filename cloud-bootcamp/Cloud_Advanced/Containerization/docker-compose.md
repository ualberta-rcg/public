Docker Compose is a tool that defines and runs multi-container applications using a single YAML file, simplifying how you build, connect, and manage related services like web apps and databases with one command (docker compose up).

Example 1 — Simple static website using Compose

Let’s say you want to:

- Run Nginx on port 8080 on your host

- Serve your local HTML files

- Easily start/stop it with docker compose up

Folder structure:
```
my-nginx/
├── Dockerfile
├── docker-compose.yml
└── html/
    └── index.html
```


docker-compose.yml
```
services:
  web:
    build: .                   # Builds from your Dockerfile
    ports:
      - "8080:80"              # Map host 8080 → container 80
    volumes:
      - ./html:/usr/share/nginx/html:ro  # Serve local files
```

Example html:
```
<!-- html/index.html -->
<h1>Hello from Docker Compose + Nginx!</h1>
```

Run it:
```
docker compose up -d
```

Test it:
```
curl http://localhost:8080
```

Example 2 - A small Flask web app with a PostgreSQL database
Both services will be running in containers.

Goal:
- Use Docker Compose to run two services (web + database).

- Connect them automatically via Compose’s internal network.

- Persist database data using a volume.

Project structure:
```
flask-psql/
├── app/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── app.py
└── docker-compose.yml

```

app/app.py
```
from flask import Flask
import psycopg2

app = Flask(__name__)

@app.route('/')
def hello():
    # Connect to Postgres using service name 'db'
    conn = psycopg2.connect(
        dbname="exampledb",
        user="exampleuser",
        password="examplepass",
        host="db"   # service name from docker-compose.yml
    )
    cur = conn.cursor()
    cur.execute("SELECT NOW();")
    time = cur.fetchone()[0]
    cur.close()
    conn.close()
    return f"Hello from Flask! The database time is {time}.\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

app/requirements.txt
```
flask
psycopg2-binary
```

app/Dockerfile
```
FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

docker-compose.yml
```
services:
  web:
    build: ./app              # Build from app/Dockerfile
    ports:
      - "8080:5000"           # Host 8080 → Flask 5000
    depends_on:
      - db                    # Wait for db service to start
    environment:
      - DATABASE_HOST=db
      - DATABASE_NAME=exampledb
      - DATABASE_USER=exampleuser
      - DATABASE_PASSWORD=examplepass

  db:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_DB: exampledb
      POSTGRES_USER: exampleuser
      POSTGRES_PASSWORD: examplepass
    volumes:
      - pgdata:/var/lib/postgresql/data  # Persist data between runs

volumes:
  pgdata:
```

Run it:
```
docker compose up -d
```

Test it:
```
curl http://localhost:8080
```

```
```

==== Commonly used docker compose commands ====

1. Starting and managing containers
   
- Start all services

   ```docker compose up```

2. Start in the background (detached mode)

   ```docker compose up -d```

3. Rebuild and restart

   ```docker compose up -d --build```

2. Stopping and cleaning up
- Stop running containers

   ```docker compose stop```

3. Stop and remove everything

   ```docker compose down```

- Remove everything including named volumes

   ```docker compose down -v```

4. Inspecting and monitoring

- List all running services

   ```docker compose ps```

- View logs

   ```docker compose logs```

   - Add a service name to filter:

       ```docker compose logs -f web```

5. Managing services individually

- Start one service

   ```docker compose up -d web```

- Stop one service

   ```docker compose stop db```

- Restart a service

   ```docker compose restart web```

- Rebuild a service’s image

   ```docker compose build web```

6. Working with containers directly

- Run a command inside a service

   ```docker compose exec web bash```

  or 

   ```docker compose exec web sh```


- Run a one-off command without entering

  ```docker compose run web python --version```

7. Misc utilities
   
- List all volumes created

   ```docker volume ls```

- Remove stopped containers, unused images, networks

   ```docker system prune```

8. Other useful commands:

| Command                                    | Description                                                                                                                                           |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `docker compose attach <service>`          | Attach your terminal to a running service’s main process (like `docker attach` but for a Compose service). Use `Ctrl + p, Ctrl + q` to detach safely. |
| `docker compose exec <service> <command>`  | Run a command inside a running container (e.g., `docker compose exec web bash`).                                                                      |
| `docker compose run <service> <command>`   | Run a one-off command in a new container based on a service (useful for migrations, debugging).                                                       |
| `docker compose restart [service]`         | Restart one or all services.                                                                                                                          |
| `docker compose stop [service]`            | Stop one or all running services without removing containers.                                                                                         |
| `docker compose start [service]`           | Start already created (but stopped) containers.                                                                                                       |
| `docker compose build [service]`           | Build or rebuild service images from the `Dockerfile`.                                                                                                |
| `docker compose pull`                      | Pull service images from a registry.                                                                                                                  |
| `docker compose push`                      | Push built images to a registry.                                                                                                                      |
| `docker compose config`                    | Validate and view the final, merged Compose configuration.                                                                                            |
| `docker compose cp <src> <service>:<dest>` | Copy files between the local machine and a service container.                                                                                         |
| `docker compose top`                       | Show processes running inside your Compose containers.                                                                                                |

