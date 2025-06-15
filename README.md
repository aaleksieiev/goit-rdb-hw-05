#  Домашнє завдання 5

```
anton@anton-Latitude-7420:~/Documents/test-csv-data$ docker exec -it mysql3 mysql -uroot -p --local-infile=ON
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 9.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use mydb;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed

/**
1. Напишіть SQL запит, який буде відображати таблицю order_details та поле customer_id з таблиці orders відповідно для кожного поля запису з таблиці order_details.

Це має бути зроблено за допомогою вкладеного запиту в операторі SELECT.
**/

mysql> select od.*, o.customer_id from order_details od, orders o limit 5;
+----+----------+------------+----------+-------------+
| id | order_id | product_id | quantity | customer_id |
+----+----------+------------+----------+-------------+
|  1 |    10248 |         11 |       12 |          91 |
|  1 |    10248 |         11 |       12 |          90 |
|  1 |    10248 |         11 |       12 |          89 |
|  1 |    10248 |         11 |       12 |          89 |
|  1 |    10248 |         11 |       12 |          88 |
+----+----------+------------+----------+-------------+
5 rows in set (0.001 sec)

/**
2. Напишіть SQL запит, який буде відображати таблицю order_details. Відфільтруйте результати так, щоб відповідний запис із таблиці orders виконував умову shipper_id=3.

Це має бути зроблено за допомогою вкладеного запиту в операторі WHERE.
**/
mysql> select od.*, o.customer_id, o.shipper_id from order_details od, orders o where o.shippe
+----+----------+------------+----------+-------------+------------+
| id | order_id | product_id | quantity | customer_id | shipper_id |
+----+----------+------------+----------+-------------+------------+
|  1 |    10248 |         11 |       12 |          51 |          3 |
|  1 |    10248 |         11 |       12 |          60 |          3 |
|  1 |    10248 |         11 |       12 |          31 |          3 |
|  1 |    10248 |         11 |       12 |          73 |          3 |
|  1 |    10248 |         11 |       12 |          87 |          3 |
+----+----------+------------+----------+-------------+------------+
5 rows in set (0.001 sec)

/**
3. Напишіть SQL запит, вкладений в операторі FROM, який буде обирати рядки з умовою quantity>10 з таблиці order_details. Для отриманих даних знайдіть середнє значення поля quantity — групувати слід за order_id.
**/

mysql> select count(ag.order_id), avg(ag.quantity) from ( select * from order_details where quantity>10) as ag group by ag.order_id limit 5;
+--------------------+------------------+
| count(ag.order_id) | avg(ag.quantity) |
+--------------------+------------------+
|                  1 |          12.0000 |
|                  1 |          40.0000 |
|                  2 |          25.0000 |
|                  2 |          17.5000 |
|                  3 |          35.0000 |
+--------------------+------------------+
5 rows in set (0.001 sec)

/**
4. Розв’яжіть завдання 3, використовуючи оператор WITH для створення тимчасової таблиці temp. Якщо ваша версія MySQL більш рання, ніж 8.0, створіть цей запит за аналогією до того, як це зроблено в конспекті.
**/
mysql> with cte as
    -> (select count(order_id) order_id_count, avg(quantity) avg_quantity
    -> from order_details
    -> where quantity  > 10
    -> group by order_id)
    -> select cte.order_id_count, cte.avg_quantity from cte limit 10;
+----------------+--------------+
| order_id_count | avg_quantity |
+----------------+--------------+
|              1 |      12.0000 |
|              1 |      40.0000 |
|              2 |      25.0000 |
|              2 |      17.5000 |
|              3 |      35.0000 |
|              3 |      34.0000 |
|              3 |      19.0000 |
|              4 |      27.5000 |
|              2 |      13.5000 |
|              2 |      20.0000 |
+----------------+--------------+
10 rows in set (0.003 sec)

/**
5. Створіть функцію з двома параметрами, яка буде ділити перший параметр на другий. Обидва параметри та значення, що повертається, повинні мати тип FLOAT.

Використайте конструкцію DROP FUNCTION IF EXISTS. Застосуйте функцію до атрибута quantity таблиці order_details . Другим параметром може бути довільне число на ваш розсуд.
**/


mysql> DROP FUNCTION IF EXISTS divide_floats;
Query OK, 0 rows affected, 1 warning (0.018 sec)

mysql> DELIMITER $$
mysql> CREATE FUNCTION divide_floats(a FLOAT, b FLOAT)
    -> RETURNS FLOAT
    -> DETERMINISTIC
    -> BEGIN
    -> DECLARE result FLOAT;
    -> IF b = 0 THEN SET result = NULL;
    -> ELSE SET result = a / b;
    -> END IF;
    -> RETURN result;
    -> END $$
Query OK, 0 rows affected (0.012 sec)
mysql> DELIMITER ;
mysql> SELECT divide_floats(10, 2);
+----------------------+
| divide_floats(10, 2) |
+----------------------+
|                    5 |
+----------------------+
1 row in set (0.001 sec)





