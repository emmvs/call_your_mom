class ApplicationRecord < ActiveRecord::Base
  include PpSql::ToSqlBeautify if defined?(Rails::Console)

  self.abstract_class = true

  primary_abstract_class
end
