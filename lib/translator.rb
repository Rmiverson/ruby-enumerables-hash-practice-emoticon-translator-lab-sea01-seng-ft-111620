require 'yaml'

def load_library(file_path)
  list = YAML.load_file(file_path)
  re_hash = Hash.new
  
  list.map { |feel, value|
    #resets the the counter for every key(feeling)
    counter = 0
    value.map { |emot|
      if !re_hash[feel]
        re_hash[feel] = {}
      end
      
      #checks flips between one or zero to set language
      if counter == 0
        lang = :english
      else
        lang = :japanese
      end
      
      re_hash[feel][lang] = emot
      counter += 1
    }
  }
  return re_hash
end

def get_japanese_emoticon(file_path, emoticon)
  lib = load_library(file_path)
  
  lib.map { |feel, value|
    value.map { |lang, emot|
      if emoticon == emot
        return lib[feel][:japanese]
      end
    }
  }
  return "Sorry, that emoticon was not found"
end

def get_english_meaning(file_path, emoticon)
  lib = load_library(file_path)
  counter = 0 #sets a counter for 'lib.keys' so it has a value to reference to get the feeling
  
  lib.map { |feel, value|
    value.map { |lang, emot|
      if emoticon == emot
        return lib.keys[counter]
      end
    }
  counter += 1
  }
  return "Sorry, that emoticon was not found"
end