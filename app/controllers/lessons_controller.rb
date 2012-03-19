class LessonsController < ApplicationController
  def current_lesson
    id = params[:lesson_id] || params[:id]
    lesson = Lesson.find_by_id(id)
    return lesson
  end

  def index
    @lessons = Lesson.where(:public => true).order("id DESC")
  end

  def show
    @lesson = current_lesson
    if @lesson.nil?
      return redirect_to root_path
    end
  end

  def chapters
    @lesson = current_lesson
    if @lesson.nil?
      return redirect_to root_path
    end
    results = @lesson.chapters
    return render :json => results.to_json 
  end

  def new
    @lesson_form = Form::Lesson.new(params[:form_lesson])
  end

  def create
    @lesson_form = Form::Lesson.new(params[:form_lesson])
    unless @lesson_form.valid?
      return redirect_to new_lesson_path
    end
    lesson = Lesson.new
    lesson.title = @lesson_form.title
    lesson.description = @lesson_form.description
    lesson.video = @lesson_form.video
    lesson.script = @lesson_form.script
    lesson.public = true
    lesson.save

    return redirect_to lesson_path(lesson)
  end

  def edit
  end

  def update
  end

end
