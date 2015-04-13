# Overview of the workshop

In this 4-hour workshop, participants will learn the basics of data modelling for relational databases, the relational database development process, and querying relational databases using SQL (Structured Query Language). The workshop will also present an overview of how relational databases are integrated into websites and other types of applications. The workshop will include a number of hands-on exercises and the chance to create, populate, and query a simple database.

# Overview of how relational databases work

Example: Model for books and authors

![Books and authors](https://dl.dropboxusercontent.com/u/1015702/linked_to/intro_to_databases/Books-Authors.jpg)

Common RDBMS systems: [MySQL](https://www.mysql.com/), [PostgreSQL](http://www.postgresql.org/), [MariaDB](https://mariadb.org/), [SQLite](http://www.sqlite.org/), [MS Access](https://products.office.com/en-us/access), [Filemaker](http://www.filemaker.com/products/overview.html), [MS SQL Server](http://www.microsoft.com/en-ca/server-cloud/products/sql-server/), [Oracle](https://www.oracle.com/database/index.html)

Tools for managing relational databases: command line, web-based management apps (e.g. web apps like [PHPMyAdmin](http://www.phpmyadmin.net/home_page/index.php) and [Adminer](http://www.adminer.org/), desktop management apps like [MySQL Workbench](https://www.mysql.com/products/workbench/)), custom applications

# Data modeling for relational databases

* Entity-relationship modeling
* Normalization

## Relational database development process

![Database development process](https://dl.dropboxusercontent.com/u/1015702/linked_to/intro_to_databases/DB_Development_process.jpg)

Lists, then ER diagrams

## Entity-relationship modeling

List all entities (things) and their attributes

Class scheduling database, whose purpose is to aid in the scheduling of classes in a given semester.

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
  * Room number
  * Room name
  * Building
  * Type (classroom, seminar, amphitheatre, etc.)
  * Built-in projector [maybe split out into Room Details table?]
* Instructors
  * Last name
  * First name
  * Department [Do we need department here and in Courses?]
  * Email address

ER Diagram version of the above list



## Normalization

## First Normal Form

## Second Normal Form

## Third Normal Form

## Fourth and Fifth Normal Forms

Don't worry about these.

# Populating and querying relational databases

```sql
SELECT * FROM foo WHERE id = 3;
```


![Example of an autocomplete field for selecting values from linked tables](https://dl.dropboxusercontent.com/u/1015702/linked_to/intro_to_databases/xataface_linked_table_example.png)
Example of a user interface built using [Xataface](http://xataface.com/) for selecting values from linked tables. Image courtesy of John Dingle and Margaret Linley.

# Exercises

## Selecting data from the classes database

## Inserting data 

## Modifying data

# Integrating relational databases into applications

Examples: Wordpress database model (https://codex.wordpress.org/images/9/97/WP3.8-ERD.png); Firefox's history feature (https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places)

Database frameworks like [Symfony](http://symfony.com/) for PHP, [Django](https://www.djangoproject.com/) for Python, [Rails](http://rubyonrails.org/) for Ruby, [Play](https://www.playframework.com/) for Java. 

# Relational databases compared to other types of databases

NoSQL databases: Store non-tabular data. Examples include [CouchDB](http://couchdb.apache.org/), [MongoDB](https://www.mongodb.org/). Typical applications serve large-scale structured data or as complements to relational database applications. No standardized query language.

XML databases: Stores and queries XML documents, not tables. Typical application is for advanced queries against a set of XML documents using teh XPath or XQuery languages. Examples include [eXist](http://exist-db.org/), [BaseX](http://basex.org/).

Triplestores: Store statements comprised of subject, predicate, object as defined by RDF (Resource Description Framework). Typical application is in providing a search endpoint for Linked Data via the SPARQL query language. Examples include [Fuseki](http://jena.apache.org/documentation/fuseki2/index.html), [Virtuoso](http://virtuoso.openlinksw.com/).


# Exercises

## Data modeling

Sample topics:
* Database that tracks which articles cite which other articles
* 



# License

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">Introduction to Relational Databases</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Mark Jordan</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
