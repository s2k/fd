# Author:: Stephan Kämper
# Copyright:: (c) 2004 Stephan Kämper
#
# Contact:: Stephan.Kaemper@Schleswig-Holstein.de
#

# FileDumper does just that: It dumps the content of a file to the standard output.
class FileDumper

	# _linelength_ sets how many characters are displayed pre line.
	# Some <i>special non-printable characters</i> are displayed as their names.
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
	#
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
 					puts( ( "%#{3*@lineLength}s" % hexvals ) +  "|" + ( "%#{5*@lineLength}s" % line ) )
					hexvals = ""
					line = ""
				end
			end
		}
	end
end

if __FILE__ == $0
	raise "Need at least a file name as parameter" if ARGV.size == 0

	ARGV.each { | fn |
		puts fn
		FileDumper.new( 10 ).dump( fn )
	}
end
