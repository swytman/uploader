class FilesController < ApplicationController

  def create
    @attachment = Nfile.create(attachment_params)
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    render json: { path:  URI.join(ActionController::Base.asset_host, @attachment.file.url(:original, timestamp: false)).to_s }
  end

  protected

  def attachment_params
    params.permit(:file)
  end


end
