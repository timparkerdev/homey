class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])

    @project_history = build_project_history(@project)

    @comment = Comment.new(commentable: @project)
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def build_project_history(project)
    comments = project.comments

    # TODO: include audits here
    # TODO: make sure to order by created_at
    # TODO: move to a service class .. ?

    comments.map do |comment|
      {
        type: 'comment',
        content: comment.content,
        created_at: comment.created_at
      }
    end
  end


  def project_params
    params.require(:project).permit(:name, :description, :project_statuses_id)
  end
end
