# frozen_string_literal: true

require_relative 'fd/version'

# Fd dumps the content of a file to the standard output.
#
class Fd
  class Error < StandardError; end

  # _line_length_ sets how many characters are displayed pre line.
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
  def initialize(line_length)
    @line_length = line_length
    @char_table = []
    (0..31).each { |i| @char_table[i] = ('%02d' % i).to_s }
    (32..255).each { |i| @char_table[i] = i.chr }
    @char_table[0]  = 'NULL'
    @char_table[7]  = 'BEL'
    @char_table[8]  = 'BS'
    @char_table[9]  = 'TAB'
    @char_table[10] = 'LF'
    @char_table[11] = 'VT'
    @char_table[12] = 'FF'
    @char_table[13] = 'CR'
    @char_table[16] = 'DEL'
    @char_table[27] = 'ESC'
    @char_table[32] = '__'
  end

  # dumps the given file _filename_ to stdout.
  def dump(file_name)
    chars = []
    File.open(file_name) do |fn|
      fn.binmode
      fn.each_byte do |b|
        chars << b
      end
      idx = 0
      line = ''
      hexvals = ''
      while idx < chars.size
        c = chars[idx]
        hexvals += ' %02x' % c
        line += '%5s' % @char_table[chars[idx]]
        idx += 1
        next unless (idx % @line_length).zero? || idx == chars.size

        puts("#{"%#{3 * @line_length}s" % hexvals} |#{"%#{5 * @line_length}s" % line}")
        hexvals = ''
        line = ''
      end
    end
  end

  def self.print_help
    puts "Usage: #{File.basename(__FILE__)} file_name_list"
    puts
    puts 'file_name_list: one or more file names'
    puts
    puts 'Options'
    puts
    puts '--help or -h           : This help text'
    puts '--width or -w a_number : Sets the number of values per line in the output'
  end
end
