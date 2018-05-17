include("../src/iniParser.jl")
data = iniParser.parseConf("config.ini")
println(iniParser.getparam(data, "try", "url"))
println(iniParser.getparam(data, "try", "port"))
