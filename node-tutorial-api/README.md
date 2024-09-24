```bash
CREATE TABLE IF NOT EXISTS `tutorials` (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  description varchar(255),
  published BOOLEAN DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

### 1. **Create a new Tutorial**
To create a new tutorial with a title, description, and published status:
```bash
curl -X POST http://localhost:8080/api/tutorials \
-H "Content-Type: application/json" \
-d '{
  "title": "Node.js Tutorial",
  "description": "Learn Node.js step by step.",
  "published": true
}'
```

### 2. **Retrieve all Tutorials**
To retrieve all tutorials:
```bash
curl -X GET http://localhost:8080/api/tutorials
```

### 3. **Retrieve all Published Tutorials**
To retrieve all tutorials that are published:
```bash
curl -X GET http://localhost:8080/api/tutorials/published
```

### 4. **Retrieve a single Tutorial by ID**
To retrieve a specific tutorial by its ID (replace `:id` with the actual tutorial ID, e.g., `1`):
```bash
curl -X GET http://localhost:8080/api/tutorials/1
```

### 5. **Update a Tutorial by ID**
To update an existing tutorial by its ID (replace `:id` with the actual tutorial ID, e.g., `1`):
```bash
curl -X PUT http://localhost:8080/api/tutorials/1 \
-H "Content-Type: application/json" \
-d '{
  "title": "Updated Node.js Tutorial",
  "description": "Updated description.",
  "published": false
}'
```

### 6. **Delete a Tutorial by ID**
To delete a specific tutorial by its ID (replace `:id` with the actual tutorial ID, e.g., `1`):
```bash
curl -X DELETE http://localhost:8080/api/tutorials/1
```

### 7. **Delete all Tutorials**
To delete all tutorials:
```bash
curl -X DELETE http://localhost:8080/api/tutorials
```
