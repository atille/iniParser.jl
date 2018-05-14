# module iniParser
# simple module to retrieve ini configuration elements.
# https://github.com/Atille/iniParser.jl

module iniParser

	export parseConf
	export getparam

	function parseConf(file::AbstractString)

		if isfile(file) == false
			println("File $file does not exist.")
			quit()
		end

		f = open(file, "r")
		return f

	end

	function getparam(container::IOStream, section::AbstractString, paramkey::AbstractString)

		current_section = ""
		current_key = ""
		current_value = ""

		for ln in eachline(container)

			if issection(ln) == true
				current_section = getsection(ln)
			end

			if isparam(ln) == true
				current_key = getkey(ln)
				current_value = getvalue(ln)

				if current_section == section && current_key == paramkey
					return current_value
				end
			end

		end
	end

	function getkey(line::AbstractString)

		if contains(line, " = ") == true
			return split(line, " = ")[1]
		end
	end

	function getvalue(line::AbstractString)

		if contains(line, " = ") == true
			return split(line, " = ")[2]
		end
	end

	function getsection(line::AbstractString)
		s = split(line, "[")[2]
		s = split(s, "]")[1]

		return s
	end

	function isparam(line::AbstractString)
		if contains(line, " = ") == true
			return true
		else
			return false
		end
	end



	function issection(line::AbstractString)

		if startswith(line, "[") && endswith(line, "]")
			return true
		else
			return false
		end
	end

end
