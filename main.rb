require 'rexml/document'
require 'date'

current_path = File.dirname(__FILE__ )
file_name = current_path + '/desires.xml'

abort 'Файл desires.xml не найден!' unless File.exist?(file_name)

file = File.open(file_name, 'r:UTF-8')

begin
  doc = REXML::Document.new(file)
rescue REXML::ParseException => e
  puts 'XML файл поврежден!'
  abort e.message
end

file.close

puts "В этом сундуке хранятся ваши желания."
puts "Чего бы вы хотели?\n\n"
desire_text = STDIN.gets.strip

puts "\nДо какого числа вы хотите осуществить это желание?\n(укажите дату в формате ДД.ММ.ГГГГ)\n\n"
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

desire = doc.root.add_element 'desire',
                              'date' => desire_date

desire.text = desire_text

file = File.new(file_name, 'w:UTF-8')
doc.write(file, 2)
file.close

puts "\nВаше желание в сундуке"