class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @profile = Profile.new({user: current_user})
    @group = Group.find_by_id(params[:group_id])
    @lessons = @group.lessons.order(:created_at).reverse_order
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @profile = Profile.new({user: current_user})
    @group = Group.find_by_id(params[:group_id])
    @current_url = request.original_url
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    @group = Group.find_by_id(params[:group_id])
    @lesson.group = @group
    @profile = Profile.new({user: current_user})

    respond_to do |format|
      if @lesson.save
        @lesson.create_activity :create, owner: current_user,
                                parameters: { title: @lesson.title, summary: @lesson.summary,
                                              thumbnail_url: @lesson.thumbnail_url,
                                              url: profile_group_lesson_url(@profile, @group, @lesson)
                                }

        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: [@profile, @group, @lesson] }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :summary, :external_url, :group_id, :order_no, :type, :provider_name, :favicon_url, :description, :thumbnail_url)
    end
end
