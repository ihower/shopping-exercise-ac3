class Export < ActiveRecord::Base

   has_attached_file :export
   do_not_validate_attachment_file_type :export

end
