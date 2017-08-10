class FilesController < ApplicationController

  def create
    @attachment = Nfile.create(attachment_params)

    render json: { path:  request.protocol + request.host_with_port + @attachment.file.url(:original, timestamp: false) }
  end

  protected

  def attachment_params
    params.permit(:file)
  end


end
