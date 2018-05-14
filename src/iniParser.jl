# module iniParser
# simple module to retrieve ini configuration elements.
# https://github.com/Atille/iniParser.jl

module iniParser

	export parseConf
	export getparam

	# return a IOStream flux as the f variable.
	function parseConf(file::AbstractString)

		# We check if the passed file exists.
		if isfile(file) == false
			println("File $file does not exist.")
			quit()
		end

		f = open(file, "r")
		return f

	end

	# getparam function : return an AbstractString containing the 
	# requested paramkey of the defined section on the conf container.
	function getparam(container::IOStream, section::AbstractString, paramkey::AbstractString)

		# defining globaly for later
		current_section = ""
		current_key = ""
		current_value = ""

		# for each line, we define if this is a section ; we keep it
		# in memory, since we want things to converge to a defined section.
		for ln in eachline(container)

			if issection(ln) == true
				current_section = getsection(ln)
			end
		
			# we define if the line is a parameter. If true, then we make
			# sure this is the section we want and the key we want.
			# if yes, then we just return the value.
			if isparam(ln) == true
				current_key = getkey(ln)
				current_value = getvalue(ln)

				if current_section == section && current_key == paramkey
					return current_value
				end
			end

		end
	end

	# Returns the key.
	# Splits the = of the line and returns the first element.
	function getkey(line::AbstractString)

		if contains(line, " = ") == true
			return split(line, " = ")[1]
		end
	end

	# Returns the value
	# Splits the = of the line and returns the second element.
	function getvalue(line::AbstractString)

		if contains(line, " = ") == true
			return split(line, " = ")[2]
		end
	end

	# To match the client request, we parse the section line containing
	# [ and ] to make it more clear.
	function getsection(line::AbstractString)
		s = split(line, "[")[2]
		s = split(s, "]")[1]

		return s
	end

	# Define the line as a parameter one if it contains the = symbol.
	function isparam(line::AbstractString)
		if contains(line, " = ") == true
			return true
		else
			return false
		end
	end



	# Define the line as a section one if it contains the [ and the ]
	function issection(line::AbstractString)

		if startswith(line, "[") && endswith(line, "]")
			return true
		else
			return false
		end
	end

end
