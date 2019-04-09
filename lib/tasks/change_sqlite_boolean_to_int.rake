# encoding: UTF-8
# This should only be necessary to run once if using an old dev/test db
namespace :db do
  desc "Convert Policy table boolean values to 1 or 0 instead of 't' or 'f'"
  task :convert_bools_to_integers => :environment do
    Policy.where("needs_revision = 't'").update_all(needs_revision: 1)
    Policy.where("needs_revision = 'f'").update_all(needs_revision: 0)

    Policy.where("obsolete = 't'").update_all(obsolete: 1)
    Policy.where("obsolete = 'f'").update_all(obsolete: 0)
  end
end
