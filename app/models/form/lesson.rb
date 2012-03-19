# -*- coding: utf-8 -*-
require 'simple_validator'

class Form::Lesson < CachedForm
  attr_accessor :title, :description, :video, :script

  validate :not_blank?

  def not_blank?
  end

end
