require 'rexml/document'
require 'date'

require_relative 'lib/wish'

current_path = File.dirname(__FILE__ )
file_name = current_path + '/data/desires.xml'

abort("Файл #{file_name} не найден!") unless File.exist?(file_name)

doc = File.open(file_name, 'r:UTF-8') do |file|
  begin
    REXML::Document.new(file)
  rescue REXML::ParseException => e
    puts 'XML файл поврежден!'
    abort e.message
  end
end

wishes = []

doc.elements.each('desires/desire') do |wish_node|
  wishes << Wish.new(wish_node)
end

puts "Эти желания должны уже были сбыться к сегодняшнему дню:"
wishes.each { |wish| puts wish if wish.overdue? }

puts "\nА этим желаниям ещё предстоит сбыться:"
wishes.each { |wish| puts wish unless wish.overdue?}