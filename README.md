{Jemdoc Website}: a ready-to-use Jemdoc website for research-groups and similar organizations (supports Python3)
====

This is a simple website and News/Rss-feed system for research groups and similar websites. This template is developed using a simple scripting language called [JEMDOC](https://jemdoc.jaboc.net). Only [Python](https://www.python.org) is required to work with this website. Unless you plan to use an FTP client, you will need [lftp](https://lftp.yar.ru) to publish the website via the FTP protocol to the hosting server.

## Installing and Building the website

We assume you have Python installed in your machine. In the first time using this website (after cloning this repo), or when moving it to another machine, run the following command to download Jemdoc and make it ready:

`$ make install`

Now, whenever you modify the Jemdoc files in the ./jemdoc/ folder (or add new ones), you need to rebuild the website to generate the HTML codes (in the HTML folder ./html/). Simply run the command:

`$ make`

This will generate the ./html folder containing all the generated html files and any other files present next to the targeted JEMDOC files. You can locally test the files before publishing them to the web host. For example, double-click the file (./html/members/member1/index.html) to check the page of Member1. If things went correct, this should look like:

![Member1](https://github.com/mkhaled87/jemdoc-ready/blob/master/screenshot.png?raw=true)


## Adding new Website Pages

In order to include new web pages in the automated build system provided by this template, follow the following steps:

    1- Add the folders/files you wish to include inside the Jemdoc folder (./jemdoc/).

    2- Modify the Makefile (./Makefile) and add the path of every new Jemdoc file in the list of documents (a line that starts with 'DOCS='). File paths should include the folders starting from inside the Jemdoc folder. File paths **must not** have the extention (i.e., the .jemdoc suffix).

    3- In case a new page should have a link in the main menu, modify the menu fuile (./MENU) and add a line pointing to the page.

    4- Now, build the website as described in the previous section.


## Cleaning the website

To remove all the generated html files, run the command:

`$ make clean`

## Publishing the Website using the Makefile

To publish the website you need to have:

1- a website domain-name and hosting space. For now, let's consider your domain name is (mywebsite.com) which points to the hosting server you have a hosting space in. In case you will be using the dynamic News/RSS-feed system which will be deployed in the folder (./html/rss/), your server must support ASP.Net.

2- an FTP account (username/password) with the hosting server. The accounts root-path should point to the published website. We use [LFTP](https://lftp.yar.ru) to automate the publishing and you need to have it installed. 

**Remark. Before starting to publish the website, you need to modify the website domain name in the Makefile. More specifically, in the first line under the rule 'publishall', replace 'mywebsite.com' with your website domain name.**

For installing LFTP on Ubuntu Linux, use:

`$ sudo apt-get install lftp`

and for Mac OS (using brew), install it using:

`$ brew install lftp`

Finally, run the next command to automatically mirror the ./html folder with the website:

`$ make publish`

You will be prompted for the Username and Password of your FTP account. Wait until the mirroring task finishes.
