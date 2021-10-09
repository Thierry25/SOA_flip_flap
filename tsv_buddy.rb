# frozen_string_literal: true

#  Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  #   # take_tsv: converts a String with TSV data into @data
  #   # parameter: tsv - a String in TSV format
  require 'yaml'
  attr_accessor :data

  TAB = "\t"
  NEWLINE = "\n"

  def take_tsv(tsv)
    @data = []
    rows = tsv.split(NEWLINE).map { |line| line.split(TAB) }
    keys = rows.shift
    rows.each do |line|
      hash = {}
      line.each_index do |value|
        hash[keys[value]] = line[value].chomp
      end
      @data << hash
    end
    # @data
  end

  #   # to_tsv: converts @data into tsv string
  #   # returns: String in TSV format
  def to_tsv
    yaml_file = @data
    # keys = yaml_file[0].keys
    tsv = get_keys(yaml_file)
    tsv.concat(NEWLINE)
    yaml_file.each do |hash|
      value = get_tabbed_files(hash)
      tsv.concat(value)
      tsv.concat(NEWLINE)
    end
    tsv
  end

  def get_keys(value)
    keys = value[0].keys
    result = ''
    keys.each_with_index do |_val, index|
      data = index == keys.length - 1 ? keys[index] : keys[index] + TAB
      result += data
    end
    result
  end

  def get_tabbed_files(hash)
    result = ''
    hash.each_with_index do |(_key, value), index|
      data = index == hash.length - 1 ? value : "#{value}#{TAB}"
      result += data
    end
    result
  end
end
