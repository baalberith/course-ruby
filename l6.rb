require 'yaml'

# zadanie 3

class Notepad
  def initialize(file = 'notepad.pkl')
    @file = file
    
    if File.exist?(file)
      @notepad = open(file, 'r') { |f| YAML.load(f) }
    else
      @notepad = []
    end
  end
  
  def browse
    contacts = []
    for c in @notepad
      contacts << "Name: #{c[:name]}\nPhone number: #{c[:phone]}\nE-mail: #{c[:mail]}\nGadu-gadu: #{c[:gg]}\n"
    end
    
    contacts
  end
  
  def search(value, key = :name)
    for c in @notepad
      if c[key] == value
        return "Name: #{c[:name]}\nPhone number: #{c[:phone]}\nE-mail: #{c[:mail]}\nGadu-gadu: #{c[:gg]}\n"
      end
    end
    
    'Not found'
  end
  
  def add(name, phone, mail, gg)
    @notepad << {
      :name => name,
      :phone => phone,
      :mail => mail,
      :gg => gg
    }
    
    open(@file, 'w') { |f| YAML.dump(@notepad, f) }
    'Added'
  end
  
  def remove(name)
    if @notepad.delete_if{ |c| c[:name] == name } 
      open(@file, 'w') { |f| YAML.dump(@notepad, f) }
      'Removed'
    else
      'Not found'
    end
  end
end

print "Filename [notepad.pkl]: "
filename = gets

if filename != "\n"
  notepad = Notepad.new(filename)
else
  notepad = Notepad.new
end

while true
  puts "Select option: "
  puts "[1] Browse [2] Add [3] Remove [4] Search"
  puts "[5] Quit notepad"
  print "Option: "
  option = gets.to_i
  
  case option
    when 1 then puts notepad.browse
    when 2 then 
      while true
        print "Name (required): "
        name = gets
        if name == "\n"
          puts "Name can't be empty!"
        else
          break
        end
      end
      
      print "Phone number: "
      phone = gets
      print "E-mail: "
      mail = gets
      print "Gadu-gadu: "
      gg = gets

      puts notepad.add(name.chomp, phone.chomp, mail.chomp, gg.chomp)
    when 3 then
      print "Name to remove: "
      name = gets
      
      puts notepad.remove(name.chomp)
    when 4 then
      while true
        puts "Search by: "
        puts "[1] name [2] phone number [3] e-mail [4] gadu-gadu"
        puts "[5] Quit search"
        print "Search option: "
        search_option = gets.to_i
        
        case search_option
          when 1 then
            print "Name: "
            name_option = gets
            
            puts notepad.search(name_option.chomp)
          when 2 then 
            print "Phone number: "
            phone_option = gets
            
            puts notepad.search(phone_option.chomp, :phone)
          when 3 then
            print "E-mail: "
            mail_option = gets
            
            puts notepad.search(mail_option.chomp, :mail)
          when 4 then
            print "Gadu-gadu: "
            gg_option = gets
            
            puts notepad.search(gg_option.chomp, :gg)
          when 5 then break
          else puts 'Option not found'
        end
      end
    when 5 then break
    else puts 'Option not found'
  end
end
