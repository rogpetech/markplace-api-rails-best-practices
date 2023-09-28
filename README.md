![Logo of the project](https://raw.githubusercontent.com/jehna/readme-best-practices/master/sample-logo.png)

# MarketPlaceAPI
> Additional information or tagline

O projeto é sobre um api com as técnicas de desenvolvimento e também com as boas
práticas do Rails 7. Onde a intensão é termos um projeto base para o desenvolvimento
de uma aplicacão RESTFULL.

## Installing / Getting started

Postgres 13

Requisitos: Docker(Colima) e Docker Compose ou Ruby 3.2.0

A quick introduction of the minimal setup you need to get a hello world up &
running.


sem docker

```sh
$ bundle install
$ rails server
```


com docker (Ele irá start a aplicacão)

```shell
$ docker-compose up -d
```

Acesse o link para documentacao dos endpoints [Link API Doc](http://api.lvh.me:3000/api-docs/index.html)

Link para a API: [Link API](http://api.lvh.me:3000)

## Developing

Here's a brief intro about what a developer must do in order to start developing
the project further:

```shell
git clone git@github.com:rogpetech/markplace-api-rails-best-practices.git
cd markplace-api-rails-best-practices/
bundle install
```

Acessar o servidor: http://localhost:3000


### Gereando Documentacão

sem docker

```shell
$ rake rswag:specs:swaggerize
```

Com docker

```shell
$ docker-compose run app rake rswag:specs:swaggerize
```

### Deploying / Publishing

In case there's some step you have to take that publishes this project to a
server, this is the right time to state it.

```shell
packagemanager deploy awesome-project -s server.com -u username -p password
```

And again you'd need to tell what the previous code actually does.

## Features

What's all the bells and whistles this project can perform?
* What's the main functionality
* You can also do another thing
* If you get really randy, you can even do this

## Configuration

Here you should write what are all of the configurations a user can enter when
using the project.

#### Argument 1
Type: `String`  
Default: `'default value'`

State what an argument does and how you can use it. If needed, you can provide
an example below.

Example:
```bash
awesome-project "Some other value"  # Prints "You're nailing this readme!"
```

#### Argument 2
Type: `Number|Boolean`  
Default: 100

Copy-paste as many of these as you need.

## Contributing

When you publish something open source, one of the greatest motivations is that
anyone can just jump in and start contributing to your project.

These paragraphs are meant to welcome those kind souls to feel that they are
needed. You should state something like:

"If you'd like to contribute, please fork the repository and use a feature
branch. Pull requests are warmly welcome."

If there's anything else the developer needs to know (e.g. the code style
guide), you should link it here. If there's a lot of things to take into
consideration, it is common to separate this section to its own file called
`CONTRIBUTING.md` (or similar). If so, you should say that it exists here.

## Links

Even though this information can be found inside the project on machine-readable
format like in a .json file, it's good to include a summary of most useful
links to humans using your project. You can include links like:

- Project homepage: https://your.github.com/awesome-project/
- Repository: https://github.com/your/awesome-project/
- Issue tracker: https://github.com/your/awesome-project/issues
  - In case of sensitive bugs like security vulnerabilities, please contact
    my@email.com directly instead of using issue tracker. We value your effort
    to improve the security and privacy of this project!
- Related projects:
  - Your other project: https://github.com/your/other-project/
  - Someone else's project: https://github.com/someones/awesome-project/


## Licensing

One really important part: Give your project a proper license. Here you should
state what the license is and how to find the text version of the license.
Something like:

"The code in this project is licensed under MIT license."