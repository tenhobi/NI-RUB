# Bittnja3gram - simple instagram clone

# How to start

```shell
bundle install
rails s
```

# Commands

All commands used for making this project work.

```shell
rails new semestral-work
cd semestral-work
bundle install
rails g controller home index
rails g scaffold posts description:text
rails db:migrate
rails active_storage:install
rails db:migrate
rails generate devise:install
rails g devise:views
rails generate devise user
rails db:migrate
rails g migration add_user_reference_to_posts user:references
rails db:migrate
rails g migration add_data_to_user username:string display_name:string description:text
rails db:migrate
rails g migration add_username_index
rails db:migrate
```

# Some notes

Using Ruby and Rails is cool,
yet in the same time very, very, very frustrating.
Because ALL works like magic.

Adding auth to the app took me HOURS.
It's all nice and shiny,
yet for people that are not used to magic,
or at least to me,
it was just so hard to get used to it.
So from a project that looks simple on a paper,
it was very overwhelming in the beginning.
Especially while it doesn't fu**ing work with Rails 7,
until I found [this treasure](https://medium.com/@nejdetkadir/how-to-use-devise-gem-with-ruby-on-rails-7-33b89f9a9c13).

After some time,
I get used to it and it became very cool!
Rails are just amazing
and everything works like magic,
if you let it and accept it yourself. :D

# PR comment

Dobrý den,
odevzdávám svou semestrální práci.

Zadání bylo udělat jednoduchý klon instagramu, tj. zobrazení fotek ve feedu, případně na profilu uživatele, filtrování a nastavení účtu. Zadání jsem doufám splnil a doufám, že bude vše vyhovovat. :)

Aplikaci jsem nasadil na Heroku: <url>

Zážitek s Ruby a Rails byly ve výsledku velmi dobré,
a trochu mě mrzí, že není nějaký doprovodný předmět jen pro Rails. Nicméně si dovolím postnout pár vět z počátečního šoku a trablí s Rails, kdy mi věci absolutně nešly. :D

> TODO
