---
slug: add-data
id: hhlyvuv7hp2w
type: challenge
title: Add Data
notes:
- type: text
  contents: To understand how we organize databases, it is helpful to understand what
    relational databases are and how they relate to SQL. For a full overview, (check
    out this helpful article)[https://www.codecademy.com/article/what-is-rdbms-sql].
    In this step, you will be challenged to complete a task, and we will provide you
    with guidance to help you along!
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
  cmd: tmux attach-session -t "rhel-session" > /dev/null 2>&1
- title: RHEL Web Console
  type: website
  url: https://rhel.${_SANDBOX_ID}.instruqt.io:9090
  new_window: true
difficulty: basic
timelimit: 600
---
To understand how we organize databases, it is helpful to understand the definition of a relational database, a relational database management system, and SQL. For an overview, [check out this helpful article](https://www.codecademy.com/article/what-is-rdbms-sql)

In this step, you will be challenged to complete a task, and we will provide you with guidance to help you along!

# Challenge: Make a database to organize the items in your home

To record all of the items in your home, there are many ways to organize the database. For our lab, we will use this database design:
![Home inventory database design](../assets/Home_Database_Diagram.jpeg)
In this diagram:

* Each item has a name, a serial number, a value, and a room where it is stored. The room of the item is a foreign key because it relates to the Room entity. Each item relates to one Room entity.
* Each room has a name, which is the primary key for the room entity. Each room is also inside a home, and home is a foreign key because it relates to the Home entity. Each room relates to 0 or more Item entities, and each room relates to one Home entity.
* Each home has a name, which is the primary key for the home entity. Each home has a size and a country in which it is located. Each home relates to many room entities.

For help understanding the meaning of Database diagrams, [check out this article.](https://www.lucidchart.com/pages/ER-diagram-symbols-and-meaning)

Now that you are familiar with the database you will build,
