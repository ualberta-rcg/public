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
version: "3.9"

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


==== Commonly used docker compose commands ====

1. Starting and managing containers
   
▶️ Start all services
```docker compose up```

Builds images (if needed) and starts all containers.

Runs them in the foreground (shows logs).


▶️ Start in the background (detached mode)
```docker compose up -d```
Starts everything in the background.

You can continue using your terminal.

👉 Most common command during development.

🔄 Rebuild and restart
docker compose up -d --build


Forces Docker to rebuild images from the Dockerfile.

Useful after changing code or dependencies.

🧹 2. Stopping and cleaning up
🛑 Stop running containers
docker compose stop


Stops containers but keeps them (and their data) around.

❌ Stop and remove everything
docker compose down


Stops containers

Removes them, networks, and default volumes.

💣 Remove everything including named volumes
docker compose down -v


Also removes data volumes → fresh start.

⚠️ Be careful — this deletes your DB data if you use volumes!

🔍 3. Inspecting and monitoring
📋 List all running services
docker compose ps


Shows something like:

NAME               COMMAND                  STATUS          PORTS
myapp-web-1        "python app.py"          Up 3 minutes    0.0.0.0:8080->5000/tcp
myapp-db-1         "docker-entrypoint.s…"   Up 3 minutes    5432/tcp

📜 View logs
docker compose logs


or follow live logs:

docker compose logs -f


Add a service name to filter:

docker compose logs -f web

🔁 4. Managing services individually
🔧 Start one service
docker compose up -d web

🚫 Stop one service
docker compose stop db

🔄 Restart a service
docker compose restart web

🔨 Rebuild a service’s image
docker compose build web

💾 5. Working with containers directly
🧠 Run a command inside a service
docker compose exec web bash


or if the container doesn’t have Bash:

docker compose exec web sh


→ You’re now inside the running container (useful for debugging).

🧮 Run a one-off command without entering
docker compose run web python --version


Runs a new temporary container for that command only.

⚙️ 6. Misc utilities
📦 List all volumes created
docker volume ls

🧼 Remove stopped containers, unused images, networks
docker system prune
