# README

This simple project contains the a url shortener, through which we will be able to input url and it will generate short url against that url.

## Key Features

  1. Short urls should be unique and not guessable.
  2. A counter that shows how many times a url is being hit.
  
### How to run this project

  * This is a public repository so there are some basic steps you need to follow to get this project up and running.
    * First of all clone the project using the command ->
      * git clone https://github.com/mhamzajutt96/url-shortner-app.git
    * After clonning, the first step you will make is to config your *database.yml*
      * I am using database level access for the system so, I have setup my username and password for the application to get access of the database, if you are using the same approach, try to provide your username and password, otherwise just remove these two fields from the development as well as test.
    * After configuration, run these commands
      * rails db:create
      * rails db:migrate
    * After the migration is successful just run rails c, and you are good to go by navigating to your port told by the terminal, usually it points to http://localhost:3000/ unless you didn't specify it manually.
    
    
#### Approach to create url-shortner
  
  * The approach is too basic, you just need to create a model that will store the links for the application, the model contains the basic fields such as original_url, short_url and clicked attributes. After model creation setup a flow to create a original_url and then generate a short link using the random creation.
  * For applications that are on high scale we needs to have more functionlity rather than just this simple conversion, so this is just a concept of what the url-shortner is, If you want to use something like this in a high scale app, check some gems like friendly_id which are seo-supported and provides a lot more functionlity.
  
##### Till then, Stay tunned.
