# Hanami Automatic Json Parameter Logger

This is a companion repository for [hanami/hanami#898](https://github.com/hanami/hanami/issues/898).

# Steps to reproduce

Start the server:

``` bash
$ hanami server --port 2300
```

Perform a JSON request:

``` bash
$ curl -H 'Content-Type: application/json' \
    --data '{"param1": "value1", "params2": "value2"}' \
    'http://localhost:2300/resource'
```

# Expected behavior

Hanami logs body parameters:

``` ruby
{"param1"=>"value1", "params2"=>"value2"}
```

# Actual behavior

Hanami doesn't log body parameters, sample log entry:

```
[hanami_automatic_json_parameter_logger] [INFO] [2018-02-19 19:12:35 +0300] HTTP/1.1 POST 405 ::1 /resource - {} 0.001979
```

# Workaround

Patch `Hanami::CommonLogger#extract_params` so it includes parameters parsed by
parsers in `hanami-router`, see [`config/initializers/common_logger_patch.rb`](https://github.com/smaximov/hanami_automatic_json_parameter_logger/blob/264657e19f02a174c45b5d5a668a0e246e76b746/config/initializers/common_logger_patch.rb).

Restart the server with `PATCH_COMMON_LOGGER` defined:

``` bash
$ PATCH_COMMON_LOGGER=true hanami server --port 2300
```

Perform the previous JSON request and the request's body parameters will appear in logs:

```
[hanami_automatic_json_parameter_logger] [INFO] [2018-02-19 19:21:43 +0300] HTTP/1.1 POST 405 ::1 /resource - {"param1"=>"value1", "params2"=>"value2"} 0.002123
```
