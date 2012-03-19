require 'abstract_form'

class CachedForm < AbstractForm
  FORM_SAVE_EXPIRE = 60 * 30

  def save(key)
    key ||= ""
    class_name = self.class.to_s
    cache_key = key + "_" + class_name
    Rails.cache.write(key, self, :expires_in => FORM_SAVE_EXPIRE) 
  end

  def clear(key)
    key ||= ""
    class_name = self.class.to_s
    cache_key = key + "_" + class_name
    Rails.cache.delete(key) 
  end

  def self.load(key)
    class_name = self.class.to_s
    cache_key = key + "_" + class_name
    obj = Rails.cache.read(key)
    return obj unless obj.nil? 
    return self.new
  end

end
