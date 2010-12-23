require 'yaml'
require 'dbm'
require 'tk'

#zadanie 1

class Notepad
  def initialize(file = 'notepad.dbm')
    @file = file
    
    if File.exist?(file)
      @db = DBM.open(file) 
    else
      @db = DBM.new(file)
    end
  end
  
  def browse
    contacts = []
    @db.values.each do |contact|
      contacts << YAML.load(contact)
    end
    
    @text.delete 1.0, 'end'
    
    contacts.each do |contact|
      @text.insert 'end', "Name: #{contact[:name]}\n"
      @text.insert 'end', "Phone: #{contact[:phone]}\n"
      @text.insert 'end', "Main: #{contact[:mail]}\n"
      @text.insert 'end', "GG: #{contact[:gg]}\n\n"
    end
  end
  
  def search
    name =  @entry2.value
    
    if @db[name]
      contact = YAML.load(@db[name])
    else
      contact = {}
    end
    
    @text.delete 1.0, 'end'
      
    if contact.any?
      @text.insert 'end', "Name: #{contact[:name]}\n"
      @text.insert 'end', "Phone: #{contact[:phone]}\n"
      @text.insert 'end', "Main: #{contact[:mail]}\n"
      @text.insert 'end', "GG: #{contact[:gg]}\n\n"
    end
  end
  
  def add
    name =  @entry31.value
    phone =  @entry32.value
    mail =  @entry33.value
    gg =  @entry34.value
    
    @db[name] = {
      :name => name,
      :phone => phone,
      :mail => mail,
      :gg => gg
    }.to_yaml
  end

  def delete
    name =  @entry2.value
    @entry2.value = ''
    @db.delete(name)
  end
  
  def run
    @win = TkRoot.new { title 'Notepad' }
    
    @butt1 = TkButton.new(@win) { pack; text 'Browse' }
    @butt1.command { self.browse }
    
    @label2 = TkLabel.new(@win) { pack; text 'Search by name:' }
    @entry2 = TkEntry.new(@win) { pack }
    
    @butt21 = TkButton.new(@win) { pack; text 'Search' }
    @butt21.command { self.search }
    @butt22 = TkButton.new(@win) { pack; text 'Delete' }
    @butt22.command { self.delete }
    
    @label3 = TkLabel.new(@win) { pack; text 'Add new contact:' }
    @label31 = TkLabel.new(@win) { pack; text 'Name:' }
    @entry31 = TkEntry.new(@win) { pack }
    @label32 = TkLabel.new(@win) { pack; text 'Phone:' }
    @entry32 = TkEntry.new(@win) { pack }
    @label33 = TkLabel.new(@win) { pack; text 'Mail:' }
    @entry33 = TkEntry.new(@win) { pack }
    @label31 = TkLabel.new(@win) { pack; text 'GG:' }
    @entry34 = TkEntry.new(@win) { pack }
    @butt3 = TkButton.new(@win) { pack; text 'Add' }
    @butt3.command { self.add }

    @text = TkText.new(@win) { pack; width 30; height 20 }

    Tk.mainloop
  end
end


notepad = Notepad.new
notepad.run
