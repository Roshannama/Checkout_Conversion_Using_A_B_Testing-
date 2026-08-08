## checkout_ab_testing

| Table                 | Purpose               |
| --------------------- | --------------------- |
| users                 | Customer Master Table |
| products              | Product Catalog       |
| sessions              | Every Website Visit   |
| events                | Every User Action     |
| orders                | Successful Purchases  |
| experiment_assignment | A/B Test Groups       |

| Parent   | Child      | Relationship |
| -------- | ---------- | ------------ |
| Users    | Sessions   | One to Many  |
| Users    | Orders     | One to Many  |
| Users    | Assignment | One to One   |
| Sessions | Events     | One to Many  |
| Sessions | Orders     | One to Many  |
| Products | Orders     | One to Many  |
| Products | Events     | One to Many  |


| Table                 | Primary Key   |
| --------------------- | ------------- |
| users                 | user_id       |
| products              | product_id    |
| sessions              | session_id    |
| events                | event_id      |
| orders                | order_id      |
| experiment_assignment | assignment_id |

| Child Table           | FK         | Parent   |
| --------------------- | ---------- | -------- |
| sessions              | user_id    | users    |
| experiment_assignment | user_id    | users    |
| events                | session_id | sessions |
| events                | user_id    | users    |
| events                | product_id | products |
| orders                | user_id    | users    |
| orders                | session_id | sessions |
| orders                | product_id | products |
