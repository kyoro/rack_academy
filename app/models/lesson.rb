# -*- coding: utf-8 -*-
require "pp"
class Lesson < ActiveRecord::Base


def chapters
  rndr = HTMLwithCoderay.new(:filter_html => true, :hard_wrap => true)

  markdown = Redcarpet::Markdown.new(
    rndr,
    :autolink => true, 
    :space_after_headers => true, 
    :fenced_code_blocks => true)

  results = []
  chapters = self.script.split(">>>>")
  chapters.each do |chapter|
    chapter = ">>>>" + chapter
    re = Regexp.new('>>>>(\d+)') 
    m = re.match(chapter)
    unless m.nil?
      time = m[1]
      chapter = chapter.gsub(">>>>" + time +"\r\n" ,"")
      #pre-processing
      title_re = Regexp.new('^#\s?(.*)\r$')
      title_m = title_re.match(chapter)
      title = ""  
      unless title_m.nil?
        title = title_m[1]
      end
      html = markdown.render(chapter)
      results.push({
        :time => time,
        :title => title,
        :body => html.to_s
      })

    end
  end
  return results
end

end

class HTMLwithCoderay < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.scan(code, language.to_sym).div(:line_numbers => :table)
  end
end
