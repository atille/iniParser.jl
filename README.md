# iniParser.jl
Easy-to-use and simple Julia module to parse ini configuration files.

## How-to-use

```julia

# First, include the library
include("libs/iniParser.jl")

# The conf variable contains the whole ini file.
conf = iniParser.parseConf("config.ini")

# We define the param variable as the ressource hosted as "param" on the section "section" of the conf file.
param = iniParser.getparam(conf, "section", "param")

# We get an AbstractString as the output, easily usable.
println(param)
```

## More information

The function ```parseConf(file_to_parse::AbstractString)``` just make it easier to you to work with multiple config files.

You can inject the one you want on the ```getparam(conf::IOStream, section::AbstractString, param::AbstractString)``` function to retrieve an element "param" of the section "section".

## Any idea ?

Something missing on this simple module ? I am ready to implement new things.
Any bug ? Create an issue.
