# Introduction to Relational Databases

## Overview of the workshop

In this 4-hour workshop, participants will learn the basics of data modelling for relational databases, the relational database development process, and querying relational databases using SQL (Structured Query Language). The workshop will also present an overview of how relational databases are integrated into websites and other types of applications. The workshop will include a number of hands-on exercises and the chance to create, populate, and query a simple database.

## How relational databases work

### Tables, relationships, and IDs

Relational databases strucutre data in tables, and provide mechanisms for linking (relating) those tables together to so that the data can be queried and managed efficiently. For example, if we wanted to manage a list of books, we would create a table that contained some data about those books:

![Some sample books](assets/sample_book_list.png)

Each row in the table describes a single book, and the data is organized into columns, with each intersection of a row and a column containing a single piece of data. But if each intersection of a row and a column can contain only one piece of data, how do we handle data that can apply more than once to each book, such as its author? It's pretty common for a book to have more than one author.

Relational databases organize data into multiple tables, and link the tables together so that all the data about something (in our example, a single book) can be assembled from the relevant tables as needed. If we put data about authors in its own table, we can allow each book to have multiple authors. Because each book can have many authors, and each author can have written more than one book, we say that books and authors have a "many-to-many" relationship with each other. Relational databases accommodate this type of relationship by using a third table whose function is to relate the two things described in separate tables, as illustrated in this diagram:

![Books and authors](assets/BooksAuthors.jpg)

This intermediate table (in this example, BookAuthors) is known as a "relation" or "join" table. For this method of breaking up data into multiple tables to work reliably, we need to ensure that each row in the books table and each row in the authors table can be referenced uniquely. To do this, we need to assign identifiers to each rown in the book and authors tables, and we use those identifiers to relate the two tables to each other in the third table. We will see some examples of these identifiers in the query examples below.

"One-to-many" relationships don't use a third table. This type of relationship links two tables, one containing the data that is on the "one" side of the relationship and the other that is on the "many" side. For example, each book can have many editions, but each edition applies to only a single book:

![Books and editions](assets/BooksEditions.jpg)

One-to-many relationships also require that rows in tables have unique IDs, but unlike in the join table used in many-to-many relationship, the table that contains the data describing the "many" side of the relationship has a column reserved for the ID of the "one" side of the relationship. 

The IDs used to uniquely identify the things described in tables are called "primary keys". If these IDs are used in other tables, they are called "foreign keys" in those tables. For example, the "book_id" column in the Books table is that table's primary key, but the "book_id" column in the Editions table is a foreign key.

Putting together all of our tables, we get a database structure that can be represented like this:

![Books and editions](assets/BooksAuthorsEditions.jpg)

Books, Authors, and Editions all have a unique ID (book_id, author_id, and edition_id respectively) that is used as their primary key, and Editions contains the foreign key book_id that links it to the Books table in a one-to-many relationship. The relation table BooksAuthors only has two columns, book_id and author_id, which are both foreign keys.

Here are the tables, structured as illustrated above, with some data in them:

Books

```
+---------+------------------------------------------------------+---------------+
| book_id | title                                                | ISBN          |
+---------+------------------------------------------------------+---------------+
|       1 | Creating relational databases for fun and profit     | 7654321123456 |
|       2 | Relational databases for really, really smart people | 9876543212345 |
|       3 | My life with relational databases: a memoir          | 3212345678909 |
|       4 | Relational databases: an existential journey         | 8172635412345 |
+---------+------------------------------------------------------+---------------+
```

Authors
```
+-----------+---------------+------------+
| author_id | last_name     | first_name |
+-----------+---------------+------------+
|         1 | Lopez Baranda | Christina  |
|         2 | Jin-Soon      | Sin        |
|         3 | Jones         | Hannah     |
|         4 | Novak         | Stanislaw  |
|         5 | Turay         | Tandice    |
|         6 | Roy           | Shanta     |
|         7 | Berger        | Henry      |
|         8 | Khatami       | Paree      |
+-----------+---------------+------------+
```

BooksAuthors
```
+---------+-----------+
| book_id | author_id |
+---------+-----------+
|       3 |         6 |
|       2 |         4 |
|       2 |         5 |
|       1 |         1 |
|       1 |         3 |
|       1 |         5 |
|       4 |         8 |
+---------+-----------+
```

Editions
```
+------------+---------+---------------------+----------------+
| edition_id | book_id | date_of_publication | edition_number |
+------------+---------+---------------------+----------------+
|          1 |       3 |                2001 | 1              |
|          2 |       3 |                2003 | 2              |
|          3 |       4 |                2003 | 1              |
|          5 |       1 |                2000 | 1              |
|          6 |       3 |                2005 | 3              |
|          8 |       2 |                2012 | 1              |
|          9 |       3 |                2009 | 4              |
+------------+---------+---------------------+----------------+
```

### Querying tables using SQL

After we have populated the database with data (we'll explain how to do that later), we can query it using SQL (the Structured Query Language). For example, to view all information stored in the Authors table, sorted by last name, we use the following query:

```sql
SELECT * FROM Authors ORDER by last_name;
```

which produces the following:

```
+-----------+---------------+------------+
| author_id | last_name     | first_name |
+-----------+---------------+------------+
|         7 | Berger        | Henry      |
|         2 | Jin-Soon      | Sin        |
|         3 | Jones         | Hannah     |
|         8 | Khatami       | Paree      |
|         1 | Lopez Baranda | Christina  |
|         4 | Novak         | Stanislaw  |
|         6 | Roy           | Shanta     |
|         5 | Turay         | Tandice    |
+-----------+---------------+------------+
8 rows in set (0.01 sec)

```

Using uppercase for SQL commands is a convention only, it's not mandatory. Also, the output we're seeing here is specific to the MySQL command-line client, which we're not using in this workshop. How you query the databaase, and how the results output will look will depend on what tool is being used to manage the database.

This query asks for the first and last names of authors of the book with book_id 1:

```sql
SELECT DISTINCT first_name, last_name
FROM Authors, BooksAuthors, Books
WHERE BooksAuthors.author_id = Authors.author_id
AND BooksAuthors.book_id = 1;
```
The results are:

```
+------------+---------------+
| first_name | last_name     |
+------------+---------------+
| Hannah     | Jones         |
| Christina  | Lopez Baranda |
| Tandice    | Turay         |
+------------+---------------+
3 rows in set (0.01 sec)
```

This query is more complex than the first one, because it is asking for data from multiple tables. It relates the tables using the clause `WHERE BooksAuthors.author_id = Authors.author_id`, which in relational database jargon is called a "join" query (not to be confused with the join table used to store many-to-many relationships.)

To find the book IDs, titles, and ISBNs that have editions published after (that is, greater than) 2003, we would use this SQL query:

```sql
SELECT Books.book_id, title, ISBN, date_of_publication
FROM Books, Editions
WHERE Books.book_id = Editions.book_id
AND Editions.date_of_publication > '2003';
```

which returns the folowing results:

```
+---------+------------------------------------------------------+---------------+---------------------+
| book_id | title                                                | ISBN          | date_of_publication |
+---------+------------------------------------------------------+---------------+---------------------+
|       2 | Relational databases for really, really smart people | 9876543212345 |                2012 |
|       3 | My life with relational databases: a memoir          | 3212345678909 |                2005 |
|       3 | My life with relational databases: a memoir          | 3212345678909 |                2009 |
+---------+------------------------------------------------------+---------------+---------------------+
3 rows in set (0.00 sec)
```
You'll notice repetition in the book_id, title, and ISBN columns in the results. Those columns are the ones we're asking for in the query, so the response is correct, since we're also asking for the date of publication from the Editions table, which in our results contains the correct values.

### Relational database management systems

#### Common systems

There are many proprietary and open source relational database management systems (RDBMSs). The most common include:

* [MySQL](https://www.mysql.com/)
* [PostgreSQL](http://www.postgresql.org/)
* [MariaDB](https://mariadb.org/)
* [SQLite](http://www.sqlite.org/)
* [Microsoft Access](https://products.office.com/en-us/access)
* [Filemaker](http://www.filemaker.com/products/overview.html)
* [Microsoft SQL Server](http://www.microsoft.com/en-ca/server-cloud/products/sql-server/)
* [Oracle](https://www.oracle.com/database/index.html)

While SQL is an [international standard](http://en.wikipedia.org/wiki/SQL#Standardization), and most of the systems listed above implment it thoroughly, every RDBMS has features or extensions to SQL that differentiate it from its competitors. Some, like Microsoft Access and Filemaker, include full graphical user interfaces to creating and querying databases. Others, like MySQL and PostgreSQL, include only a back-end server and command-line clients for querying and administration. It is common for third-party tools to be used to interact with these databases. Some of these tools are described in the next section.


#### Interacting with RDBMSs

In this workshop, we'll be interacting with our databases using a web-based management tool called [Adminer](http://www.adminer.org/). However, it is important to note that there are a variety of ways to interact with relational databases.

##### Command-line clients

MySQL, PostgreSQL, and SQLite come with a command-line client. To invoke MySQL's client as the database's root user on Linux, you run the command `mysql -uroot -p`. After entering the root user's password, you would enter the MySQL shell, which looks like this:

![MySQL command-line client](assets/mysql_client.png)

You then issue SQL and MySQL-specific commands within the MySQL shell, like this:

![MySQL command-line client](assets/mysql_client_query.png)

Other command-line clients exist for specific purposes. For example, a database developer or administrator would use the `mysqldump` command to produce a "dump" of a MySQL database for backup purposes or for moving to a different server. The dump contains all the SQL commands required to recreate the database:

```sql
-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 16, 2015 at 07:16 AM
-- Server version: 5.5.41-0ubuntu0.14.04.1-log
-- PHP Version: 5.5.9-1ubuntu4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ClassSchedules`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE IF NOT EXISTS `classes` (
  `class_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE IF NOT EXISTS `courses` (
  `course_id` int(11) NOT NULL,
  `coursescol` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE IF NOT EXISTS `instructors` (
  `instructor_id` int(11) NOT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The instructor''s last name (or name conventionally used in alphabetical lists)\n',
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `location_id` int(11) NOT NULL,
  `room_number` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `room_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
```

##### Web-based RDBMS management applications

The following screenshot show the database in [Adminer](http://www.adminer.org/):

![Adminer tables view](assets/adminer_tables_view.png)


This is a screenshot from [PHPMyAdmin](http://www.phpmyadmin.net/home_page/index.php), a popular web-based management application for MySQL databaeses, showing the rows in a table:

![Adminer tables view](assets/phpmyadmin_rows_view.png)




##### Desktop RDBMS management applications

[MySQL Workbench](https://www.mysql.com/products/workbench/):

![MySQL Workbench schema view](assets/mysqlworkbench_schema.png)
MySQL Workbench schema view

![MySQL Workbench ER diagram view](assets/mysqlworkbench_er_diagram.png)
MySQL Workbench ER diagram view

##### Using managemant applications

The intended audience of RDBMS management applications is database developers and administrators. They are not designed for allowing a wide variety of users to interact with databases. Most end users acces databases through applications that easier to use and more specific to the content stored in the database than through general-purpose database management applicatoins like phpMyAdmin or MySQL Workbench. We will survey some of the tools used to create web-based access to databases in the "Web application frameworks" section below.

The most obvious limitation to most RDBMS management tools is that while they provide a simple interface for populating and updating individual tables, they do not allow users to populate and update linked tables easily. For example, if you wanted to add a book entry to the database we saw in the overview section, you'd also want to add at least one linked record for the book's edition. Let's look again at the Editions table:

```
+------------+---------+---------------------+----------------+
| edition_id | book_id | date_of_publication | edition_number |
+------------+---------+---------------------+----------------+
|          1 |       3 |                2001 | 1              |
|          2 |       3 |                2003 | 2              |
|          3 |       4 |                2003 | 1              |
|          5 |       1 |                2000 | 1              |
|          6 |       3 |                2005 | 3              |
|          8 |       2 |                2012 | 1              |
|          9 |       3 |                2009 | 4              |
+------------+---------+---------------------+----------------+
```
If you are adding a row to this table, you need to know which book ID to use to link the new entry to the corresponding book. The tools described above for managing relational databases don't provide automatic ways to let you pick from a list of book IDs (or better yet, book titles that correspond to book IDs) when you're editing or adding an edition entry. The professional version of Adminer provides this feature, but in this workshop we're using the free version.

In the exercises using SQL below, we'll need to work around this limitation of the tool we are using by opening multiple web browser windows so we can see all the tables we are using in our queries. Your instructor will demonstrate this work around in person.

One web-based RDBMS management tool that does not have this limitation is [Xataface](http://xataface.com/). The screen shot below was taken from a database that uses Xataface. (The database, coincidentally, also describes books, specifcally, a set of books published in the late 1700s up to the end of the 1800s associated with a particular region in England.) The "Places" form depicted here exists within the form used to edit book entries. The database contains a "books" table, a "publication_place" table, and a more general "place" table. The example below shows how the user can choose a value from either of those tables directly within the form used to edit the book that the places are associated with:

![Example of an autocomplete field for selecting values from linked tables](assets/xataface_linked_table_example.png)
Example of a user interface built using [Xataface](http://xataface.com/) for selecting values from linked tables. Image courtesy of John Dingle and Margaret Linley.


## Data modeling for relational databases

* Entity-relationship modeling
* Normalization

### Relational database development process

The process of developing the structure of a relational database is iterative. Only the simplest databases do not require repeated testing and adjustment before they meet their intended goals. This diagram represents the various steps you should consider taking while developing your database, starting with "Define entities and their attributes" and moving clockwise:

![Database development process](assets/DB_Development_process.jpg)

Defining the entities in the database (the things that the database describes), their attributes, and their relationships to each other (e.g., one-to-many, many-to-many) can be done using several techniques. Many people like to start with simple lists of entities and attributes, and then translate those into Entity Relationship diagrams to better match the functionality of an RDBMS. The following section provides one concrete example of this method.

### Entity-relationship modelling

Our goal in this example of entity-relationship modelling is to create a database that we can use to schedule classes in a set of academic courses. Any real school, college, university, or training center will have such a database. The database used in this example is _probably_ a lot simpler than the real databases used in these institutions.

We will begin by listing all of the things we need to include in our database:

* Classes
* Courses
* Rooms

If we put some thought into this short list of entities, and add to each one the likely attributes that we'll need to include, we come up with a more detailed list, plus some example values for the attributes and some questions we need to flesh out more fully later on:

* Classes
  * Date
  * Time
  * Course
  * Location
* Courses
  * Number
  * Title
  * Instructor
  * Department
  * Semester [Do we need semsester if we have dates?]
* Locations
  * Room number [Why do we use "room" for the attributes but call the table "locations"?]
  * Room name
  * Building
  * Type (e.g., classroom, seminar, amphitheatre, etc.)
  * Built-in projector [maybe split out into Room Details table?]
* Instructors
  * Last name
  * First name
  * Department [Do we need department here and in Courses?]
  * Email address

We can then use this list as a basis for rough ER diagram, which provides us with an opportunity to think about the relationships between the entities using a more formalized approach:

![Rough ER diagram with notes](assets/classes_modelling_example.jpg)

Using the modifications made to our rough ER diagram, we can create a cleaner version before moving on to normalization:

![Revised ER diagram](assets/classes_modelling_example_revised_erd.jpg)


### Normalization

#### First Normal Form

Each column/row intersection can contain only one value. In our class locations database, courses.instructor can only have one instructor ID. 

#### Second Normal Form

Applies to association tables with a composite key. All non-key columns must describe the entire composite key.

#### Third Normal Form

Second Normal Form for non-association tables. Non non-key column must be dependent on another non-key column.

#### Fourth and Fifth Normal Forms

Don't worry about these.

### Testing databases

[@todo: add some sample data, do some SQL queries.]


## Exercise: Using SQL

In this exercise, we will create a database that contains a single table describing shapes, populate the table with some data, and modify some of the data. Your instructor will provide the URL of the tool you will use, plus login credentials for the tool.

The ER diagram for the table (including the data types for each column) is:

![SQL exercise table structure](assets/SQL_exercise_table.jpg)

* shape_id: This is the primary key for the table. It must be set to Auto Increment.
* name: The name of the shape, e.g., square, triangle, circle, etc.
* number_straight_sides: The number of straight sides the shape has. Make this field have a default value of 0 (zero).
* example_picture_url: To popluate this field, you will need to find a picture of the shape on the Web.
* real_world_example: Enter the name of an object that has this shape, e.g., for 'circle' you could use 'Frisbee'

### Creating a table

Won't be using SQL, we'll be using Adminer's web interface, but the SQL would be:

```sql
CREATE TABLE IF NOT EXISTS `shapes` (
  `shape_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `number_straight_sides` int(11) NOT NULL DEFAULT '0',
  `example_picture_url` text COLLATE utf8_unicode_ci NOT NULL,
  `real_world_example` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`shape_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
```

This is what you should see in Adminer:

![Creating a table in Adminer](assets/using_sql_exercise_creating_table.png)

### Inserting data

We'll use raw SQL to add (INSERT) a row into the table. Click on the "SQL command" link on the left-hand side of the Adminer interface and enter this:

```sql
INSERT INTO `shapes` (`name`, `number_straight_sides`, `example_picture_url`, `real_world_example`)
VALUES ('square', '4', 'http://www.mlahanas.de/Greeks/images/sq1.jpg', 'Window');
```

### Modifying data

```sql
UPDATE `shapes` SET
`real_world_example` = 'Plate'
WHERE `shape_id` = '1';
```

### Deleting data

```sql
DELETE FROM `shapes`
WHERE `shape_id` = '1';
```

### Selecting data



## Exercise: Selecting data from the Class Scheduling database

In this exercise, we will perform some SELECT queries on the Classes database we modelled earlier in the workshop. Your instructor will provide the URL of the tool you will use, plus login credentials for the tool.

1. Find all the..

2. Find all the 

## Integrating relational databases into applications

Now that we've seen how relational databases organize data, and how to use SQL to add, update, delete, and select data, we will take a look at how two well-known applications use relational databases, and then survey some tools commonly used to create custom Web-based database applications.

### Wordpress

Wordpress is a popular blogging and Content Management System that powers a [very large proportion](https://om4.com.au/wordpress/market-share/) of websites. Wordpress, like many other open-source products, makes its [core database ER diagram](https://codex.wordpress.org/images/9/97/WP3.8-ERD.png) available.

This diagram shows us that rows in the wp_posts table are on the "one" side of a one-to-many relationship with rows in three "many" tables, and is on the "many" side of a relationship with the wp_users table.

Also of note is the use of several lookup tables (wp_usermeta, wp_commentmeta, and wp_postmeta) that use "[key-value](http://en.wikipedia.org/wiki/Attribute-value_pair)" pattern to define rows. Tables that use this pattern define a column for keys and a column for values. In each row, the key is the name of an attribute and the value is the content of the attribute. Using this structure, the table can store date whose key or name is not known when the table was designed and created. Tables that use key-value structure are very flexible, but SQL queries used to manage them and select data from them are more complicated than ones that use predictable column names.

### Firefox

The Firefox web browser uses an SQLite database, which is bundled with Firefox, to manage users' history, bookmarks, and annotations. Information on how this database works, include its [ER diagram](http://people.mozilla.org/~dietrich/places-erd.png), is available on the [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places) website.

Firefox's use of SQLite demostrates that relational databases can be used in desktop applications as well as in web-based applications like blogs. Firefox is not the only product that uses SQLite; according to [SQLite's website](http://www.sqlite.org/mostdeployed.html), it is also used in Mac OSX, Skype, and on many types of smartphones. This page claims that "it is likely that SQLite is the most widely deployed SQL database engine in the world."

### Web application frameworks

Many application development frameworks are availble that provide tools for integrating relational databases into web applications. If you were to develop a relational database to use in your research, and you wanted to have that database live on the web, you would likely need to use (or pay someone else to use) a web application framework to create a useful application for your database's users to interact with it.

These frameworks implement tools require knowlege of programming languages such as PHP or Python, but they provide a wide range of tools to make developing applications easier, more secure, and more maintainable than if the applications were developed using only the core language. Popular web application frameworks include (notice the consistency across their slogans):

* [Django](https://www.djangoproject.com/) for Python ("The web framework for perfectionists with deadlines.")
* [Symfony](http://symfony.com/) for PHP ("Speed up the creation and maintenance of your PHP web applications. End repetitive coding tasks and enjoy the power of controlling your code.")
* [Rails](http://rubyonrails.org/) for Ruby ("Ruby on Rails® is an open-source web framework that’s optimized
for programmer happiness and sustainable productivity.")
* [Play](https://www.playframework.com/) for Java ("The High Velocity Web Framework For Java and Scala")

These toolkits use a technology called "object-relational mapping" (ORM) to manage databases. ORMs allow developers to avoid much of the database plaform-specifc SQL syntax and table management features and to focus on how the entities in their databases are structured. ORMs also make it easy to change the structure of a database. Using ORMs are outside the scope of this workshop, but Django's [introduction to its ORM](https://docs.djangoproject.com/en/1.8/topics/db/models/) provides a very readable overview of how ORMs in general function for readers who know the fundamentals of how relational databases work.

Many web application frameworks provide tools to generate web forms for creating, updating, and deleting rows in the database, and for providing other ways for users to interact with the database. In many ways, these frameworks are so popular because of the efficiency they bring to creating relational database applications for the web and for the tools they provide that allow developers to avoid direct, low-level interaction with the RDBMS itself.

## Relational databases compared to other types of databases

Relational databases are remarkably flexible and powerful, but they have limits. Other types of databases that you will hear of include:

* NoSQL databases
  * "NoSLQ" is an acronym for "Not only SQL." These databases store non-tabular data. Examples include [CouchDB](http://couchdb.apache.org/), [MongoDB](https://www.mongodb.org/). Typical applications for NoSQL databases include serving large-scale structured data or as complements to relational database applications. As a class of products, NoSQL databases have no standardized query language - each product uses its own language for adding, modifying, and retrieving data.
* XML databases
  * XML databases store and query data in XML documents, not in tables. A typical application for XML databases is to provide advanced queries against a set of XML documents using the [XPath](http://en.wikipedia.org/wiki/XPath) or [XQuery](http://en.wikipedia.org/wiki/XQuery) languages. Examples of XML databases include [eXist](http://exist-db.org/) and [BaseX](http://basex.org/).
* Triplestores
  * Triplestore store statements comprised of subject, predicate, object as defined by [RDF](http://www.w3.org/TR/2014/NOTE-rdf11-primer-20140225/) (the Resource Description Framework). A typical application is providing a search endpoint for [Linked Data](http://linkeddata.org/) via the [SPARQL](http://en.wikipedia.org/wiki/SPARQL) query language. Examples of RDF triplestores include [Fuseki](http://jena.apache.org/documentation/fuseki2/index.html) and [Virtuoso](http://virtuoso.openlinksw.com/).


## Exercise: Data modeling for relational databases

Sample topics:
* Database that tracks which articles cite which other articles
* Personal music, book (or other) collection
* Research project status reporter (for producing periodic updates)


## License

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">Except where noted, Introduction to Relational Databases</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Mark Jordan</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.