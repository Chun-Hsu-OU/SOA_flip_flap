# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    data = []
    lines = tsv.split("\n")
    keys = lines[0].split("\t")
    keys.map!(&:chomp)
    lines.shift
    lines.each do |line|
      values = line.split("\t")
      record = Hash.new
      keys.each_index { |index| record[keys[index]] = values[index].chomp }
      data.push(record)
    end

    @data = data
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    first_hash = @data[0]
    keys_array = first_hash.keys
    line = ''
    keys_array.each { |key| line.concat(key + "\t") }
    
    file = ''
    file << line + "\n"
    @data.each do |record|
      record.each_value { |value| file << value + "\t" }
      file << "\n"
    end

    file
  end

end
