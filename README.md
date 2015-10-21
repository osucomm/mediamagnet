Media Magnet
============

Co-ordinating digital media.

Dependencies
------------

  * Ruby 2.1.4
  * Git
  * Bundler
  * ElasticSearch

Development Installation
------------------------

Ensure you have all of the dependencies listed above. Then clone the project and
install the required gems:

    $ git clone https://code.osu.edu/ucom/mediamagnet.git
    $ cd mediamagnet
    $ bundle install

Create your `.env` file to set up the local environment from the example and
fill in the various service credentials:

    $ cp .env.example .env
    $ vi .env

Next, create the database schema and the ElasticSearch index:

    $ bundle exec rake db:migrate
    $ bundle exec rake items:es_rebuild

Finally populate keywords from production and some initial seed data:

    $ bundle exec rake keywords:import_from_mm
    $ bundle exec rake db:seed

Run Locally
-----------

Media Magnet can be run using the Rails web server.

    $ bundle exec rails s

Then open your browser to `http://localhost:3000`.

Copyright and License
---------------------

Media Magnet - Co-ordinating digital media  
Copyright (C) 2015 The Ohio State University

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
