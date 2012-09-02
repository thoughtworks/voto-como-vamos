[![Build Status](https://secure.travis-ci.org/thoughtworks/voto-como-vamos.png?branch=master)](http://travis-ci.org/thoughtworks/voto-como-vamos)

Voto Como Vamos
================

O Voto Como Vamos será uma aplicação no Facebook que vai revolucionar a relação eleitor-candidato.
Nele você vai saber tudo sobre as propostas e candidatos das próximas eleições de maneira simples, didática e rápida.

Idealizadores:
-------------

Gabriela Guerra   - http://www.facebook.com/gabrielaludwigguerra

Igor Czermainski  - http://www.facebook.com/mrigoroliveira

Carolina Dalla    - http://www.facebook.com/carolina.cereja

Silvia Kihara     - http://www.facebook.com/silviakihara

Carlos Hoffmann   - http://www.facebook.com/polistecnologia

Michel Coelho     - http://www.facebook.com/polistecnologia

Amaralina Machado - http://www.facebook.com/Amaralina.xavier

Daniel Mattos     - http://www.facebook.com/danielcmattos


Para mais acesse:
-----------------

http://catarse.me/pt/projects/694-voto-como-vamos

http://www.facebook.com/groups/411911862161552/

http://voto.poacomovamos.org/


Instructions
==========

Development
-----------

1. Fork the project

2. Install [RVM](https://rvm.io/rvm/install/) and then Ruby 1.9.3 with bundler 1.2.0:

        $ rvm install 1.9.3
        $ gem uninstall -ax bundler
        $ gem install bundler --pre
        $ bundle --version

    (The last step should ensure that the bundler version is correct.)

3. Run `bundle` to download all of the dependencies for the project.

4. Run `rake db:migrate` to create the database schemas
and `rake db:seed` to feed your database with some basic data.

5. Start Solr (the search engine we use) with `rake sunspot:solr:start`

6. If you want to import the candidates data, run `rake candidates:import`

7. Have Solr create its indexes for the search with `rake sunspot:reindex`

8. Finally, start your local server with `rails s` and Voto Como Vamos should be up and running on your localhost!

9. Aaaaand, you can run the automated tests suite running a `rake` with no other parameters!

Troubleshooting
---------------

- If you get errors like `Errno::ECONNREFUSED (Connection refused - connect(2)):`,
this means that Solr is not running. You need to start it with `rake sunspot:solr:start`.

  If you get this error while running the automated test suite,
  you need to start it on the `test` environment, with `RAILS_ENV=test rake sunspot:solr:start`.

- Solr is running fine but I cannot see any Candidate nor Proposal!

  This happens if Solr didn't index anything. Run `rake sunspot:reindex` and this problem should be solved.


LICENSE
=======

Voto Como Vamos
Copyright (C) 2012 Porto Alegre Como Vamos

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
