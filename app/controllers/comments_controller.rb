class CommentsController < ApplicationController
  def create

    comment = Comment.new(comment_params)

    if comment.save
      redirect_to edit_project_path(comment.commentable_id)
    else
      redirect_to edit_project_path(comment.commentable_id), status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
end
