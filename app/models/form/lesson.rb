# -*- coding: utf-8 -*-
require 'simple_validator'

class Form::Lesson < CachedForm
  attr_accessor :title, :description, :video, :script, :passcode

  validate :not_blank?,:passcode?

  def not_blank?
  end

  def passcode?
    if passcode != "miko3moemoe"
      errors.add(:passcode,"passcode invalid")
      return
    end
  end

end
