# frozen_string_literal: true

require_relative 'fd/version'

# Fd dumps the content of a file to the standard output.
#
class Fd
  class Error < StandardError; end

  ESCAPE_CHARACTERS = %w[␀ ␇ ␈ ␉ ␊ ␋ ␌ ␍ ␡ ␛ ␠].freeze

  CHAR_TABLE = {
    0 => '␀',
    7 => '␇',
    8 => '␈',
    9 => '␉',
    10 => '␊',
    11 => '␋',
    12 => '␌',
    13 => '␍',
    16 => '␡',
    27 => '␛',
    32 => '␠'
  }.freeze

  attr_reader :line_length

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
    unless line_length.is_a?(Integer) && line_length.positive?
      raise ArgumentError,
            "Line width must be a positive integer, was given '#{line_length}'"
    end

    @line_length = line_length
  end

  def add_esc_sequence(chr)
    "\e[31m#{chr}\e[0m"
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
    @line       += format('%2s', CHAR_TABLE[char.ord] || char)
    @char_index += 1
  end

  def enough_space_in_line?(byte_count_in_line, bytes)
    byte_count_in_line + bytes.size <= line_length
  end

  def print_single_line
    hex_val_format      = "%#{(3 * line_length) - 1}s"
    line_content_format = "%#{2 * line_length}s"
    raw_content         = "#{format(hex_val_format, hex_values.join(' '))} |#{format(line_content_format, line)}"
    puts(raw_content.gsub(/([#{ESCAPE_CHARACTERS.join}])/, add_esc_sequence('\1')))
  end
end
