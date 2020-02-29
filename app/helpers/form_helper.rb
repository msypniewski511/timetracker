module FormHelper
  def errors_for(form, field)
    content_tag(:small, form.object.errors[field].try(:first), class: "help-block")
  end

  def form_group_for(form, field, text=field, &block)
    has_errors = form.object.errors[field].present?


    content_tag :div, class: "form-group #{'is-invalid' if has_errors}" do
      concat form.label(text, class: 'control-label', for: field)
      concat capture(&block)
      concat errors_for(form, field)
    end
  end


end
# .custom-file
# %input#customFile.custom-file-input{:type => "file"}/
# %label.custom-file-label{:for => "customFile"} Choose file