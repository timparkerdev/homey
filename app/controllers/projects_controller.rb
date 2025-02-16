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

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def build_project_history(project)
     ProjectHistory.call(project, project.comments, project.audits)
  end


  def project_params
    params.require(:project).permit(:name, :description, :project_statuses_id)
  end
end
