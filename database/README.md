# Uranus Database 

Esse banco de dados é responsável por armazenar todas as informações que são geradas pelo ecossistema de crawlers e workers do uranus, de forma organizada e de fácil acesso.

---

### Database Diagram

![](/files/uranus_database_diagram.png) 

---

### Data Catalog

COMPANY 
COLUMN | TYPE | DESCRIPTION
---- | ---- | ----
ID | INT / NOT NULL / AUTO INCREMENT | Lorem Ipsum
NAME | VARCHAR / NOT NULL | Name of Company
PHONE | 
MANAGER | 
STATUS | 

RULE
COLUMN | TYPE | DESCRIPTION
---- | ---- | ----
ID | INT / NOT NULL / AUTO INCREMENT | Lorem Ipsum
ID_COMPANY
STRING
SOURCE
FILTER
SCORE
DESCRIPTION
STATUS

#### ALERT 
COLUMN | TYPE | DESCRIPTION
---- | ---- | ----
ID | INT / NOT NULL / AUTO INCREMENT | Lorem Ipsum
ID_COMPANY
DATETIME
STATUS
NOTIFICATION
CONTENT
HASH

#### HISTORY 
COLUMN | TYPE | DESCRIPTION
---- | ---- | ----
ID | INT / NOT NULL / AUTO INCREMENT | Lorem Ipsum
ID_COMPANY |
ENGINE | 
DATETIME | 
RULE_QTT | 
EVENT_QTT |

---

### Setup

```
    $ docker build --rm --squash -t uranus-database ./database/
    $ docker run -d -p 3306:3306 --name database -e MARIADB_ROOT_PASSWORD=mypassword uranus-database
```

---