# Foraker StatusBoard

Providing up-to-the-date analytics, Tweets, pull requests, and more!
View it at [status.foraker.com](http://status.foraker.com/)

## Installation

`git clone git@github.com:foraker/statusboard.git`

Then create the database

`rake db:create db:migrate`

Set up your ENV variables with keys and tokens
[secrets.yml](config/secrets.yml)

Finally, import your data

```
rake import:twitter
rake import:github
rake import:analytics
rake active_pivot:import:pivotal_initial
```

(These commands may take a very long time)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/foraker/statusboard.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
