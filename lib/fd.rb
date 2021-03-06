# frozen_string_literal: true

require_relative 'fd/version'

# Fd dumps the content of a file to the standard output.
#
class Fd
  class Error < StandardError; end

  attr_reader :line_length, :char_table

  # _line_length_ sets how many characters are displayed per @line.
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
  # __   :: 32
  #
  def initialize(line_length)
    raise ArgumentError,
          "Line width must be a positive integer, was given '#{line_length}'" unless line_length.is_a?(Integer) && line_length.positive?

    @line_length = line_length
    @char_table = {}
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

  # dumps the given file _file_name_ to stdout.
  def dump(content)
    raise "Not the expected encoding of UFT-8, got #{content.encoding}" unless content.encoding == Encoding::UTF_8

    initialize_fields(content)
    process_current_character while @char_index < @chars.size
    print_single_line unless line.empty?
  end

  def dump_file(file_name)
    puts file_name
    dump(File.read(file_name))
  end

  def dump_stdin(content)
    puts 'STDIN'
    dump(content)
  end

  private

  def process_current_character
    char  = @chars[@char_index]
    bytes = char.bytes
    if enough_space_in_line?(@byte_count_in_line, bytes)
      append_to_line(bytes, char)
    else
      print_single_line
      reset_line
    end
  end

  def initialize_fields(content)
    @chars              = content.chars
    @byte_count_in_line = 0
    @line               = ''
    @hex_values         = []
    @char_index         = 0
  end

  attr_reader :hex_values, :line

  def reset_line
    @byte_count_in_line = 0
    @hex_values.clear
    @line = ''
  end

  def append_to_line(bytes, char)
    @byte_count_in_line += bytes.size
    bytes.each { |bt| @hex_values << format('%02x', bt) }
    @line       += format('%5s', (char_table[char.ord] || char))
    @char_index += 1
  end

  def enough_space_in_line?(byte_count_in_line, bytes)
    byte_count_in_line + bytes.size <= line_length
  end

  def print_single_line
    puts("#{format("%#{(3 * line_length) - 1}s", hex_values.join(' '))} |#{format("%#{5 * line_length}s", line)}")
  end
end
