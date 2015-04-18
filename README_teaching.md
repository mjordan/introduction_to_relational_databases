# Teaching using this material

This README file contains information that people who wish to reuse this workshop material will find useful.

The 4-hour workshop this material was originally developed for given for a group of Digital Humanists. The focus in on showing how relational databases work and how they are commonly used. If you are looking for a "gentle" introduction to relational databases (if there is such a thing) for more general audiences, you might find the material in this Git repository useful. There is a lot of much more technical, detailed material out there that will be suitable for different kinds of audiences, such as Adrienne Watt and Nelson Eng's open textbook [Database Design](http://opentextbc.ca/dbdesign01/).

## Licenses

Except where otherwise noted, the text and images in this Git repostitory may be reused under the terms of the http://creativecommons.org/licenses/by/4.0/ license. Scripts and other content in the `scripts` directory is in the public domain.

## Providing your students with databases they can use

This tutorial contains hands-on excersises in using databases, specifically, MySQL databases accessed via the [Adminer](http://www.adminer.org/) web-based management application, which provides full database administration functionality in a single PHP file. Instructors will need to provision a web server that can run MySQL and Adminer (which any standard VPS or IaaS server can do).

The createdbs.sh script provided in the `scripts` directory lets you create a set of MySQL databases and corresponding user accounts with full privileges on those databases. Feel free to modify it to suit your needs.

## Typos, errors, etc.

Feel free to open an issue using the GitHub issue list, or to open a pull request, if you find a typo or other error that should be corrected.
