#!/usr/bin/env ruby -wKU
# script written by Dan Hixon to help his wife
# get her contacts onto her new phone.

class VCard
  @card_count = 0
  @area_code = ""
  def initialize(default_area_code)
    @area_code = default_area_code
    @card_count = 0
  end
  def split_file(input_file_path)
    file = File.new(input_file_path, "r")
    while (line = file.gets)
        line.chomp!
        new_card = [] if line.eql? "BEGIN:VCARD"
        new_card << line
        write_card(new_card) if line.eql? "END:VCARD"
    end
    file.close
  end
  
  private
  
  def write_card(card)
    @card_count += 1
    Dir.mkdir "vCards" unless File.exist? "vCards"
    file_path = "vCards/vCard#{@card_count}.vcf"
    File.open(file_path,"w") do |vcf|
      card.each do |line|
        vcf.puts format_line(line)
      end
    end
    puts "created card: #{file_path}"
  end
  def format_line(line)
    if line[0..3].eql?("TEL;") || line[0..9].eql?("phone.TEL;")
      return reformat_telephone_number_line(line)
    end
    if line[0..1].eql? "N:"
      return reformat_name_line(line)
    end
    line
  end
  def reformat_name_line(line)
    # N:L;Joanne;;;
    parts = line.delete("N:").split(";")
    return "N:" + parts[1] + ";" + parts[0] + ";;;"
  end
  def reformat_telephone_number_line(line)
    #TEL;TYPE=HOME,PREF:563-0250
    parts = line.split("PREF:")
    formatted_number = format_phone_number(parts[1])
    parts[0].delete("phone.") + "PREF:" + formatted_number
  end
  
  def format_phone_number(raw_number)
    number = extract_digits(raw_number)
    if number.length==7
      #append area code
      @area_code + number
    else
      number
    end
  end
  
  def extract_digits(phone_number)
    phone_number.to_s.delete("-").delete("(").delete(")").delete(" ")
  end
end

if ARGV.length!=2
  usage = <<DATA 
  usage:
		ruby parse_vcards.rb [area code] [vCard File]

	  [area code]  	- default area code for numbers without
	  [vCard File]	- file path of the vcard file
	
	  This will create a folder called "vCards" and write out files for
	  each contact in your original file.
	
DATA
  puts usage
else
  processor = VCard.new(ARGV[0])
  processor.split_file ARGV[1]
end

