class FilesController < ApplicationController

  def create
    @attachment = Nfile.create(attachment_params)
    render json: { path:  URI.join(ActionController::Base.asset_host, @attachment.file.url(:original, timestamp: false)).to_s }
  end

  protected

  def attachment_params
    params.permit(:file)
  end


end
