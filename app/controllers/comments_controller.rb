class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    # @comments = Comment.all
    @profile = Profile.find_by(user_id: current_user.id)
    @comments = @profile.comments.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @comments = Comment.all
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @headhunter = current_headhunter 
    @comment = Comment.new(comment_params)
    @comment.headhunter_id = @headhunter.id
    
    if @comment.save
      redirect_to request.referrer, notice: "Comentário criado com sucesso."
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comentário atualizado." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    redirect_to request.referrer, notice: "Comentário excluído com sucesso." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end 
    def comment_params
      params.require(:comment).permit(:profile_id, :headhunter_id, :body)
    end
end