# Teaching a tutorial using this material

This README file contains information that people who wish to reuse this workshop material will find useful.

## Licenses

The text and images in this Git repostitory may be reused under the terms of the http://creativecommons.org/licenses/by/4.0/ license. Scripts and other content in the 'scripts' directory is in the public domain.

Also, please feel free to open an issue using the GitHub issue list, or to open a pull request, if you find a typo or other error that should be corrected.

## Providing your students with databases they can use during the tutorial

This tutorial contains hands-on excersises in using databases, specifically, MySQL databases accessed via the [Adminer](http://www.adminer.org/) web-based management application, which provides full database administration functionality in a single PHP file. Instructors will need to provision a web server that can run MySQL and Adminer (any standard VPS or IaaS server can do that).

The createdbs.sh script provided in the 'scripts' directory lets you create a set of MySQL databases and corresponding user accounts with full privileges on those databases. Feel free to modify it to suit your needs.

Have fun!
