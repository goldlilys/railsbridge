class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
    @number_of_topics = Topic.count  #get count
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        # Changing @topic to topics_path
        # format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.html { redirect_to topics_path, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        # Change topic
        # format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.html { redirect_to topics_path, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # vote topic button action
  def upvote
      @topic = Topic.find(params[:id])   # finds the topic in the database with that id and stores it in the variable @topic
      @topic.votes.create  # creates a new vote for the current topic and saves it in the database.
      redirect_to(topics_path)   # tells the browser to go back to topics_path (the topics list).
  end

  # down vote a topic
  def downvote
    @topic = Topic.find(params[:id])
    @topic.votes.first.destroy   # doesn't matter where to delete from vote
    redirect_to(topics_path)
  end

  def unwanted
   @topics = Topic.all
  end


  def mostVoted
    @topics = Topic.all
    @topics.sort_by do |votes|
      @topics.votes.count
    end
    redirect_to(topics_path)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description)
    end
end
