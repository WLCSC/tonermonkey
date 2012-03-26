TonerMonkey
========

Consumable inventory management.  

How To
------

* bundle install
* edit/create config/database.yml & config/app_config.yml
* edit config/initializers/setup_mail.rb with your mail server details
* rake db:setup

This requires LDAP for user authentication.  Users don't exist inside of TonerMonkey until they log in for the first time.

You should start by defining your stores (where stuff is stored) & items (things you want to keep track of).  Items have fields for a name, a short name, and a barcode - any of which can be used to refer to the item.  Orders are how you add or remove items from stores.

Copyright 2011, 2012 Brad Thompson
Distributed under the terms of the GNU General Public License

    TonerMonkey is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    TonerMonkey is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with TonerMonkey.  If not, see <http://www.gnu.org/licenses/>.
