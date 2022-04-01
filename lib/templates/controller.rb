# frozen_string_literal: true
class Admin::<%= controller_class_name %>Controller < BaseAdminController

  private

  def default_params_permited
    <%- if attributes_names.empty? -%>
    []
    <%- else -%>
      [ <%= attributes_names.excluding('deleted_at').map { |name| ":#{name}" }.join(', ') %> ]
    <%- end -%>
  end

  def filter_fields
    <%- if attributes_names.empty? -%>
    []
    <%- else -%>
      [ <%= attributes_names.excluding('id', 'deleted_at').map { |name| "'#{controller_file_name + '.' + name}'" }.join(', ') %> ]
    <%- end -%>
  end

end
