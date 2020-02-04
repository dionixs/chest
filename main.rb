require 'rexml/document'
require 'date'

current_path = File.dirname(__FILE__ )
file_name = current_path + '/data/desires.xml'

unless File.exist?(file_name)
  File.open(file_name, 'w:UTF-8') do |file|
    file.puts "<?xml version='1.0' encoding='UTF-8'?>"
    file.puts "<desires></desires>"
  end
end

xml_file = File.open(file_name, 'r:UTF-8')

begin
  doc = REXML::Document.new(xml_file)
rescue REXML::ParseException => e
  puts 'XML файл поврежден!'
  abort e.message
end

xml_file.close

puts "В этом сундуке хранятся ваши желания."
puts "Чего бы вы хотели?"
desire_text = STDIN.gets.strip

puts "\nДо какого числа вы хотите осуществить это желание?\n(укажите дату в формате ДД.ММ.ГГГГ)"
date_input = STDIN.gets.strip

desire_date = if date_input == ''
                 Date.today
               else
                 begin
                   Date.parse(date_input)
                 rescue ArgumentError
                   Date.today
                 end
               end

desire = doc.root.add_element('desire', 'date' => desire_date.strftime('%d.%m.%Y'))

desire.text = desire_text

File.open(file_name, 'w:UTF-8') do |file|
  doc.write(file, 2)
end

puts "\nВаше желание в сундуке"