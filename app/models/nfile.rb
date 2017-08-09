class Nfile < ActiveRecord::Base
  self.table_name = 'files'
  has_attached_file :file,
    url: "/files/:hash.:extension",
    hash_secret: "longSecretString"
  do_not_validate_attachment_file_type :file
end