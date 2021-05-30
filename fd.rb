# Author:: Stephan Kämper
# Copyright:: (c) 2004 Stephan Kämper
# Contact:: the.tester@seasidetesting.com
# Licence:: There's are a couple of issues with software licenses,
#           the most important of which is probably the
#           liability of the software author in case of a software
#           failure. Most of the <em>Open Source</em> licenses
#           reject any liability with words like "provide the software
#           'as is' without warranty of any kind, either expressed or
#           implied...".
#           This complete rejection of liability might (or is) not
#           possible in Germany. According to the creators "Bremer
#           Software Lizenz" a software author will be liable in case
#           of a "gross negligence", the liability in case of a "slight
#           negligence" can be rejected however.
#           Therefore the license depends of the law of the country
#           the software author comes from _and_ the country where the
#           software is used. Therefore:
#           In Germany:: The "Bremer Software Lizenz" applies
#           Otherwise:: Ruby's license
#
# _fd_ is the abbreviation of "file dump" and that's what it does. It prints
# the file content to _STDOUT_. It does so in two columns, the left one will
# display the hex values of the bytes in the file, the right one will display
# the characters.
#
# Usage:: fd.rb [-w _number_] <em>file_name(s)</em>
#
# Depending on your operating system, you may have to type a bit more...
# Usage:: ruby fd.rb [-w _number_] <em>file_name(s)</em>

require 'Getoptlong'

# FileDumper does just that: It dumps the content of a file to the standard output.
class FileDumper

	# _linelength_ sets how many characters are displayed pre line.
	# Some <i>special non-printable/invisible characters</i> are displayed as their names.
	#
	# Name :: Char val
	# NULL :: 0
	# BEL  :: 7
	# BS   :: 8
	# TAB  :: 9
	# LF   :: 10
	# VT   :: 11
	# FF   :: 12
	# CR   :: 13
	# DEL  :: 16
	# ESC  :: 27
	# SPC  :: 32
	#
	def initialize( linelength )
		@lineLength = linelength
		@charTable = Array.new
		(0..31).each{ |i| @charTable[i] = "#{'%02d' % i}" }
		(32..255).each{ |i| @charTable[i] = i.chr }
		@charTable[ 0] = "NULL"
		@charTable[ 7] = "BEL"
		@charTable[ 8] = "BS"
		@charTable[ 9] = "TAB"
		@charTable[10] = "LF"
		@charTable[11] = "VT"
		@charTable[12] = "FF"
		@charTable[13] = "CR"
		@charTable[16] = "DEL"
		@charTable[27] = "ESC"
		@charTable[32] = "__"
	end

	# dumps the given file _filename_ to stdout.
	def dump( fileName )
		chars = Array.new
		File.open( fileName ) { | fn |
			fn.binmode
			fn.each_byte { | b |
				chars << b
			}
			idx = 0
			line = ""
			hexvals = ""
			while idx < chars.size
				c = chars[ idx ]
				hexvals += " %02x" % c
				line += "%5s" % @charTable[ chars[ idx ] ]
				idx += 1
				if ( idx % @lineLength == 0 ) || idx == chars.size
					puts( ( "%#{3*@lineLength}s" % hexvals ) +  " |" + ( "%#{5*@lineLength}s" % line ) )
					hexvals = ""
					line = ""
				end
			end
		}
	end

	def usage
		puts "Usage: #{File.basename( __FILE__ )} file_name_list"
		puts ""
		puts "file_name_list: A list of file names"
		puts ""
		puts "Options"
		puts ""
		puts "--help or -h           : This help text"
		puts "--width or -w a_number : Sets the number of values per line in the output"
		puts ""
	end

end

if __FILE__ == $0

	opts = GetoptLong.new(
		[ "--width",  "-w", GetoptLong::REQUIRED_ARGUMENT ],
		[ "--help",   "-h", GetoptLong::NO_ARGUMENT ]
	)

	# A useful number of bytes/characters per output line
	# Will be used if no number is given via '-w' option
	width = 10

	opts.each do |opt, arg|
		case opt
			when "--help"
			when "--width"
				width = arg.to_i
		end
	end

	puts "Remaining args: #{ARGV.join(', ')}"

	ARGV.each { | fn |
		puts fn
		FileDumper.new( width ).dump( fn )
	}
end
